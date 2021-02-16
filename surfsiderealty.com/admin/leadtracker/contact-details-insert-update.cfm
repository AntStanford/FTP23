
<cfif isdefined('url.id') and LEN(url.id) and isdefined('form.SaveProfile')> <!--- UPDATE CONTACT --->

	<cfquery datasource="#mls.dsn#" name="UpdateInfo">
		Update cl_accounts
		Set FIRSTNAME = <cfqueryparam value="#form.FIRSTNAME#" cfsqltype="cf_sql_varchar">
			,LASTNAME = <cfqueryparam value="#form.LASTNAME#" cfsqltype="cf_sql_varchar">
			,SALUTATION = <cfqueryparam value="#form.SALUTATION#" cfsqltype="cf_sql_varchar">
			,ADDRESS = <cfqueryparam value="#form.ADDRESS#" cfsqltype="cf_sql_varchar">
			,COMPANY = <cfqueryparam value="#form.COMPANY#" cfsqltype="cf_sql_varchar">
			,State = <cfqueryparam value="#form.State#" cfsqltype="cf_sql_varchar">
			,CITY = <cfqueryparam value="#form.CITY#" cfsqltype="cf_sql_varchar">
			,ZIP = <cfqueryparam value="#form.ZIP#" cfsqltype="cf_sql_varchar">
			,PASSWORD = <cfqueryparam value="#form.PASSWORD#" cfsqltype="cf_sql_varchar">
			,PHONE = <cfqueryparam value="#form.PHONE#" cfsqltype="cf_sql_varchar">
			,CellPhone = <cfqueryparam value="#form.CellPhone#" cfsqltype="cf_sql_varchar">
			,Officephone = <cfqueryparam value="#form.Officephone#" cfsqltype="cf_sql_varchar">
			,NOTIFYOFLOGIN = <cfqueryparam value="#form.NOTIFYOFLOGIN#" cfsqltype="cf_sql_varchar">
			,EMAIL = <cfqueryparam value="#form.EMAIL#" cfsqltype="cf_sql_varchar">
			,EMAIL2 = <cfqueryparam value="#form.EMAIL2#" cfsqltype="cf_sql_varchar">
			,rating = <cfqueryparam value="#form.rating#" cfsqltype="cf_sql_varchar">
			<!--- ,LeadStatus = <cfqueryparam value="#form.LeadStatus#" cfsqltype="cf_sql_varchar"> --->
			,leadsource = <cfqueryparam value="#form.leadsource#" cfsqltype="cf_sql_varchar">
			,leadreferral = <cfqueryparam value="#form.leadreferral#" cfsqltype="cf_sql_varchar">
			,WEBSITE = <cfqueryparam value="#form.WEBSITE#" cfsqltype="cf_sql_varchar">
			,LEADREFERRAL = <cfqueryparam value="#form.LEADREFERRAL#" cfsqltype="cf_sql_varchar">	
			,AGENTID = <cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_varchar">
			,LASTEDIT = <cfqueryparam value="#dateformat(now(), 'yyyy-mm-dd hh:mm:ss')#" cfsqltype="cf_sql_date">

			,lastreached = <cfqueryparam value="#dateformat(form.lastreached, 'yyyy-mm-dd hh:mm:ss')#" cfsqltype="cf_sql_date">
			,lastemail = <cfqueryparam value="#dateformat(form.lastemail, 'yyyy-mm-dd hh:mm:ss')#" cfsqltype="cf_sql_date">


				<cfif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '1'>
					,LASTEDITBY = <cfqueryparam value="50" cfsqltype="cf_sql_integer">
				<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '3'>
					,LASTEDITBY = <cfqueryparam value="9" cfsqltype="cf_sql_integer">
				<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '4'>
					,LASTEDITBY = <cfqueryparam value="9" cfsqltype="cf_sql_integer">
				<cfelseif isdefined('cookie.LoggedInAgentID')>
					,LASTEDITBY = <cfqueryparam value="#cookie.LoggedInAgentID#" cfsqltype="cf_sql_integer">
				</cfif>

		Where id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- If Follow UP Reminder type selected, insert --->
	<!--- Any update to this, make it below where we send the message --->
	<cfif form.followuptype eq 'nofollowup'>


		<cfquery datasource="#mls.dsn#" name="AddNote">
			Insert into cl_leadtracker_response (clientid,privatepublic,FromOrTo,MessageBody,agentid,messagesubject,contacttype)
				Values(
						<cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="Private" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="Private Note - No Action Needed" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#form.followupnotes#" cfsqltype="cf_sql_longvarchar">,
						<cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="Note Posted" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="Follow Up Note" cfsqltype="cf_sql_varchar">
			          )
		</cfquery>


	<cfelse>
			<cfset CalendarFileName = "#dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHMMSS')#.ics">

			<cfquery datasource="#mls.dsn#" name="UpdateInfo">
				Insert into cl_followup_reminder (FollowUpDate,FollowUpHour,FollowUpMinute,FollowUpAMPM,FollowUpTime,notes,agentid,clientid,OutlookCalendarFile)
					Values(
							<cfqueryparam value="#form.followupdate#" cfsqltype="cf_sql_date">,
							<cfqueryparam value="#TimeFormat(form.followuptime, 'h')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#TimeFormat(form.followuptime, 'mm')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#TimeFormat(form.followuptime, 'tt')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.followuptime#" cfsqltype="cf_sql_time">,
							<cfqueryparam value="#form.followupnotes#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#url.id#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#CalendarFileName#" cfsqltype="cf_sql_varchar">
				          )
			</cfquery>


			<cfquery datasource="#mls.dsn#" name="AddNote">
				Insert into cl_leadtracker_response (clientid,privatepublic,FromOrTo,MessageBody,agentid,messagesubject,contacttype)
					Values(
							<cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="Private" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="Private Note - No Action Needed" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.followupnotes#" cfsqltype="cf_sql_longvarchar">,
							<cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="Note Posted" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="Follow Up Note" cfsqltype="cf_sql_varchar">
				          )
			</cfquery>

