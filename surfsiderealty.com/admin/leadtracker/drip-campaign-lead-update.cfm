<cfset StartDate = CreateODBCDate(now())>
	<!--- To ensure certain fields  are accounted for --->
	<cfparam name="form.AutoPauseEmail" default="0" type="any">
	<cfparam name="form.AutoPauseTalk" default="0" type="any">
	<cfparam name="form.TurnToCold" default="0" type="any">
	<cfparam name="form.StartNow" default="0" type="any">
	<cfparam name="form.LeadScore" default="0" type="any">


<!--- This sets Scheduling Dates for each entry --->
<cfinclude template="drip-campaign-lead-set-dates.cfm">


	<!--- Update Main Campaign Information --->
<cfquery datasource="#mls.dsn#" name="UpdateCampaign">
Update drip_campaigns
Set 
	PlanName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PlanName#">
	,PlanDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PlanDescription#">
	,AutoPauseEmail = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AutoPauseEmail#">
	,AutoPauseTalk = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AutoPauseTalk#">
	,RepeatCampaign = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RepeatCampaign#">
	,RepeatAfter = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RepeatAfter#">
	,TurnToCold = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.TurnToCold#">
	<cfif isDefined('form.startnow') and form.startnow eq 1>
	,DripStartDate = <cfqueryparam cfsqltype="cf_sql_date" value="#StartDate#">
	,Status = <cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
	</cfif>
