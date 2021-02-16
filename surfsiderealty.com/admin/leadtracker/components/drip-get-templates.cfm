<cfif isdefined('url.TemplateID') and LEN('url.TemplateID')>

	<cfquery datasource="#mls.dsn#" name="getTemplate">
		select id,subject,status,body,defaultentry
		from drip_templates
		where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.TemplateID#">
		limit 1
	</cfquery>

	<cfif getTemplate.recordcount gt 0>
		<cfoutput query="getTemplate">#body#</cfoutput>
	<cfelse>
		Error on pulling template.
	</cfif>

<cfelse>
	Error on pulling template.
</cfif>