<!---  Do not intent this block of code, breaks the file --->
<cfoutput>
<cfset reminderDateTime = dateformat(form.followupdate, 'mm-dd-yyyy') & ' ' & timeformat(form.followuptime, 'hh:mm:ss tt')>

<cfset utcDTStart = DateAdd("h", 5, reminderDateTime)>
<cfset utcDTEnd = DateAdd("n", 30, utcDTStart)>

<cfset convertedDTStart = dateformat(utcDTStart, 'mm-dd-yyyy') & ' ' & timeformat(utcDTStart, 'HH:mm:ss')>
<cfset convertedDTEnd = dateformat(convertedDTStart, 'mm-dd-yyyy') & ' ' & timeformat(utcDTEnd, 'HH:mm:ss')>

<!--- Start: #dateformat(convertedDTStart, 'yyyymmdd')#T#timeformat(convertedDTStart, 'HHmmss')#Z
End: #dateformat(convertedDTEnd, 'yyyymmdd')#T#timeformat(convertedDTEnd, 'HHmmss')#Z --->

<cfsavecontent variable="icsContent">
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
BEGIN:VEVENT
UID:1233242
DTSTAMP:#dateformat(now(), 'yyyymmdd')#T#timeformat(now(), 'HHmmss')#Z
DTSTART:#dateformat(convertedDTStart, 'yyyymmdd')#T#timeformat(convertedDTStart, 'HHmmss')#Z
DTEND:#dateformat(convertedDTEnd, 'yyyymmdd')#T#timeformat(convertedDTEnd, 'HHmmss')#Z
SUMMARY:#form.firstname# #form.lastname#
DESCRIPTION:#form.firstname# #form.lastname# - Phone: #form.phone# - Cell: #form.cellphone# - Office: #form.officephone# - Email: #form.email# - #trim(form.followupnotes)#
END:VEVENT
END:VCALENDAR
</cfsavecontent>


<cffile action="WRITE" file="#UploadPathOutlook#\#CalendarFileName#" output="#icsContent#" addnewline="Yes" fixnewline="No">

