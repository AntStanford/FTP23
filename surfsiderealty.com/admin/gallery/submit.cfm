<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_assets">
     <cfcatch></cfcatch> 
</cftry>

<!--- On page variables --->
<cfset uploadPath = #ExpandPath('/images/gallery')#>
<cfset table = 'cms_assets'>

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
      <cfset results=Obj.Check(uploadPath,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      
      <cfset myfile = results.filename>  
                
      <cfimage action="resize" source="#uploadPath#/#myfile#" width="100" height="100" destination="#uploadPath#/th_#myfile#">
          
    </cfif>
    

    <cfquery dataSource="#settings.dsn#">
      update #table# set
      name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">
      <cfif len(form.photo)>,thefile = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>
    
    <cflocation addToken="no" url="form.cfm?id=#id#&success"> 
    

<!--- Add New Record --->    
<cfelse>
  
      
    <cfif NOT len(form.photo)>      
      
      Whoops! You forgot the image! Go back and try again.<cfabort>
      
    <cfelse>
    
          <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
          <cfset results=Obj.Check(uploadPath,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
          <cfset myfile = results.filename>   
          
          <cfimage action="resize" source="#uploadPath#/#myfile#" width="100" height="100" destination="#uploadPath#/th_#myfile#">
          
          
           <!--- Get current sort values --->
          <cfquery name="getSort" dataSource="#settings.dsn#">
            select max(sort) as maxSort from #table# where section = 'Gallery' 
          </cfquery>
          
          
          <cfif getSort.recordcount gt 0 and len(getSort.maxSort)>
             
             <cfset sortValue = getSort.maxSort + 1> 
          
          <cfelse>
            
            <cfset sortValue = 1>
            
          </cfif>
          
      
          <cfquery dataSource="#settings.dsn#">
            insert into #table#(name,thefile,section,sort) 
            values(
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,        
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
              'Gallery',
              <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#sortValue#">
              )
          </cfquery>
          
          <cflocation addToken="no" url="form.cfm?success"> 
    
    </cfif>
  
</cfif>  
       




