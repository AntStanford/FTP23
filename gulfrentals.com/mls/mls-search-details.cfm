<cfparam name="url.req" default="">
<cfset qsslug = "/" & ListGetAt(cgi.query_string,1,'&')>
<cfset mnum="">
<cfset mwsid="">
<cfloop item="key" collection="#URL#">
    <cfset var="#key#"> 
    <cfset val="#URL[key]#">
    <cfif var neq '' and val neq '' and var eq 'mlsnumber'>
    	<cfset mnum=val>
    </cfif>
    <cfif var neq '' and val neq '' and var eq 'wsid'>
    	<cfset mwsid=val>
    </cfif>
</cfloop>
<cfoutput>
 <cfset NewURL="/mls/property.cfm?mlsid=#settings.mls.MLSID#&#mwsid#=1&mlsnumber=#mnum#">           
            <cfheader statuscode="301" statustext="Moved permanently">
            <cfheader name="Location" value="#NewURL#">
           <!--- Redirect #OldURL# to #NewURL# --->
            </cfoutput>