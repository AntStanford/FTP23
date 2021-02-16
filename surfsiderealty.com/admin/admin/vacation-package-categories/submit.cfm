<cftry>
   <cfcache action="flush" key="cms_vacation_packages_categories">
   <cfcatch></cfcatch>
</cftry>

<!--- On page variables --->
<cfset uppicture = #ExpandPath('/images/vacation-packages')#>
<cfset table = 'cms_vacation_packages_categories'>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>

   <cfquery name="getinfo" dataSource="#settings.dsn#">
    select photo from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

  <cfif fileExists("#uppicture#/#getinfo.photo#")><cffile action="delete" file="#uppicture#/#getinfo.photo#"></cfif>

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
      name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#"><!--- ,
	  slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#slug#"> --->
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
      insert into #table#(name,photo,sort<!--- ,slug --->)
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
        <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#sortValue#"><!--- ,
		<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#slug#"> --->
        )
    </cfquery>

    <cflocation addToken="no" url="form.cfm?success">


</cfif>





