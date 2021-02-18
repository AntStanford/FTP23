<cfoutput>
  <cfif url.page is 1>
    <!--- Start |  --->
  <cfelse>
    <li><a href="##" class="btn btn-control" onclick="paginate(1)">Start</a></li>
  </cfif>
  <cfif url.page EQ 1>
    <!---    Prev  --->
  <cfelse>
    <li><a href="##" onclick="paginate(#url.page-1#)" class="btn btn-control">Prev</a></li>
  </cfif>
  <cfif url.page + int(show_pages / 2) - 1 GTE total_pages>
    <cfset start_page = total_pages - show_pages + 1>
  <cfelseif url.page + 1 GT show_pages>
    <cfset start_page = url.page - int(show_pages / 2)>
  </cfif>
  <cfset end_page = start_page + show_pages - 1>
  <cfif start_page neq end_page>
    <cfloop from="#start_page#" to="#end_page#" index="i">
      <cfif url.page EQ i>     
        <li><a href="##" class="btn current-page">Page #i#</a></li>
      <cfelse>      
        <li><a href="##" onclick="paginate(#i#)" class="btn" data-pagenum='#i#'>Page #i#</a></li>
      </cfif>
    </cfloop>
    <cfif url.page * records_per_page LT countinfo.thecount>
      <li><a href="##" onclick="paginate(#url.page+1#)" class="btn btn-control" data-pagenum='#url.page+1#'>Next</a></li>
    <cfelse> 
      <!---  Next --->
    </cfif>
    <cfif url.page is Total_Pages>
      <!--- Last --->
    <cfelseif total_pages gt 0> 
      <li><a href="##" onclick="paginate(#total_pages#)" class="btn btn-control" data-pagenum='#total_pages#'>Last</a></li>
    </cfif>
  </cfif>
  <!--- <cfif isdefined('cookie.LoggedInAdminID')><div align="center"><a href="/admin/pages/form.cfm?Action=Add&CreateSearchPage=" class="button">Create a Custom Page</a></div></cfif> --->
</cfoutput>

