<div class="results-list-legend">
  <cfif !isDefined('page')>
    <h1>Real Estate</h1>
  </cfif>
  <ul class="results-list-key">
    <cfif isdefined('cookie.numResults') and cookie.numResults gt 0>
    	<li><i class="fa fa-map-marker" aria-hidden="true"></i> <span class="props-return"><cfoutput>#cookie.numResults#</cfoutput></span> listings returned</li>
    </cfif>
  </ul>
  <ul class="results-list-sort" id="sortForm">
    <li data-resultsList="placeholder">
      <span>
        <em id="resultsListSortTitle">
          <b>Sort by:</b>
          <cfif isdefined('session.mlssearch.sortBy') and len(session.mlssearch.sortBy)>
<!---
            <cfif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "RAND()">
              <i>Random</i>
            <cfelseif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "bedrooms DESC">
              <i>Beds (DESC)</i>
            <cfelseif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "baths_full DESC">
              <i>Baths (DESC)</i>
            <cfelseif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "created_at DESC">
              <i>Listing Date (Old to New)</i>
            <cfelseif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "created_at ASC">
--->
            <cfif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "created_at ASC">
              <i>Listing Date (New to Old)</i>
            <cfelseif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "created_at DESC">
                <i>Listing Date (Old to New)</i>
            <cfelseif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "list_price ASC">
              <i>Price (ASC)</i>
            <cfelseif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "list_price DESC">
              <i>Price (DESC)</i>
            <cfelse>
            	<i>Random</i>
            </cfif>
          <cfelse>
            <i></i>
          </cfif>
        </em>
        <i class="fa fa-chevron-down" aria-hidden="true"></i>
      </span>
      <ul class="hidden results-sort-by">
        <cfif isdefined('session.mlssearch.sortBy') and len(session.mlssearch.sortBy)>
          <li data-resultsList="RAND()" class="<cfif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "RAND()">active</cfif>"><span>Random</span></li>
          <!---
          <li data-resultsList="bedrooms DESC"><span>Beds (DESC)</span></li>
          <li data-resultsList="baths_full DESC"><span>Baths (DESC)</span></li>--->
          <li data-resultsList="created_at DESC"  class="<cfif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "created_at DESC">active</cfif>"><span>Listing Date (Old to New)</span></li>
          <li data-resultsList="created_at ASC" class="<cfif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "created_at ASC">active</cfif>"><span>Listing Date (New to Old)</span></li>
          <li data-resultsList="list_price ASC" class="<cfif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "list_price ASC">active</cfif>"><span>Price (ASC)</span></li>
          <li data-resultsList="list_price DESC" class="<cfif isdefined('session.mlssearch.sortby') and session.mlssearch.sortby is "list_price DESC">active</cfif>"><span>Price (DESC)</span></li>
        </cfif>
      </ul>
    </li>
  </ul>
</div>

<cfif isdefined('session.mls.qResults.query') and session.mls.qResults.query.recordcount gt 0>
  <div class="results-pagination">
    <ul class="pagination">
      <cfinclude template="/#settings.mls.dir#/search-results-pagination_.cfm">
    </ul>
  </div>
</cfif>

<div id="list-all-results">
  <cfinclude template="results-loop.cfm">
</div>

<cfif session.mls.qResults.query.recordcount gt 0>
  <div class="results-pagination">
    <ul class="pagination">
      <cfinclude template="/#settings.mls.dir#/search-results-pagination_.cfm">
    </ul>
  </div>
</cfif>