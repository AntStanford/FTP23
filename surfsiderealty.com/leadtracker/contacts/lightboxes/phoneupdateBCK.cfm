<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">
<cfinclude template="/admin/components/functions.cfm">
<cfoutput>


<div id="boxbody">

<h1>Update Verification</h1>

<cfif cgi.request_method eq "post">



<cfquery datasource="#mls.dsn#">
	Insert Into phone_verification(phonenumber,verified,numberdata,agentid)
	Values(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#phonenumber#">,
	<cfqueryparam cfsqltype="cf_sql_int" value="#verified#">,
	<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#numberdata#">,
	<cfqueryparam cfsqltype="cf_sql_int" value="#agentid#">
	)
</cfquery>

<p>Success! Close windw.</p>

<cfelse>

	<form method="post">
		<input type="hidden" name="phonenumber" value="#url.phonenumber#">
		<cfif isdefined('cookie.LOGGEDINAGENTID')><input type="hidden" name="agentid" value="#cookie.LOGGEDINAGENTID#"><cfelse><input type="hidden" name="agentid" value="51"></cfif>
		<table>
		<tr>
			<td>Phone Number:</td>
			<td><input type="type" name="phonenumbershow" value="#FormatPhone(url.phonenumber)#" disabled></td>
		</tr>
		<tr>
			<td>Verified:</td>
			<td><select name="verified"><option value="1">Verified<option value="3">Bad Number<option value="0">Not Verified</select></td>
		</tr>
		<tr><td colspan="2">
		Details:<br><textarea cols="35" rows="15" name="numberdata"></textarea>
		</td></tr>
		<tr><td colspan="2" align="right"><input type="submit" value="Update Phone Number"></td></tr>
		</table>
	</form>

</cfif>



</div>


</cfoutput>