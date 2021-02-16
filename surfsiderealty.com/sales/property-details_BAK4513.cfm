<cfif isdefined('mlsnumber') is "No" and isdefined('Favoritemlsnumber') is "No">
  <cflocation url = "/sales/index.cfm">
</cfif>



<!---START: ADD TO FAVORITES--->
<cfinclude template="/sales/lightboxes/add-to-favorites_.cfm">

<cfif isdefined('Favoritemlsnumber')>
  <cfset mlsnumber = "#Favoritemlsnumber#">
  <cfset wsid = "#Favoritewsid#">
  <cfset mlsid = "#Favoritemlsid#">
</cfif>
<!---END: ADD TO FAVORITES--->



<!---START: USED TO CLOSE LIGHTBOX AND RELOAD PAGE--->
<cfset session.RememberMePage = "#script_name#?#query_string#">
<!---END: USED TO CLOSE LIGHTBOX AND RELOAD PAGE--->


<cfif cgi.http_referer does not contain 'lightboxes'>
  
<!---START: CAPTURE PAGE VIEW--->
<cfquery datasource="#mls.dsn#" name="CountViewsOfProperty">
  SELECT COUNT(mlsnumber) as thecount
  FROM cl_properties_viewed
  where mlsnumber = '#mlsnumber#' and wsid= '#wsid#' and mlsid = '#mlsid#'
</cfquery>
<!---this one variable below is used to show the popularity of properties in the dashboard--->
<cfset TotalPropViews = #CountViewsOfProperty.thecount# + 1>
<cfquery datasource="#mls.dsn#" dbtype="ODBC">
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


<cfquery datasource="#DSNMLS#" name="GetListings">
  SELECT *
  FROM mastertable
  where mlsnumber = '#mlsnumber#' and wsid= '#wsid#' and mlsid = '#mlsid#'
</cfquery>

<cfquery datasource="#dsnmls#" name="getareas">
  SELECT *
  FROM masterareas_cleaned
  where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> <cfif GetListings.recordcount gt 0 and GetListings.area is not ""> and areashidden in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#Getlistings.area#">)</cfif>
</cfquery>

<cfquery datasource="#dsnmls#" name="GetDateListed">
  SELECT *
  FROM property_dates
  where mlsnumber = '#mlsnumber#' 
</cfquery>



<!---GETS IMAGE PATH--->
<cfquery name="getmlscoinfo" datasource="#DSNMLS#" >
  SELECT *
  FROM mlsfeeds
  where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
</cfquery>