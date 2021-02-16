<cfset table = 'cms_specials'>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">
  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
    startdate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#startdate#">,
    enddate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#enddate#">,
    description = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#description#">
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->
  
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(title,startdate,enddate,description) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#title#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#startdate#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#enddate#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#description#">
      )
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?success">
  
</cfif>