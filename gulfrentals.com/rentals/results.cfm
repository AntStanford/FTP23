<cfinclude template="results-search-query.cfm">
<cfinclude template="/#settings.booking.dir#/components/header.cfm">
<style>.results-list-sort ul li.hidden-sort {display: none;}</style>

  <div class="refine-wrap refine-mobile">
    <cfinclude template="_refine-search.cfm">
    <div class="refine-panel-controls refine-mobile-controls">
      <cfif NOT StructKeyExists(request,'resortContent')>
      <a href="javascript:;" id="viewListAndMap" class="mobile-hidden" rel="tooltip" data-placement="bottom" title="Toggle Grid/Split View">
        <i class="fa fa-th-large site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Grid View</span>
      </a>
      <a href="javascript:;" id="viewMapOnly" rel="tooltip" data-placement="bottom" title="Map Full View">
        <i class="fa fa-map-marker site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Map View</span>
      </a>
      </cfif>
      <a href="javascript:;" id="viewFiltersMobile"  rel="tooltip" data-placement="bottom" title="Refine Your Search">
        <i class="fa fa-toggle-off site-color-1" aria-hidden="true"></i>
        <span class="site-color-1">Refine Your Search</span>
      </a>
    </div>
  </div>
  <div class="results-wrap <cfif StructKeyExists(request,'resortContent')>resorts-wrap</cfif>">
    <div class="results-list-wrap <cfif StructKeyExists(request,'resortContent')>resorts-list-wrap</cfif>">
    	<cfif StructKeyExists(request,'resortContent')>
				<cfoutput>#request.resortContent#</cfoutput>
      </cfif>
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
            <cfif isdefined('getSpecial') and getSpecial.recordcount gt 0>
              <cfoutput>
                <h1>#getSpecial.title#</h1>
                #getSpecial.description#
              </cfoutput>
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

      <cfif isdefined('session.booking.strCheckin') and session.booking.strCheckin neq '' and isdefined('session.booking.camefromsearchform') and isdefined('session.booking.flex_dates') and session.booking.flex_dates eq 'on'>

        <!--- The user selected flex dates, is this the default tab, or did they click a flex tab link? --->
        <cfif isDefined('session.booking.flexed') and trim(session.booking.flexed) is not ''>
          <!--- they clicked a flex tab link, set the dates up accordingly --->
          <cfif session.booking.flexed is 'early'>

            <cfset variables.earlyStrCheckin = session.booking.strcheckin>
            <cfset variables.earlyStrCheckout = session.booking.strcheckout>

            <cfset variables.midStrCheckin = DateFormat(DateAdd('d',1,session.booking.strcheckin),'mm/dd/yyyy')>
            <cfset variables.midStrCheckout = DateFormat(DateAdd('d',1,session.booking.strcheckout),'mm/dd/yyyy')>

            <cfset variables.lateStrCheckin = DateFormat(DateAdd('d',2,session.booking.strcheckin),'mm/dd/yyyy')>
            <cfset variables.lateStrCheckout = DateFormat(DateAdd('d',2,session.booking.strcheckout),'mm/dd/yyyy')>

          <cfelse><!--- session.booking.flexed must be 'late' --->

            <cfset variables.earlyStrCheckin = DateFormat(DateAdd('d',-2,session.booking.strcheckin),'mm/dd/yyyy')>
            <cfset variables.earlyStrCheckout = DateFormat(DateAdd('d',-2,session.booking.strcheckout),'mm/dd/yyyy')>

            <cfset variables.midStrCheckin = DateFormat(DateAdd('d',-1,session.booking.strcheckin),'mm/dd/yyyy')>
            <cfset variables.midStrCheckout = DateFormat(DateAdd('d',-1,session.booking.strcheckout),'mm/dd/yyyy')>

            <cfset variables.lateStrCheckin = session.booking.strcheckin>
            <cfset variables.lateStrCheckout = session.booking.strcheckout>
            <cfset variables.lateCheckinDay = dateFormat(variables.lateStrCheckin,'dddd')>

          </cfif>

        <cfelse>
          <!--- they didn't, so show tabs for +/- 1 day --->
          <cfset variables.earlyStrCheckin = DateFormat(DateAdd('d',-1,session.booking.strcheckin),'mm/dd/yyyy')>
          <cfset variables.earlyStrCheckout = DateFormat(DateAdd('d',-1,session.booking.strcheckout),'mm/dd/yyyy')>
          <cfset variables.earlyCheckinDay = dateFormat(variables.earlyStrCheckin, 'dddd')>

          <cfset variables.midStrCheckin = session.booking.strcheckin>
          <cfset variables.midStrCheckout = session.booking.strcheckout>
          <cfset variables.midStrCheckinDay = dateFormat(variables.midStrCheckin, 'dddd')>

          <cfset variables.lateStrCheckin = DateFormat(DateAdd('d',1,session.booking.strcheckin),'mm/dd/yyyy')>
          <cfset variables.lateStrCheckout = DateFormat(DateAdd('d',1,session.booking.strcheckout),'mm/dd/yyyy')>
          <cfset variables.lateCheckinDay = dateFormat(variables.lateStrCheckin,'dddd')>

        </cfif>

        <div class="results-tab-bar">
          <ul class="nav nav-tabs">

            <cfoutput>
              <li id="earlyTab" <cfif isDefined('session.booking.flexed') and session.booking.flexed is 'early'>class="active"</cfif>>
                <a data-newcheckin="#variables.earlyStrCheckin#" data-newcheckout="#variables.earlyStrCheckout#" data-flextab="early" href="javascript:;" id="earlySelectDay"><small>#dateFormat(variables.earlyStrCheckin, 'dddd')#</small><span class="tab-date tab-date-friday"></span></a>
              </li>

              <li id="midTab" <cfif !isDefined('session.booking.flexed') or (isDefined('session.booking.flexed') and trim(session.booking.flexed) is '')>class="active"</cfif>>
                <a data-newcheckin="#variables.midStrCheckin#" data-newcheckout="#variables.midStrCheckout#" data-flextab="" href="javascript:;" id="midSelectDay"><small>#dateFormat(variables.midStrCheckin, 'dddd')#</small><span class="tab-date tab-date-saturday"></span></a>
              </li>

              <li id="lateTab" <cfif isDefined('session.booking.flexed') and session.booking.flexed is 'late'>class="active"</cfif>>
                <a data-newcheckin="#variables.lateStrCheckin#" data-newcheckout="#variables.lateStrCheckout#" data-flextab="late" href="javascript:;" id="lateSelectDay"><small>#dateFormat(variables.lateStrCheckin, 'dddd')#</small><span class="tab-date tab-date-sunday"></span></a>
              </li>
            </cfoutput>

          </ul>
        </div><br>

      <cfelse><!--- flex days if --->

        <!---
        This version is hidden/shown via the results page refine search filter
        User came to the page on a non-dated search initially, then used the filter at the top
        --->

        <div class="results-tab-bar hidden">
          <ul class="nav nav-tabs">
              <li id="earlyTab"><a data-newcheckin="" data-newcheckout="" data-flextab="early" href="javascript:;" id="earlySelectDay"><small><!--- Friday5 ---></small><span class="tab-date tab-date-friday"></span></a></li>
              <li id="midTab"><a data-newcheckin="" data-newcheckout="" data-flextab="" href="javascript:;" id="midSelectDay"><small><!--- Saturday4 ---></small><span class="tab-date tab-date-saturday"></span></a></li>
              <li id="lateTab"><a data-newcheckin="" data-newcheckout="" data-flextab="late" href="javascript:;" id="lateSelectDay"><small><!--- Sunday2 ---></small><span class="tab-date tab-date-sunday"></span></a></li>
          </ul>
        </div><br>

      </cfif><!--- flex days else --->

      <!---<div id="scrollReturn"></div>--->

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

            $('.cssload-container').delay(1500).fadeOut(200);
          }
        });
      </script>
    </cfif>
  </cf_htmlfoot>

<cfinclude template="/#settings.booking.dir#/components/results-modals.cfm">

<cfinclude template="/#settings.booking.dir#/components/footer.cfm">