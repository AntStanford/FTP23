<cfinclude template="/sales/index_.cfm">
<cfinclude template="/sales/includes/session-killer.cfm">
<!--- <cfinclude template="/components/header.cfm"> --->


<cfif isdefined('LinkToLogin') and (isdefined('session.loggedin') is "No" or isdefined('cookie.loggedin') is "No")>
	<script>
		$(document).ready(function(){
			$.fancybox('<div style="width:780px"><iframe src="/sales/lightboxes/create-account.cfm" width="765" height="434" frameborder="0"></iframe></div>',{'enableEscapeButton': false,'showCloseButton': false,'hideOnContentClick': true,'hideOnOverlayClick': false,'width': '75%','height': '75%','autoScale': false,'overlayOpacity': 0.9});
		});
	</script>
</cfif>


<!--- Start: Used to close Lightbox and Reload page --->
<cfset session.RememberMePage = "#script_name#?#query_string#">
<!--- End: Used to close Lightbox and Reload page --->

<!--- Agent on Duty --->
<CFQUERY NAME="getAoD" DATASOURCE="#settings.dsn#">
	SELECT *
	FROM cms_staff
	Where OnDuty = <cfqueryparam value="sales" cfsqltype="cf_sql_varchar">
	Limit 1
</CFQUERY>

<div class="content">
	<cfif getAoD.recordcount eq 1>
		<cfoutput query="getAoD">
			<a hreflang="en" href="/contact-surfside-realty.cfm?to=#id#" class="agent">
				<cfif LEN(photo) and FileExists(ExpandPath('/images/staff/#photo#'))><img src="/images/staff/#photo#"></cfif>
				<div>
					<span>Agent on Duty</span>
					<strong>#name#</strong>
					<b>#phone#</b>
					<small>Contact Agent Now</small>
				</div>
			</a>
		</cfoutput>
	</cfif>
	<div class="welcome">
		<div class="page-text">
			<h1><span>welcome to</span> Surfside Realty Company</h1>
			<p>Surfside Beach is a small seaside community nestled in the heart of South Carolina's Grand Strand area. It encompasses 2 miles of pristine beach, enjoys a temperate climate and is both an active residential community and a thriving vacation destination.</p>
			<p>This is the place where you will hear the ocean breezes, feel the soft white sand underneath your toes, and see the sandpiper birds race across the beach!  Whether it is your dream home or your vacation getaway you will just love living here creating lifetime memories with your family and friends.</p>
			<p>We have been helping families find their homes along the South Strand in Surfside Beach and Garden City Beach since 1962.  We are your experts in this area. We love where we live, and you will too!</p>
			<ul>
				<li><a hreflang="en" href="/mls/our-listings">Our Listings</a></li>
				<li><a hreflang="en" href="/mls/oceanfront">Oceanfront</a></li>
				<li><a hreflang="en" href="/mls/condos">Condos</a></li>
				<li><a hreflang="en" href="/mls/search-results.cfm">MLS Listings</a></li>
				<li><a hreflang="en" href="/mls/golf-oriented">Golf Oriented</a></li>
				<li><a hreflang="en" href="/mls/foreclosure">Foreclosure</a></li>
			</ul>
		</div><!-- END page-text -->
		<div class="video">
<!---       <cfif listfind('216.99.119.254,68.51.114.167',cgi.remote_addr)> --->
  			<div class="video-wrap">
    			<iframe src="https://player.vimeo.com/video/149761900?color=3573b9&title=0&byline=0&portrait=0" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
  			</div>
  			<style>
    		.video-wrap { position: relative; padding-bottom: 56.25%; padding-top: 25px; height: 0; }
    		.video-wrap iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
  			</style>
<!---
  		<cfelse>
  			<img src="/sales/images/layout/family-beach.jpg">
			</cfif>