</cfoutput>



				<cfquery datasource="#mls.dsn#" name="GetAgentInfo">
					select firstname,email
					from cl_agents
					where id = <cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfmail to="#GetAgentInfo.email#" from="#mls.adminemail# <#cfmail.username#>" replyto="#mls.adminemail#" bcc="#cfmail.bcc#" username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" subject="Follow Up Reminder Notice for #form.firstname# #form.lastname#" mimeattach="#UploadPathOutlook#\#CalendarFileName#"  type="html">
					<p>This is the follow up reminder set for #form.firstname# #form.lastname# on #dateformat(form.followupdate,'mm/dd/yyyy')# at #TimeFormat(form.followuptime, 'h')#:#TimeFormat(form.followuptime, 'mm')# #TimeFormat(form.followuptime, 'tt')#</p>
					<p>Click the attached file and save to your Outlook.</p>
					<p>Note:</p>
					<p>#form.followupnotes#</p>
				</cfmail>

	</cfif>


	<!--- If Agent has changed, re-assign agent and send notice --->
	<cfif LEN(form.agentcheck) and LEN(form.agentid) and form.agentcheck neq form.agentid>

		<cfquery datasource="#mls.dsn#" name="GetAgentInfo">
			select *
			from cl_agents
			where id = <cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_integer">
		</cfquery>

		   <cfmail from="#mls.adminemail# <#cfmail.username#>" to="#GetAgentInfo.email#" subject="#mls.companyname# - Lead Assignment by Administrator" type="html" bcc="#cfmail.bcc#" replyto="#mls.adminemail#" username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#">
			   <p>Hello #GetAgentInfo.firstname#,</p>

			   <p>You have been assigned the lead #form.firstname# #form.lastname# by the #mls.companyname# website administrator.</P>

			   <p>Login to the <a hreflang="en" href="http://#cgi.HTTP_HOST#/admin/login.cfm">control panel</a> and
			    <a hreflang="en" href="http://#cgi.HTTP_HOST#/admin/leadtracker/contact-details.cfm?id=#url.id#">follow this link</a>.  </p>

				<p>Thank you!</p>
		   </cfmail>




	</cfif>



		<cflocation url="contact-details.cfm?id=#url.id#&updated=" addtoken="false">


<cfelseif isdefined('form.addcontact')> <!--- INSERT NEW CONTACT --->

	<!--- Check to make sure an account doesn't exist with this email addresss --->
	<cfquery datasource="#mls.dsn#" name="CheckForDup">
		Select id
		From cl_accounts
		Where email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
	</cfquery>

	<cfif CheckForDup.recordcount gt 0>
			<cfoutput>An account with this email address already exists. Click here to <a hreflang="en" href="contact-details.cfm?id=#CheckForDup.id#">view profile</a>.</cfoutput>
		<cfabort>
	<cfelse>
		<cfinsert datasource="#mls.dsn#" tablename="cl_accounts" formfields="FIRSTNAME,LASTNAME,SALUTATION,ADDRESS,COMPANY,CITY,ZIP,PASSWORD,PHONE,CellPhone,Officephone,NOTIFYOFLOGIN,EMAIL,EMAIL2,leadsource,WEBSITE,LEADREFERRAL,rating,AGENTID,CAMEFROMWEBSITE,state">

			 
		<cfquery datasource="#mls.dsn#" name="getID">
			Select id
			From cl_accounts
			Where email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
			limit 1
		</cfquery>

		<cflocation addtoken="false" url="/admin/leadtracker/contact-details.cfm?id=#getID.id#">

	</cfif>

<cfelseif isdefined('form.MESSAGECENTERSEND')> <!--- Sending Message --->


	<cfset MessageBodyHTMLRemoved = REReplace(MessageBody,'<[^>]*>','','all')>

	<cfquery datasource="#mls.dsn#">
		INSERT INTO cl_leadtracker_response (agentid, clientid, MessageSubject, MessageBody, FromOrTo, PrivatePublic, MessageCC, MessageBCC, contacttype) 
			VALUES(
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.AgentID#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#id#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#MessageSubject#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(MessageBody)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Waiting On Customer's Response">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#PrivatePublic#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#MessageCC#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#MessageBCC#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#contacttype#">
			)
	</cfquery>


	<cfmail to="#MessageTo#" cc="#MessageCC#" bcc="#MessageBCC#" from="#AgentEmail# <#cfmail.username#>" subject="#messagesubject#" type="html" replyto="#mls.replytoaddress#" username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#">
	<span style='color:##ffffff;'><center>:..................................:</center></span>
		
		#MessageBody#

		<span style='color:##ffffff'>~#id#~</span>
	</cfmail>




