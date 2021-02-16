<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_thingstodo">
     <cfcatch></cfcatch> 
</cftry>

<cfset table = 'cms_thingstodo_categories'>
<cfset uppicture = #ExpandPath('/images/thingstodo')#>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>
    
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="categories-index.cfm?success">


<!--- Update Existing Record --->  
<cfelseif isdefined('form.id')>
    
    <cfif isdefined('form.photo') and len(form.photo)>
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>  
    </cfif>
    
    <cfquery dataSource="#settings.dsn#">
      update #table# set
      title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
      slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">
      <cfif isdefined('form.photo') and len(form.photo)>,photo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>
    
    <cflocation addToken="no" url="categories-form.cfm?id=#id#&success"> 
    

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
      insert into #table#(title,photo,slug) 
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">
        )
    </cfquery>
    
    <cflocation addToken="no" url="categories-form.cfm?success"> 
  
  
</cfif>  
       




