<!--- Flush the cache if it exists --->
<cftry>
     <cfcache action="flush" key="cms_pages">
     <cfcatch></cfcatch>
</cftry>

<cfset table = 'cms_pages'>
<cfset uppicture = #ExpandPath('/images/popular')#>
<cfparam name="form.subNavParentID" default="0">

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->

  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

  <cfquery dataSource="#settings.dsn#">
  	delete from cms_pages_properties where pageID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

  <cflocation addToken="no" url="index.cfm?success">


<cfelseif isdefined('form.id')> <!--- update statement --->


  <cfif isdefined('form.popularSearchPhoto') and len(form.popularSearchPhoto)>
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"popularSearchPhoto")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>
  </cfif>


  <cfif form.parentID neq 0 and form.ignoreParentSlug eq 'No'>

      <!--- Get the slug for the parent page and append to new page slug --->
      <cfquery name="getParentSlug" dataSource="#settings.dsn#">
         select slug from #table# where id = <cfqueryparam  CFSQLType="CF_SQL_INTEGER" value="#form.parentID#">
      </cfquery>

      <cfset mySlug = getParentSlug.slug & '/' & form.slug>

  <cfelse>
      <cfset mySlug = form.slug>
  </cfif>


  <!---START: VERSIONING CODE BY BS--->

  	<cfquery name="getPreviousPageData" dataSource="#settings.dsn#">
     select * from #table# where id = <cfqueryparam  CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  	</cfquery>


    <cfquery dataSource="#settings.dsn#">
    insert into cms_pages_versioning (name,body,slug,h1,metatitle,metadescription,parentID,subNavParentID,MainPageID,externalLink,triggerOnly,showinnavigation,ignoreParentSlug,layout,popularSearch,customSearchJSON,isCustomSearchPage,showInFooter<cfif isdefined('form.popularSearchPhoto') and len(form.popularSearchPhoto)>,popularSearchPhoto</cfif>)
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getPreviousPageData.name#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#trim(getPreviousPageData.body)#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getPreviousPageData.slug#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getPreviousPageData.h1#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getPreviousPageData.metatitle#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#getPreviousPageData.metadescription#">,
      <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.parentID#">,
      <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.subNavParentID#">,
      <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getPreviousPageData.externalLink#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getPreviousPageData.triggerOnly#">,
      <cfqueryparam CFSQLType="CF_SQL_CHAR" value="#getPreviousPageData.showinnavigation#">,
      <cfqueryparam CFSQLType="CF_SQL_CHAR" value="#getPreviousPageData.ignoreParentSlug#">,
      <cfqueryparam CFSQLType="CF_SQL_CHAR" value="#getPreviousPageData.layout#">,
      <cfqueryparam CFSQLType="CF_SQL_CHAR" value="#getPreviousPageData.popularSearch#">,
      <cfqueryparam cfsqltype="sql_varchar" value="#serializeJSON(FORM)#">,
      <cfif isdefined('form.isCustomSearchPage')>
      isCustomSearchPage = 'Yes',
      <cfelse>
      isCustomSearchPage = 'No',
      </cfif>
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getPreviousPageData.showInFooter#">
      <cfif isdefined('form.popularSearchPhoto') and len(form.popularSearchPhoto)>,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
    )
  </cfquery>

   <!---END: VERSIONING CODE BY BS--->


  <cfquery datasource="#settings.dsn#">
	update #table# set
    name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
    body = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#trim(form.body)#">,
    slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#mySlug#">,
    h1 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.h1#">,
    metatitle = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metatitle#">,
    metadescription = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.metadescription#">,
    showinnavigation = <cfqueryparam CFSQLType="CF_SQL_CHAR" value="#form.showinnavigation#">,
    parentID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.parentID#">,
    subNavParentID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.subNavParentID#">,
    externalLink = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.externalLink#">,
    triggerOnly = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.triggerOnly#">,
    ignoreParentSlug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.ignoreParentSlug#">,
    layout = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.layout#">,
    popularSearch = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.popularSearch#">,
    customSearchJSON = <cfqueryparam cfsqltype="sql_varchar" value="#serializeJSON(FORM)#">,
    <cfif isdefined('form.isCustomSearchPage')>
    isCustomSearchPage = 'Yes',
    <cfelse>
    isCustomSearchPage = 'No',
    </cfif>
    showInFooter = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.showInFooter#">
    <cfif isdefined('form.popularSearchPhoto') and len(form.popularSearchPhoto)>,popularSearchPhoto = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>


  <!--- Clear out any page properties, then re-insert, if any --->
  <cfquery dataSource="#settings.dsn#">
      delete from cms_pages_properties where pageID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>


  <cfif isdefined('form.properties') and ListLen(form.properties) gt 0>

      <cfloop list="#form.properties#" index="i">

         <cfquery dataSource="#settings.dsn#">
            insert into cms_pages_properties(pageID,unitcode) values(<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">,'#i#')
         </cfquery>

      </cfloop>

      <!--- Now update this page type and add the results.cfm partial --->
      <cfquery dataSource="#settings.dsn#">
         update cms_pages set `layout` = 'full.cfm', partial = 'results.cfm' where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
      </cfquery>

  <cfelseif isdefined('form.isCustomSearchPage')>

      <!--- Now update this page type and add the results.cfm partial --->
      <cfquery dataSource="#settings.dsn#">
         update cms_pages set `layout` = 'full-booking.cfm', partial = 'results.cfm' where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
      </cfquery>

  </cfif>


  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->

	<cfif isdefined('form.popularSearchPhoto') and len(form.popularSearchPhoto)>

		<cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
		<cfset results=Obj.Check(uppicture,"popularSearchPhoto")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
		<cfset myfile = results.filename>

	<cfelse>
		<cfset myfile = ''>
	</cfif>


  <cfif form.parentID neq 0 and form.ignoreParentSlug eq 'No'>

      <!--- Get the slug for the parent page and append to new page slug --->
      <cfquery name="getParentSlug" dataSource="#settings.dsn#">
         select slug from #table# where id = <cfqueryparam  CFSQLType="CF_SQL_INTEGER" value="#form.parentID#">
      </cfquery>

      <cfset mySlug = getParentSlug.slug & '/' & form.slug>

  <cfelse>
      <cfset mySlug = form.slug>
  </cfif>

  <cfset newString = replace(form.name,' ','-','all')>
  <cfset mybodyclass = lcase(newstring)>

  <cfquery dataSource="#settings.dsn#">
    insert into #table#(name,body,slug,h1,metatitle,metadescription,showinnavigation,parentID,subNavParentID,externalLink,triggerOnly,ignoreParentSlug,bodyClass,layout,popularSearch,popularSearchPhoto,customSearchJSON,isCustomSearchPage,showInFooter)
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.body#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#mySlug#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.h1#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metatitle#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.metadescription#">,
      <cfqueryparam CFSQLType="CF_SQL_CHAR" value="#form.showinnavigation#">,
      <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.parentID#">,
      <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.subNavParentID#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.externalLink#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.triggerOnly#">,
      <cfqueryparam CFSQLType="CF_SQL_CHAR" value="#form.ignoreParentSlug#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#mybodyclass#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.layout#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.popularSearch#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">,
      <cfqueryparam cfsqltype="sql_varchar" value="#serializeJSON(FORM)#">,
      <cfif isdefined('form.isCustomSearchPage')>
      isCustomSearchPage = 'Yes',
      <cfelse>
      isCustomSearchPage = 'No',
      </cfif>
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.showInFooter#">
    )
  </cfquery>
   <cfquery name="getNewID" datasource="#settings.dsn#">
     select LAST_INSERT_ID() as newID
   </cfquery>

  <!--- check for any submitted properties --->
  <cfif isdefined('form.properties') and ListLen(form.properties) gt 0>


      <cfloop list="#form.properties#" index="i">

         <cfquery dataSource="#settings.dsn#">
            insert into cms_pages_properties(pageID,unitcode) values(<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getNewID.newID#">,'#i#')
         </cfquery>

      </cfloop>

      <!--- Now update this page type and add the results.cfm partial --->
      <cfquery dataSource="#settings.dsn#">
         update cms_pages set layout = 'full.cfm',partial = 'results.cfm' where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getNewID.newID#">
      </cfquery>

  <cfelseif isdefined('form.isCustomSearchPage')>

      <!--- Now update this page type and add the results.cfm partial --->
      <cfquery dataSource="#settings.dsn#">
         update cms_pages set layout = 'full.cfm',partial = 'results.cfm' where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getNewID.newID#">
      </cfquery>

  </cfif>

  <cflocation addToken="no" url="form.cfm?success">

</cfif>