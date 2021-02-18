<div class="box market-trends panel-body">
  <cfoutput query="application.settings.mls.getMarketTrend">
  <h3>Market Trends for #settings.mls.getmlscoinfo.displayname#</h3>
  <ul id="trend-list">
    <li><b>Last Updated:</b> <i>#dateformat(date,'m/d/yy')#</i></li>
    <li><h4>Market Snapshot</h4></i>
      <ul>
        <li><b>Total Properties listed:</b> <i>#application.settings.mls.GetMarketTrend.property_count#</i></li>
        <li><b>Average list Price:</b> <i>#dollarformat(application.settings.mls.GetMarketTrend.average_price)#</i></li>
        <li><b>Median list Price:</b> <i>#dollarformat(application.settings.mls.GetMarketTrend.median_price)#</i></li>
      </ul>
    </li>
  </ul>
  </cfoutput>
  <cfif cgi.remote_addr eq '69.249.111.59_randy'><Cfdump var="#application.settings.mls.getMarketTrend#"></cfif>
</div><!---END box market-trends--->