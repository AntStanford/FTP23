<!--- On page variables --->
<cfset uppicture = #ExpandPath('/images/vacationpackages')#>
<cfset table = 'cms_vacation_packages'>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>

   <cfquery name="getinfo" dataSource="#settings.dsn#">
    select photo from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

  <cfif fileexists("#uppicture#/#getinfo.photo#")>
      <cffile action="delete" file="#uppicture#/#getinfo.photo#">
  </cfif>

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
      active = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.active#">,
      name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
      safename = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.safename#">,
  	  cost = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.cost#">,
  	  description = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.description#">,
  	  category = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#category#">
      <cfif len(form.photo)>,photo = '#myfile#'</cfif>
      where id = #id#
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
      insert into #table#(active,name,safename,photo,sort,cost,description,category)
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.active#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.safename#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
        <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#sortValue#">,
    		<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cost#">,
    		<cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#description#">,
    		<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.category#">
        )
    </cfquery>

    <cflocation addToken="no" url="form.cfm?success">


</cfif>





