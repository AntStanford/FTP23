<!---  Update or Add --->
 <cfif cgi.request_method eq 'post' and form.submit eq 'Update'>

	<cfquery datasource="#mls.dsn#">
		Update cl_tracking_links
		Set subject = <cfqueryparam value="#form.subject#" cfsqltype="cf_sql_longvarchar">,
			body = <cfqueryparam value="#form.body#" cfsqltype="cf_sql_longvarchar">
		Where ID = <cfqueryparam value="#form.theid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="tracking-links.cfm">

 <cfelseif cgi.request_method eq 'post' and form.submit eq 'Add'>

	<cfquery datasource="#mls.dsn#">
		Insert into cl_tracking_links(subject,body,agentid)
		Values(<cfqueryparam value="#form.subject#" cfsqltype="cf_sql_longvarchar">,<cfqueryparam value="#form.body#" cfsqltype="cf_sql_longvarchar">,<cfif isdefined('cookie.LOGGEDINADMINID')><cfqueryparam value="#cookie.LOGGEDINADMINID#" cfsqltype="cf_sql_integer"><cfelse><cfqueryparam value="#cookie.LoggedInAgentID#" cfsqltype="cf_sql_integer"></cfif>)
	</cfquery>

	<cflocation addtoken="false" url="tracking-links.cfm">

 </cfif>

 <cfif isdefined('url.id') and LEN(url.id) and isdefined('url.delete')>

	<cfquery datasource="#mls.dsn#">
		delete from cl_tracking_links
		Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="tracking-links.cfm">

 </cfif>

 <!--- Get Sources --->
<cfquery datasource="#mls.dsn#" name="getInfo">
	select *
	from cl_tracking_links
	<cfif isdefined('url.id') and LEN(url.id)>Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"></cfif>
	order by subject
</cfquery>

