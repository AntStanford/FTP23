<cfquery datasource="#mls.dsn#" name="GetCampaigns">
  SELECT * 
  FROM cl_drip_campaigns
</cfquery>

<cfloop query="GetCampaigns">
  <!---GET ACCOUNTS AND SEE WHICH ONE IS READY TO SEND--->
  <cfquery datasource="#mls.dsn#" name="GetLeads">
    SELECT * 
    FROM cl_accounts
    where  TO_DAYS(lastrequest) = To_DAYS(NOW())-#WhenToSend#
  </cfquery>
  <cfif GetLeads.recordcount gt 0>
    <!---GET AGENT INFORMATION--->
    <cfquery datasource="#mls.dsn#" name="GetAgent">
      SELECT * 
      FROM cl_agents
      where id = <cfqueryparam value="#GetLeads.agentid#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfloop query="GetLeads">
      <cfset encryptedID = EncryptID(#GetLeads.id#)>
      <cfset body = #replacenocase(GetCampaigns.body,'!id!',encryptedID,"all")#>
      <cfset body = #replacenocase(body,'%21',encryptedID,"all")#>

<cfmail to="#GetLeads.email#" from="#GetAgent.email# <#cfmail.username#>" replyto="#GetAgent.email#"
subject="#GetCampaigns.subject#" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
        <cfinclude template="/sales/emails/_header.cfm">
          #body#
        <cfinclude template="/sales/emails/_footer.cfm">
        <!--this must stay for tracking-->
        <img src="#mls.companyurl#/sales/opened-drip-campaign.cfm?drippercampaign=#GetCampaigns.id#&dripclientid=#GetLeads.id#" alt="" border="0">
        <!--this must stay for tracking-->
      </cfmail>
      <!---insert into drip tracker table to know who received this--->
      <cfquery datasource="#mls.dsn#">
        INSERT INTO cl_drip_tracker (dripid, clientid) 
        VALUES(
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetCampaigns.id#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#id#">)
      </cfquery>
      <!--- <cfoutput>[#GetCampaigns.id#] of campaign<br>	{#GetLeads.id#} of account<br>	</cfoutput> --->
    </cfloop>
  </cfif>
</cfloop>