<cftry>



<!---START: Check ClientID and PlanID to continue --->
<cfif isdefined('url.clientid') is "No" or 
		isDefined('url.planid') is "No" or
		isdefined('url.clientid') and LEN(url.clientid) is '0' or
		isdefined('url.planid') and LEN(url.planid) is '0'>
	A Client and Plan must be selected.
	<cfabort>
</cfif>
<!--- END: Check ClientID and PlanID to continue --->

<!--- START: Make Sure Client Exists --->
<cfquery datasource="#mls.dsn#" name="checkLead">
	select id,agentid
	from cl_accounts
	where id = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif checkLead.recordcount eq 0>
		This Lead cannot be found.
	<cfabort>
</cfif>
<!--- END: Make Sure Client Exists --->


<!--- START: Make sure there are no campaigns already running for this ClientID --->
<cfquery datasource="#mls.dsn#" name="checkActive">
	select Count(id) as thecount
	from drip_campaigns
	where clientid = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer"> and status = <cfqueryparam value="Active" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif checkActive.thecount gt 0>
	There is already an active campaign running for this Lead.
	<cfabort>
</cfif>
<!--- END: Make sure there are no campaigns already running for this ClientID --->


<!--- START: Make Sure Library Exists --->
<cfquery datasource="#mls.dsn#" name="checkLibrary">
	select *
	from drip_library
	where Lib_PlanID = <cfqueryparam value="#url.planid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif checkLibrary.recordcount eq 0>
		There selected Plan from the Drip Library cannot be found.
	<cfabort>
</cfif>
<!--- END: Make Sure Library Exists --->



<!--- Now that we've made sure the Lead exists, there are no campaigns for the Lead and the Plan exists in the Library - we can continue to set up campaign --->

<!--- We already pulled the Plan from the Library in 'checkLibrary' query above --->


<!--- 
<cfdump var="#checkLibrary#">
LIB_1_MODIFIEDTEMPLATE	
LIB_1_SCHEDULEDTIME	
LIB_1_SUBJECT	
LIB_1_TEMPLATEID	
LIB_1_WAITDAYS	
LIB_2_MODIFIEDTEMPLATE	
LIB_2_SCHEDULEDTIME	
LIB_2_SUBJECT	
LIB_2_TEMPLATEID	
LIB_2_WAITDAYS	
LIB_3_MODIFIEDTEMPLATE	
LIB_3_SCHEDULEDTIME	
LIB_3_SUBJECT	
LIB_3_TEMPLATEID	
LIB_3_WAITDAYS	
LIB_4_MODIFIEDTEMPLATE	
LIB_4_SCHEDULEDTIME	
LIB_4_SUBJECT	
LIB_4_TEMPLATEID	
LIB_4_WAITDAYS	
LIB_5_MODIFIEDTEMPLATE	
LIB_5_SCHEDULEDTIME	
LIB_5_SUBJECT	
LIB_5_TEMPLATEID	
LIB_5_WAITDAYS	
LIB_AGENTID	
LIB_AUTOPAUSEEMAIL	
LIB_AUTOPAUSETALK	
LIB_CREATEDAT	
LIB_LEADSCORE	
LIB_PLANDESCRIPTION	
LIB_PLANID	
LIB_PLANNAME	
LIB_REPEATAFTER	
LIB_REPEATCAMPAIGN	
LIB_TURNTOCOLD	
LIB_UPDATEDAT

 --->

