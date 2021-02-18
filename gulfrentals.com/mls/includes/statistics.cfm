<cffunction name="getMLSStats" access="public" mixin="controller">
	<cfargument name="mlsid" type="numeric" default="2">
	<cfargument name="area" type="string">
	<cfif StructKeyExists(arguments, "area") AND IsNumeric(arguments.area)>
    <cfquery datasource="mlsv20master" name="getStats">
      SELECT * 
      FROM stats_by_area
      WHERE mlsid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#ARGUMENTS['mlsid']#">
      AND area = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#ARGUMENTS['area']#">
      ORDER BY date DESC
      LIMIT 1
    </cfquery>
  <cfelse>
    <cfquery dataSource="mlsv20master" name="getStats">
      SELECT *
      FROM stats_by_mls
      WHERE mlsid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#ARGUMENTS['mlsid']#">
      ORDER BY date DESC
      LIMIT 1
    </cfquery>
  </cfif>  
  <cfreturn getStats>
</cffunction>

<!--- MLS ID, Area ID --->
<cfset stats = getMLSStats(1, 155)>

<cfoutput>
  <div class="market-trends">
    <h5>Local Market Trends</h5>
    <ul>
      <li><h6>Market Snapshot</h6></li>
      <li><span>Total Properties Listed: #NumberFormat(stats['property_count'][1])#</span></li>
      <li><span>Average List Price: #DollarFormat(stats['average_price'][1])#</span></li>
      <li><span>Median list Price: #DollarFormat(stats['median_price'][1])#</span></li>          
    </ul>
    <ul>
      <li><h6>Typical Property</h6></li>
      <li>
        <strong>
          <cfswitch expression="#stats['majority_wsid'][1]#">
            <cfcase value="1">Residential</cfcase>
            <cfcase value="2">Land</cfcase>
            <cfcase value="3">Commercial</cfcase>
            <cfcase	value="4">Rentals</cfcase>
            <cfcase value="5">Condo / Villa</cfcase>
            <cfcase value="6">Multi-Family</cfcase>
            <cfcase value="7">Boat Slips</cfcase>
            <cfdefaultcase>Other</cfdefaultcase>
          </cfswitch>
        </strong>
      </li>
      <li><span>#stats['average_bedrooms'][1]# Bedrooms</span></li>
      <li><span>#stats['average_bathrooms'][1]# Baths</span></li>
      <li><span>#DollarFormat(stats['average_price_per_sq_ft'][1])# / Sq. Ft.</span></li>
    </ul>
    <ul>
      <li><h6>Avg. Price/Bedroom</h6></li>
      <cfif Len(stats['average_price_per_bedroom'][1])>		
        <cfset bedroom_prices = DeSerializeJSON(ToString(ToBinary(stats['average_price_per_bedroom'][1])))>
        <cfset sort_order = StructSort(bedroom_prices, "numeric")>
        <cfset length = 6>
        <cfif StructCount(bedroom_prices) LT length>
          <cfset length = StructCount(bedroom_prices)>
        </cfif>
        <cfif StructCount(bedroom_prices) gt 0>
          <cfloop from="1" to="#length#" index="i">
            <cfif StructKeyExists(bedroom_prices, i)>
              <li><span>#i# Bedroom(s): #DollarFormat(bedroom_prices[i])#</span></li>
            </cfif>
          </cfloop>
        </cfif>
      </cfif>
    </ul>
  </div>
</cfoutput>