--->
		</div>
	</div><!-- END welcome -->

	<cfquery DATASOURCE="#dsnmls#" NAME="GetListings">
	  SELECT street_number,street_name,city,zip_code,mlsnumber,mlsid,wsid,unit_number,list_price,bedrooms,baths_full,total_heated_square_feet,photo_link
	  	FROM mastertable where MLSID = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.MLSID#"> and Listing_Office_Id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.CompanyMLSID#">
	  and street_name <> ''
	  order by rand()
	  limit 8
	</cfquery>


	<div class="container-fluid featured-props">
		<div class="row">
			<div class="col-md-12">
				<img src="/sales/images/layout/featured-prop-header.png" class="featured-logo">

<!--- <cfif cgi.remote_addr eq "67.209.31.5"> --->

      	<div class="container featured-container placeholder">
      	  <div class="owl-carousel owl-theme featured-props-carousel">
  					<cfoutput query="GetListings">
  					  <cfset mlsnumber = "#GetListings.mlsnumber#">
              <cfinclude template="/sales/includes/image-handler.cfm">
  					  <cfset seolink = optimizeMyURL(street_number,street_name,city,zip_code,mlsnumber,mlsid,wsid)>
    					<div class="property">
    						<div class="prop-pic">
    						  <a hreflang="en" href="#Replace(seolink,'mls','sales')#"><img src="#Replace(thephoto,'http:','')#"></a>
    						</div>
    						<div class="prop-info">
    							<h5>#street_number# #street_name#</h5>
    							<em>#city#</em>
    							<strong>#dollarformat(list_price)#</strong>
    							<ul>
    								<li><img src="/sales/images/layout/bed-icon.png"> #bedrooms#</li>
    								<li><img src="/sales/images/layout/bath-icon.png"> #baths_full#</li>
                    <li><img src="/sales/images/layout/house-icon.png"> <cfif total_heated_square_feet contains "-">#trim(listgetat(total_heated_square_feet,'1','-'))#<cfelse>#trim(total_heated_square_feet)#</cfif></li>
    							</ul>
                  <a hreflang="en" href="#Replace(seolink,'mls','sales')#" class="btn">View This Property</a>
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
					<cfoutput query="GetListings">
					  <cfset mlsnumber = "#GetListings.mlsnumber#">
            <cfinclude template="/sales/includes/image-handler.cfm">
					  <cfset seolink = optimizeMyURL(street_number,street_name,city,zip_code,mlsnumber,mlsid,wsid)>
  					<div class="property">
  						<div class="prop-pic">
  							<a hreflang="en" href="#Replace(seolink,'mls','sales')#"><img src="#Replace(thephoto,'http:','')#"></a>
  						</div>
  						<div class="prop-info">
  							<h5>#street_number# #street_name#</h5>
  							<em>#city#</em>
  							<strong>#dollarformat(list_price)#</strong>
  							<ul>
  								<li><img src="/sales/images/layout/bed-icon.png"> #bedrooms#</li>
  								<li><img src="/sales/images/layout/bath-icon.png"> #baths_full#</li>
  								<li><img src="/sales/images/layout/house-icon.png"> <cfif total_heated_square_feet contains "-">#trim(listgetat(total_heated_square_feet,'1','-'))#<cfelse>#trim(total_heated_square_feet)#</cfif></li>
  							</ul>
  							<a hreflang="en" href="#Replace(seolink,'mls','sales')#" class="btn">View This Property</a>
  						</div>
  					</div>
					</cfoutput>

					<!--- <div class="property">
						<div class="prop-pic">
							<img src="images/layout/featured-prop3.jpg">
						</div>
						<div class="prop-info">
							<h5>540 Waccamaw Drive</h5>
							<em>Garden City Beach</em>
							<strong>$168,700</strong>
							<ul>
								<li><img src="images/layout/bed-icon.png"> 6</li>
								<li><img src="images/layout/bath-icon.png"> 4</li>
								<li><img src="images/layout/house-icon.png"> 4100</li>
							</ul>
							<a hreflang="en" href="" class="btn">View This Property</a>
						</div>
					</div> --->

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
	</div>
</div><!-- END content -->

<!--- <cfinclude template="/sales/components/footer.cfm"> --->
