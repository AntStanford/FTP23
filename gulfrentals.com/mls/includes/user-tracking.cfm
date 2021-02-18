<!--- This is for Tracking Drip Campaigns --->
<cfif isdefined('campaigntracker')>
  <cfset DecryptedCampaignID = DecryptID(#campaigntracker#)>
  <cfset DecryptedID = DecryptID(#id#)>
  <cfquery datasource="#settings.mls.propertydsn#" name="GetCampaign">
    SELECT * 
    FROM cl_drip_campaigns
    where id = <cfqueryparam value="#DecryptedCampaignID#" cfsqltype="CF_SQL_INTEGER">
  </cfquery>
  <cfquery datasource="#settings.mls.propertydsn#" dbtype="ODBC">
    Insert 
    Into cl_activity
    (clientid,RefferingSite,Action,ActionID)    
    Values    
    (<cfqueryparam value="#DecryptedID#" cfsqltype="CF_SQL_VARCHAR">,
    <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,
    <cfqueryparam value="Drip Campaign - #GetCampaign.subject#" cfsqltype="CF_SQL_VARCHAR">,
    <cfqueryparam value="#DecryptedCampaignID#" cfsqltype="CF_SQL_VARCHAR">
    )
  </cfquery>
</cfif>
<!--- End: This is for Tracking Drip Campaigns --->



<!--- Start: This is for Tracking E-Notification Returns --->
<cfif isdefined('enotifydatesearchid')>
	<cfquery datasource="#settings.mls.propertydsn#" name="GetSearchInformation">
		SELECT * 
		FROM cl_saved_searches
		where id = <cfqueryparam value="#enotifydatesearchid#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>	
	<cfquery datasource="#settings.mls.propertydsn#" dbtype="ODBC">
 		Insert 
		Into cl_activity
		(clientid,RefferingSite,Action,ActionID) 
    Values	
		(<cfqueryparam value="#GetSearchInformation.clientid#" cfsqltype="CF_SQL_VARCHAR">,
		<cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,
		<cfqueryparam value="Enotify Clicked - #GetSearchInformation.searchname#" cfsqltype="CF_SQL_VARCHAR">,
		<cfqueryparam value="#enotifydatesearchid#" cfsqltype="CF_SQL_VARCHAR">
		)
	</cfquery>
</cfif>
<!--- End: This is for Tracking E-Notification Returns --->



<!--- Start: This is for Tracking Link Tracker Links --->
<cfif isdefined('linktracker')>
  <cfset DecryptedID = DecryptID(#linktracker#)>
  <cfquery datasource="#settings.mls.propertydsn#" name="GetTrackingLinkInformation">
    SELECT * 
    FROM cl_tracking_links
    where id = <cfqueryparam value="#DecryptedID#" cfsqltype="CF_SQL_INTEGER">
  </cfquery>
  <cfquery datasource="#settings.mls.propertydsn#" dbtype="ODBC">
    Insert 
    Into cl_activity
    (
    <cfif isdefined('cookie.loggedin')>
      clientid,
    <cfelse>
      TheCFID, TheCFTOKEN,
    </cfif>
    RefferingSite,Action,ActionID)    
    Values    
    (
    <cfif isdefined('cookie.loggedin')>
      <cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR">,
    <cfelse>
      <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR">,
      <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">,
    </cfif>    
    <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,
    <cfqueryparam value="Tracking Link - #GetTrackingLinkInformation.subject#" cfsqltype="CF_SQL_VARCHAR">,
    <cfqueryparam value="#DecryptedID#" cfsqltype="CF_SQL_VARCHAR">
    )
  </cfquery>
</cfif>
<!--- End: This is for Tracking Link Tracker Links --->



<!--- Start: This is for Tracking Bulk Email Compain Links --->
<cfif isdefined('bulkemailtracker')>
  <cfset DecryptedCampaignID = DecryptID(#bulkemailtracker#)>
  <cfset DecryptedID = DecryptID(#id#)>
	<cfquery datasource="#settings.mls.propertydsn#" name="GetCampaign">
		SELECT * 
		FROM cl_bulk_emailer_templates
		where id = <cfqueryparam value="#DecryptedCampaignID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
  <cfquery datasource="#settings.mls.propertydsn#" dbtype="ODBC">
    Insert 
    Into cl_activity
    (clientid,RefferingSite,Action,ActionID)    
    Values     
    (<cfqueryparam value="#DecryptedID#" cfsqltype="CF_SQL_VARCHAR">,
    <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,
    <cfqueryparam value="Bulk Email - #GetCampaign.subject#" cfsqltype="CF_SQL_VARCHAR">,
    <cfqueryparam value="#DecryptedCampaignID#" cfsqltype="CF_SQL_VARCHAR">
    )
  </cfquery>
</cfif>
<!--- End: This is for Tracking Bulk Email Compain Links --->