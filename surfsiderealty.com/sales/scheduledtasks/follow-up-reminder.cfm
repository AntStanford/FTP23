<cfset date1 = DateFormat(now(),"YYYY-MM-DD")>

<cfquery datasource="#mls.dsn#" name="GetFollowUps">
  SELECT * 
  FROM cl_followup_reminder
  where FollowUpDate = <cfqueryparam value="#date1#" cfsqltype="CF_SQL_TIMESTAMP"> 
</cfquery>

<cfloop query="GetFollowUps">
  <cfquery datasource="#mls.dsn#" name="GetClient">
    SELECT *
    FROM cl_accounts
    where id = '#clientid#' 
  </cfquery>
  <cfquery datasource="#mls.dsn#" name="GetAgent">
    SELECT *
    FROM cl_agents
    where id = '#agentid#' 
  </cfquery>
  <cfquery datasource="#mls.dsn#" name="GetResponse">
    SELECT *
    FROM cl_leadtracker_response
    where id = '#responseid#' 
  </cfquery>

 <cfmail to="#GetAgent.email#" from="#mls.adminemail# <#cfmail.username#>" replyto="#mls.adminemail#"
subject="#mls.companyname# - Follow Up Reminder - #GetClient.firstname# #GetClient.lastname#" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
    <cfinclude template="/sales/emails/_header.cfm">
      <p>Hello #GetAgent.firstname#,</p>
      <p>You set yourself a reminder to follow up with #GetClient.firstname# #GetClient.lastname# on #dateformat(followupdate,'mm/dd/yyyy')#.</P>
      <p>Login to the <a href="http://#cgi.HTTP_HOST#/admin/login.cfm">control panel</a> and <a href="http://#cgi.HTTP_HOST#/admin/contacts/contacts.cfm?Action=Edit&id=#ClientID#">follow this link</a>.</p>
      <hr>
      <p>Note Set For This Reminder:</p>
      #GetResponse.messagebody#
    <cfinclude template="/sales/emails/_footer.cfm">
  </cfmail>
  <!---delete the reminder--->
  <cfquery datasource="#mls.dsn#" name="DeleteReminder">
    delete
    FROM cl_followup_reminder
    where id = '#id#' 
  </cfquery>
</cfloop>