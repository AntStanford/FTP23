<!--- Get the popular searches --->
<cfquery name="getPopularSearches" dataSource="#settings.dsn#">
	select slug,name,popularSearchPhoto from cms_pages where popularSearch = 'Yes'
</cfquery>

<cfif getPopularSearches.recordcount gt 0>
  <div class="i-popular-searches">
  	<div class="container text-center">
      <h6 class="site-color-2">View some of our most</h6>
  	  <h2 class="h1 site-color-1">Popular Vacation Rental Searches</h2>
  	</div>
  	<div class="container popular-container">
  	  <div class="owl-carousel owl-theme popular-rentals-carousel">
        <cfloop query="getPopularSearches">
          <cfoutput>
          <div class="popular-rental">
            <div class="popular-rental-img-wrap">
              <a href="/#slug#" class="popular-rental-link">
                <div class="popular-rental-overlay">
      	          <h3 class="popular-rental-title text-white">#name#</h3>
                </div>
                <span class="popular-rental-img" style="background:url('/images/popular/#popularSearchPhoto#');"></span>
              </a>
            </div><!-- END featured-property-img-wrap -->
  	      </div>
          </cfoutput>
	      </cfloop>
  	  </div><!-- END popular-rentals-carousel -->

      <div class="cssload-container">
        <div class="cssload-tube-tunnel"></div>
      </div>
    </div>
  </div><!-- END i-popular-searches -->
</cfif>