<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>
	<cfset StartDate = dateformat(now(), 'yyyy-mm-dd')>

	<!--- Create Email Dates For Each Step --->
		<!--- Step One --->
		<cfif LEN(checkLibrary.LIB_1_TEMPLATEID) and LEN(checkLibrary.LIB_1_SUBJECT) and LEN(checkLibrary.LIB_1_MODIFIEDTEMPLATE)>
			<cfset StepOneDate = DateAdd('d',checkLibrary.LIB_1_WAITDAYS,StartDate)>
		</cfif>

		<!--- Step Two --->
		<cfif LEN(checkLibrary.LIB_2_TEMPLATEID) and LEN(checkLibrary.LIB_2_SUBJECT) and LEN(checkLibrary.LIB_2_MODIFIEDTEMPLATE)>
			<cfset StepTwoDate = DateAdd('d',checkLibrary.LIB_2_WAITDAYS,StartDate)>
		</cfif>

		<!--- Step Three --->
		<cfif LEN(checkLibrary.LIB_3_TEMPLATEID) and LEN(checkLibrary.LIB_3_SUBJECT) and LEN(checkLibrary.LIB_3_MODIFIEDTEMPLATE)>
			<cfset StepThreeDate = DateAdd('d',checkLibrary.LIB_3_WAITDAYS,StartDate)>
		</cfif>

		<!--- Step Four --->
		<cfif LEN(checkLibrary.LIB_4_TEMPLATEID) and LEN(checkLibrary.LIB_4_SUBJECT) and LEN(checkLibrary.LIB_4_MODIFIEDTEMPLATE)>
			<cfset StepFourDate = DateAdd('d',checkLibrary.LIB_4_WAITDAYS,StartDate)>
		</cfif>

		<!--- Step Five --->
		<cfif LEN(checkLibrary.LIB_5_TEMPLATEID) and LEN(checkLibrary.LIB_5_SUBJECT) and LEN(checkLibrary.LIB_5_MODIFIEDTEMPLATE)>
			<cfset StepFiveDate = DateAdd('d',checkLibrary.LIB_5_WAITDAYS,StartDate)>
		</cfif>

</cfif>

<!--- START: Create the main Campaign entry --->
<cfquery datasource="#mls.dsn#" name="InsertCampaign">
insert into drip_campaigns(CreatedAt,ClientID,AgentID,PlanName,LeadScore,AutoPauseEmail,AutoPauseTalk,RepeatCampaign,RepeatAfter,TurnToCold,Lib_PlanID<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,status,DripStartDate</cfif>)
	values(
		<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(), 'yyyy-mm-dd')#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLead.agentid#">
		,<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkLibrary.LIB_PLANNAME#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="0">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_AUTOPAUSEEMAIL#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_AUTOPAUSETALK#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_REPEATCAMPAIGN#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_REPEATAFTER#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_TURNTOCOLD#">
		,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_PLANID#">
		<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>
		,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
		,<cfqueryparam cfsqltype="cf_sql_date" value="#StartDate#">
		</cfif>

		)
</cfquery>
<!--- END: Create the main Campaign entry --->


<!---START: Get Campaign ID of above --->
<cfquery datasource="#mls.dsn#" name="getLastCampaign">
	select ID
	from drip_campaigns
	where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#"> and PlanName = <cfqueryparam value="#checkLibrary.LIB_PLANNAME#" cfsqltype="cf_sql_varchar">
	order by ID desc
	limit 1
</cfquery>
<!---END: Get Campaign ID of above --->





<!--- START: Insert Step 1 --->
<cfif LEN(checkLibrary.LIB_1_TEMPLATEID) and LEN(checkLibrary.LIB_1_SUBJECT) and LEN(checkLibrary.LIB_1_MODIFIEDTEMPLATE)>
	<cfquery datasource="#mls.dsn#" name="InsertStepOne">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject,ScheduledTime,Status<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,ScheduledDate</cfif>)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLead.agentid#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="1">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_1_WAITDAYS#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_1_TEMPLATEID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#checkLibrary.LIB_1_MODIFIEDTEMPLATE#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkLibrary.LIB_1_SUBJECT#">
					,<cfqueryparam cfsqltype="cf_sql_time" value="#checkLibrary.LIB_1_SCHEDULEDTIME#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
					<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepOneDate#"></cfif>
				)
	</cfquery>
</cfif>
<!--- END: Insert Step 1 --->


<!--- START: Insert Step 2 --->
<cfif LEN(checkLibrary.LIB_2_TEMPLATEID) and LEN(checkLibrary.LIB_2_SUBJECT) and LEN(checkLibrary.LIB_2_MODIFIEDTEMPLATE)>
	<cfquery datasource="#mls.dsn#" name="InsertStepTwo">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject,ScheduledTime,Status<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,ScheduledDate</cfif>)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLead.agentid#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="2">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_2_WAITDAYS#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_2_TEMPLATEID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#checkLibrary.LIB_2_MODIFIEDTEMPLATE#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkLibrary.LIB_2_SUBJECT#">
					,<cfqueryparam cfsqltype="cf_sql_time" value="#checkLibrary.LIB_2_SCHEDULEDTIME#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
					<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepTwoDate#"></cfif>
				)
	</cfquery>
