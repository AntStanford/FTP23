<!---  Update or Add --->
 <cfif cgi.request_method eq 'post' and form.submit eq 'Update'>

      <cfquery dataSource="#mls.dsn#">
		update pages set 
		name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">
		,body = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.body#">
		,slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">
		,TypeOfPage = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.TypeOfPage#">
		,status = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.Status#">
		,H1Tag = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.H1Tag#">
		,metatitle = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metatitle#">
		,metakeywords = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metakeywords#">
		,metadesc = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metadesc#">
		where id =   <cfqueryparam value="#form.theid#" cfsqltype="cf_sql_integer">
  </cfquery>  

	<cflocation addtoken="false" url="pages.cfm">

 <cfelseif cgi.request_method eq 'post' and form.submit eq 'Add'>

	<cfquery datasource="#mls.dsn#">
		Insert into pages(name,body,slug,TypeOfPage,status,H1Tag,metatitle,metakeywords,metadesc)
		Values(<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.body#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.TypeOfPage#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.Status#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.H1Tag#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metatitle#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metakeywords#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metadesc#">)
	</cfquery>

	<cflocation addtoken="false" url="pages.cfm">

 </cfif>

 <cfif isdefined('url.id') and LEN(url.id) and isdefined('url.delete')>

	<cfquery datasource="#mls.dsn#">
		delete from pages
		Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="pages.cfm">

 </cfif>

 <!--- Get Sources --->
<cfquery datasource="#mls.dsn#" name="getInfo">
	select *
	from pages
	<cfif isdefined('url.id') and LEN(url.id)>Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"></cfif>
	order by Typeofpage DESC, name asc
</cfquery>

