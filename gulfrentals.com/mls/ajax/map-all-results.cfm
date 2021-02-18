<cfif isdefined('session.mls.qResults.query') and isQuery(session.mls.qResults.query)>
	<cfquery dbtype="query" name="tmpMapData" maxrows="500">
		SELECT 	mlsid, wsid, mlsnumber, street_number, city_or_township as city, list_price, 
              	street_name, mapphoto as photo_link, bedrooms, baths_full, baths_half, 
              	map_latitude as latitude, map_longitude as longitude, status_name, proplink
        FROM 	session.mls.qResults.query
        where map_latitude > 30 and map_latitude < 40
        and map_longitude < -75 and map_longitude > -88
    </cfquery>

    <cfoutput>#SerializeJSON(tmpMapData)#</cfoutput>

</cfif>