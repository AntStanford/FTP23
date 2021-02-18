<cfif isdefined('form.submit')>
	
	<cfquery dataSource="#application.dsn#">
		update cms_cleaning set cleaning = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.cleaning#">
		where id = 1
	</cfquery>
	
	<cflocation addToken="no" url="form.cfm?success">
	
</cfif>