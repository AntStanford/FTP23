<cfinclude template="results-search-query.cfm">
<cfset request.location_id = 3><!--- real-estate is location 3 --->
<cfinclude template="/#settings.mls.dir#/components/header.cfm">
<style>.results-list-sort ul li.hidden-sort {display: none;}</style>

  <div class="refine-wrap refine-mobile">
    <cfinclude template="_refine-search.cfm">
    <div class="refine-panel-controls refine-mobile-controls">
      <!---<a href="javascript:;" class="mobile-hidden" rel="tooltip" data-placement="bottom" title="Save Search Criteria" data-toggle="modal" data-target="#saveSearchModal">
        <i class="fa fa-floppy-o site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Save Search</span>
      </a>--->
      <a href="javascript:;" id="viewListAndMap" class="mobile-hidden" rel="tooltip" data-placement="bottom" title="Toggle Grid/Split View">
        <i class="fa fa-th-large site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Grid View</span>
      </a>
      <a href="javascript:;" id="viewMapOnly" rel="tooltip" data-placement="bottom" title="Map Full View">
        <i class="fa fa-map-marker site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Map View</span>
      </a>
      <a href="javascript:;" id="viewFiltersMobile"  rel="tooltip" data-placement="bottom" title="Refine Your Search">
        <i class="fa fa-toggle-off site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Refine Your Search</span>
      </a>
    </div>
  </div>

<!---
    <cfinclude template="_refine-search.cfm">

    <div class="filters-group">
      <a href="javascript:;" id="viewFiltersMobile">
        <button class="button text-white site-color-2-bg site-color-2-lighten-bg-hover">
          <i class="fa fa-toggle-off" aria-hidden="true"></i>
          <span>Refine <strong>Your Search</strong></span>
        </button>
      </a>
    </div>

    <div class="refine-panel-controls refine-mobile-controls">
      <a href="javascript:;" id="viewMapOnly" rel="tooltip" data-placement="bottom" title="Map Full View">
        <button class="button text-white site-color-2-bg site-color-2-lighten-bg-hover">
          <i class="fa fa-map-marker text-white" aria-hidden="true"></i>
          <span class="text-white">Map <strong>View</strong></span>
        </button>
      </a>
      <a href="javascript:;" id="viewListAndMap" class="mobile-hidden" rel="tooltip" data-placement="bottom" title="Toggle Grid/Split View">
        <button class="button text-white site-color-2-bg site-color-2-lighten-bg-hover">
          <i class="fa fa-th-large text-white" aria-hidden="true"></i>
          <span class="text-white">Grid <strong>View</strong></span>
        </button>
      </a>

      <cfif isDefined("cookie.loggedIn") and cookie.loggedIn gt 0>
        <cfset clientid = cookie.loggedIn>
      <cfelse>
        <cfset clientid = 0>
      </cfif>

      <cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
      <cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER"><!--- just to make sure the cookie favorite list is up to date --->
      <a href="javascript:;" id="favoritesToggle" class="header-actions-action">
        <button id="favorites" class="btn-danger text-white">
          <i class="fa fa-heart"></i>
          Favorites
        </button>
      </a>
      <cfinclude template="/#application.settings.mls.dir#/_favoriteslist.cfm">
      <cfif structKeyExists(COOKIE,"LoggedIn") and cookie.loggedin gt 0>
        <a href="/mls/save-search.cfm?action=savesearch&propertycount=<cfoutput>#session.mls.qResults.total_properties#</cfoutput>&width=765&height=500" data-toggle="modal" data-target="#saveSearchModal" id="savesearchbtn">
      <cfelse>
        <a href="/mls/components/mls-account.cfm?action2=savesearch&propertycount=<cfoutput>#session.mls.qResults.total_properties#</cfoutput>&width=765&height=500">
      </cfif>
        <button id="saveSearchResults" class="site-color-1-bg site-color-1-lighten-bg-hover text-white">
          <i class="fa fa-save"></i>
          Save <span>Search</span>
        </button>
      </a>
    </div>
  </div>
--->

  <div class="results-wrap">
    <div class="results-list-wrap <cfif isDefined('session.mlssearch.communityId') and isNumeric(session.mlssearch.communityId) and session.mlssearch.communityId gt 0>results-list-full-width community-list-full-width</cfif>">

      <!--- This is in the wrong place - it needs to go up higher where it can be full width... --->
      <cfif isDefined('session.mlssearch.communityId') and isNumeric(session.mlssearch.communityId) and session.mlssearch.communityId gt 0>
        <cfinclude template="/mls/partials/community-details.cfm" />

      <cfelseif isDefined('session.mlssearch.customSearchId') and session.mlssearch.customSearchId gt 0>

        <cfquery name="customSearchPage" datasource="#application.settings.dsn#">
          SELECT h1, `name`, body FROM cms_pages WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.customSearchId#">
        </cfquery>

        <cfif customSearchPage.recordcount is 1 and len(customSearchPage.h1)>
          <h1><cfoutput>#customSearchPage.h1#</cfoutput></h1>
        <cfelseif customSearchPage.recordcount is 1 and len(customSearchPage.name)>
          <h1><cfoutput>#customSearchPage.name#</cfoutput></h1>
        </cfif>
        <cfif customSearchPage.recordcount is 1 and len(customSearchPage.body)>
          <p><cfoutput>#customSearchPage.body#</cfoutput></p>
        </cfif>

      <cfelse>

        <cfif isdefined('page.h1') and len(page.h1)>
          <h1><cfoutput>#page.h1#</cfoutput></h1>
        <cfelseif isdefined('page.name') and len(page.name)>
          <h1><cfoutput>#page.name#</cfoutput></h1>
        </cfif>
<!---
        <cfif isdefined('page.body') and len(page.body)>
        	<p><cfoutput>#page.body#</cfoutput></p>
        </cfif>
--->
        <cfif isdefined('page.body') and len(page.body)>
          <!--- We are doing this so we can still show dummy images from ContentBuilder.js --->
          <cfset tempBody = replace(page.body,'assets','/admin/pages/contentbuilder/assets','all')>
          <div class="content-builder-wrap">
            <cfoutput>#tempBody#</cfoutput>
          </div>
        </cfif>

      </cfif>

      <div id="searchResults">
        <cfinclude template="/mls/results-list.cfm">
      </div>

    </div>
    <cfinclude template="results-map.cfm">
  </div><!---END results-wrap--->

  <cf_htmlfoot>
    <div class="results-loader-overlay">
      <div class="cssload-container">
        <div class="cssload-tube-tunnel"></div>
      </div>
    </div>
  </cf_htmlfoot>

  <!--- moved a block of code to footer-modals.cfm to better control execution order (footer-modals.cfm is the last thing loaded) --->

<cfinclude template="/#settings.mls.dir#/components/results-modals.cfm">

<cfinclude template="/#settings.mls.dir#/components/footer.cfm">