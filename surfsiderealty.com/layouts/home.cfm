<!---
<div class="i-content">
  <div class="container">
		<cfinclude template="/components/callouts.cfm">
	</div>
	<div class="i-welcome text-center">
    <div class="container">
    	<div class="row">
    		<div class="col-lg-12">
          <cfcache key="cms_pages" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">
        		<cfif len(page.h1)>
        		  <cfoutput><h1 class="site-color-1">#page.h1#</h1></cfoutput>
        		<cfelse>
        		  <cfoutput><h1 class="site-color-1">#page.name#</h1></cfoutput>
        		</cfif>
        		<cfoutput>#page.body#</cfoutput>
          </cfcache>
    		</div>
    	</div>
    </div>
	</div>
  <div class="container">
    <cfinclude template="/components/featured-properties.cfm">
		<cfif len(page.partial)><cfinclude template="/partials/#page.partial#"></cfif>
  </div>
  <cfinclude template="/components/popular-searches.cfm">
</div>
--->
<!---
<cfif len(page.h1)>
  <cfoutput><h1>#page.h1#</h1></cfoutput>
<cfelse>
  <cfoutput><h1>#page.name#</h1></cfoutput>
</cfif>
<cfoutput>#page.body#</cfoutput>
--->

<!--- <cfset StructClear(Session)> --->


<CFQUERY NAME="getAoD" DATASOURCE="#settings.dsn#">
	SELECT *
	FROM cms_staff
	Where OnDuty = <cfqueryparam value="booking" cfsqltype="cf_sql_varchar">
	Limit 1
</CFQUERY>


<div class="content">
	<cfif getAoD.recordcount eq 1>
		<cfoutput query="getAoD">
			<a hreflang="en" href="/contact-surfside-realty.cfm?to=#id#" class="agent">
				<cfif LEN(photo) and FileExists(ExpandPath('/images/staff/#photo#'))><img src="/images/staff/#photo#"></cfif>
				<div>
					<span>Reservationist on Duty</span>
					<strong>#name#</strong>
					<b>#phone#</b>
					<small>Contact Agent Now</small>
				</div>
			</a>
		</cfoutput>
	</cfif>

	<div class="welcome">
		<div class="page-text">
			<div class="hpheading"><span>welcome to</span> Surfside Realty Company</div>
      <h1 class="hph1">...a proven leader in vacation rentals in Surfside Beach, Garden City Beach and Myrtle Beach. </h1>
			<p>Surfside Realty has been providing families with perfect vacation homes and condos for their beach getaway since 1962. Whether you are looking to create childhood memories for your kids, celebrate life, relax with an unforgettable escape or all of the above, we are ready to exceed your expectations. You'll enjoy our white sandy beaches, endless shopping, spine-tingling attractions, mouth-watering seafood dinners, and championship golf. It's a great vacation waiting to happen.  It's a beach thing!</p>
			<p>We have a large assortment of <a href="/surfside-beach-vacation-rentals">Surfside Beach rentals</a> in various sizes and price ranges sure to meet your needs. We also offer a wide selection of <a href="/garden-city-beach-vacation-rentals">Garden City rentals</a> for those looking to stay further south. All of our properties come <strong>fully furnished</strong> with kitchens equipped for cooking any size meal. Whether you want a place that's oceanfront or with a golf course fairway view, we can accommodate your wishes. You'll love the Surfside Beach vacation rentals we have -- they provide everything you would expect your home away from home to have plus <strong>many extra amenities</strong> that provide that something extra. Come for a week, a month, or for the whole winter! We'd love to have you!</p>
			<ul>
				<li><a hreflang="en" href="/alphabetical-listings">All Properties</a></li>
				<!---<li><form action="/rentals/results.cfm" method="post" id="form1"><input type="hidden" name="camefromsearchform"><input type="hidden" name="strType" value="Condo"><a hreflang="en" href="javascript:{}" onclick="document.getElementById('form1').submit(); return false;">Condos</a></form></li>--->
				<li><a hreflang="en" href="/surfside-beach-oceanfront-rentals">Oceanfront</a></li>
				<li><a hreflang="en" href="/ocean-view-rentals">Oceanview</a></li>
        <!--- <li><form action="/rentals/results.cfm" method="post" id="form3"><input type="hidden" name="camefromsearchform"><input type="hidden" name="strArea" value="Ocean View"><a hreflang="en" href="javascript:{}" onclick="document.getElementById('form3').submit(); return false;">Oceanview</a></form></li> --->
				<li><a hreflang="en" href="/second-row-rentals">2nd Row</a></li>
        <!--- <li><form action="/rentals/results.cfm" method="post" id="form4"><input type="hidden" name="camefromsearchform"><input type="hidden" name="strArea" value="2nd Row"><a hreflang="en" href="javascript:{}" onclick="document.getElementById('form4').submit(); return false;">2nd Row</a></form></li> --->
        <!--- <li><form action="/rentals/results.cfm" method="post" id="form5"><input type="hidden" name="camefromsearchform"><input type="hidden" name="strArea" value="3rd Row"><a hreflang="en" href="javascript:{}" onclick="document.getElementById('form5').submit(); return false;">3rd Row</a></form></li> --->
				<li><a hreflang="en" href="/rental-homes-with-private-pool">Private Pool</a></li>
				<li><a hreflang="en" href="/pet-friendly-rentals">Dog Friendly</a></li>
        <li><a hreflang="en" href="/garden-city-beach-vacation-rentals">All Garden City</a></li>
        <li><a hreflang="en" href="/surfside-beach-vacation-rentals">All Surfside</a></li>
        <li><a hreflang="en" href="/surfside-beach-condo-rentals">Surfside Condos</a></li>
				<!---
        <li><a hreflang="en" href="/golf-carts.cfm">Golf Cart Rentals</a></li>
				<li><a hreflang="en" href="/rental_gear.cfm">Beach Supplies</a></li>
				--->
			</ul>
		</div><!-- END page-text -->
		<div class="video">
			<!---<cfif isdefined('url.emaillink') and url.emaillink eq 'k7stKXjNjb8YpqawJ5u'>--->
