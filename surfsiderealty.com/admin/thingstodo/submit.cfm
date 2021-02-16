<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_thingstodo">
     <cfcatch></cfcatch> 
</cftry>

<!--- On page variables --->
<cfset uppicture = #ExpandPath('/images/thingstodo')#>
<cfset table = 'cms_thingstodo'>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>
    
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">


<!--- Update Existing Record --->  
<cfelseif isdefined('form.id')>
  
  
    <cfif len(form.photo)>
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>  
    </cfif>
    

    <cfquery dataSource="#settings.dsn#">
      update #table# set
      title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
      description = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.description#">,
      catID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.catID#">,
      website = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.website#">
      <cfif len(form.photo)>,photo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>
    
    <cflocation addToken="no" url="form.cfm?id=#id#&success"> 
    

<!--- Add New Record --->    
<cfelse>
  
  
    <cfif len(form.photo)>      
    
    <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
    <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
    <cfset myfile = results.filename>   
  
    <cfelse>
      <cfset myfile = ''>  
    </cfif>

    <cfquery dataSource="#settings.dsn#">
      insert into #table#(title,description,photo,catID,website) 
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
        <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.description#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
        <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.catID#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.website#">
        )
    </cfquery>
    
    <cflocation addToken="no" url="form.cfm?success"> 
  
  
</cfif>  
       




