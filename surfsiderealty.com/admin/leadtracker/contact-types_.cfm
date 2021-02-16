<!---  Update or Add --->
 <cfif cgi.request_method eq 'post' and form.submit eq 'Edit'>

	<cfquery datasource="#mls.dsn#">
		Update cl_contact_types
		Set contacttype = <cfqueryparam value="#form.typename#" cfsqltype="cf_sql_varchar">
		Where ID = <cfqueryparam value="#form.theid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="contact-types.cfm">

 <cfelseif cgi.request_method eq 'post' and form.submit eq 'Add'>

	<cfquery datasource="#mls.dsn#">
		Insert into cl_contact_types(contacttype)
		Values(<cfqueryparam value="#form.typename#" cfsqltype="cf_sql_varchar">)
	</cfquery>

	<cflocation addtoken="false" url="contact-types.cfm">

 </cfif>

 <cfif isdefined('url.id') and LEN(url.id) and isdefined('url.delete')>

	<cfquery datasource="#mls.dsn#">
		delete from cl_contact_types
		Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="contact-types.cfm">

 </cfif>

 <!--- Get Sources --->
<cfquery datasource="#mls.dsn#" name="getInfo">
	select *
	from cl_contact_types
	<cfif isdefined('url.id') and LEN(url.id)>Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"></cfif>
	order by contacttype
</cfquery>

