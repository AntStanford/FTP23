<div class="<cfif isdefined('page.slug') and page.slug eq 'index'>i-hero-wrap<cfelse>i-hero-wrap int</cfif>">
  <div class="i-hero">
	  <cfif mobileDetect>
	    <img class="i-hero-img" src="/images/layout/<cfif isdefined('page.slug') and page.slug eq 'index'>hero-mobile<cfelse>hero-int-mobile</cfif>.jpg">
    <cfelse>
  	  <cfif isdefined('page.slug') and page.slug eq 'index'>
    	  <!--- Home Page Slide Show --->
        <cfquery name="getHomeSlides" dataSource="#settings.dsn#">
          select thefile from cms_assets where section = 'Homepage Slideshow' order by sort
        </cfquery>
        <div class="owl-carousel owl-theme hp">
          <cfoutput query="getHomeSlides">
            <span class="i-hero-img owl-lazy" data-src="/images/homeslideshow/#replace(thefile,' ','%20','all')#"></span>
          </cfoutput>
        </div>
      <cfelseif (isdefined('page.slug') and page.slug eq 'propertymanagement')>
	    <img class="i-hero-img" src="/images/prohero1.jpg">
      <cfelse>
        <img class="i-hero-img" src="/images/layout/hero-int.jpg">
  	  </cfif>
          
          
          
          
	  </cfif>
	  <cfif cgi.script_name contains 'rentals' or (isdefined('page.partial') and page.partial eq 'results.cfm') or cgi.script_name eq '/layouts/special.cfm' or cgi.script_name eq '/layouts/resort.cfm'>
      <!--- No quicksearch on these pages --->
    <cfelse>
      <cfinclude template="/components/quick-search.cfm">
	  </cfif>
        
     
        
        
        
        
  </div>
</div>