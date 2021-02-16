<cfoutput>
  <cfif mls.FeedHasLatLongs is "Yes">
    <cfif isdefined('showmap')>
      <li><a hreflang="en" class="button" href="/sales/search-results.cfm?start=#start#&searchpage=#searchpage#">List View</a></li>
    <cfelse>
      <li><a hreflang="en" class="button" href="/sales/search-results.cfm?start=#start#&searchpage=#searchpage#&showmap=">Map View</a></li>
    </cfif>
  </cfif>
</cfoutput>

<cfoutput>
  <li><a hreflang="en" href="/sales/lightboxes/save-search.cfm?action=savesearch&propertycount=#COUNTINFO.thecount#&width=765&height=500" class="fb_dynamic button">Save Search</a></li>
</cfoutput>

<li class="results">
  <cfoutput>
    Results 
    <cfif isdefined('url.searchpage') is "No" or url.searchpage is "1">
      1
    <cfelse>
      <cfif searchpage is "2">
        11
      <cfelse>
        #(start_record + 1)#
      </cfif>
    </cfif> 
    - 
    <cfif isdefined('url.searchpage') is "No" or url.searchpage is "1">
      <cfif #COUNTINFO.thecount# lt 10>
        #COUNTINFO.thecount# 
      <cfelse>
        10
      </cfif>
      <cfelse>
        <!--- <cfif searchpage gt 10>
          #evaluate((searchpage + 2) * 10)#
        <cfelse> --->
      <cfif searchpage is "2" and #COUNTINFO.thecount# gt 20>
        20
      <cfelseif searchpage is "2" and #COUNTINFO.thecount# lt 20>
        #COUNTINFO.thecount# 
      <cfelse>
        <cfif (start_record + 10) gt COUNTINFO.thecount>#COUNTINFO.thecount#<cfelse>#(start_record + 10)#</cfif>
      </cfif>
      <!--- </cfif> --->
    </cfif> 
    of #COUNTINFO.thecount#
  </cfoutput>
</li>