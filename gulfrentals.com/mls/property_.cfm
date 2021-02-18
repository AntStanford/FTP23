<cfif
   isdefined('url.mlsnumber') and len(url.mlsnumber) and isValid('integer',url.mlsnumber) and
   isdefined('url.mlsid') and len(url.mlsid) and isValid('integer',url.mlsid) and
   isdefined('url.wsid') and len(url.wsid) and isValid('integer',url.wsid)
>

   <cfset errorMessage = ''>
   <cfparam name="isavailable" default="false">

   <!--- Add this property to cookie.mlsrecent if it has not already been added --->

   <cfset lf = ListFindNoCase(cookie.mlsrecent,url.mlsnumber)> <!--- Search for the property --->

   <cfif lf gt 0>
      <!--- We found it, so don't do anything --->
   <cfelse>

      <!--- We did not find it, add it to cookie.mlsrecent --->
      <cfif len(cookie.mlsrecent)>
         <cfcookie name="mlsrecent" value="#cookie.mlsrecent#,#url.mlsnumber#">
      <cfelse>
         <cfcookie name="mlsrecent" value="#url.mlsnumber#">
      </cfif>

   </cfif>

   <!--- end cookie.recent section --->


   <!--- Get what we need for this property --->
   <cfquery name="property" dataSource="#application.settings.mls.propertydsn#">
      select *
      from mastertable
      where
      mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.mlsnumber#">
      and
      mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.mlsid#">
      and
      wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.wsid#">
   </cfquery>

   <cfif property.recordcount eq 0>
      <cflocation addToken="no" url="/">
   </cfif>

   <cfif property.Virtual_Tour contains 'vimeo.com'>
      <cfset variables.virtualTourLink = replaceNoCase(property.Virtual_Tour, 'http:', 'https:') />
      <cfset variables.virtualTourModal = false />
    <cfelse>
      <cfset variables.virtualTourLink = application.oHelpers.optimizeVirtualTour(property.Virtual_Tour) />
      <cfset variables.virtualTourModal = true />
    </cfif>

   <cfquery datasource="#application.settings.mls.propertydsn#" name="getareas">
      SELECT *
      FROM masterareas_cleaned
      where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.MLSID#">
      <cfif property.recordcount gt 0 and property.area is not ""> and areashidden in (#property.area#)</cfif>
    </cfquery>

  <cfquery datasource="#application.settings.mls.propertydsn#" name="GetDateListed">
    SELECT *
    FROM property_dates
    where
    mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.mlsnumber#"> and mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.mlsid#">
  </cfquery>


  <cfif isdefined('application.settings.logpropertiesviewed') and application.settings.logpropertiesviewed is 'yes'>
     <!--- Log the user's visit --->
    <!---START: CAPTURE PAGE VIEW--->
    <cfquery datasource="#application.settings.dsn#" name="CountViewsOfProperty">
      SELECT COUNT(mlsnumber) as thecount
      FROM cl_properties_viewed
      where mlsnumber = '#mlsnumber#' and wsid= '#wsid#' and mlsid = '#mlsid#'
    </cfquery>
    <!---this one variable below is used to show the popularity of properties in the dashboard--->
    <cfset TotalPropViews = #CountViewsOfProperty.thecount# + 1>
    <cfquery datasource="#application.settings.dsn#" dbtype="ODBC">
      Insert
      Into cl_properties_viewed
          (<cfif isdefined('cookie.loggedin')>clientid,<cfelse>TheCFID,TheCFTOKEN,</cfif>mlsid,wsid,mlsnumber,AllViewsCount)
      Values
          (<cfif isdefined('cookie.loggedin')>
             <cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR">,
           <cfelse>
             <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">,
           </cfif>
           <cfqueryparam value="#mlsid#" cfsqltype="CF_SQL_VARCHAR">,
           <cfqueryparam value="#wsid#" cfsqltype="CF_SQL_VARCHAR">,
           <cfqueryparam value="#mlsnumber#" cfsqltype="CF_SQL_VARCHAR">,
           <cfqueryparam value="#TotalPropViews#" cfsqltype="CF_SQL_INTEGER"> )
    </cfquery>
    <!---END: CAPTURE PAGE VIEW--->
  </cfif>
<cfelse>
   You cannot access this page. <cfabort>
</cfif>

