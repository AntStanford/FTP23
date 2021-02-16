<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">
<cfoutput>


<div id="boxbody">

<h1>Add Phone Call</h1>

<cfif cgi.request_method eq "post">



<cfquery datasource="#mls.dsn#">
	Insert Into cl_phonecalls(calldatetime,clientid,callresult,callnotes,agentid)
	Values(
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#calldate# #calltime#">,
	<cfqueryparam cfsqltype="cf_sql_int" value="#clientid#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#callresult#">,
	<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#callnotes#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#agentid#">
	)
</cfquery>



<!--- update phone verification --->
<cfquery datasource="#mls.dsn#">
	Insert Into phone_verification(phonenumber,verified,numberdata,agentid)
	Values(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#phonenumber#">,
	<cfqueryparam cfsqltype="cf_sql_int" value="#verified#">,
	<cfqueryparam cfsqltype="cf_sql_longvarchar" value="call logged">,
	<cfqueryparam cfsqltype="cf_sql_int" value="#agentid#">
	)
</cfquery>



<p>Success! Close windw.</p>

<cfelse>

<cfquery name="getPhone" datasource="#mls.dsn#">
	select phone,cellphone,officephone
	from cl_accounts
	where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.clientid#">
	limit 1
</cfquery>



	<form method="post">
		<input type="hidden" name="clientid" value="#url.clientid#">
		<cfif isdefined('cookie.LOGGEDINAGENTID')><input type="hidden" name="agentid" value="#cookie.LOGGEDINAGENTID#"><cfelse><input type="hidden" name="agentid" value="51"></cfif>
		<table>
		<tr>
			<td>Phone Number:</td>
			<td><input type="type" name="phonenumber" value="<cfif getPhone.recordcount eq 1><cfif LEN(getPhone.phone)>#getPhone.phone#<cfelseif LEN(getPhone.cellphone)>#getPhone.cellphone#<cfelseif LEN(getPhone.officephone)>#getPhone.officephone#</cfif></cfif>"></td>
			
		</tr>
		<tr>
			<td>Date:</td>
			<td><input type="type" name="calldate" value="#dateformat(now(), 'mm-dd-yyyy')#"></td>
		</tr>
		<tr>
			<td>Time:</td>
			<td><input type="type" name="calltime" value="#timeformat(now(), 'hh:mm:ss tt')#"></td>
		</tr>
		<tr>
			<td>Result</td>
			<td><select name="callresult"><option>Answered<option>VoiceMail<option>Left Message<option>No Answer<option>Bad Number</select></td>
		</tr>
				<tr>
			<td>Verified:</td>
			<td><select name="verified">
			 <option value="5">Talking to Prospect
			 <option value="6">Valid Phone Number
			 <option value="0">Unknown Phone Status
			 <option value="7">Do Not Call
			 <option value="3">Wrong Number
			</select></td>
		</tr>
		<tr><td colspan="2">
		Notes:<br><textarea cols="35" rows="15" name="callnotes"></textarea>
		</td></tr>
		<tr><td colspan="2" align="right"><input type="submit" value="Submit Call"></td></tr>
		</table>
	</form>

</cfif>



</div>


</cfoutput>