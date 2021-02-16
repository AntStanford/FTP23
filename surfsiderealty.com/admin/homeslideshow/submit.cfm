<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_assets">
     <cfcatch></cfcatch> 
</cftry>

<!--- On page variables --->
<cfset uppicture = #ExpandPath('/images/homeslideshow')#>
<cfset table = 'cms_assets'>



<!--- Deleting an uploaded photo --->
<cfif isdefined('url.id') and isdefined('url.delete')>
  
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?delete">
  

<cfelseif isdefined('form.id')>
  
       <cfif len(form.photo)>
         <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>          
         <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
         <cfset myfile = results.filename>
       </cfif>
   
			
       <cfquery dataSource="#settings.dsn#">
			  update #table# set
			  name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
			  link = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.link#">,
			  caption = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.caption#">
			  <cfif len(form.photo)>,thefile = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
			  where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
	    </cfquery>
	    
	  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">


<!--- Add New Record --->    
<cfelse>
        
              
     <cfif form.photo eq ''>
       
       <p>Whoops, you forgot to upload a pic.</p>
       <a href="javascript:history.go(-1)">Go Back and Try Again.</a>
       <cfabort>
     
     <cfelse>
			
  				<cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck-homepage-slideshow").Init()></cfif>
            <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
            <cfset myfile = results.filename>
            
            
            <cfimage  action = "info"  source = "#uppicture#\#myfile#"  structname = "picinfo" >
                        
            <!--- resize the image if width exceeds 1800px --->                   
            <cfif picinfo.width gt 1800>                        
                   
               <cfimage  action = "resize"  height = ""  source = "#uppicture#\#myfile#" width = "1800"  destination = "#uppicture#\#myfile#"  overwrite = "yes">
                                                                                                                                                               
             </cfif>
              
             <!--- Get current sort values --->
             <cfquery name="getSort" dataSource="#settings.dsn#">
               select max(sort) as maxSort from #table# where section = 'Homepage Slideshow' 
             </cfquery>          
          
             <cfif getSort.recordcount gt 0 and len(getSort.maxSort)>
                
                <cfset sortValue = getSort.maxSort + 1> 
             
             <cfelse>
               
               <cfset sortValue = 1>
               
             </cfif>          
  				
  				<cfquery dataSource="#settings.dsn#">
  				  insert into #table#(thefile,section,link,sort,name,caption)
  				  values(
  				  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
  				  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="Homepage Slideshow">,
  				  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#link#">,
  				  <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#sortValue#">,
  				  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#name#">,
  				  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#caption#">
  				  )
  		      </cfquery>
		
     </cfif>   
    
    <cflocation addToken="no" url="form.cfm?success">   
  
</cfif>  



       




