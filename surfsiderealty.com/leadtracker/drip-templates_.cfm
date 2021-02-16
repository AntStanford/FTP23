<cfif isdefined('url.deactivate') and isdefined('url.id')>

		<cfquery datasource="#mls.dsn#" name="UpdateTemplate">
			Update drip_templates
			Set Status = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
			where id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
		</cfquery>

		<cflocation url="drip-templates.cfm" addtoken="false">

<cfelseif isdefined('url.activate') and isdefined('url.id')>

		<cfquery datasource="#mls.dsn#" name="UpdateTemplate">
			Update drip_templates
			Set Status = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
			where id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
		</cfquery>

		<cflocation url="drip-templates.cfm" addtoken="false">


<cfelseif isdefined('url.delete') and isdefined('url.id')>

		<cfquery datasource="#mls.dsn#" name="UpdateTemplate">
			Delete From drip_templates
			where id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
		</cfquery>

		<cflocation url="drip-templates.cfm" addtoken="false">

</cfif>