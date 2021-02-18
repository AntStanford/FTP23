<cfset page = getPageText('property-map')>
<cfparam name="form.mapArea" default="all">
<cfparam name="form.propMapAreas" default="all">
<cfset form.camefromsearchform = ''>

<cfif listfind(form.mapArea, 'all')>
	<cfset form.fieldnames = 'camefromsearchform,propMapAreas' />
	<cfset form.propMapAreas = 'all'>
<cfelse>
	<cfset form.fieldnames = 'camefromsearchform,propMapAreas' />
	<cfset form.propMapAreas = "">
	<cfloop list="#form.mapArea#" index="thisArea">
		<cfquery name="getMapAid" dbtype="query">
			SELECT aid FROM settings.booking.mapPageData WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#thisArea#">
		</cfquery>
		<cfset form.propMapAreas = listappend(form.propMapAreas,getMapAid.aid)>
	</cfloop>
</cfif>

<cfinclude template="/#settings.booking.dir#/map-results.cfm">