</cfif>
<!--- END: Insert Step 2 --->


<!--- START: Insert Step 3 --->
<cfif LEN(checkLibrary.LIB_3_TEMPLATEID) and LEN(checkLibrary.LIB_3_SUBJECT) and LEN(checkLibrary.LIB_3_MODIFIEDTEMPLATE)>
	<cfquery datasource="#mls.dsn#" name="InsertStepThree">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject,ScheduledTime,Status<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,ScheduledDate</cfif>)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLead.agentid#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="3">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_3_WAITDAYS#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_3_TEMPLATEID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#checkLibrary.LIB_3_MODIFIEDTEMPLATE#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkLibrary.LIB_3_SUBJECT#">
					,<cfqueryparam cfsqltype="cf_sql_time" value="#checkLibrary.LIB_3_SCHEDULEDTIME#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
			<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepThreeDate#"></cfif>
				)
	</cfquery>
</cfif>
<!--- END: Insert Step 3 --->


<!--- START: Insert Step 4 --->
<cfif LEN(checkLibrary.LIB_4_TEMPLATEID) and LEN(checkLibrary.LIB_4_SUBJECT) and LEN(checkLibrary.LIB_4_MODIFIEDTEMPLATE)>
	<cfquery datasource="#mls.dsn#" name="InsertStepFour">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject,ScheduledTime,Status<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,ScheduledDate</cfif>)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLead.agentid#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="4">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_4_WAITDAYS#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_4_TEMPLATEID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#checkLibrary.LIB_4_MODIFIEDTEMPLATE#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkLibrary.LIB_4_SUBJECT#">
					,<cfqueryparam cfsqltype="cf_sql_time" value="#checkLibrary.LIB_4_SCHEDULEDTIME#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
					<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepFourDate#"></cfif>
				)
	</cfquery>
</cfif>
<!--- END: Insert Step 4 --->


<!--- START: Insert Step 5 --->
<cfif LEN(checkLibrary.LIB_5_TEMPLATEID) and LEN(checkLibrary.LIB_5_SUBJECT) and LEN(checkLibrary.LIB_5_MODIFIEDTEMPLATE)>
	<cfquery datasource="#mls.dsn#" name="InsertStepFive">
		insert into drip_entries(CampaignID,AgentID,ClientID,StepNum,WaitDays,OriginalTemplateID,ModifiedTemplate,EmailSubject,ScheduledTime,Status<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,ScheduledDate</cfif>)
			values(
					<cfqueryparam cfsqltype="cf_sql_integer" value="#getLastCampaign.ID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLead.agentid#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="5">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_5_WAITDAYS#">
					,<cfqueryparam cfsqltype="cf_sql_integer" value="#checkLibrary.LIB_5_TEMPLATEID#">
					,<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#checkLibrary.LIB_5_MODIFIEDTEMPLATE#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkLibrary.LIB_5_SUBJECT#">
					,<cfqueryparam cfsqltype="cf_sql_time" value="#checkLibrary.LIB_5_SCHEDULEDTIME#">
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active">
					<cfif isdefined('url.AutoStart') and url.AutoStart eq 1>,<cfqueryparam cfsqltype="cf_sql_date" value="#StepFiveDate#"></cfif>
				)
	</cfquery>
</cfif>
<!--- END: Insert Step 1 --->


<cflocation url="/admin/leadtracker/drip-campaign-lead.cfm?campaignid=#getLastCampaign.ID#&clientid=#url.ClientID#" addtoken="false">


<cfcatch>

An error has occurred while creating the campaign and a notification has been sent to Support. Please check Drip Campaigns to check if it was created.

<cfmail to="icnderrors@gmail.com" from="#mls.adminemail# <#cfmail.username#>" replyto="#mls.adminemail#" bcc="#cfmail.bcc#" 
username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" 
subject="HHH Error Drip Create From Library" mimeattach="#UploadPathOutlook#\#CalendarFileName#"  type="html">
	<cfif isdefined('getLastCampaign.ID')>Campaign = #getLastCampaign.ID#<cfelse>Campaign wasn't started</cfif><br>
	Clientid = #url.ClientID#<br>
	PLanID = #url.planid#<br>
	#cfcatch.message#
</cfmail>

</cfcatch>
</cftry>