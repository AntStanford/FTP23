

<cfif isdefined('url.pause')>

	<!--- If Pausing Campaign, set Campaign and all Steps to Paused --->
	<cfquery datasource="#mls.dsn#" name="PauseCampaign">
		Update drip_campaigns
		Set status = <cfqueryparam value="Paused" cfsqltype="cf_sql_varchar">,
			PausedOn = <cfqueryparam value="#CreateODBCDate(now())#" cfsqltype="cf_sql_date">
		Where id = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	</cfquery>


	<cfquery datasource="#mls.dsn#" name="PauseEntries">
		Update drip_entries
		Set status = <cfqueryparam value="Paused" cfsqltype="cf_sql_varchar">
		Where CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	</cfquery>


<cfelseif isdefined('url.resume')>

<!--- If Resumeing Campaign, Set Campaign to Active and Change StartDate to Now --->

	<cfquery datasource="#mls.dsn#" name="resumeCampaign">
		Update drip_campaigns
		Set status = <cfqueryparam value="Active" cfsqltype="cf_sql_varchar">,
		DripStartDate = <cfqueryparam value="#CreateODBCDate(now())#" cfsqltype="cf_sql_date">,
		PausedOn = NULL
		Where id = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	</cfquery>

		<cfquery datasource="#mls.dsn#" name="PauseEntries">
			Update drip_entries
			Set status = <cfqueryparam value="Active" cfsqltype="cf_sql_varchar">
			Where CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
		</cfquery>

	<cfquery datasource="#mls.dsn#" name="getCampaign">
		select NextStep
		From drip_campaigns
		Where id = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	</cfquery>

<!--- 	If campaign is in progress, only update scheduling dates for future steps --->
	<cfif getCampaign.NextStep gt 0>
		<cfset StartWithStep = getCampaign.NextStep> 
	</cfif>

	<cfquery datasource="#mls.dsn#" name="getEntries">
		select id,ScheduledDate,WaitDays
		From drip_entries
		Where CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer"> and ScheduledDate <> ''  <cfif isdefined('StartWithStep')>and StepNum >= <cfqueryparam value="#StartWithStep#" cfsqltype="cf_sql_integer"></cfif>
	</cfquery>

		<cfoutput query="getEntries">

			<!--- Update Steps to Active and New ScheduleDates --->
			<cfquery datasource="#mls.dsn#" name="PauseEntries">
				Update drip_entries
				Set ScheduledDate = <cfqueryparam value="#DateAdd('d', WaitDays, CreateODBCDate(now()))#" cfsqltype="cf_sql_date">
				Where CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer"> and id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
			</cfquery>

		</cfoutput>


</cfif>




<cfif isdefined('cgi.HTTP_REFERER') and cgi.HTTP_REFERER contains "drip-campaigns.cfm">
	<cflocation url="drip-campaigns.cfm" addtoken="false">
<cfelseif isdefined('cgi.HTTP_REFERER') and cgi.HTTP_REFERER contains "drip-campaign-lead.cfm">
	<cflocation url="drip-campaign-lead.cfm?campaignid=#url.campaignid#&clientid=#url.clientid#" addtoken="false">
</cfif>

