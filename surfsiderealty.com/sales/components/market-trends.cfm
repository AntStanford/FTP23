
<cfquery name="GetMarketTrend" datasource="#DSNMLS#">
SELECT date,property_count,average_price,median_price,average_bedrooms,average_bathrooms,average_square_footage,average_price_per_sq_ft,majority_wsid,average_price_per_bedroom
FROM stats_by_mls
where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">  
and date >   <cfqueryparam cfsqltype="cf_sql_date" value="#dateadd("d", -10, now())#">
order by date DESC
 limit 1
</cfquery>

<!--- Loop through the Price Per Bedroom Data --->
<cfif GetMarketTrend.majority_wsid is "1" or GetMarketTrend.majority_wsid is "5">
      <cfset strData = CharsetEncode(GetMarketTrend.average_price_per_bedroom,"ISO-8859-1")>
      <cfset strDataLength = "#listlen(strData,':')#">
      <cfset cnt = 0>
      <cfloop index="i" list="#strData#" delimiters=":">
        <cfset cnt = #cnt# + 1>
        <cfif cnt gt 1>
          <cfset NumberOfRooms = "#listgetat(i,'2',',')#">
          <cfset NumberOfRooms = #replacenocase(NumberOfRooms,'"','')#>
          <cfset NumberOfRooms = #replacenocase(NumberOfRooms,'"','')#>
          <cfset PricePerRoom = "#listgetat(i,'1',',')#">
          <cfset PricePerRoom = #replacenocase(PricePerRoom,'"','')#>
          <cfset PricePerRoom = #replacenocase(PricePerRoom,'"','')#>
          <!--- Set room --->
          <cfset "PPR#NumberOfRooms#" = "#PricePerRoom#">

          <cfif strDataLength - 1 eq cnt>
            <cfbreak>
          </cfif>   
        </cfif>
      </cfloop>
    </ul>
  </li>
</cfif>

<cfoutput>
<div class="market-trends">
<h4>Market Snapshot</h4> 
Total Properties Listed: #GetMarketTrend.property_count#<br>
Average List Price: #dollarformat(GetMarketTrend.average_price)#<br>
Median list Price: #dollarformat(GetMarketTrend.median_price)#<br><br>

<h4>Typical Property</h4>
<strong>
  <cfswitch expression="#GetMarketTrend.majority_wsid#">
  <cfcase value="1">Residential</cfcase>
  <cfcase value="2">Land</cfcase>
  <cfcase value="3">Commercial</cfcase>
  <cfcase value="4">Rentals</cfcase>
  <cfcase value="5">Condo / Villa</cfcase>
  <cfcase value="6">Multi-Family</cfcase>
  <cfcase value="7">Boat Slips</cfcase>
  <cfdefaultcase><br>Other</cfdefaultcase>
  </cfswitch>
  </strong>
<br>#GetMarketTrend.average_bedrooms# Bedrooms<br>
#GetMarketTrend.average_bathrooms# Baths<br>
$#GetMarketTrend.average_price_per_sq_ft# / Sq. Ft.<br><br>

<cfif GetMarketTrend.majority_wsid is "1" or GetMarketTrend.majority_wsid is "5">
<h4>Avg. Price/Bedroom</h4>
   <cfif isdefined('PPR1')>1 Bedroom <I>#dollarformat(PPR1)#</I><br></cfif>
   <cfif isdefined('PPR2')>2 Bedrooms <I>#dollarformat(PPR2)#</I><br></cfif>
   <cfif isdefined('PPR3')>3 Bedrooms <I>#dollarformat(PPR3)#</I><br></cfif>
   <cfif isdefined('PPR4')>4 Bedrooms <I>#dollarformat(PPR4)#</I><br></cfif>
   <cfif isdefined('PPR5')>5 Bedrooms <I>#dollarformat(PPR5)#</I><br></cfif>
   <cfif isdefined('PPR6')>6 Bedrooms <I>#dollarformat(PPR6)#</I><br></cfif>
</cfif>
</div>
</cfoutput>