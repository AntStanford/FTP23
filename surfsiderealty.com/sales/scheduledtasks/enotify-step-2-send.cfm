<!---get list of searches that have new listings ready to be sent out.--->
<cfquery name="GetProperties" datasource="#mls.dsn#">
  select distinct searchid
  from cl_saved_searches_props_returned
  where notifiedyet = 'No'
</cfquery>

<cfloop query="GetProperties">
  <cfquery name="HowManyNewListings" datasource="#mls.dsn#">
    select *
    from cl_saved_searches_props_returned
    where notifiedyet = 'No' and searchid = '#searchid#'
    ORDER BY RAND()
  </cfquery>
  <cfquery name="GetSearchInformation" datasource="#mls.dsn#">
    select *
    from cl_saved_searches
    where id = '#searchid#'
  </cfquery>
  <cfquery name="GetClientInformation" datasource="#mls.dsn#">
    select *
    from cl_accounts
    where id = <cfqueryparam value="#GetSearchInformation.clientid#" cfsqltype="cf_sql_integer">
  </cfquery>
  <cfquery name="GetAgentInformation" datasource="#mls.dsn#">
    select *
    from cl_agents
    where id = <cfqueryparam value="#GetClientInformation.agentid#" cfsqltype="cf_sql_integer">
  </cfquery>
  <cfquery datasource="#DSNMLS#" name="GetListings">
    SELECT *
    from mastertable
    where mlsnumber = <cfqueryparam value="#HowManyNewListings.mlsnumber#" cfsqltype="cf_sql_numeric"> and wsid = <cfqueryparam value="#HowManyNewListings.wsid#" cfsqltype="cf_sql_integer"> and mlsid = <cfqueryparam value="#HowManyNewListings.mlsid#" cfsqltype="cf_sql_integer">
  </cfquery>
  <cfquery name="UpdateQuery" datasource="#mls.dsn#">
    UPDATE cl_saved_searches_props_returned
    SET 
      notifiedyet = 'Yes', 
      datenotified = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_DATE">
    where searchid = '#searchid#' and notifiedyet = 'No'
  </cfquery> 

  <!---GET INFORMATION SO YOU CAN INCLUDE ONE PROPERTY IN THIS EMAIL--->
  <!---GETS IMAGE PATH--->
  <cfquery name="getmlscoinfo" datasource="#DSNMLS#" >
    SELECT *
    FROM mlsfeeds
    where id = <cfqueryparam value="#mls.mlsid#" cfsqltype="cf_sql_integer">
  </cfquery>
  


<!---START: EMAIL NOTICATION THAT GOES TO THE CLIENT--->
<cfmail to="#GetClientInformation.email#" from="#GetAgentInformation.email# <#cfmail.username#>" replyto="#GetAgentInformation.email#"
subject="#mls.companyname# - Save Search Notification - #GetSearchInformation.searchname#" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
    <cfinclude template="/sales/emails/_header.cfm">
      <p>Hello #GetClientInformation.firstname#,</p>
      <p>This is your automatic notification email for the following search: <strong>#GetSearchInformation.searchname#</strong>.</p>
      <p>There <cfif #HowManyNewListings.recordcount# eq 1>is <a href="#mls.companyurl#/sales/search-results.cfm?enotifydate=#dateformat(now(),'yyyy-mm-dd')#&enotifydatesearchid=#searchid#&clearsession=">#HowManyNewListings.recordcount# new property</a><cfelse>are <a href="#mls.companyurl#/sales/search-results.cfm?enotifydate=#dateformat(now(),'yyyy-mm-dd')#&enotifydatesearchid=#searchid#&clearsession=">#HowManyNewListings.recordcount# new properties</a></cfif> that meet your search criteria.</p>
      <p>Follow this link to  <a href="#mls.companyurl#/sales/search-results.cfm?enotifydate=#dateformat(now(),'yyyy-mm-dd')#&enotifydatesearchid=#searchid#&clearsession=">view these new properties.</a></p>
      <table width="100%" cellspacing="2" cellpadding="2" align="center">
      <tr>
        <td valign="top">
          <strong>Contact Your Agent Today</strong><br>
          #GetAgentInformation.firstname# #GetAgentInformation.lastname#<br>
          <cfif GetAgentInformation.agentphoto is not ""><br><img src="#mls.companyurl#/sales/images/agents/sm_#GetAgentInformation.agentphoto#" alt="" border="0"></cfif>
          <cfif GetAgentInformation.email is not ""><br><a href="mailto:#GetAgentInformation.email#">#GetAgentInformation.email#</a></cfif>
          <cfif GetAgentInformation.cellphone is not ""><br>#GetAgentInformation.cellphone#</cfif>
          <cfif GetAgentInformation.phone is not ""><br>#GetAgentInformation.phone#</cfif>
        </td>
        <td valign="top">
          <strong>Featured Property From Search</strong><br>
          <cfloop query="GetListings">
            <cfinclude template="/sales/includes/image-handler.cfm">
            <cfif AddressDisplayYN is not "N">#street_number# #street_name# <cfif LEN(unit_number)>#unit_number#</cfif><br></cfif><br>
            <A href="#mls.companyurl#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#&enotifydatesearchid=#GetProperties.searchid#"><cfif HowManyPhotos gt 0><IMG src="#getmlscoinfo.imageurl#/#thephoto#" width="200" border="0" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="200" border="0" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif></A><br>
            #dollarformat(list_price)#<br>
            <cfif bedrooms is not "">Bedroom(s): #bedrooms#  &nbsp;&nbsp;<br></cfif>
            <cfif baths_full is not "">Full Baths: #baths_full#  &nbsp;&nbsp;<br></cfif>
          </cfloop>
        </td>
      </tr>
      </table>
      <cfset encryptedID = EncryptID(#searchid#)>
      <cfset encryptedClientID = EncryptID(#GetSearchInformation.clientid#)>
      <p><a href="#mls.companyurl#/sales/unsubscribe-from-notification.cfm?unsubscribe=#encryptedID#&unsubsearchname=#GetSearchInformation.searchname#">Unsubscribe me from this notification</a>.<br>  Note: there may be other notification emails setup within your profile.  <a href="#mls.companyurl#/sales/index.cfm?LinkToLogin=">Login</a> and adjust your settings.</p>
    <cfinclude template="/sales/emails/_footer.cfm">
    <!--this must stay for tracking-->
    <img src="#mls.companyurl#/sales/opened-enotify.cfm?clientid=#encryptedClientID#&searchid=#encryptedID#&datenotified=#dateformat(HowManyNewListings.datenotified,'yyyy-mm-dd')#&searchname=#GetSearchInformation.searchname#" alt="" border="0">
    <!--this must stay for tracking-->
  </cfmail> 
  


<!---START: EMAIL NOTICATION THAT GOES TO THE CLIENT--->
  <br><br>NEXT EMAIL NOTIFICATION<br><br>
</cfloop>