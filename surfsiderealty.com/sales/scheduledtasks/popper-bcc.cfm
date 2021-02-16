<cfscript>
/**
* Searches a string for email addresses.
* Based on the idea by Gerardo Rojas and the isEmail UDF by Jeff Guillaume.
* New TLDs
*
* @param str      String to search. (Required)
* @return Returns a list.
* @author Raymond Camden (ray@camdenfamily.com)
* @version 2, September 21, 2006
*/
function getEmails(str) {
  var email = "(['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name|jobs|travel)))";
  var res = "";
  var marker = 1;
  var matches = "";
  matches = reFindNoCase(email,str,marker,marker);
  while(matches.len[1] gt 0) {
    res = listAppend(res,mid(str,matches.pos[1],matches.len[1]));
    marker = matches.pos[1] + matches.len[1];
    matches = reFindNoCase(email,str,marker,marker);
  }
  return res;
}
</cfscript>

<cfpop action="GETALL" name="GetMessages"  server="mail.icoastalnet.com" username="#mls.BCCToCRM#" password="#mls.BCCToCRMPassword#">
<cfset deletemail = "">
<cfoutput query="GetMessages">
  


<!---START: HANDLES ALL THE PARSING--->
  <!---FROM Email address--->
  <cfset FromEmail = trim(getEmails(from))>
  <p><strong>From:</strong> #FromEmail#</p>
  <!---TO Email address--->
  <cfset ToEmail = trim(getEmails(To))>
  <p><strong>To:</strong> #ToEmail#</p>
  <!---SUBJECT--->
  <cfset MessageSubject = "#subject#">
  <p><strong>Message Subject:</strong> #MessageSubject#</p>
  <!---MESSAGE BODY--->
  <cfset MessageBody = "#textbody#">
  <p><strong>Message Body:</strong><br>#MessageBody#</p>
  <!---gets message id - OPTING NOT TO USE, USING THE EMAIL ADDRESS AS THE PRIMARY KEY HERE.
  <cfset GetClientID = #listgetat(Body,'2','~')#>
  <cfset GetClientID = #listgetat(GetClientID,'1','~')#>
  <p><strong>ClientId:</strong> #GetClientID#</p>--->
  <!---END: HANDLES ALL THE PARSING--->
  <cfquery datasource="#mls.dsn#" name="GetAcctInfo">
    SELECT * 
    FROM cl_accounts
    where email = '#ToEmail#'
  </cfquery>
  <cfif GetAcctInfo.recordcount gt 0>
    <cfquery datasource="#mls.dsn#">
      INSERT INTO cl_leadtracker_response (agentid, clientid, MessageSubject, MessageBody, FromOrTo, PrivatePublic, FullEmail) 
      VALUES(
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAcctInfo.agentid#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAcctInfo.id#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#MessageSubject#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#MessageBody#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Waiting On Customer's Response">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Public">,
        <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#htmlbody#" >
      )
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#mls.dsn#">
      UPDATE cl_accounts
      SET 
        lastrequest = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP">
      where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetAcctInfo.id#">
    </cfquery>
  <cfelse>
    <!---THERE IS NO ACCOUNT IN THE CRM - I'm requiring that the website admin create an account and assign to a rep--->
<cfmail to="#mls.AdminEmailNonAcctHolders#" from="#FromEmail# <#cfmail.username#>" replyto="#FromEmail#"
subject="#MessageSubject#" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
      This message has been sent to you b/c there is no record of this person existing in the LeadTracker. You will need to login to you Control Panel and create an entry.
      #MessageBody#
    </cfmail>
  </cfif>
  <cfset deletemail = #LISTAPPEND(deletemail,messagenumber,',')#>
</cfoutput>




<!---START: DELETING THE EMAILS AFTER PARSED--->
<cfpop action="DELETE" messagenumber="#deletemail#" server="mail.icoastalnet.com" username="#mls.BCCToCRM#" password="#mls.BCCToCRMPassword#"> 
<!---END: DELETING THE EMAILS AFTER PARSED--->