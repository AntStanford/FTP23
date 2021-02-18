<cfset form.camefromsearchform=true>

<cfquery name="getSearches" datasource="mlsv30master">
    select *
    from cl_custom_searches
    where siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.id#">
    and pageid = <cfqueryparam cfsqltype="cf_sql_integer" value="#page.id#">
    and searchCriteria is not null
    and searchCriteria <> ''
</cfquery>

<cfif cgi.remote_addr eq '70.40.111.48x'>
     <cfdump var="#getSearches#" label="getSearches" abort="true">
</cfif>

<cfset jsonStruct = deserializeJSON(trim(getSearches.searchCriteria))>

<cfloop collection="#jsonStruct#" item="theField">
    <cfset form[theField] = jsonStruct[theField]>
</cfloop>


<cfinclude template="/mls/results.cfm">