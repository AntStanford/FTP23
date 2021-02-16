<cfoutput>
<form method="post">

	<select name="month">
		<cfloop from="1" to="12" index="i">
			<option>#i#</option>
		</cfloop>
	</select>

	<select name="day">
		<cfloop from="1" to="31" index="i">
			<option>#i#</option>
		</cfloop>
	</select>

	<select name="year">
			<option>2014</option>
			<option>2015</option>
	</select>
@
	<select name="hour">
		<cfloop from="1" to="23" index="i">
			<option>#i#</option>
		</cfloop>
	</select>

	<select name="minute">
		<cfloop from="1" to="59" index="i">
			<option>#i#</option>
		</cfloop>
	</select>

	<select name="ampm">
			<option>AM</option>
			<option>PM</option>
	</select>


	<input type="submit" value="Test Scheduled Task">

</form>

</cfoutput>


<cfif cgi.request_method eq 'post'>

<!--- <cfset TodaysDate = CreateODBCDate(now())>
<cfset TodaysTime = CreateODBCTime(now())> --->
<cfset TodaysDate = CreateDate(form.year, form.month, form.day)>
<cfset TodaysTime = CreateTime(form.hour, form.minute, form.day)>

<cfset current.thisMinute = Minute(TodaysTime)>
<cfset current.thisHour = Hour(TodaysTime)>
<cfif current.thisMinute gte 30>
	<cfset current.thisTime = current.thisHour & ':30'>
<cfelse>
	<cfset current.thisTime = current.thisHour & ':00'>
</cfif>
<cfset TodaysTime = CreateODBCTime(current.thisTime)>

<!--- Get Scheduled Entries/Steps for Campaigns that are Active --->
<cfquery datasource="#mls.dsn#" name="getCampaignEntries">
	SELECT drip_entries.*,drip_campaigns.OnRepeat as OnRepeat,drip_entries.id as entryid,drip_campaigns.DripStartDate,drip_campaigns.AutoPauseEmail,drip_campaigns.AutoPauseTalk
	FROM drip_entries
	LEFT JOIN drip_campaigns ON drip_entries.campaignid = drip_campaigns.id
	WHERE drip_campaigns.status = <cfqueryparam value="Active" cfsqltype="cf_sql_varchar"> 
	and drip_entries.ScheduledDate = <cfqueryparam value="#TodaysDate#" cfsqltype="cf_sql_date">
	and  drip_entries.ScheduledTime = <cfqueryparam value="#TodaysTime#" cfsqltype="cf_sql_time">
	and (drip_entries.LastSent <> <cfqueryparam value="#TodaysDate#" cfsqltype="cf_sql_date"> or drip_entries.LastSent is NULL)
</cfquery>


<cfdump var="#TodaysDate#">
<cfdump var="#TodaysTime#">
<cfdump var="#getCampaignEntries#">




<cfoutput query="getCampaignEntries">


<!--- Get Client Info --->
<cfquery datasource="#mls.dsn#" name="getClientInfo">
	SELECT id,email,firstname,lastname,camefromwebsite,password
	FROM cl_accounts
	WHERE id = <cfqueryparam value="#getCampaignEntries.CLIENTID#" cfsqltype="cf_sql_integer">
</cfquery>

<!--- Get Agent Info --->
<cfquery datasource="#mls.dsn#" name="getAgentInfo">
	SELECT email,firstname,lastname,phone,cellphone,agentphoto
	FROM cl_agents
	WHERE id = <cfqueryparam value="#getCampaignEntries.AGENTID#" cfsqltype="cf_sql_integer">
</cfquery>


<!--- Set to 0 if Auto Pause trips --->
<cfset sendemail = 1>

