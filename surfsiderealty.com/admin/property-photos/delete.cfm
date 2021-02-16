

<cfset originalPath = expandPath('/uploaded')>


<!--- Delete --->
<cfif isdefined('url.image') and isdefined('url.imageid')>

  <cfif FileExists('#originalPath#/#url.image#')><cffile action="delete" file="#originalPath#/#url.image#"></cfif>
  <!--- <cfif FileExists('#originalPath#/thumbs/#url.image#')><cffile action="delete" file="#originalPath#/thumbs/sm_#url.image#"></cfif> --->




  <cfquery dataSource="#settings.dsn#">
    delete from prop_images where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.imageid#">
  </cfquery>

  <cftry>
    <!--- TT-87698: Flush cache for _overview-tab.cfm --->
    <cfcache action="flush" key="overviewTab">
    <cfcatch></cfcatch>
  </cftry>

  <cflocation addToken="no" url="index.cfm?deleteimage&strpropid=#url.strpropid#">

</cfif>
