<cfif isdefined('url.drippercampaign') and isnumeric(url.drippercampaign)>
  <cfset transGif = "#expandpath('/sales/images/dot.gif')#">
  <cfparam name="url.opened" default="0">
  <CFQUERY NAME="UpdateQuery" DATASOURCE="#mls.dsn#">
    UPDATE cl_drip_tracker
    SET 
      opened='Yes',
      dateopened = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_DATE">
    where clientid = <cfqueryparam value="#url.dripclientid#" cfsqltype="CF_SQL_NUMERIC"> and dripid = <cfqueryparam value="#url.drippercampaign#" cfsqltype="CF_SQL_NUMERIC">
  </cfquery>
  <cfcontent type="image/gif" file="#transGif#">
</cfif>