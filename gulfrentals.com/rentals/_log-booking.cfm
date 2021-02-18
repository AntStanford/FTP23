<cfif cgi.HTTP_USER_AGENT does not contain 'bot'>
	<cftry>
		<cfquery dataSource="#settings.dsn#">
			insert into be_logs(totalAmount,rezNumber,email,propertyid,propertyname,strcheckin,strcheckout)
			values(
				<cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.Total#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#request.reservationCode#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyid#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyName#">,
				<cfqueryparam CFSQLType="CF_SQL_DATE" value="#dateformat(form.strCheckin,'yyyy-mm-dd')#">,
				<cfqueryparam CFSQLType="CF_SQL_DATE" value="#dateformat(form.strCheckout,'yyyy-mm-dd')#">
			)
		</cfquery>
	   <cfcatch>
		   <cfdump var="#cfcatch#" abort="true">
		</cfcatch>
	</cftry>
</cfif>