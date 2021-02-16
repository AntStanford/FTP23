<!---  Update or Add --->
 <cfif cgi.request_method eq 'post' and form.submit eq 'Update'>

<cfupdate datasource="#mls.dsn#" tablename="drip_templates" formfields="id,subject,body,status,lastModified,defaultentry">

	<cflocation addtoken="false" url="drip-campaign-templates.cfm">

 <cfelseif cgi.request_method eq 'post' and form.submit eq 'Add'>

	<cfinsert datasource="#mls.dsn#" tablename="drip_templates" formfields="subject,body,status,lastModified,createdAt,defaultentry">

	<cflocation addtoken="false" url="drip-campaign-templates.cfm">

 </cfif>

 <cfif isdefined('url.id') and LEN(url.id) and isdefined('url.delete')>

	<cfquery datasource="#mls.dsn#">
		delete from drip_templates
		Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="drip-campaign-templates.cfm">

 </cfif>

 <!--- Get Sources --->
<cfquery datasource="#mls.dsn#" name="getInfo">
	select *
	from drip_templates
	<cfif isdefined('url.id') and LEN(url.id)>Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"></cfif>
	order by subject
</cfquery>

