<cfset table = 'cms_property_enhancements'>

<cfif isdefined('form.id')> <!--- update statement --->

	<!---<cfquery name="Delete" datasource="#application.dsn#">
		Delete from cms_property_enhancements
		Where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">
	</cfquery>

	<cfquery dataSource="#application.dsn#">
		insert into cms_property_enhancements (strpropid,virtualTour,videolink)
		values(
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">,
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.virtualTour#">,
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.videolink#">
		)
	</cfquery>--->

	<cfquery name="propCheck" dataSource="#application.dsn#">
		select strpropid from cms_property_enhancements where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">
	 </cfquery>
  
	 <!--- property exists, delete it --->
	 <cfif propCheck.recordcount gt 0>
 
		<cfquery name="Delete" datasource="#application.dsn#">
			update cms_property_enhancements
			set virtualTour = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.virtualTour#">,
			videolink = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.videolink#">
			<!---cleaning = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.cleaning#">--->
			where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">
		</cfquery>

	<cfelse>

		<!--- property does not exist, add it --->
			<cfquery dataSource="#application.dsn#">
				insert into cms_property_enhancements (strpropid,virtualTour,videolink<!---,cleaning--->)
				values(
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">,
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.virtualTour#">,
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.videolink#">
					<!---<cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.cleaning#">--->
				)
			</cfquery>

	</cfif>

	<cflocation addToken="no" url="form.cfm?id=#url.id#&success">

</cfif>

<cfif isdefined('url.propertyid')>

	<cfquery name="propCheck" dataSource="#application.dsn#">
	   select strpropid from cms_property_enhancements where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">
	</cfquery>
 
	<cfif structkeyexists(url,"datanew")>
		<!--- property exists, delete it --->
		<cfif propCheck.recordcount gt 0>
	
			<cfquery name="Delete" datasource="#application.dsn#">
				update cms_property_enhancements
				set new = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.datanew#">
				where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">
			</cfquery>
	
		<cfelse>
	
			<!--- property does not exist, add it --->
			<cfquery dataSource="#application.dsn#">
				insert into cms_property_enhancements (strpropid,new)
				values(<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.datanew#">)
			</cfquery>
	
		</cfif>
	</cfif>

	<cfif structkeyexists(url,"datashow")>
		<!--- property exists, delete it --->
		<cfif propCheck.recordcount gt 0>
	
			<cfquery name="Delete" datasource="#application.dsn#">
				update cms_property_enhancements
				set showonsite = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.datashow#">
				where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">
			</cfquery>
	
		<cfelse>
	
			<!--- property does not exist, add it --->
			<cfquery dataSource="#application.dsn#">
				insert into cms_property_enhancements (strpropid,showonsite)
				values(<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.datashow#">)
			</cfquery>
	
		</cfif>
	</cfif>
 
 </cfif>