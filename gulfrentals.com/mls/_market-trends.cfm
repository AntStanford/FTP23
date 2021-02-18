<cfquery name="cusqMarketTrends" datasource="#settings.mls.propertydsn#">
  SELECT *
  FROM stats_by_area
  where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.MLSID#">
  and `date` > <cfqueryparam value="#dateadd('d','-1',now())#" cfsqltype="CF_SQL_DATE">
  and area='#property.area#'
  order by date desc
  limit 1;
</cfquery>

<div class="market-trends">
  <cfoutput query="cusqMarketTrends">
    <h3>Market Trends for #getareas.city#</h3>
    <ul id="trend-list">
      <li><strong>Last Updated: </strong><em>#dateformat(date,'m/d/yy')#</em></li>
      <li>
        <h4>Market Snapshot</h4>
        <ul>
          <li><b>Total Properties listed:</b> <I>#property_count#</I></li>
          <li><b>Average list Price:</b> <I>#dollarformat(average_price)#</I></li>
          <li><b>Median list Price:</b> <I>#dollarformat(median_price)#</I></li>
        </ul>
      </li>
    </ul>
  </cfoutput>

<cfif cgi.remote_addr eq '69.249.111.59_randy'><cfdump var="#application.settings.mls.getMarketTrend#"></cfif>
</div><!-- END  market-trends -->