<!---       <cfif listfind('216.99.119.254,68.51.114.167',cgi.remote_addr)> --->
  			<div class="video-wrap">
<!---     			<iframe src="https://player.vimeo.com/video/149761900?color=3573b9&title=0&byline=0&portrait=0" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> --->
    			<iframe src="https://player.vimeo.com/video/235050334?color=3573b9&amp;title=0&amp;byline=0&amp;portrait=0" width="100%" height="275" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
  			</div>
  			<style>
    		.video-wrap { position: relative; padding-bottom: 56.25%; padding-top: 25px; height: 0; }
    		.video-wrap iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
  			</style>

  		<!---<cfelse>
  			<img src="/mls/images/layout/family-beach.jpg">
			</cfif>--->

		</div>
  </div><!-- END welcome -->

  <cfset GetFeatured = application.bookingObject.getFeaturedProperties()>
	<div class="container-fluid featured-props">
			<div class="col-md-12">
				<img src="/mls/images/layout/featured-prop-header.png" class="featured-logo">

<!--- <cfif cgi.remote_addr eq "67.209.31.5"> --->

      	<div class="container featured-container placeholder">
      	  <div class="owl-carousel owl-theme featured-props-carousel">
            <cfoutput query="GetFeatured">

              <cfset detailPage = '/rentals/#seoPropertyName#'>
    					<div class="property">
    						<div class="prop-pic">

    						   <cfif len(photo) gt 0>
    						      <a hreflang="en" href="#detailPage#"><img src="#photo#"></a>
    						   <cfelse>
    						      <a hreflang="en" href="#detailPage#"><img src="http://placehold.it/300x300&text=No%20Image"></a>
    						   </cfif>

    						</div>
    						<div class="prop-info">
    							<h5>#name#</h5>
    							<em>#address#</em>
    							<!--- #getPriceRange(strpropid)# --->
    							<ul>
    								<li><img src="/sales/images/layout/bed-icon.png"> #bedrooms#</li>
    								<li><img src="/sales/images/layout/bath-icon.png"> #bathrooms#</li>
    								<li><img src="/sales/images/layout/sleeps-icon.png"> #sleeps#</li>
    								<!--- <li><img src="/sales/images/layout/house-icon.png"></li> --->
    							</ul>
    							<a hreflang="en" href="#detailPage#" class="btn">View This Property</a>
    						</div>
    					</div>

            </cfoutput>
      	  </div><!-- END featured-props-carousel -->
          <div class="cssload-container">
            <div class="cssload-tube-tunnel"></div>
          </div>
      	</div>

<!---
<cfelse>

				<div class="cycle-slideshow" data-cycle-fx="carousel" data-cycle-slides="> div.property" data-cycle-timeout="5000" data-cycle-pause-on-hover="true" data-cycle-next="#f-next" data-cycle-prev="#f-prev" data-cycle-pager="">

				<cfoutput query="GetFeatured">
					 <cfset detailPage = '/rentals/#seoPropertyName#'>
					<div class="property">
						<div class="prop-pic">

						   <cfif len(photo) gt 0>
						      <a hreflang="en" href="#detailPage#"><img src="#photo#"></a>
						   <cfelse>
						      <a hreflang="en" href="#detailPage#"><img src="http://placehold.it/300x300&text=No%20Image"></a>
						   </cfif>

						</div>
						<div class="prop-info">
							<h5>#name#</h5>
							<em>#address#</em>
							<!--- #getPriceRange(strpropid)# --->
							<ul>
								<li><img src="/mls/images/layout/bed-icon.png"> #bedrooms#</li>
								<li><img src="/mls/images/layout/bath-icon.png"> #bathrooms#</li>
								<li><img src="/mls/images/layout/sleeps-icon.png"> #sleeps#</li>
								<!--- <li><img src="/mls/images/layout/house-icon.png"></li> --->
							</ul>
							<a hreflang="en" href="#detailPage#" class="btn">View This Property</a>
						</div>
					</div>
				</cfoutput>

				</div>
				<div class="controls">
					<a class="prev" id="f-prev" href="">Prev</a>
					<div class="cycle-pager" id="p-pager"></div>
					<a class="next" id="f-next" href="">Next</a>
				</div><!-- END controls -->

</cfif>
--->

      </div>
	</div>
</div><!-- END content -->
<!-- Forms to submit custom queries -->
<cfif isdefined('url.emaillink') and url.emaillink eq 'k7stKXjNjb8YpqawJ5u'>
<cf_htmlfoot>
<!---<cfif listfind('216.99.119.254,68.51.114.167,74.77.253.163,75.139.80.23',cgi.remote_addr)>--->
  <div class="modal fade" id="hp-video-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <div class="embed-responsive embed-responsive-16by9">
            <iframe src="https://player.vimeo.com/video/149761900?color=3573b9&title=0&byline=0&portrait=0&autoplay=1?api=1&player_id=vimeoplayer" id="nofocusvideo" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
  <script src="http://a.vimeocdn.com/js/froogaloop2.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
    $('#hp-video-modal').modal('show');
    var iframe = document.getElementById('nofocusvideo');
    // $f == Froogaloop
    var player = $f(iframe);
    $('#hp-video-modal').on('hidden.bs.modal', function () {
      player.api('pause');
    });
    $('#hp-video-modal').on('shown.bs.modal', function () {
      player.api('play');
    });
  });
  </script>
</cf_htmlfoot>
</cfif>


