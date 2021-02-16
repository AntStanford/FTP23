<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_eventcal">
     <cfcatch></cfcatch> 
</cftry>

<cfset table = 'cms_eventcal'>
<cfset uppicture = #ExpandPath('/images/events')#>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">
  
<cfelseif isdefined('url.reocurringEventID') and isdefined('url.deleteSeries')>
  
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where reocurringEventID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.reocurringEventID#"> 
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
   
   
  <cfelseif original_photo is not "">
   	   <cfset myfile = '#original_photo#'> 
  <cfelse>
  
      <cfset myfile = ''> 

  </cfif>
  
   
    <!---START: HANDLES REOCURRANCE CALCULATIONS--->
	
<cfif isdefined('form.GroupOrSingle')>
  <cfif form.reocurring is "Yes" and form.GroupOrSingle is "All">
  
	  <!---delete all the reocurring events and add them again--->
	  <CFQUERY DATASOURCE="#settings.dsn#" NAME="DeleteAndAdd">
		delete
		FROM #table#
		where reocurringEventID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.reocurringEventID#">
	  </CFQUERY>
  
  
  <cfset reocurringEventID = "#cfid##cftoken##randrange(10000,999999999)#">
  
 
  <cfset howmany = form.HowManyTimes - 1>
  
	<cfloop index="i" from="0" to="#howmany#" step="1">
	
	
	<cfif form.Occurance is "Daily">
	    <cfset StartNextTimePeriod = "#dateadd('d',i,form.start_date)#">
		<cfif form.end_date is not ""><cfset EndNextTimePeriod = "#dateadd('d',i,form.end_date)#"></cfif>
	<cfelseif form.Occurance is "Weekly">
	    <cfset StartNextTimePeriod = "#dateadd('ww',i,form.start_date)#">
		<cfif form.end_date is not ""><cfset EndNextTimePeriod = "#dateadd('ww',i,form.end_date)#"></cfif>
	<cfelseif form.Occurance is "Monthly">
	    <cfset StartNextTimePeriod = "#dateadd('m',i,form.start_date)#">
		<cfif form.end_date is not ""><cfset EndNextTimePeriod = "#dateadd('m',i,form.end_date)#"></cfif>
	</cfif>
	
		
	 <cfquery dataSource="#settings.dsn#">
    insert into #table#(event_title,start_date<cfif form.end_date is not "">,end_date</cfif>,details_long,photo,event_location,time_start,time_end,reocurring,Occurance,HowManyTimes,reocurringEventID<!--- ,address,
city,state,zip --->) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_title#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#StartNextTimePeriod#">,
      <cfif form.end_date is not ""><cfqueryparam CFSQLType="CF_SQL_DATE" value="#EndNextTimePeriod#">,</cfif>
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.details_long#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_location#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_start#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_end#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.reocurring#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.Occurance#">,
	  <cfqueryparam CFSQLType="CF_SQL_NUMERIC" value="#form.HowManyTimes#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#reocurringEventID#"><!--- ,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#address#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#city#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#state#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#zip#"> --->
      )
  </cfquery>
	
	
	</cfloop>  
  
    <!---END: HANDLES REOCURRANCE CALCULATIONS--->
  
  <cfelse>
  <!---non reocurring--->
  
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    event_title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_title#">,
    start_date = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.start_date#">,
    end_date = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.end_date#">,
    time_start = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_start#">,
    time_end = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_end#">,
    details_long = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.details_long#">,
    event_location = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_location#"><!--- ,
	address = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address#">,
	city = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.city#">,
	state = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.state#">,
	zip = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.zip#"> --->
    <cfif isdefined('form.photo') and len(form.photo)>,photo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>  
   
  
   </cfif>
  </cfif>
  

  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->
  
  <cfif isdefined('form.photo') and len(form.photo)>
   
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>
   
  <cfelse>
  
      <cfset myfile = ''> 

  </cfif>
  
  
  <!---START: HANDLES REOCURRANCE CALCULATIONS--->
  
  <cfset reocurringEventID = "#cfid##cftoken##randrange(10000,999999999)#">
  
  <cfif form.reocurring is "Yes">
  
  <cfset howmany = form.HowManyTimes - 1>
  
	<cfloop index="i" from="0" to="#howmany#" step="1">
	
	
	<cfif form.Occurance is "Daily">
	    <cfset StartNextTimePeriod = "#dateadd('d',i,form.start_date)#">
		<cfif form.end_date is not ""><cfset EndNextTimePeriod = "#dateadd('d',i,form.end_date)#"></cfif>
	<cfelseif form.Occurance is "Weekly">
	    <cfset StartNextTimePeriod = "#dateadd('ww',i,form.start_date)#">
		<cfif form.end_date is not ""><cfset EndNextTimePeriod = "#dateadd('ww',i,form.end_date)#"></cfif>
	<cfelseif form.Occurance is "Monthly">
	    <cfset StartNextTimePeriod = "#dateadd('m',i,form.start_date)#">
		<cfif form.end_date is not ""><cfset EndNextTimePeriod = "#dateadd('m',i,form.end_date)#"></cfif>
	</cfif>
	
		
	 <cfquery dataSource="#settings.dsn#">
    insert into #table#(event_title,start_date<cfif form.end_date is not "">,end_date</cfif>,details_long,photo,event_location,time_start,time_end,reocurring,Occurance,HowManyTimes,reocurringEventID<!--- ,address,
city,state,zip --->) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_title#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#StartNextTimePeriod#">,
      <cfif form.end_date is not ""><cfqueryparam CFSQLType="CF_SQL_DATE" value="#EndNextTimePeriod#">,</cfif>
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.details_long#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_location#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_start#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_end#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.reocurring#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.Occurance#">,
	  <cfqueryparam CFSQLType="CF_SQL_NUMERIC" value="#form.HowManyTimes#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#reocurringEventID#"><!--- ,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#address#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#city#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#state#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#zip#"> --->
      )
  </cfquery>
	
	
	</cfloop>  
  


  <!---END: HANDLES REOCURRANCE CALCULATIONS--->
  
  <cfelse>
  <!---non reocurring--->
  
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(event_title,start_date,end_date,details_long,photo,event_location,time_start,time_end<!--- ,address,
city,state,zip --->) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_title#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.start_date#">,
      <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.end_date#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.details_long#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.event_location#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_start#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.time_end#"><!--- ,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#address#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#city#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#state#">,
	  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#zip#"> --->
      )
  </cfquery>
  
  
   </cfif>  
  
 <cflocation addToken="no" url="form.cfm?success">
  
</cfif>

































