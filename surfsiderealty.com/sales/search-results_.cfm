<!---GETS IMAGE PATH--->
<cfquery name="getmlscoinfo" datasource="#DSNMLS#" >
  SELECT *
  FROM mlsfeeds
  where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
</cfquery>



<!---START: USED TO CLOSE LIGHTBOX AND RELOAD PAGE--->
<cfset session.RememberMePage = "#script_name#?#query_string#">
<!---END: USED TO CLOSE LIGHTBOX AND RELOAD PAGE--->



<!---START: ADD TO FAVORITES--->
<cfinclude template="/sales/lightboxes/add-to-favorites_.cfm">
<!---END: ADD TO FAVORITES--->



<!---START: QUERY WRITTEN ONCE FOR RESULTS AND PAGINATION--->
<cfinclude template="/sales/search-results_query.cfm">
<!---END: QUERY WRITTEN ONCE FOR RESULTS AND PAGINATION--->



<!--- START: Pagination Code --->
<cfparam name="url.searchpage" default="1">
<cfset page_links_shown = 4>
<cfset records_per_page = 10>
<cfparam name="start_page" default="1">
<cfparam name="start" DEFAULT="1">
<cfset nextpage = "/sales/search-results.cfm">
<cfquery datasource="#DSNMLS#" name="COUNTINFO">
  SELECT COUNT(mastertable.mlsnumber) as thecount
  FROM mastertable
  Inner Join property_dates
  where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">  and property_dates.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
    and  mastertable.mlsid =  property_dates.mlsid
    and  mastertable.wsid =  property_dates.wsid
  #preservesinglequotes(querycode)#
</cfquery>
<cfset CountInfo.TheCount=Countinfo.thecount>
<cfset start_record = url.searchpage * records_per_page - records_per_page>
<cfset total_pages = ceiling(COUNTinfo.thecount / records_per_page)>
<cfparam name="show_pages" default="#min(page_links_shown,total_pages)#">
<!--- END: Pagination Code --->



<!---START: Main Query--->
<cfquery datasource="#DSNMLS#" name="GetListings">
  SELECT
    mastertable.street_number,mastertable.street_name,mastertable.city,mastertable.zip_code,mastertable.state,mastertable.mlsnumber,mastertable.mlsid,mastertable.wsid,mastertable.unit_number,mastertable.list_price,mastertable.subdivision,mastertable.bedrooms,mastertable.baths_full,mastertable.acreage,mastertable.zoning,mastertable.kind,mastertable.photo_link,mastertable.addressdisplayyn,mastertable.legaladdress,mastertable.shortsale,mastertable.foreclosure,property_dates.created_at,mastertable.longitude,mastertable.latitude
  FROM mastertable
  Inner Join property_dates
  where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and property_dates.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
    and  mastertable.mlsid =  property_dates.mlsid
    and  mastertable.wsid =  property_dates.wsid
    #preservesinglequotes(querycode)#
  LIMIT #start_record#, #records_per_page#
</cfquery>
<!---END: Main Query--->



<!---START: SAME QUERY AS ABOVE MINUS THE LIMIT TO GET THE ENTIRE LIST OF MLS NUMBER FOR THE PREVIOUS NEXT BUTTONS--->
<!--- <cfquery datasource="#DSNMLS#" name="GetAllListings">
  SELECT
    mastertable.*,
    property_dates.created_at
  FROM mastertable
  Inner Join property_dates
  where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and property_dates.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
  #preservesinglequotes(querycode)#
</cfquery> --->


<!--- <cfquery datasource="#DSNMLS#" name="GetAllListings">
  SELECT
    mastertable.mlsnumber,
    property_dates.created_at
  FROM mastertable
  Inner Join property_dates
  where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and property_dates.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
  #preservesinglequotes(querycode)#
    LIMIT #start_record#, #records_per_page#
</cfquery> --->
<cfset session.PrevNextMLSNumbers = "#valuelist(GetListings.mlsnumber)#">


<!---END: SAME QUERY AS ABOVE MINUS THE LIMIT TO GET THE ENTIRE LIST OF MLS NUMBER FOR THE PREVIOUS NEXT BUTTONS--->



<!---Saving all the searches for tracking purposes--->
<cfif isdefined('dontcountsearch') is "No" and isdefined('dcr') is "No" and GetListings.recordcount gt 0>
  <cfinclude template="/sales/lightboxes/save-search_.cfm">
</cfif>
