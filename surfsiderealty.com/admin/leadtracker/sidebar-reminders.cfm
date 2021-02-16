
  <CFQUERY DATASOURCE="#mls.dsn#" NAME="GetReminders">  
    SELECT cl_followup_reminder.id,cl_followup_reminder.agentid,cl_followup_reminder.clientid,cl_followup_reminder.followupdate,cl_followup_reminder.followuptime,cl_followup_reminder.followupampm,
    cl_followup_reminder.notes,cl_followup_reminder.showing,cl_accounts.firstname,cl_accounts.lastname
    FROM cl_followup_reminder
    Inner Join cl_accounts on cl_followup_reminder.clientid = cl_accounts.id
    WHERE cl_followup_reminder.archive <> 'YES' and cl_accounts.agentid <> '' and cl_followup_reminder.followuptime <> '00:00:00'
  <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">and cl_accounts.agentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.LOGGEDINAGENTID#"></cfif>
     order by followupdate desc
    limit 8;
  </CFQUERY>



  <h3>Reminders</h3>

  <ul>
  <cfoutput query="GetReminders">
  <cfif showing eq 1><cfset displayaction = "Showing"><cfelse><cfset displayaction = "Notes"></cfif>
  	<li class="reminder"><a hreflang="en" href="#cgi.script_name#?#cgi.query_string#&ArchiveReminderID=#GetReminders.id#" onclick="return confirm('Are you sure you wish to archive this?')"><img src="/admin/images/redx.png" border="0">
  	<a hreflang="en" href="contact-details.cfm?id=#clientid#&display=#displayaction#">#firstname# #lastname#</a> <cfif isdefined('cookie.LoggedInAdminName') or isdefined('cookie.LoggedInAgentID') and (cookie.LoggedInAgentID eq "9" or cookie.LoggedInAgentID eq "50")><i>#GetAgentName(agentid)#</i></cfif> #dateformat(followupdate,'mm/dd/yyyy')# <br><cfif LEN(notes)><span style="color:##207E92;">'#notes#'</span></cfif></li>
  </cfoutput>
  </ul>


