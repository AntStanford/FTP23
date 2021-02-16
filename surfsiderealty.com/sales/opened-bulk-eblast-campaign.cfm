<cfif isdefined('url.eblastcampaignid') and isnumeric(url.eblastcampaignid)>
  <cfset transGif = "#expandpath('/sales/images/dot.gif')#">
  <cfparam name="url.opened" default="0">
  <CFQUERY NAME="UpdateQuery" DATASOURCE="#mls.dsn#">
    UPDATE cl_bulk_emailer_tracker
    SET 
      opened='Yes',
      dateopened = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_DATE">
    where clientid = <cfqueryparam value="#url.eblastclientid#" cfsqltype="CF_SQL_NUMERIC"> and messageid = <cfqueryparam value="#url.eblastcampaignid#" cfsqltype="CF_SQL_NUMERIC"> and opened = 'No'
  </cfquery>
  <cfcontent type="image/gif" file="#transGif#">
</cfif>