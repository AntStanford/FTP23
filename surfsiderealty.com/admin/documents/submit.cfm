<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_assets">
     <cfcatch></cfcatch> 
</cftry>

<!--- On page variables --->
<cfset uppicture = #ExpandPath('/files')#>
<cfset table = 'cms_assets'>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>
      
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">


<!--- Update Existing Record --->  
<cfelseif isdefined('form.id')>
  
  
    <cfif len(form.thefile)>
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"thefile")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>  
    </cfif>
    

    <cfquery dataSource="#settings.dsn#">
      update #table# set
      name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">      
      <cfif len(form.thefile)>,thefile = '#myfile#'</cfif>
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>
    
    <cflocation addToken="no" url="form.cfm?id=#id#&success"> 
    

<!--- Add New Record --->    
<cfelse>
  
  
    <cfif len(form.thefile)>      
    
    <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
    <cfset results=Obj.Check(uppicture,"thefile")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
    <cfset myfile = results.filename>   
  
    <cfelse>
      <cfset myfile = ''>  
    </cfif>

    <cfquery dataSource="#settings.dsn#">
      insert into #table#(name,thefile,section) 
      values(        
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
        'Documents'
        )
    </cfquery>
    
    <cflocation addToken="no" url="form.cfm?success"> 
  
  
</cfif>  
       




