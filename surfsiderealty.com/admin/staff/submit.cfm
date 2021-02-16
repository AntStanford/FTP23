<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_staff">
     <cfcatch></cfcatch> 
</cftry>

<!--- On page variables --->
<cfset uppicture = #ExpandPath('/images/staff')#>
<cfset table = 'cms_staff'>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>
  
   <cfquery name="getinfo" dataSource="#settings.dsn#">
    select photo from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cfif len(getinfo.photo)>
  	<cffile action="delete" file="#uppicture#/#getinfo.photo#">
  </cfif>
  
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?successdelete">

<cfelseif isdefined('url.id') and isdefined('url.onduty')>
  
  <cfquery dataSource="#settings.dsn#">
    Update #table# set onduty = '' where onduty = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.onduty#">
  </cfquery>
  
  <cfquery dataSource="#settings.dsn#">
    Update #table# set onduty = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.onduty#"> where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

  <cflocation addToken="no" url="index.cfm?successonduty">


<!--- Update Existing Record --->  
<cfelseif isdefined('form.id')>
  <cftry>
  
    <cfif len(form.photo)>
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>  
    </cfif>
    

    <cfquery dataSource="#settings.dsn#">
      update #table# set
      name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
      title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
      description = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.description#">,
      phone = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.phone#">,
      email = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
      category = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.category#">,
      onduty = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.onduty#">
      <cfif len(form.photo)>,photo = '#myfile#'</cfif>
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>
    	<cfcatch type="any">
        	<cfdump var="#cfcatch#"><cfabort>
        </cfcatch>
    </cftry>
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
    
     <!--- Get current sort values --->
    <cfquery name="getSort" dataSource="#settings.dsn#">
      select max(sort) as maxSort from #table#
    </cfquery>
             
    <cfif getSort.recordcount gt 0 and len(getSort.maxSort)>
      <cfset sortValue = getSort.maxSort + 1> 
    <cfelse>
      <cfset sortValue = 1>
    </cfif>

    <cfquery dataSource="#settings.dsn#">
      insert into #table#(name,title,description,photo,sort,phone,email,category,onduty) 
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
        <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.description#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
        <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#sortValue#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.phone#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.category#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.onduty#">
        )
    </cfquery>
    
    <cflocation addToken="no" url="form.cfm?success"> 
  
  
</cfif>  
       