<!--- Auto-Pause Check for Phone Calls --->
<cfquery datasource="#mls.dsn#" name="getCalls">
	SELECT id
	FROM cl_phonecalls
	WHERE clientid = <cfqueryparam value="#getCampaignEntries.CLIENTID#" cfsqltype="cf_sql_integer"> and
	Date(calldatetime) >= <cfqueryparam value="#getCampaignEntries.DripStartDate#" cfsqltype="cf_sql_date"> and callresult = <cfqueryparam value="Answered" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif getCalls.recordcount gt 0 and getCampaignEntries.AutoPauseTalk eq 1><cfset sendemail = 0></cfif>


<!--- Auto-Pause Check for Emails --->
<cfquery datasource="#mls.dsn#" name="getEmail">
	SELECT id
	FROM cl_leadtracker_response
	WHERE clientid = <cfqueryparam value="#getCampaignEntries.CLIENTID#" cfsqltype="cf_sql_integer"> and
	Date(createdat) >= <cfqueryparam value="#getCampaignEntries.DripStartDate#" cfsqltype="cf_sql_date"> and 
	FromOrTo = <cfqueryparam value="Waiting on Agent's Response" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif getEmail.recordcount gt 0 and getCampaignEntries.AutoPauseEmail eq 1><cfset sendemail = 0></cfif>


<cfdump var="#getClientInfo#">
<cfdump var="#getAgentInfo#">
<cfdump var="#getCalls#">
<cfdump var="#getEmail#">

<cfdump var="#sendemail#">




<!--- Setting Dynamic Variables for the Email --->

	<cfset whichsite = "site">
	<cfset siteaddress = mls.companyurl>
	<cfset shortaddress = mls.companyurl>
	<cfset companyname = mls.companyname>


