<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">


<div id="boxbody">

<cfif cgi.request_method eq "post" >


<cfif isdefined('form.editinfo')>

	<cfquery datasource="#mls.dsn#" name="update">
		update cl_secondary_contacts
			set 
				spousefirstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spousefirstname#">,
				spouselastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spouselastname#">,
				spouseemail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spouseemail#">,
				spousephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spousephone#">,
				facebook = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.facebook#">,
				twitter = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.twitter#">,
				children = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.children#">,
				birthday = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.birthday#">
		where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
	</cfquery>

	<div class="success">
	Information has been updated.
	</div>

	<cfelse>

			<cfquery datasource="#mls.dsn#" name="create">
			insert into cl_secondary_contacts(clientid,spousefirstname,spouselastname,spouseemail,spousephone,facebook,twitter,children,birthday)
				values(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spousefirstname#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spouselastname#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spouseemail#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.spousephone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.facebook#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.twitter#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.children#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.birthday#">
					)
		</cfquery>

					
					

		<div class="success">
		Information has been updated.
		</div>

</cfif>



<cfelse>
<cfif parameterexists(url.id)>
	<cfquery datasource="#mls.dsn#" name="getinfo">
	select *
	from cl_secondary_contacts
	where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
</cfquery>
</cfif>



<h1>Update Secondary Information</h1>
<cfoutput>
<form action="#cgi.script_name#" method="post">
	<input type="hidden" name="id" value="#url.id#">
	<cfif parameterexists(url.id) and getinfo.recordcount gt 0><input type="hidden" name="editinfo" value="yes"></cfif>
	<!--- 	<div>
			<label for="state" style="margin-right:89px;">State</label>
			<select name="state"><cfloop query="getStates"><option value="#abbreviation#" <cfif parameterexists(url.id) and getinfo.state eq "#abbreviation#">selected</cfif>>#state#</cfloop></select>
		</div> --->
		<div>
			<label for="birthday" style="margin-right:73px;">Birthday:</label>
			<input type="text" name="birthday" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.birthday#</cfif>">
		</div>
		<div>
			<label for="facebook" style="margin-right:65px;">Facebook:</label>
			<input type="text" name="facebook" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.facebook#</cfif>">
		</div>
		<div>
			<label for="twitter" style="margin-right:79px;">Twitter:</label>
			<input type="text" name="twitter" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.twitter#</cfif>">
		</div>
		<div>
			<label for="spousefirstname" style="margin-right:5px;">Spouse's First Name:</label>
			<input type="text" name="spousefirstname" style="width:115px;" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.spousefirstname#</cfif>">
		</div>
		<div>
			<label for="spouselastname" style="margin-right:5px;">Spouse's Last Name:</label>
			<input type="text" name="spouselastname" style="width:115px;" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.spouselastname#</cfif>">
		</div>
		<div>
			<label for="spouseemail" style="margin-right:33px;">Spouse's Email:</label>
			<input type="text" name="spouseemail" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.spouseemail#</cfif>">
		</div>
		<div>
			<label for="spousephone" style="margin-right:29px;">Spouse's Phone:</label>
			<input type="text" name="spousephone" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.spousephone#</cfif>">
		</div>
		<div>
			<label for="zip_code" style="margin-right:70px;">Children:</label>
			<input type="text" name="children" value="<cfif parameterexists(url.id) and getinfo.recordcount gt 0>#getinfo.children#</cfif>">
		</div>

		<input type="submit" name="submit" value="Update">
	</div>
</form>
</cfoutput>

</cfif>

</div>
