<cfoutput>
  <cfif url.searchpage is 1>
    <!--- Start |  --->
  <cfelse>
    <li><a hreflang="en" href="#nextpage#?start=#start#" class="button light">Start</A></li>
  </cfif>
  <cfif url.searchpage EQ 1>
    <!---    Prev  --->
  <cfelse>
    <li><a hreflang="en" href="#nextpage#?start=#start#&searchpage=#url.searchpage-1#<cfif isdefined('showmap')>&showmap=</cfif>" class="button light">Prev</a></li>
  </cfif>
  <cfif url.searchpage + int(show_pages / 2) - 1 GTE total_pages>
    <cfset start_page = total_pages - show_pages + 1>
  <cfelseif url.searchpage + 1 GT show_pages>
    <cfset start_page = url.searchpage - int(show_pages / 2)>
  </cfif>
  <cfset end_page = start_page + show_pages - 1>
  <cfloop from="#start_page#" to="#end_page#" index="i">
    <cfif url.searchpage EQ i>
      <li><a hreflang="en" href="##" class="button light">#i#</a></li>
    <cfelse>
      <li><a hreflang="en" href="#nextpage#?start=#start#&searchpage=#i#<cfif isdefined('showmap')>&showmap=</cfif>" class="button">#i#</a></li>
    </cfif>
  </cfloop> 
  <cfif url.searchpage * records_per_page LT countinfo.thecount>
    <li><a hreflang="en" href="#nextpage#?start=#start#&searchpage=#url.searchpage+1#<cfif isdefined('showmap')>&showmap=</cfif>" class="button light">Next</a></li>
  <cfelse>
    <!---  Next --->
  </cfif>
  <cfif url.searchpage is Total_Pages>
    <!--- Last --->
  <cfelse>
    <li><a hreflang="en" href="#nextpage#?start=#start#&searchpage=#total_pages#<cfif isdefined('showmap')>&showmap=</cfif>" class="button light">Last</a></li>
  </cfif>
  <cfif isdefined('cookie.LoggedInAdminID')><li><a hreflang="en" href="/admin/pages/form.cfm?Action=Add&CreateSearchPage=" class="button">Create a Custom Page</a></li></cfif>
</cfoutput>

