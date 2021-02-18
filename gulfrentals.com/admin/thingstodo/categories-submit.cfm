<!--- Flush the cache if it exists --->
<cftry>
     <cfcache action="flush" key="cms_thingstodo">
     <cfcatch></cfcatch>
</cftry>

<cfset table = 'cms_thingstodo_categories'>
<cfset uppicture = #ExpandPath('/images/thingstodo')#>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>

  <cfquery dataSource="#application.dsn#">
    delete from cms_thingstodo_categories where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

  <cflocation addToken="no" url="categories-index.cfm?success">


<!--- Update Existing Record --->
<cfelseif isdefined('form.id')>

    <cfif isdefined('form.photo') and len(form.photo)>
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results)><cfoutput>#results#</cfoutput><cfabort></cfif>
      <cfset myfile = cffile.serverfile>

      <!--- Now compress the image using CF_GraphicsMagick  --->
		<CF_GraphicsMagick
			     action="Optimize"
			     infile="#uppicture#\#myfile#"
			     outfile="#uppicture#\#myfile#"
			     compress="JPEG">

    </cfif>

    <cfquery dataSource="#application.dsn#">
      update cms_thingstodo_categories set
      title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
      slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">
      <cfif isdefined('form.photo') and len(form.photo)>,photo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>

    <cflocation addToken="no" url="categories-form.cfm?id=#id#&success">


<!--- Add New Record --->
<cfelse>

    <cfif len(form.photo)>

	    <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
	    <cfset results=Obj.Check(uppicture,"photo")><cfif len(results)><cfoutput>#results#</cfoutput><cfabort></cfif>
	    <cfset myfile = cffile.serverfile>

	    <!--- Now compress the image using CF_GraphicsMagick  --->
		 <CF_GraphicsMagick
			     action="Optimize"
			     infile="#uppicture#\#myfile#"
			     outfile="#uppicture#\#myfile#"
			     compress="JPEG">

    <cfelse>
      <cfset myfile = ''>
    </cfif>


    <cfquery dataSource="#application.dsn#">
      insert into cms_thingstodo_categories(title,photo,slug)
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">
        )
    </cfquery>

    <cflocation addToken="no" url="categories-form.cfm?success">


</cfif>





