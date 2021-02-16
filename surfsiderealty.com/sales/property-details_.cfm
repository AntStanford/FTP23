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
  where mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'> and wsid= <cfqueryparam cfsqltype="cf_sql_varchar" value='#wsid#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsid#'> <cfif isdefined('cookie.loggedin')>and clientid = <cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric"></cfif>
</cfquery>


<!---this one variable below is used to show the popularity of properties in the dashboard--->
<cfset TotalPropViews = #CountViewsOfProperty.thecount# + 1>


<cfif isdefined('cookie.loggedin')>

  <cfif CountViewsOfProperty.THECOUNT eq 0>
      <cfquery datasource="#mls.dsn#" dbtype="ODBC">
      Insert
      Into cl_properties_viewed
          (clientid,TheCFID,TheCFTOKEN,mlsid,wsid,mlsnumber,AllViewsCount)
      Values
          (
          <cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#mlsid#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#wsid#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#mlsnumber#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#TotalPropViews#" cfsqltype="CF_SQL_INTEGER">
         )
     </cfquery>
  <cfelse>
      <cfquery datasource="#mls.dsn#" dbtype="ODBC">
          update cl_properties_viewed
          set AllViewsCount = #TotalPropViews#
          where mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'> and wsid= <cfqueryparam cfsqltype="cf_sql_varchar" value='#wsid#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsid#'> and clientid = <cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric">
      </cfquery>
  </cfif>

<cfelse>

    <cfquery datasource="#mls.dsn#" dbtype="ODBC">
    Insert
    Into cl_properties_viewed
        (TheCFID,TheCFTOKEN,mlsid,wsid,mlsnumber,AllViewsCount)
    Values
        (
       <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR">,
       <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">,
       <cfqueryparam value="#mlsid#" cfsqltype="CF_SQL_VARCHAR">,
       <cfqueryparam value="#wsid#" cfsqltype="CF_SQL_VARCHAR">,
       <cfqueryparam value="#mlsnumber#" cfsqltype="CF_SQL_VARCHAR">,
       <cfqueryparam value="#TotalPropViews#" cfsqltype="CF_SQL_INTEGER">
       )
   </cfquery>

</cfif>


<!---END: CAPTURE PAGE VIEW--->


</cfif>


<cfquery datasource="#DSNMLS#" name="GetListings">
  SELECT *
  FROM mastertable
  where mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'> and wsid= <cfqueryparam cfsqltype="cf_sql_varchar" value='#wsid#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsid#'>
</cfquery>

<cfquery datasource="#dsnmls#" name="getareas">
  SELECT *
  FROM masterareas_cleaned
  where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> <cfif GetListings.recordcount gt 0 and GetListings.area is not ""> and areashidden in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#Getlistings.area#">)</cfif>
</cfquery>



<cfquery datasource="#dsnmls#" name="GetDateListed">
  SELECT *
  FROM property_dates
  where mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
</cfquery>



<!---GETS IMAGE PATH--->
<cfquery name="getmlscoinfo" datasource="#DSNMLS#" >
  SELECT *
  FROM mlsfeeds
  where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
</cfquery>


<!--- CHECK TO SEE IF THIS IS USING A STATIC URL, IF SO REDIRECT --->
<cfif cgi.QUERY_STRING contains 'subdivision=' or cgi.QUERY_STRING contains 'area=' or cgi.QUERY_STRING contains 'city=' or cgi.QUERY_STRING contains 'dcr='>

  <cfif GetListings.recordcount gt 0>
    <cfoutput query="GetListings" maxrows="1">
      <cflocation url="#optimizeMyURL(GetListings.street_number,GetListings.street_name,GetListings.city,GetListings.zip_code,GetListings.mlsnumber,GetListings.mlsid,GetListings.wsid)#" addtoken="false" statuscode="301">
    </cfoutput>
  </cfif>

</cfif>
<!--- END REDIRECT --->