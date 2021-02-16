<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">
<cfoutput>


<div id="boxbody">

<h1>Add Showing</h1>

<cfif cgi.request_method eq "post">

<cfquery datasource="#mls.dsn#">
	Insert Into cl_showings(clientid,showdate,<cfif LEN(mlsnumber)>mlsnumber,</cfif>notes,createdat)
	Values(
		<cfqueryparam cfsqltype="cf_sql_int" value="#clientid#">,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#showday# #showtime#">,
	<cfif LEN(mlsnumber)><cfqueryparam cfsqltype="cf_sql_int" value="#mlsnumber#">,</cfif>
	<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#notes#">,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'mm-dd-yyyy')# #timeFormat(now(), 'hh:mm:ss tt')#">
	)
</cfquery>


	<cfif form.FollowUpDate neq 'mm/dd/yyyy' and form.FollowUpDate neq ''>
		<cfset CompleteTime = "#dateformat(FollowUpDate,'yyyy-mm-dd')# #FollowUpHour#:#FollowUpMinute#:00 #FollowUpAMPM#">
		<cfquery datasource="#mls.dsn#">
			Insert Into cl_followup_reminder(agentid,clientid,followupdate,archive,followuphour,followupminute,followupampm,followuptime,notes,showing)
			Values(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#agentid#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#clientid#">,
			<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(FollowUpDate,'yyyy-mm-dd')#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="no">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#followuphour#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#followupminute#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#followupampm#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'mm-dd-yyyy')# #timeFormat(now(), 'hh:mm:ss tt')#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#notes#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="1">
			)
		</cfquery>
	</cfif>

 


<p>Success! Close windw.</p>

<cfelse>

	<form method="post">
		<input type="hidden" name="clientid" value="#url.clientid#">
		<input type="hidden" name="agentid" value="<cfif parameterexists(cookie.LoggedInAgentID)>#cookie.LoggedInAgentID#<cfelse>#cookie.LoggedInAdminID#</cfif>">
		<table>
		<tr>
			<td>Date:</td>
			<td><input type="text" name="showday" value="#dateformat(now(), 'mm-dd-yyyy')#" style="width:95px"></td>
		</tr>
		<tr>
			<td>Time:</td>
			<td><input type="text" name="showtime" value="#timeformat(now(), 'hh:mm:ss tt')#" style="width:95px"></td>
		</tr>
		<tr>
			<td>MLS ##:</td>
			<td><input type="text" name="mlsnumber" value="" style="width:200px"></td>
		</tr>
		<tr>
			<td>Address:</td>
			<td><input type="text" name="address" value="" style="width:200px"></td>
		</tr>
		<tr><td colspan="2">
		Notes:<br><textarea cols="35" rows="8" name="notes"></textarea>
		</td></tr>
<tr>
    <td colspan='2'>Set Reminder</td>
</tr>
<tr>
	<td>Date: </td>
    <td><input type="text" name="FollowUpDate" value="mm/dd/yyyy"></td>
</tr>
<tr>
<td>Time:</td><td><select name="FollowUpHour">
	<option value="12">12</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9" selected>9</option>
	<option value="10">10</option>
	<option value="11">11</option>
</select>
<select name="FollowUpMinute">
<cfloop index="i" from="00" to="59" step="1">
<cfif i gte 0 and i lte 9>
<cfset min = "0#i#">
<cfelse>
<cfset min = "#i#">
</cfif>
<cfoutput>
<option value="#min#">#min#</option>
</cfoutput>
</cfloop>
</select>
<select name="FollowUpAMPM">
<option value="AM">AM</option>
<option value="PM">PM</option>
</select>
	</td>
</tr>
<tr><td colspan="2" align="center"> </td></tr>
		<tr><td colspan="2" align="center"><input type="submit" value="Add Showing"></td></tr>
		</table>
	</form>

</cfif>



</div>


</cfoutput>