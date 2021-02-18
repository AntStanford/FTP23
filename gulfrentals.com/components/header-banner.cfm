<div class="<cfif isdefined('page.slug') and page.slug eq 'index'>i-hero-wrap<cfelse>i-hero-wrap int</cfif>">
  <cfif mobileDetect>
    <div class="i-hero-img-wrap"><div class="i-hero-img lazy" data-src="/images/layout/hero-mobile.jpg"></div></div>
  <cfelse>
	  <cfif isdefined('page.slug') and page.slug eq 'index'>
  	  <!--- Home Page Slide Show --->
      <cfquery name="getHomeSlides" dataSource="#settings.dsn#">
        select thefile from cms_assets where section = 'Homepage Slideshow' order by sort
      </cfquery>
      <div class="owl-carousel owl-theme hp">
        <cfoutput query="getHomeSlides">
          <div class="i-hero-img-wrap"><div class="i-hero-img owl-lazy" data-src="/images/homeslideshow/#replace(thefile,' ','%20','all')#"></div></div>
        </cfoutput>
      </div>
    <cfelseif isdefined('page.headerImage') and len(trim(page.headerImage)) GT 0>
      <div class="i-hero-img-wrap"><div class="i-hero-img lazy" data-src="/images/header/<cfoutput>#page.headerImage#</cfoutput>"></div></div>
    <cfelse>
      <div class="i-hero-img-wrap"><div class="i-hero-img lazy" data-src="/images/layout/hero-int.jpg"></div></div>
	  </cfif>
  </cfif>

  <cfif cgi.script_name contains 'booking' or (isdefined('page.partial') and page.partial eq 'results.cfm') or cgi.script_name eq '/layouts/special.cfm' or cgi.script_name eq '/layouts/resort.cfm'>
    <!--- No quicksearch on these pages --->
  <cfelse>
    <cfinclude template="/components/quick-search.cfm">
  </cfif>
</div><!-- END i-hero-wrap -->