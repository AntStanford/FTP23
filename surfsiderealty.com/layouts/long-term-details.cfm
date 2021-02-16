
<cfparam name="URL.id" default="0">

<cfquery name="rental" dataSource="#settings.dsn#">
	SELECT * from cms_long_term_rentals where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
</cfquery>

<cfif len(rental.metakeywords) or len(rental.metadesc) or len(rental.metatitle)>
	<cfset GetInfo.metatitle = rental.metatitle>
	<cfset GetInfo.metadesc = rental.metadesc>
	<cfset GetInfo.metakeywords = rental.metakeywords>
<cfelse>
	<cfset GetInfo.metatitle = "Annual Vacation Rentals - Surfside Realty">
	<cfset GetInfo.metadesc = "Annual Vacation Rentals">
	<cfset GetInfo.metakeywords = "annual, vacation, rentals, surfside">
</cfif>

<!--- Get the photos --->
<cfquery name="photos" dataSource="#settings.dsn#">
	select photo from cms_long_term_rentals_photos where rental_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> order by sort
</cfquery>

<cfinclude template="/components/header.cfm">
<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">

			<div id="details">
				<cfoutput>
					<div id="detail-header">
						<h4>#rental.name#</h4>
						<span id="rate">#DollarFormat(rental.rate)# per month</span>
						<span id="subtext">Rental Details</span>
					</div>

					<div class="row">
						<div class="col-xs-12 col-sm-7 col-md-6">
							<div id="propertySlideshow">
								<div id="propertyControls">
									<a hreflang="en" href="##" class="cycle-prev"><i class="glyphicon glyphicon-chevron-left"></i></a>
									<a hreflang="en" href="##" class="cycle-next"><i class="glyphicon glyphicon-chevron-right"></i></a>
									<!-- <span class="custom-caption"></span> -->
								</div>
								<div id="propertyImages" class="cycle-slideshow" data-cycle-slides="> div" data-cycle-timeout="0" data-cycle-prev="##propertyControls .cycle-prev" data-cycle-next="##propertyControls .cycle-next" data-cycle-caption="##propertyControls .custom-caption" data-cycle-caption-template="Slide {{slideNum}} of {{slideCount}}" data-cycle-fx="fadeIn">
									<cfloop query="photos">
										<div><img class="thumb" src="/images/long-term/lg_#photo#" ref="/images/long-term/lg_#photo#" alt="#rental.name# - #id#"></div>
									</cfloop>
								</div>
								<div id="propertyThumbs" class="cycle-slideshow" data-cycle-slides="> div" data-cycle-timeout="0" data-cycle-prev="##thumbControls .cycle-prev" data-cycle-next="##thumbControls .cycle-next" data-cycle-fx="carousel" data-cycle-carousel-visible="5" data-cycle-carousel-fluid="true" data-allow-wrap="false">
									<cfloop query="photos">
										<div><img class="thumb" src="/images/long-term/th_#photo#" ref="/images/long-term/md_#photo#" alt="#rental.name# - Thumbnail #id#"></div>
									</cfloop>
								</div>
								<div id="thumbControls">
									<a hreflang="en" href="##" class="cycle-prev"><i class="glyphicon glyphicon-chevron-left"></i></a>
									<a hreflang="en" href="##" class="cycle-next"><i class="glyphicon glyphicon-chevron-right"></i></a>
								</div>
							</div>

							<script>
								$(document).ready(function(){
									var slideshows = $('.cycle-slideshow').on('cycle-next cycle-prev', function(e, opts) {
										slideshows.not("##propertyImages").cycle('goto', opts.currSlide);
									});

									$('##propertyThumbs .cycle-slide').click(function(){
										$(this).addClass('cycle-slide-active').siblings().removeClass('cycle-slide-active');
										var index = $('##propertyThumbs').data('cycle.API').getSlideIndex(this);
										slideshows.cycle('goto', index);
									});

									/*
									$(".fancybox").fancybox({
										openEffect: 'none',
										closeEffect: 'none'
									});
									*/
								});
							</script>
						</div>
						<div class="col-xs-12 col-sm-5 col-md-6">
							<div id="rental-info">
								<h5>Details</h5>
								<dl>
									<dt><strong>Community</strong></dt>
									<dd>#rental.community#</dd>

									<dt><strong>Bedrooms</strong></dt>
									<dd>#rental.beds#</dd>

									<dt><strong>Bathrooms</strong></dt>
									<dd>#rental.baths#</dd>

									<dt><strong>Furnished</strong></dt>
									<dd><cfif rental.furnished is 1>Yes<cfelse>No</cfif></dd>

									<dt><strong>Address</strong></dt>
									<dd>#rental.address1# #rental.address2#</dd>

									<dt><strong>City</strong></dt>
									<dd>#rental.city#</dd>

									<dt><strong>State</strong></dt>
									<dd>#rental.state#</dd>

									<dt><strong>ZIP Code</strong></dt>
									<dd>#rental.zip#</dd>

									<dt><strong>Contact Information</strong></dt>
									<dd>#rental.contact#</dd>
								</dl>

								<p class="description">#rental.description#</p>
							</div>
						</div>
					</div>

				</cfoutput>
			</div>

		</div>
	</div>
</div>
<cfinclude template="/components/footer.cfm">
