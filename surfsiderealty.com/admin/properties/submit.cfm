<cfset table = 'cms_property_enhancements'>

<cfif isdefined('form.id')> <!--- update statement --->

	<cfquery name="Delete" datasource="#settings.dsn#">
		Delete from #table#
		Where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">
	</cfquery>

	<cfquery dataSource="#settings.dsn#">
		insert into #table# (strpropid,virtualTour,videolink) 
		values(
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">,
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.virtualTour#">,
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.videolink#">
		)
	</cfquery>

	<cflocation addToken="no" url="form.cfm?id=#url.id#&success">

</cfif>

































