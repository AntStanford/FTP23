<cfquery name="getSearches" datasource="mlsv30master">
    select *
    from cl_custom_searches
    where siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.id#">
    and pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#page.id#">
    and searchCriteria is not null
    and searchCriteria <> ''
    and (searchType ='1' or searchType='2')
</cfquery>

<cfif cgi.remote_addr eq '68.80.62.233' and getSearches.recordcount eq 0>
<cfdump var="#getSearches#" label="getSearches">
</cfif>


<!---
If the above query produces a result...
--->
<cfif getSearches.recordcount gt 0>
    <!---
    And the Display As setting is button, show a button
    --->
    <cfif getSearches.searchType eq '1'>
        <cfoutput>
            <a class="btn btn-success" href="/mls/results?#application.oHelpers.StructToQueryString(deserializeJSON(getSearches.searchCriteria))#">#getSearches.buttonTExt#</a><!--- removed .cfm --->
        </cfoutput>

    <!---
    Else, the Display As setting is, "Results on Page"...
    --->
    <cfelseif getSearches.searchType eq '2'>

        <cfset mBedsmin="">
        <cfset mBedsmax="">
        <cfset mBathsmin="">
        <cfset mBathsmax="">
        <cfset mcity="">
        <cfset marea="">
        <cfset mSortby="">
        <cfset mPropertyType="">

        <!--- deserialize JSON --->
        <cfset mlsSearchdata=deserializeJSON(getSearches.searchCriteria)>

        <cfset pmax = mlsSearchdata.PMAX>
        <cfset pmin = mlsSearchdata.PMIN>

        <!--- Below isdefined added as a result of:  --->
        <!--- https://basecamp.com/2598991/projects/10482567/todos/230731936#events_todo_230731936 --->
        <cfif isdefined('mlsSearchdata.CITY')>
            <cfset mcity = mlsSearchdata.CITY>
        </cfif>
        <cfif isdefined('mlsSearchdata.area')>
            <cfset marea = mlsSearchdata.area>
        </cfif>

        <cfif isdefined('mlsSearchdata.SORTBY')>
            <cfset mSortby = mlsSearchdata.SORTBY>
        </cfif>

        <!--- TODO There's probably a join table that has the property type --->
        <!--- defined, masterstyles, seems not to be it --->
        <cfif isdefined('mlsSearchdata.WSID') and len(mlsSearchdata.WSID)>
            <!--- Residential --->
            <cfif mlsSearchdata.WSID eq 1>
                <cfset mPropertyType = "Residential">
            </cfif>
            <!--- Land --->
            <cfif mlsSearchdata.WSID eq 2>
                <cfset mPropertyType = "Land">
            </cfif>
            <!--- Commercial --->
            <cfif mlsSearchdata.WSID eq 3>
                <cfset mPropertyType = "Commercial">
            </cfif>
            <!--- Condo/Villa --->
            <cfif mlsSearchdata.WSID eq 5>
                <cfset mPropertyType = "Condo/Townhouse">
            </cfif>
            <!--- Multifamily --->
            <cfif mlsSearchdata.WSID eq 6>
                <cfset mPropertyType = "Multifamily">
            </cfif>
        </cfif>

        <cfset mBedrooms = mlsSearchdata.BEDROOMS>
        <!--- split bedrooms, min and max --->
        <cfif mBedrooms neq ''>
            <cfset sBeds = ListToArray(mBedrooms, ",", false, true)>
            <cfset mBedsmin=sBeds[1]>
            <cfset mBedsmax=sBeds[2]>
        </cfif>

        <cfset pBaths = mlsSearchdata.BATHS_FULL>

        <cfif pBaths neq ''>
            <cfset sBaths = ListToArray(pBaths, ",", false, true)>
            <cfset mBathsmin=sBaths[1]>
            <cfset mBathsmax=sBaths[2]>
        </cfif>

      <!---
      <strong>City: </strong> <cfoutput>#mcity#</cfoutput>--->
         <!--- Get data for search
         <cfset colList=ArrayToList(mlsSearchdata.COLUMNS)>  --->
         <cfinclude template="/mls/partials/custom-search.cfm">
         <br><br>
         <cfoutput>
         <a class="btn btn-success" href="/mls/results?camefromsearchform=&#application.oHelpers.StructToQueryString(deserializeJSON(getSearches.searchCriteria))#">View All #getSearches.buttonTExt#</a><!--- removed .cfm --->
         </cfoutput>
   </cfif>
</cfif>