<cfoutput>
<cfset encryptedID = EncryptID(#getClientInfo.id#)>
<cfset body = MODIFIEDTEMPLATE>
<cfset body = #replacenocase(body,'!id!',encryptedID,"all")#>
<cfset body = #replacenocase(body,'%21',encryptedID,"all")#>
<cfset body = #replacenocase(body,'{{Firstname}}',getClientInfo.firstname,"all")#>
<cfset body = #replacenocase(body,'{{lastname}}',getClientInfo.lastname,"all")#>
<cfset body = #replacenocase(body,'{{email}}',getClientInfo.email,"all")#>
<cfset body = #replacenocase(body,'{{password}}',getClientInfo.password,"all")#>
<cfset body = #replacenocase(body,'{{fulllink}}',siteaddress,"all")#>
<cfset body = #replacenocase(body,'{{www}}',shortaddress,"all")#>
<cfset body = #replacenocase(body,'{{agentsignature}}',getAgentInfo.firstname & '<br><br>' & '<b>' & getAgentInfo.firstname & ' ' & getAgentInfo.lastname & '</b>' & '<br>' & companyname  & '<br>' & 'Office:' & getAgentInfo.phone & '<br>' & 'Cell:' & getAgentInfo.cellphone,"all")#>
<cfif len(getAgentInfo.agentphoto)>
	<cfset body = #replacenocase(body,'{{agentsignature}}',getAgentInfo.firstname & '<br><br>' & '<b>' & getAgentInfo.firstname & ' ' & getAgentInfo.lastname & '</b>' & '<br>' & companyname  & '<br>' & 'Office:' & getAgentInfo.phone & '<br>' & 'Cell:' & getAgentInfo.cellphone & '<br>' & '<img src="#siteaddress#/mls/images/agents/' & #getAgentInfo.agentphoto# & '">',"all")#>
<cfelse>
	<cfset body = #replacenocase(body,'{{agentsignature}}',getAgentInfo.firstname & '<br><br>' & '<b>' & getAgentInfo.firstname & ' ' & getAgentInfo.lastname & '</b>' & '<br>' & companyname  & '<br>' & 'Office:' & getAgentInfo.phone & '<br>' & 'Cell:' & getAgentInfo.cellphone,"all")#>
</cfif>
</cfoutput>
<!--- ADD EMAIL CODE --->
EMAIL SENT.

#reReplace(body, '\n', '<br />', 'ALL')#



<!--- ONLY SEND EMAILS IF NO AUTO-PAUSE QUERY TRIPPED --->
<cfif sendemail eq 1>


	<!--- SEND EMAIL--->
	<cfmail from="#getAgentInfo.email# <#cfmail.username#>" to="#getClientInfo.email#" subject="#EMAILSUBJECT#" type="html" replyto="#mls.adminemail#" username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#">
		<cfoutput>#reReplace(body, '\n', '<br />', 'ALL')#</cfoutput>
		<p style="color:black;" align="center">To stop receiving future emails, <a hreflang="en" href="#siteaddress#/unsubscribe.cfm?email=#getAgentInfo.email#">unsubscribe here</a>.</p>
		<!--this must stay for tracking-->
		<img src="http://www.hiltonheadhomes.com/mls/drip-tracker.cfm?dci=#getCampaignEntries.campaignid#&eid=#getCampaignEntries.entryid#&ds=#DateFormat(now(), 'yyyy-mm-dd')#" alt="" border="0"  style="display:none;">
		<!--this must stay for tracking-->
	</cfmail>



	<!--- Update Sent Date for Entry --->
	<cfquery datasource="#mls.dsn#" name="UpdateEntry">
		Update drip_entries
		Set LastSent = <cfqueryparam value="#TodaysDate#" cfsqltype="cf_sql_date">
		Where CampaignID = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer"> and id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Update Last Sent Campaign--->
	<cfquery datasource="#mls.dsn#" name="UpdateEntry">
		Update drip_campaigns
		Set LastSent = <cfqueryparam value="#TodaysDate#" cfsqltype="cf_sql_date">
		Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- Insert into History--->
	<cfquery datasource="#mls.dsn#" name="UpdateEntry">
		Insert Into drip_history (CampaignID,ClientID,StepNum,DateSent,TimeSent,EmailSubject,EntryID)
			Values(
				 <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#getCampaignEntries.CLIENTID#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#getCampaignEntries.StepNum#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#DateFormat(now(), 'yyyy-mm-dd')#" cfsqltype="cf_sql_date">
				,<cfqueryparam value="#TimeFormat(now(), 'hh:mm:ss')#" cfsqltype="cf_sql_time">
				,<cfqueryparam value="#EMAILSUBJECT#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#getCampaignEntries.entryid#" cfsqltype="cf_sql_integer">
				)
	</cfquery>


	<!--- Check For Next Step --->
	<cfquery datasource="#mls.dsn#" name="CheckNextSteps">
		Select StepNum
		From drip_entries
		Where CampaignID = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer"> and StepNum = <cfqueryparam value="#(StepNum + 1)#" cfsqltype="cf_sql_integer">
		Limit 1
	</cfquery>


	<!--- If Next Step, Update Campaign NextStep --->
	<cfif CheckNextSteps.recordcount eq 1>

		<cfquery datasource="#mls.dsn#" name="UpdateNextStep">
			Update drip_campaigns
			Set NextStep = <cfqueryparam value="#(StepNum + 1)#" cfsqltype="cf_sql_integer">
			Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
		</cfquery>
		
	<cfelse> <!--- If No Next Step, Look to see if Campaign repeats --->

		<cfquery datasource="#mls.dsn#" name="getRepeat">
			Select RepeatCampaign,OnRepeat,RepeatAfter
			From drip_campaigns
			Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer"> and RepeatCampaign > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfdump var="#getRepeat#">

		<cfif getRepeat.recordcount gt 0>

			<cfparam name="ThisRepeat" default="0">

			<!--- If the OnRepeat number is less than the amount of times Repeated, Reschule --->
			<cfif getRepeat.OnRepeat LT getRepeat.RepeatCampaign>

					<cfset NewStartDate = DateAdd('d', getRepeat.RepeatAfter, TodaysDate)>

					<cfif LEN(getRepeat.OnRepeat) eq 0>
						<cfset ThisRepeat = 0>
					<cfelse>
						<cfset ThisRepeat = getRepeat.OnRepeat>
					</cfif>

					<cfset ThisRepeat = (ThisRepeat +1)>

					<cfquery datasource="#mls.dsn#" name="UpdateNextStep">
						Update drip_campaigns
						Set NextStep = <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
							DripStartDate = <cfqueryparam value="#NewStartDate#" cfsqltype="cf_sql_date">,
							OnRepeat = <cfqueryparam value="#ThisRepeat#" cfsqltype="cf_sql_integer">
						Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
					</cfquery>

					<!--- Get all Entries/Steps to update schedule dates --->
					<cfquery datasource="#mls.dsn#" name="getEntries">
						Select id,WaitDays,campaignid
						From drip_entries
						Where CampaignID = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
					</cfquery>

						<cfdump var="#getEntries#">
						<cfloop query="getEntries">
							#DateAdd('d', getEntries.WaitDays, NewStartDate)#
							<!--- Update SChedule Date --->
							<cfquery datasource="#mls.dsn#" name="CheckNextSteps">
								Update drip_entries
								Set ScheduledDate = <cfqueryparam value="#DateAdd('d', getEntries.WaitDays, NewStartDate)#" cfsqltype="cf_sql_date">
								Where CampaignID = <cfqueryparam value="#getEntries.campaignid#" cfsqltype="cf_sql_integer"> and id = <cfqueryparam value="#getEntries.id#" cfsqltype="cf_sql_integer">
							</cfquery>

						</cfloop>


				<cfelse>


				<!--- Change to Finished, Check for Cold Update --->
					<cfquery datasource="#mls.dsn#" name="FinishCampaign">
						Update drip_campaigns
						Set Status = <cfqueryparam value="Finished" cfsqltype="cf_sql_varchar">
						Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
					</cfquery>

				

					<cfquery datasource="#mls.dsn#" name="checkCold">
						Select TurnToCold
						From drip_campaigns
						Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
					</cfquery>

					<!--- Update LEad to Cold --->
					<cfif checkCold.recordcount gt 0>
						<cfquery datasource="#mls.dsn#" name="UpdateRating">
							Update cl_accounts
							Set Rating = <cfqueryparam value="4" cfsqltype="cf_sql_varchar">
							Where id = <cfqueryparam value="#getCampaignEntries.clientid#" cfsqltype="cf_sql_integer">
						</cfquery>
					</cfif>


			 </cfif>

		<cfelse>

			<!--- Change to Finished, Check for Cold Update --->
				<cfquery datasource="#mls.dsn#" name="Finish">
					Update drip_campaigns
					Set Status = <cfqueryparam value="Finished" cfsqltype="cf_sql_varchar">
					Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
				</cfquery>

		

				<cfquery datasource="#mls.dsn#" name="checkCold">
					Select TurnToCold
					From drip_campaigns
					Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
				</cfquery>

				<!--- Update LEad to Cold --->
				<cfif checkCold.recordcount gt 0>
					<cfquery datasource="#mls.dsn#" name="Finish">
						Update cl_accounts
						Set Rating = <cfqueryparam value="4" cfsqltype="cf_sql_varchar">
						Where id = <cfqueryparam value="#getCampaignEntries.clientid#" cfsqltype="cf_sql_integer">
					</cfquery>
				</cfif>


		</cfif>



	</cfif>


<cfelse>

	<!--- IF AutoPause  is tripped, Update Campaign to Paused and Set Pause Date --->

		<cfquery datasource="#mls.dsn#" name="UpdateNextStep">
			Update drip_campaigns
			Set status = <cfqueryparam value="Paused" cfsqltype="cf_sql_varchar">,
				PausedOn = <cfqueryparam value="#CreateODBCDate(now())#" cfsqltype="cf_sql_date">
			Where id = <cfqueryparam value="#campaignid#" cfsqltype="cf_sql_integer">
		</cfquery>


</cfif>


</cfoutput>



</cfif>