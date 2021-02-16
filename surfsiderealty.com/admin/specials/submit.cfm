<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_specials">
     <cfcatch></cfcatch> 
</cftry>

<cfset table = 'cms_specials'>
<cfset uppicture = #ExpandPath('/images/specials')#>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">
  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <cfif len(form.photo)>      
    
    <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
    <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
    <cfset myfile = results.filename>   
   
  </cfif> 
  
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
    startdate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#startdate#">,
    enddate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#enddate#">,
    description = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#description#">,
    active = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.active#">,
    slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">,
    allowedBookingStartDate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.allowedBookingStartDate#">,
    allowedBookingEndDate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.allowedBookingEndDate#">
    <cfif len(form.photo)>,photo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->
  
  <cfif len(form.photo)>      
    
    <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
    <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
    <cfset myfile = results.filename>   
  
  <cfelse>
      <cfset myfile = ''>  
  </cfif>
  
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(title,startdate,enddate,description,photo,active,slug,allowedBookingStartDate,allowedBookingEndDate) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#title#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#startdate#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#enddate#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#description#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.active#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.allowedBookingStartDate#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.allowedBookingEndDate#">
      )
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?success">
  
</cfif>