Where AgentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#"> and id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.CampaignID#">
</cfquery>


	<!--- If already exists, update entry else insert entry --->
	<cfif isdefined('HasOne')>

		<cfquery datasource="#mls.dsn#" name="InsertStepOne">
			Update drip_entries
			Set	
				OriginalTemplateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepOneTemplateID#">,
				ModifiedTemplate = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepOneMessageBody#">,
				EmailSubject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepOneSubject)#">
				<cfif isdefined('StepOneDate')>,ScheduledDate = <cfqueryparam cfsqltype="cf_sql_date" value="#StepOneDate#"></cfif>
			Where StepNum = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#"> and campaignid = <cfqueryparam value="#form.CampaignID#" cfsqltype="cf_sql_integer">
		</cfquery>

	<cfelseif NOT isdefined('HasOne') and form.StepOneTemplateID neq 0 and LEN(form.StepOneSubject) and LEN(form.StepOneMessageBody)>

		<cfif LEN(getCampaign.DripStartDate)><cfset StepOneDate = DateAdd('d',form.StepOneWait,getCampaign.DripStartDate)></cfif>

		<cfquery datasource="#mls.dsn#" name="InsertStepOne">
			insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif LEN(getCampaign.DripStartDate)>,ScheduledDate</cfif>,ScheduledTime,Status)
				values(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#form.CampaignID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="1">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepOneWait#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepOneTemplateID#">
						,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepOneMessageBody#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepOneSubject)#">
						<cfif isdefined('StepOneDate')>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepOneDate#"></cfif>
						,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepOneSendAt#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.status#">
					)
		</cfquery>

	</cfif>


	<!--- If already exists, update entry else insert entry --->
	<cfif isdefined('HasTwo')>

		<cfquery datasource="#mls.dsn#" name="InsertStepTwo">
			Update drip_entries
			Set	
				OriginalTemplateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepTwoTemplateID#">,
				ModifiedTemplate = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepTwoMessageBody#">,
				EmailSubject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepTwoSubject)#">
				<cfif isdefined('StepTwoDate')>,ScheduledDate = <cfqueryparam cfsqltype="cf_sql_date" value="#StepTwoDate#"></cfif>
			Where StepNum = <cfqueryparam cfsqltype="cf_sql_integer" value="2"> and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#"> and campaignid = <cfqueryparam value="#form.CampaignID#" cfsqltype="cf_sql_integer">
		</cfquery>

	<cfelseif NOT isdefined('HasTwo') and form.StepTwoTemplateID neq 0 and LEN(form.StepTwoSubject) and LEN(form.StepTwoMessageBody)>

		<cfif LEN(getCampaign.DripStartDate)><cfset StepTwoDate = DateAdd('d',form.StepTwoWait,getCampaign.DripStartDate)></cfif>

		<cfquery datasource="#mls.dsn#" name="InsertStepTWo">
			insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif LEN(getCampaign.DripStartDate)>,ScheduledDate</cfif>,ScheduledTime,Status)
				values(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#form.CampaignID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="2">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepTwoWait#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepTwoTemplateID#">
						,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepTwoMessageBody#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepTwoSubject)#">
						<cfif isdefined('StepTwoDate')>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepTwoDate#"></cfif>
						,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepTwoSendAt#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.status#">
					)
		</cfquery>

	</cfif>



	<!--- If already exists, update entry else insert entry --->
	<cfif isdefined('HasThree')>

		<cfquery datasource="#mls.dsn#" name="InsertStepThree">
			Update drip_entries
			Set	
				OriginalTemplateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepThreeTemplateID#">,
				ModifiedTemplate = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepThreeMessageBody#">,
				EmailSubject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepThreeSubject)#">
				<cfif isdefined('StepThreeDate')>,ScheduledDate = <cfqueryparam cfsqltype="cf_sql_date" value="#StepThreeDate#"></cfif>
			Where StepNum = <cfqueryparam cfsqltype="cf_sql_integer" value="3"> and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#"> and campaignid = <cfqueryparam value="#form.CampaignID#" cfsqltype="cf_sql_integer">
		</cfquery>

	<cfelseif NOT isdefined('HasThree') and form.StepThreeTemplateID neq 0 and LEN(form.StepThreeSubject) and LEN(form.StepThreeMessageBody)>

		<cfif LEN(getCampaign.DripStartDate)><cfset StepThreeDate = DateAdd('d',form.StepThreeWait,getCampaign.DripStartDate)></cfif>

		<cfquery datasource="#mls.dsn#" name="InsertStepThree">
			insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif LEN(getCampaign.DripStartDate)>,ScheduledDate</cfif>,ScheduledTime,Status)
				values(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#form.CampaignID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="3">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepThreeWait#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepThreeTemplateID#">
						,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepThreeMessageBody#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepThreeSubject)#">
						<cfif isdefined('StepThreeDate')>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepThreeDate#"></cfif>
						,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepThreeSendAt#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.status#">
					)
		</cfquery>

	</cfif>



	<!--- If already exists, update entry else insert entry --->
	<cfif isdefined('HasFour')>

		<cfquery datasource="#mls.dsn#" name="InsertStepFour">
			Update drip_entries
			Set	
				OriginalTemplateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFourTemplateID#">,
				ModifiedTemplate = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepFourMessageBody#">,
				EmailSubject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepFourSubject)#">
				<cfif isdefined('StepFourDate')>,ScheduledDate = <cfqueryparam cfsqltype="cf_sql_date" value="#StepFourDate#"></cfif>
			Where StepNum = <cfqueryparam cfsqltype="cf_sql_integer" value="4"> and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#"> and campaignid = <cfqueryparam value="#form.CampaignID#" cfsqltype="cf_sql_integer">
		</cfquery>

	<cfelseif NOT isdefined('HasFour') and form.StepFourTemplateID neq 0 and LEN(form.StepFourSubject) and LEN(form.StepFourMessageBody)>

		<cfif LEN(getCampaign.DripStartDate)><cfset StepFourDate = DateAdd('d',form.StepFourWait,getCampaign.DripStartDate)></cfif>

		<cfquery datasource="#mls.dsn#" name="InsertStepFour">
			insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif LEN(getCampaign.DripStartDate)>,ScheduledDate</cfif>,ScheduledTime,Status)
				values(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#form.CampaignID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="4">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFourWait#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFourTemplateID#">
						,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepFourMessageBody#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepFourSubject)#">
						<cfif isdefined('StepFourDate')>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepFourDate#"></cfif>
						,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepFourSendAt#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.status#">
					)
		</cfquery>

	</cfif>



	<!--- If already exists, update entry else insert entry --->
	<cfif isdefined('HasFive')>

		<cfquery datasource="#mls.dsn#" name="InsertStepFive">
			Update drip_entries
			Set	
				OriginalTemplateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFiveTemplateID#">,
				ModifiedTemplate = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepFiveMessageBody#">,
				EmailSubject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepFiveSubject)#">
				<cfif isdefined('StepFiveDate')>,ScheduledDate = <cfqueryparam cfsqltype="cf_sql_date" value="#StepFiveDate#"></cfif>
			Where StepNum = <cfqueryparam cfsqltype="cf_sql_integer" value="5"> and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#"> and campaignid = <cfqueryparam value="#form.CampaignID#" cfsqltype="cf_sql_integer">
		</cfquery>

	<cfelseif NOT isdefined('HasFive') and form.StepFiveTemplateID neq 0 and LEN(form.StepFiveSubject) and LEN(form.StepFiveMessageBody)>

		<cfif LEN(getCampaign.DripStartDate)><cfset StepFiveDate = DateAdd('d',form.StepFiveWait,getCampaign.DripStartDate)></cfif>

		<cfquery datasource="#mls.dsn#" name="InsertStepFour">
			insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject<cfif LEN(getCampaign.DripStartDate)>,ScheduledDate</cfif>,ScheduledTime,Status)
				values(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#form.CampaignID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AgentID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ClientID#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="5">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFiveWait#">
						,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.StepFiveTemplateID#">
						,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.StepFiveMessageBody#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#cleanSubject(form.StepFiveSubject)#">
						<cfif isdefined('StepFiveDate')>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepFiveDate#"></cfif>
						,<cfqueryparam cfsqltype="cf_sql_time" value="#form.StepFiveSendAt#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.status#">
					)
		</cfquery>

	</cfif>

	<cfinclude template="drip-campaign-lead-update-upload.cfm">

	<cflocation url="#cgi.script_name#?campaignid=#form.CampaignID#&clientid=#form.ClientID#" addtoken="false">