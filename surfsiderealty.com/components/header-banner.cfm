<!---
<style>
.banner img { min-height: 56vh; max-height: 65vh; }
.banner-info { bottom: 24%; }
<!--- .quick-search {display:none;} --->
</style>
--->



<cfif isdefined('page.slug') and page.slug eq 'index'>
	<cfquery name="getHomepageSlideshowImages" dataSource="#settings.dsn#">
		select thefile, sort from cms_assets
		where section = 'Homepage Slideshow'
		order by sort asc
	</cfquery>

	<div class="banner">
  	<div class="banner-wrapper placeholder">
  		<div class="banner-info">It's A Beach Thing!</div><!-- END banner-info -->
  		<div id="banner" class="cycle-slideshow" data-cycle-fx="scrollHorz" data-cycle-timeout="5000" data-cycle-speed="400" data-cycle-pause-on-hover="true" data-cycle-prev="#prev" data-cycle-next="#next" data-cycle-pager=".cycle-pager">
  		<!-- GALLERY FRAME CONTROLS -->
  <!---
  			<img src="/images/banner-home1-xmas.jpg">
  			<img src="/images/banner-home1-xmas2.jpg">
  			<img src="/images/banner-home1-xmas3.jpg">
  --->
				<cfoutput query="getHomepageSlideshowImages">
					<img src="/images/homeslideshow/#thefile#">
				</cfoutput>
			</cfif>
  		</div>
  	</div>
	</div><!-- END banner -->
<cfelseif isdefined('page.slug') and page.slug eq 'sales'>
	<div class="banner">
  	<div class="banner-wrapper placeholder">
  		<div class="banner-info">It's A Beach Thing!</div><!-- END banner-info -->
  		<div id="banner" class="cycle-slideshow" data-cycle-fx="scrollHorz" data-cycle-timeout="5000" data-cycle-speed="400" data-cycle-pause-on-hover="true" data-cycle-prev="#prev" data-cycle-next="#next" data-cycle-pager=".cycle-pager">
  		<!-- GALLERY FRAME CONTROLS -->
  			<img src="/images/banner-01.jpg">
  			<img src="/images/banner-02.jpg">
  			<img src="/images/banner-03.jpg">
  			<img src="/images/banner-06.jpg">
  			<img src="/images/banner-07.jpg">
  		</div>
  	</div>
	</div><!-- END banner -->
<cfelseif isdefined('page.slug') and page.slug eq 'association-management'>
	<div class="banner">
  	<div class="banner-wrapper placeholder">
  		<div class="banner-info">It's A Beach Thing!</div>
  		<div id="banner" class="cycle-slideshow" data-cycle-fx="scrollHorz" data-cycle-timeout="5000" data-cycle-speed="400" data-cycle-pause-on-hover="true" data-cycle-prev="#prev" data-cycle-next="#next" data-cycle-pager=".cycle-pager">
  			<img src="/images/asshero.jpg">
  		</div>
  	</div>
	</div><!-- END banner -->
<cfelseif isdefined('page.slug') and page.slug eq 'propertymanagement'>
	<div class="banner">
  	<div class="banner-wrapper placeholder">
  		<div class="banner-info">It's A Beach Thing!</div>
  		<div id="banner" class="cycle-slideshow" data-cycle-fx="scrollHorz" data-cycle-timeout="5000" data-cycle-speed="400" data-cycle-pause-on-hover="true" data-cycle-prev="#prev" data-cycle-next="#next" data-cycle-pager=".cycle-pager">
  			<img src="/images/prohero1.jpg">
  		</div>
  	</div>
	</div><!-- END banner -->
<cfelse>
	<div class="banner interiorBanner">
		<div id="banner">
			<img src="/mls/images/layout/interior-masthead.jpg">
		</div>
	</div><!-- END banner -->
</cfif>