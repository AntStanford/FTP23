<cfset minmaxamenities = application.bookingObject.getMinMaxAmenities()>
<cfset settings.booking.minBed = minmaxamenities.minBed>
<cfset settings.booking.maxBed = minmaxamenities.maxBed>
<cfset settings.booking.minBath = minmaxamenities.minBath>
<cfset settings.booking.maxBath = minmaxamenities.maxBath>
<cfset settings.booking.minOccupancy = minmaxamenities.minOccupancy>
<cfset settings.booking.maxOccupancy = minmaxamenities.maxOccupancy>

<!--- needed for refine search --->
<cfset settings.booking.typeList = application.bookingObject.getDistinctTypes()>
<cfset settings.booking.areaList = application.bookingObject.getDistinctAreas()>
<cfset settings.booking.properties = application.bookingObject.getAllProperties()>
<cfset settings.booking.viewList = application.bookingObject.getDistinctViews()>
<cfset settings.booking.locationList = application.bookingObject.getDistinctLocations()>
<cfset settings.booking.NeighborhoodList = application.bookingObject.getDistinctNeighborhood()>

<!--- We are doing this so we can sort the list by propertyID on the refine search --->
<cfquery name="settings.booking.propertiesByID" dbtype="query">
    SELECT
    seoPropertyName,propertyid,name
    FROM settings.booking.properties ORDER BY name
</cfquery>

<cfquery name="settings.booking.getAmenities" dataSource="#settings.dsn#">
    select * from cms_amenities order by title
</cfquery>

<!--- build query for map page data --->
<cfset settings.booking.mapPageData = queryNew('id,name,aid,cnt','integer,varchar,varchar,integer')>
<cfset variables.mapSearchList = "Boat-Friendly,Large Groups,Pet-Friendly,Pool Homes,Summer Daily">
<cfset variables.mapSearchAidList = "a297,a343,a299,a303,a304">

<cfloop from="1" to="#listlen(variables.mapSearchList)#" index="i">
	<!--- get # of props with the aid --->
	<cfquery name="getPropCount" dataSource="#settings.dsn#">
		SELECT 	COUNT(propertyid) AS cnt
		FROM 		bf_property_amenities
		WHERE 	amenityValue = -1
		AND 		aid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listGetAt(variables.mapSearchAidList, i)#">
	</cfquery>

	<cfset queryAddRow(settings.booking.mapPageData)>
	<cfset querySetCell(settings.booking.mapPageData, 'id', i)>
	<cfset querySetCell(settings.booking.mapPageData, 'name', listGetAt(variables.mapSearchList, i))>
	<cfset querySetCell(settings.booking.mapPageData, 'aid', listGetAt(variables.mapSearchAidList, i))>
	<cfset querySetCell(settings.booking.mapPageData, 'cnt', getPropCount.cnt)>
</cfloop>
