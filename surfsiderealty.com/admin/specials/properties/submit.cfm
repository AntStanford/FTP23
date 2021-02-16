<cfset table = 'cms_specials_properties'>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#"> and specialid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#specialid#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?specialid=#specialid#&success">
  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <cfquery dataSource="#settings.dsn#">
   update #table# set 
   description = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.description#">,
   active = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.active#">,
   PriceWas = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.PriceWas#">,
   PriceReducedTo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.PriceReducedTo#">
   where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.id#"> and specialid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#specialid#">
  </cfquery>  
  
 <cflocation addToken="no" url="index.cfm?specialid=#specialid#&success">

<cfelse>  <!---insert statement--->
 
 <cfquery dataSource="#settings.dsn#">
    insert into #table#(description,active,PriceWas,PriceReducedTo,UnitCode,specialid) 
    values(
	  <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#description#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#active#">,
      <cfqueryparam CFSQLType="CF_SQL_NUMERIC" value="#form.PriceWas#">,
	  <cfqueryparam CFSQLType="CF_SQL_NUMERIC" value="#form.PriceReducedTo#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#UnitCode#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#specialid#">
      )
  </cfquery> 
  

  
  <cflocation addToken="no" url="form.cfm?specialid=#specialid#&success=">
  
</cfif>