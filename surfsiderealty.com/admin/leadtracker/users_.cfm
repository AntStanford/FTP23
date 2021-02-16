<!---  Update or Add --->
 <cfif cgi.request_method eq 'post' and form.submit eq 'Edit'>

	<cfquery datasource="#mls.dsn#">
		Update cl_passwords
		Set name = <cfqueryparam value="#form.thename#" cfsqltype="cf_sql_varchar">,
		email = <cfqueryparam value="#form.theemail#" cfsqltype="cf_sql_varchar">,
		password = <cfqueryparam value="#form.thepassword#" cfsqltype="cf_sql_varchar">
		Where ID = <cfqueryparam value="#form.theid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="users.cfm">

 <cfelseif cgi.request_method eq 'post' and form.submit eq 'Add'>

	<cfquery datasource="#mls.dsn#">
		Insert into cl_passwords(name,email,password)
		Values(<cfqueryparam value="#form.thename#" cfsqltype="cf_sql_varchar">,<cfqueryparam value="#form.theemail#" cfsqltype="cf_sql_varchar">,<cfqueryparam value="#form.thepassword#" cfsqltype="cf_sql_varchar">)
	</cfquery>

	<cflocation addtoken="false" url="users.cfm">

 </cfif>

 <cfif isdefined('url.id') and LEN(url.id) and isdefined('url.delete')>

	<cfquery datasource="#mls.dsn#">
		delete from cl_passwords
		Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="users.cfm">

 </cfif>

 <!--- Get Sources --->
<cfquery datasource="#mls.dsn#" name="getInfo">
	select *
	from cl_passwords
	<cfif isdefined('url.id') and LEN(url.id)>Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"></cfif>
	order by name
</cfquery>

