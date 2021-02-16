<cfif cgi.request_method eq 'Post'>


	<cfif isdefined('form.id') and LEN(form.id)>

		<cfupdate datasource="#mls.dsn#" tablename="drip_templates" formfields="id,subject,body,status,lastModified,defaultentry">

		<cflocation url="drip-template-form.cfm?id=#form.id#&action=Updated" addtoken="false">

	<cfelse>


	<cfinsert datasource="#mls.dsn#" tablename="drip_templates" formfields="subject,body,status,lastModified,createdAt,defaultentry">

		<cfquery datasource="#mls.dsn#" name="getLastInsert">
			select Max(id) as MaxId
			from drip_templates
			where subject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subject#">
		</cfquery>

		<cflocation url="drip-template-form.cfm?id=#getLastInsert.MaxId#&action=Added" addtoken="false">


	</cfif>


</cfif>