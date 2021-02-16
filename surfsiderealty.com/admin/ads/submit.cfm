<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_ads">
     <cfcatch></cfcatch> 
</cftry>

<cfset table = 'cms_ads'>
<cfset uppicture = #ExpandPath('/images/ads')#>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">
  

<cfelseif isdefined('url.id') and isdefined('url.deletephoto')>
   
   <cfquery dataSource="#settings.dsn#">
    update #table# set 
    photo = ''
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#url.id#&deletephoto">

  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <cfif isdefined('form.photo') and len(form.photo)>
   
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>
   
  </cfif>
  
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
    link = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.link#">,
    couponcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.couponcode#">,
    time_start = <cfqueryparam cfsqltype="CF_SQL_Date" value="#time_start#">,
	time_end = <cfqueryparam cfsqltype="CF_SQL_Date" value="#time_end#">,
	details = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#details#">,
	ShowOnPage = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.ShowOnPage#">
    <cfif isdefined('form.photo') and len(form.photo)>,photo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->
  
  <cfif isdefined('form.photo') and len(form.photo)>
   
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>
   
  <cfelse>
  
      <cfset myfile = ''> 

  </cfif>
  
  
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(name,link,couponcode,time_start,time_end,details,photo,ShowOnPage) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.link#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.couponcode#">,      
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.time_start#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.time_end#">,
	  <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.details#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.ShowOnPage#">
      )
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?success">
  
</cfif>

































