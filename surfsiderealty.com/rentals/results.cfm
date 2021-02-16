<cfinclude template="results-search-query.cfm">
<cfinclude template="/#settings.booking.dir#/components/header.cfm">
<style>.results-list-sort ul li.hidden-sort {display: none;}</style>

  <div id="refineWrap" class="refine-wrap refine-mobile">
    <div id="refineAnchor"><!-- REFINE ANCHOR FOR SCROLL --></div>
    <cfinclude template="_refine-search.cfm">
    <div id="refineControls" class="refine-panel-controls refine-mobile-controls">
      <cfif NOT StructKeyExists(request,'resortContent')>
      <a href="javascript:;" id="viewListAndMap" class="mobile-hidden" <!--- rel="tooltip" data-placement="bottom" title="Toggle Grid/Split View" --->>
        <i class="fa fa-th-large site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Grid View</span>
      </a>
      <a href="javascript:;" id="viewMapOnly" <!--- rel="tooltip" data-placement="bottom" title="Map Full View" --->>
        <i class="fa fa-map-marker site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Map View</span>
      </a>
      </cfif>
      <a href="javascript:;" id="viewFiltersMobile" <!--- rel="tooltip" data-placement="bottom" title="Refine Your Search" --->>
        <i class="fa fa-toggle-off site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Refine Your Search</span>
      </a>
    </div>
  </div>
  <div class="results-wrap <cfif StructKeyExists(request,'resortContent')>resorts-wrap</cfif>">
    <div class="results-list-wrap <cfif StructKeyExists(request,'resortContent')>resorts-list-wrap</cfif>">
      <!--- BASIC PAGE TITLE AND CONTENT --->
      <cfif isdefined('page') and len(page.h1)>
      	<h1><cfoutput>#page.h1#</cfoutput></h1>
      <cfelseif isdefined('page') and len(page.name)>
      	<h1><cfoutput>#page.name#</cfoutput></h1>
      </cfif>
      <cfif isdefined('page.body') and len(page.body)>
        <!--- We are doing this so we can still show dummy images from ContentBuilder.js --->
        <cfset tempBody = replace(page.body,'assets','/admin/pages/contentbuilder/assets','all')>
        <div class="content-builder-wrap">
          <cfoutput>#tempBody#</cfoutput>
        </div>
      </cfif>
      <!--- RESORT PAGE CONTENT --->
    	<cfif StructKeyExists(request,'resortContent')>
				<cfoutput>#request.resortContent#</cfoutput>
      </cfif>

    	<cfif isdefined('displayThis')>
	      <div class="results-list-alert-popular alert alert-info" id="results-list-alert-popular-post">
	        <i class="fa fa-fire" aria-hidden="true"></i>
	        <span>Your dates are popular!</span>
	        <b><span class="percent-booked-ajax"><cfoutput>#NumberFormat(ceiling(displayThis), "__")#</cfoutput></span>% of our inventory is booked.</b>
	        <span>Book Now!</span>
	      </div>
      </cfif>

      <div class="results-list-alert-popular alert alert-info" style="display:none" id="results-list-alert-popular-ajax">
        <i class="fa fa-fire" aria-hidden="true"></i>
        <span>Your dates are popular!</span>
        <b><span class="percent-booked-ajax"><!--- data loaded via ajax in results.js ---></span>% of our inventory is booked.</b>
        <span>Book Now!</span>
      </div>

      <div id="scrollReturn"></div>

      <div class="results-list-legend">
        <ul class="results-list-key">
          <cfif isdefined('session.booking.unitCodeList')>
          	<li><i class="fa fa-map-marker" aria-hidden="true"></i> <span class="props-return"><cfoutput>#cookie.numResults#</cfoutput></span> properties returned</li>
          </cfif>
        </ul>
        <ul class="results-list-sort" id="sortForm">
          <li data-resultsList="placeholder">
            <span>
              <em id="resultsListSortTitle">
                <b>Sort by:</b>
                <cfif isdefined('session.booking.strSortBy') and len(session.booking.strSortBy)>
                  <cfif session.booking.strSortBy eq 'rand()'>
                    <i>Random</i>
                  <cfelseif session.booking.strSortBy eq 'name'>
                    <i>Name (ASC)</i>
                  <cfelseif session.booking.strSortBy eq 'bedrooms asc'>
                    <i>Beds (ASC)</i>
                  <cfelseif session.booking.strSortBy eq 'bedrooms desc'>
                    <i>Beds (DESC)</i>
                  <cfelseif session.booking.strSortBy eq 'sleeps asc'>
                    <i>Sleeps (ASC)</i>
                  <cfelseif session.booking.strSortBy eq 'sleeps desc'>
                    <i>Sleeps (DESC)</i>
                  <cfelseif session.booking.strSortBy eq 'price asc'>
                    <i>Price (ASC)</i>
                  <cfelseif session.booking.strSortBy eq 'price desc'>
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
            	<li data-resultsList="rand()"><span>Random</span></li>
    					<li data-resultsList="name"><span>Name (ASC)</span></li>
    					<li data-resultsList="bedrooms asc"><span>Beds (ASC)</span></li>
    					<li data-resultsList="bedrooms desc"><span>Beds (DESC)</span></li>
    					<li data-resultsList="sleeps asc"><span>Sleeps (ASC)</span></li>
    					<li data-resultsList="sleeps desc"><span>Sleeps (DESC)</span></li>
	  					<cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate>
	  						<li data-resultsList="price asc" class="priceasc"><span>Price (ASC)</span></li>
	  						<li data-resultsList="price desc"><span>Price (DESC)</span></li>
              <cfelse>
	  						<li data-resultsList="price asc" class="priceasc hidden-sort"><span>Price (ASC)</span></li>
	  						<li data-resultsList="price desc" class="hidden-sort"><span>Price (DESC)</span></li>
	  					</cfif>
            </ul>
          </li>
        </ul>
      </div>
      <div id="list-all-results" <cfif StructKeyExists(request,'resortContent')>class="resorts-list-all-results"</cfif>>
        <cfinclude template="results-loop.cfm">
      </div>

		<cfif isdefined('cookie.numResults')>
      <!--- Loading Animation for Infinite Scroll --->
      <div id="bottom-result" data-count="<cfoutput>#cookie.numResults#</cfoutput>">
        <div class="cssload-container">
          <div class="cssload-tube-tunnel"></div>
        </div>
      </div>
      </cfif>

    </div>
    <cfinclude template="results-map.cfm">
  </div><!--- END results-wrap --->

  <cf_htmlfoot>
    <div class="results-loader-overlay">
      <div class="cssload-container">
        <div class="cssload-tube-tunnel"></div>
      </div>
    </div>

		<cfif StructKeyExists(request,'resortContent')>
			<script>
        $(document).ready(function(){
          //Resorts Slider
          if ($('.owl-carousel.resorts-carousel').length) {
            $('.owl-carousel.resorts-carousel').owlCarousel({
              lazyLoad: true, loop: true, nav: true, navText: ["<i class='fa fa-chevron-left'></i>","<i class='fa fa-chevron-right'></i>"], dots: false, margin: 15,
              responsive: { 0: { items: 1 }, 481: { items: 2 }, 993: { items: 3 } }
            });

            $('.owl-resorts-gallery-wrap .cssload-container').delay(1500).fadeOut(200);
          }
        });
      </script>
    </cfif>
  </cf_htmlfoot>

<cfinclude template="/#settings.booking.dir#/components/results-modals.cfm">

<cfinclude template="/#settings.booking.dir#/components/footer.cfm">