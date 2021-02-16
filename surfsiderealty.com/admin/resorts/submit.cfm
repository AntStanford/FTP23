<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_resorts">
     <cfcatch></cfcatch> 
</cftry>



<!--- On page variables --->
<cfset uppicture = #ExpandPath('/images/resorts')#>
<cfset uppicturethumb = #ExpandPath('/images/resorts/thumbs')#>
<cfset table = 'cms_resorts'>



<!--- Deleting an uploaded photo --->
<cfif isdefined('url.resortID') and isdefined('url.delPhoto') and isdefined('url.photo')>
 
     
  <cfquery dataSource="#settings.dsn#">
    update #table# 
    set <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.photo#"> = ''
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.resortID#">
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?id=#url.resortID#&deletephoto">  
  
  

  <!--- Delete the entire record and photos --->
<cfelseif isdefined('url.id') and isdefined('url.delete')>
  
    
  
  <!--- Finally, delete the property ---> 
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  
  <cflocation addToken="no" url="index.cfm?success">







<!--- Update Existing Record --->  
<cfelseif isdefined('form.id')>
  
    <cfif Len(form.mainphoto)>
  		
  		<cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
  		<cfset results=Obj.Check(uppicture,"mainphoto")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>	               
  		<cfset form.mainphoto = results.filename>
  		
  		<!--- Make a thumbnail of main photo 
 		  <cfimage source="#uppicture#\#cffile.serverfile#" action="resize" width="196"  height="" destination="#uppicturethumb#\#cffile.serverfile#">--->

  	</cfif>	    
   
    <cfquery dataSource="#settings.dsn#">
      update #table# set
      name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
      address = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address#">,
      bedrooms = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.bedrooms#">,
      bathrooms = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.bathrooms#">,
      description = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">,
      amenities = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.amenities#">,
      sleeps = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.sleeps#">,
      area = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.area#">,
      slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">,
      city = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.city#">,
      state = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.state#">,
      zip = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.zip#">,
      metaTitle = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaTitle#">,
      metaDescription = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaDescription#">
      <cfif len(form.mainphoto)>,mainphoto = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.mainphoto#"></cfif>
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>       
    
    <cflocation addToken="no" url="form.cfm?id=#id#&success"> 


<!--- Add New Record --->    
<cfelse>
    
    <cfparam name="form.mainphoto" default="">    
    
    <cfif Len(form.mainphoto)>
  		
  		<cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
  		<cfset results=Obj.Check(uppicture,"mainphoto")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>	               
  		<cfset form.mainphoto = results.filename>
  		
  		<!--- Make a thumbnail of main photo 
 		  <cfimage source="#uppicture#\#cffile.serverfile#" action="resize" width="90"  height="" destination="#uppicturethumb#\#cffile.serverfile#">--->

  	</cfif>
  	

     
    <cfquery dataSource="#settings.dsn#">
      insert into #table#(name,address,bedrooms,bathrooms,description,amenities,mainphoto,sleeps,area,slug,city,state,zip,metaTitle,metaDescription) 
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.bedrooms#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.bathrooms#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.amenities#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.mainphoto#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.sleeps#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.area#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.city#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.state#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.zip#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaTitle#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaDescription#">
        )
    </cfquery>
    
        
    <cflocation addToken="no" url="form.cfm?success"> 
  
  
</cfif>  



       




