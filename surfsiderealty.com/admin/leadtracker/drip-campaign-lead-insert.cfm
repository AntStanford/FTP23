<cfset StartDate = CreateODBCDate(now())>

<!--- <cfdump var="#form#"><cfdump var="#startdate#"> --->

	<!--- To ensure certain fields  are accounted for --->
	<cfparam name="form.AutoPauseEmail" default="0" type="any">
	<cfparam name="form.AutoPauseTalk" default="0" type="any">
	<cfparam name="form.TurnToCold" default="0" type="any">
	<cfparam name="form.StartNow" default="0" type="any">
	<cfparam name="form.LeadScore" default="0" type="any">

<!--- Insert Main Campaign Information --->
<cfquery datasource="#mls.dsn#" name="InsertCampaign">
insert into drip_campaigns(CreatedAt,ClientID,AgentID,PlanName,PlanDescription,LeadScore,AutoPauseEmail,AutoPauseTalk,RepeatCampaign,RepeatAfter,TurnToCold<cfif isdefined('form.StartNow') and form.StartNow eq 1>,status,DripStartDate</cfif>)
	values(
		<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(), 'yyyy-mm-dd')#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
		,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PlanName#">
		,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PlanDescription#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="0">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AutoPauseEmail#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AutoPauseTalk#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.RepeatCampaign#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.RepeatAfter#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.TurnToCold#">
		<cfif isdefined('form.StartNow') and form.StartNow eq 1>
		,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
		,<cfqueryparam cfsqltype="cf_sql_date" value="#StartDate#">
		</cfif>
		)
</cfquery>


<!--- Create Email Dates For Each Step --->
<cfif isdefined('form.StartNow') and form.StartNow eq 1>

	<!--- Step One --->
	<cfif form.StepOneTemplateID neq 0 and LEN(form.StepOneSubject) and LEN(form.StepOneMessageBody)>
		<cfset StepOneDate = DateAdd('d',form.StepOneWait,StartDate)>
	</cfif>

	<!--- Step Two --->
	<cfif form.StepTwoTemplateID neq 0 and LEN(form.StepTwoSubject) and LEN(form.StepTwoMessageBody)>
		<cfset StepTwoDate = DateAdd('d',form.StepTwoWait,StartDate)>
	</cfif>

	<!--- Step Three --->
	<cfif form.StepThreeTemplateID neq 0 and LEN(form.StepThreeSubject) and LEN(form.StepThreeMessageBody)>
		<cfset StepThreeDate = DateAdd('d',form.StepThreeWait,StartDate)>
	</cfif>

	<!--- Step Four --->
	<cfif form.StepFourTemplateID neq 0 and LEN(form.StepFourSubject) and LEN(form.StepFourMessageBody)>
		<cfset StepFourDate = DateAdd('d',form.StepFourWait,StartDate)>
	</cfif>

	<!--- Step One --->
	<cfif form.StepFiveTemplateID neq 0 and LEN(form.StepFiveSubject) and LEN(form.StepFiveMessageBody)>
		<cfset StepFiveDate = DateAdd('d',form.StepFiveWait,StartDate)>
	</cfif>

</cfif>

<!--- Get Campaign ID of above --->
<cfquery datasource="#mls.dsn#" name="getLastCampaign">
	select  ID
	from drip_campaigns
	where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
	order by ID desc
	limit 1
</cfquery>


<cfif getLastCampaign.recordcount eq 1>
<!--- AttachedFileURL FileLinkText --->

<!--- Step One --->
<cfif form.StepOneTemplateID neq 0 and LEN(form.StepOneSubject) and LEN(form.StepOneMessageBody)>

	<cfquery datasource="#mls.dsn#" name="InsertStepOne">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif isdefined('form.StartNow') and form.StartNow eq 1>,ScheduledDate</cfif>,ScheduledTime,Status)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="1">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepOneWait#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepOneTemplateID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepOneMessageBody#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepOneSubject)#">
					<cfif isdefined('form.StartNow') and form.StartNow eq 1>
						,<cfqueryparam cfsqltype="cf_sql_date" value="#StepOneDate#">
					</cfif>
					,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepOneSendAt#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
				)
	</cfquery>

</cfif>

<!--- Step Two --->
<cfif form.StepTwoTemplateID neq 0 and LEN(form.StepTwoSubject) and LEN(form.StepTwoMessageBody)>

	<cfquery datasource="#mls.dsn#" name="InsertStepOne">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif isdefined('form.StartNow') and form.StartNow eq 1>,ScheduledDate</cfif>,ScheduledTime,Status)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="2">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepTwoWait#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepTwoTemplateID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepTwoMessageBody#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepTwoSubject)#">
					<cfif isdefined('form.StartNow') and form.StartNow eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepTwoDate#"></cfif>
					,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepTwoSendAt#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
				)
	</cfquery>

</cfif>

<!--- Step Three --->
<cfif form.StepThreeTemplateID neq 0 and LEN(form.StepThreeSubject) and LEN(form.StepThreeMessageBody)>

	<cfquery datasource="#mls.dsn#" name="InsertStepOne">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif isdefined('form.StartNow') and form.StartNow eq 1>,ScheduledDate</cfif>,ScheduledTime,Status)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="3">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepThreeWait#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepThreeTemplateID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepThreeMessageBody#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepThreeSubject)#">
					<cfif isdefined('form.StartNow') and form.StartNow eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepThreeDate#"></cfif>
					,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepThreeSendAt#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
				)
	</cfquery>

</cfif>

<!--- Step Four --->
<cfif form.StepFourTemplateID neq 0 and LEN(form.StepFourSubject) and LEN(form.StepFourMessageBody)>

	<cfquery datasource="#mls.dsn#" name="InsertStepOne">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif isdefined('form.StartNow') and form.StartNow eq 1>,ScheduledDate</cfif>,ScheduledTime,Status)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="4">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFourWait#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFourTemplateID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepFourMessageBody#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepFourSubject)#">
					<cfif isdefined('form.StartNow') and form.StartNow eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepFourDate#"></cfif>
					,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepFourSendAt#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
				)
	</cfquery>

</cfif>

<!--- Step Five --->
<cfif form.StepFiveTemplateID neq 0 and LEN(form.StepFiveSubject) and LEN(form.StepFiveMessageBody)>

	<cfquery datasource="#mls.dsn#" name="InsertStepOne">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif isdefined('form.StartNow') and form.StartNow eq 1>,ScheduledDate</cfif>,ScheduledTime,Status)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="5">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFiveWait#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFiveTemplateID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepFiveMessageBody#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepFiveSubject)#">
					<cfif isdefined('form.StartNow') and form.StartNow eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepFiveDate#"></cfif>
					,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepFiveSendAt#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
				)
	</cfquery>

</cfif>


</cfif>
	<cfinclude template="drip-campaign-lead-update-upload.cfm">
	<cflocation url="#cgi.script_name#?campaignid=#getLastCampaign.ID#&clientid=#form.ClientID#" addtoken="false">