<!--- If Follow UP Reminder type selected, insert --->
	<cfif form.followuptype neq 'nofollowup'>

			<cfquery datasource="#mls.dsn#" name="UpdateInfo">
				Insert into cl_followup_reminder (FollowUpDate,FollowUpHour,FollowUpMinute,FollowUpAMPM,FollowUpTime,notes,agentid,clientid)
					Values(
							<cfqueryparam value="#form.followupdate#" cfsqltype="cf_sql_date">,
							<cfqueryparam value="#TimeFormat(form.followuptime, 'h')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#TimeFormat(form.followuptime, 'mm')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#TimeFormat(form.followuptime, 'tt')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.followuptime#" cfsqltype="cf_sql_time">,
							<cfqueryparam value="#form.followupnotes#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#url.id#" cfsqltype="cf_sql_varchar">
				          )
			</cfquery>


			<cfquery datasource="#mls.dsn#" name="AddNote">
				Insert into cl_leadtracker_response (clientid,privatepublic,FromOrTo,MessageBody,agentid,messagesubject,contacttype)
					Values(
							<cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="Private" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="Private Note - No Action Needed" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.followupnotes#" cfsqltype="cf_sql_longvarchar">,
							<cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="Note Posted" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="Follow Up Note" cfsqltype="cf_sql_varchar">
				          )
			</cfquery>



				<cfset CalendarFileName = "#dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHMMSS')#.ics">

				<cfset thetimeplus = "#dateadd('n','30',form.followuptime)#">
				<cfset thetimeplus = "#dateadd('h','4',thetimeplus)#">
				<cfset thetimeplus = "#timeformat(thetimeplus,'HHMMSS')#">


				<cffile action="WRITE" file="#UploadPathOutlook#\#CalendarFileName#" output="BEGIN:VCALENDAR
				VERSION:1.0
				BEGIN:VEVENT
				DTSTART:#form.followupdate#T#form.followuptime#Z
				DTEND:#form.followupdate#T#thetimeplus#Z
				SUMMARY:Contact Manager Note: #form.firstname# #form.lastname#
				LOCATION:
				DESCRIPTION:#form.firstname# #form.lastname# - Phone: #form.phone# - Cell: #form.cellphone# - Office: #form.officephone# - Email: #form.email#  - #trim(form.followupnotes)#
				PRIORITY:3
				END:VEVENT
				END:VCALENDAR" addnewline="Yes" fixnewline="No">

				<cfquery datasource="#mls.dsn#" name="GetAgentInfo">
					select firstname,email
					from cl_agents
					where id = <cfqueryparam value="#form.AGENTID#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfmail to="#GetAgentInfo.email#" from="#mls.adminemail# <#cfmail.username#>" replyto="#mls.adminemail#" bcc="#cfmail.bcc#" username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" subject="Follow Up Reminder Notice for #form.firstname# #form.lastname#" mimeattach="#UploadPathOutlook#\#CalendarFileName#"  type="html">
					<p>This is the follow up reminder set for #form.firstname# #form.lastname# on #dateformat(form.followupdate,'mm/dd/yyyy')# at #TimeFormat(form.followuptime, 'h')#:#TimeFormat(form.followuptime, 'mm')# #TimeFormat(form.followuptime, 'tt')#</p>
					<p>Click the attached file and save to your Outlook.</p>
					<p>Note:</p>
					<p>#form.followupnotes#</p>
				</cfmail>


	</cfif>




	<cflocation url="contact-details.cfm?id=#url.id#&emailsent=" addtoken="false">

</cfif>


<cfabort>

