<!--- This removes admin note about subject from it being submitted to email entry --->
<cffunction name="cleanSubject" returntype="Any">
	<cfargument name="thesubject" type="any" required="true">
		<cfset returnSubject = Rereplace(thesubject, '\(recommended\)|\(inactive\)','', 'ALL')>
	<cfreturn returnSubject>
</cffunction>


	<cfif isdefined('url.clientid') and NOT isdefined('url.campaignID') and NOT isdefined('form.campaignID')>
		<!--- Get This Campaign --->
		<cfquery datasource="#mls.dsn#" name="checkCampaign">
			select *
			from drip_campaigns
			where clientid = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer"> and status = <cfqueryparam value="active" cfsqltype="cf_sql_varchar">
			limit 1
		</cfquery>
		<cfif checkCampaign.recordcount eq 1>
			<cfoutput>There is already an existing campaign for this Lead. <a hreflang="en" href="drip-campaign-lead.cfm?clientid=#url.clientid#&campaignID=#checkCampaign.id#">Click here</a> to view.</cfoutput>
			<cfabort>
		</cfif>
	</cfif>



<cfset dripFilePath = #ExpandPath('/files')#>

<!--- Handles Total delete of Campaign and Entries --->
<cfif isdefined('url.delete') and url.delete eq 'deletecampaign' and isdefined('url.campaignid') and isdefined('url.clientid')>


	<!--- Delete  attachment files  --->
	<cfquery datasource="#mls.dsn#" name="getAttachments">
		select FileLinkText
		from drip_entries
		where campaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer"> and FileLinkText <> ''
	</cfquery>

	<cfoutput query="getAttachments">
		<cffile  action = "delete" file = "#dripFilePath#/#FileLinkText#">
	</cfoutput> 


	<!--- Delete campaign --->
	<cfquery datasource="#mls.dsn#" name="DeleteCampaign">
		delete from drip_campaigns
		where id = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Delete steps for campaign --->
	<cfquery datasource="#mls.dsn#" name="DeleteEntries">
		delete from drip_entries
		where campaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation url="drip-campaigns.cfm" addtoken="false">
</cfif>


<cfif isdefined('url.campaignID') or isdefined('form.campaignID')>

	<!--- Standardize Vars for Queries --->
	<cfif isdefined('url.campaignID')>
		<cfset thecampaignID = url.campaignID>
	<cfelseif isdefined('form.campaignID')>	
		<cfset thecampaignID = form.campaignID>
	</cfif>
		
	<cfif isdefined('url.clientid')>
		<cfset theclientid = url.clientid>
	<cfelseif isdefined('form.clientid')>	
		<cfset theclientid = form.clientid>
	</cfif>


	<!--- Get This Campaign --->
	<cfquery datasource="#mls.dsn#" name="getCampaign">
		select *
		from drip_campaigns
		where id = <cfqueryparam value="#thecampaignID#" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Check For Each Step and Set a Variable if exists --->
	<cfquery datasource="#mls.dsn#" name="Step1">
		select *
		from drip_entries
		where campaignID = <cfqueryparam value="#thecampaignID#" cfsqltype="cf_sql_integer"> and StepNum = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer">
		limit 1
	</cfquery>
	<cfif Step1.recordcount eq 1><cfset HasOne = "Yes"></cfif>

	<cfquery datasource="#mls.dsn#" name="Step2">
		select *
		from drip_entries
		where campaignID = <cfqueryparam value="#thecampaignID#" cfsqltype="cf_sql_integer"> and StepNum = <cfqueryparam value="2" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer">
		limit 1	
	</cfquery>
	<cfif Step2.recordcount eq 1><cfset HasTwo = "Yes"></cfif>

	<cfquery datasource="#mls.dsn#" name="Step3">
		select *
		from drip_entries
		where campaignID = <cfqueryparam value="#thecampaignID#" cfsqltype="cf_sql_integer"> and StepNum = <cfqueryparam value="3" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer">
		limit 1	
	</cfquery>
	<cfif Step3.recordcount eq 1><cfset HasThree = "Yes"></cfif>

	<cfquery datasource="#mls.dsn#" name="Step4">
		select *
		from drip_entries
		where campaignID = <cfqueryparam value="#thecampaignID#" cfsqltype="cf_sql_integer"> and StepNum = <cfqueryparam value="4" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer">
		limit 1	
	</cfquery>
	<cfif Step4.recordcount eq 1><cfset HasFour = "Yes"></cfif>

	<cfquery datasource="#mls.dsn#" name="Step5">
		select *
		from drip_entries
		where campaignID = <cfqueryparam value="#thecampaignID#" cfsqltype="cf_sql_integer"> and StepNum = <cfqueryparam value="5" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer">
		limit 1	
	</cfquery>
	<cfif Step5.recordcount eq 1><cfset HasFive = "Yes"></cfif>

	<!--- Get Send History --->
	<cfquery datasource="#mls.dsn#" name="getHistory">
		select *
		from drip_history
		where CampaignID = <cfqueryparam value="#thecampaignID#" cfsqltype="cf_sql_integer"> and ClientID = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer">
	</cfquery>


</cfif>

<cfif isdefined('url.clientid')>
	<cfquery datasource="#mls.dsn#" name="getAcct">
		select firstname,lastname,donotsend
		from cl_accounts
		where id = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer">
		limit 1
	</cfquery>
</cfif>

<!--- Update / Insert Campaign --->
<cfif cgi.request_method eq 'Post'>

	<!--- <cfdump var="#form#"><cfabort> --->

	<!--- If Campaign ID exists, update - if not Insert new --->
	<cfif isdefined('form.CampaignID') and LEN(form.CampaignID)>
		<cfinclude template="drip-campaign-lead-update.cfm">
	<cfelse>
		<cfinclude template="drip-campaign-lead-insert.cfm">
	</cfif>


<cfelse>

	<!--- Make sure that a Lead has been selected and an Agent is logged in --->
	<cfif isdefined('url.clientid') and LEN(url.clientid)>
	<cfelse>
		A lead must be selected before you can create an campaign.<cfabort>
	</cfif>

</cfif>


<!--- Get All Templates --->
<cfquery datasource="#mls.dsn#" name="getTemplates">
	select id,subject,status,body,defaultentry
	from drip_templates
	order by subject ASC
</cfquery>



<!--- START: Get Sharing Library --->

<cfif isdefined('cookie.LOGGEDINAGENTID')>
	<cfquery datasource="#mls.dsn#" name="myPlans">
		select Lib_PlanName,Lib_LeadScore,Lib_PlanID
		from drip_library
		where Lib_AgentID = <cfqueryparam value="#cookie.LOGGEDINAGENTID#" cfsqltype="cf_sql_integer">
		order by Lib_LeadScore,Lib_PlanName
	</cfquery>
	<cfquery datasource="#mls.dsn#" name="otherPlans">
		select Lib_PlanName,Lib_LeadScore,Lib_PlanID
		from drip_library
		where Lib_AgentID <> <cfqueryparam value="#cookie.LOGGEDINAGENTID#" cfsqltype="cf_sql_integer">
		order by Lib_LeadScore,Lib_PlanName
	</cfquery>
<cfelse>
	<cfquery datasource="#mls.dsn#" name="otherPlans">
		select Lib_PlanName,Lib_LeadScore,Lib_PlanID
		from drip_library
		order by Lib_LeadScore,Lib_PlanName
	</cfquery>
</cfif>
<!--- END: Get Sharing Library --->