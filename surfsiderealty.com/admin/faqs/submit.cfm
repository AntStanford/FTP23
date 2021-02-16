<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_faqs">
     <cfcatch></cfcatch> 
</cftry>

<cfset table = 'cms_faqs'>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">
  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    question = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.question#">,
    answer = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.answer#">
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->
  
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(question,answer) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#question#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#answer#">
      )
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?success">
  
</cfif>