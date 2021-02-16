<cfinclude template="/components/header.cfm">

<cf_htmlfoot>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
		$('form#advancedSearchForm').submit(function(){
			var arrivaldate = $(this).find('input[name=strCheckin]').val();
			var sortby = $(this).find('select[name=strSortBy]').val();
			if(arrivaldate == '' && (sortby == 'rentalRate asc' || sortby == 'rentalRate desc')){
				alert('"Sort by Price" requires an arrival date.');
				return false;
			}
		});

  $('.refine-filter-specific-property-select').change(function(){
    var url = $(this).val();
    var redirectWindow = window.open(url, '_blank');
    redirectWindow.location;
  });


	});
</script>
</cf_htmlfoot>

<br>
<div id="advanced-form" class="booking container">
<form role="form" action="/rentals/results.cfm" method="post" id="advancedSearchForm">

   <input type="hidden" name="camefromsearchform">

	<div class="row">
  	<div class="col-md-12">

    	<div class="panel panel-default">
      	<div class="panel-heading">
      	  <h3 class="pull-left" style="margin:0">Advanced Search</h3>
      	  <span class="pull-right ajaxResponse"></span>
      	  <div style="clear:both"></div>
      	</div>
  			<div class="panel-body">
	 				<div class="row">
		 				<div class="col-xs-12 col-md-6">

			 				<div class="features panel panel-default">
				 				<div class="panel-heading"><h4 class="nomargin">Date</h4></div>
				 				<div class="panel-body">
						      <div class="input-group form-group">
						        <input type="text" name="strCheckin" id="start-date" value="" placeholder="Arrival Date" class="form-control mycal datepicker" readonly>
						      </div>
						      <div class="input-group form-group">
						        <input type="text" name="strCheckout" id="end-date" value="" placeholder="Departure Date" class="form-control mycal datepicker" readonly>
						      </div>


				 				</div>
			 				</div> <!-- END features -->

                     <div class="features panel panel-default">
				 				<div class="panel-heading"><h4 class="nomargin">Search by Unit Name</h4></div>
				 				<div class="panel-body">
									<div class="input-group form-group">
                    <select class="refine-filter-specific-property-select form-control" name="unitname" id="rs-unitname">
                      <option value="">- Choose One -</option>
                      <cfloop query="settings.booking.properties">
                        <cfoutput><option value="/#settings.booking.dir#/#settings.booking.properties.seoPropertyName#">#settings.booking.properties.name#</option></cfoutput>
                      </cfloop>
                    </select>
									</div>
								</div>
							</div>

                      <div class="features panel panel-default">
                      	<div class="panel-heading"><h4 class="nomargin">Search by Amenity</h4></div>
                      	<div class="panel-body">
                      		<div class="input-group form-group">
                              <!--- remove off season monthly from list --->
                             <cfoutput>
								<style>
								/* Forces the first checkbox to have padding. Don't understand it. */
								.checkbox-inline:nth-child(1),
								.radio-inline:nth-child(1) {
								    padding-left: 20px !important;
								}
								</style>

																<cfloop from="1" to="#listLen(amenityList)#" index="i">
																	<cfset cleanAmenityID = reReplace(ListGetAt(amenityList,i),'[^A-Za-z0-9]','','all')>
                                   <label class="checkbox-inline">
                                     <input type="checkbox" name="amenities" VALUE="#ListGetAt(amenityList,i)#" id="#cleanAmenityID#">#ListGetAt(amenityList,i)#
                                   </label>
                                </cfloop>
                              </cfoutput>

									</div>
								</div>
							</div>

						</div><!-- END col- -->
						<div class="col-xs-12 col-md-6">
							<div class="features panel panel-default">
								<div class="panel-heading"><h4 class="nomargin">Features</h4></div>
								<div class="panel-body">
									<div class="input-group form-group">
										<label>Type</label>
										<select class="form-control required" name="type">
											<option value="">Any</option>
											<cfloop list="#settings.booking.typeList#" index="i">
												<cfoutput>
													<option>#i#</option>
												</cfoutput>
											</cfloop>
										</select>
									</div>
									<div class="input-group form-group">
										<label>Location</label>
										<select name="location"  id="strLocations" class="form-control required">
											<option value="">Any</option>
											<cfloop list="#settings.booking.locationList#" index="i">
												<cfoutput>
													<option>#i#</option>
												</cfoutput>
											</cfloop>
										</select>
									</div>
									<div class="input-group form-group">
										<label>Area</label>
										<select class="form-control required" name="area">
											<option value="">Any</option>
											<cfoutput query="getAreas">
												<option>#strArea#</option>
											</cfoutput>
										</select>
									</div>
									<div class="input-group form-group">
                              			<label>Bedrooms</label>
										<select class="form-control required" name="bedrooms">
											<option value="">All Bedrooms</option>
											<cfloop from="#settings.booking.minBed#" to="#settings.booking.maxBed#" index="i">
											    <cfoutput><option value="#i#,#settings.booking.maxBed#">#i#+</option></cfoutput>
											</cfloop>
										</select>
									</div>

									<div class="input-group form-group">
									<label>Bathrooms</label>
										<select class="form-control required" name="bathrooms">
											<option value="">All Bathrooms</option>
											<cfloop from="#settings.booking.minbath#" to="#settings.booking.maxBath#" index="i">
												<cfoutput><option value="#i#,#settings.booking.maxBath#">#i#+</option></cfoutput>
											</cfloop>
										</select>
									</div>

									<div class="input-group form-group">
                              			<label>Sleeps</label>
										<select class="form-control required" name="sleeps">
											<option value="">Any</option>
                       						<cfloop from="#settings.booking.minoccupancy#" to="#settings.booking.maxoccupancy#" index="i">
											    <cfoutput><option>#i#</option></cfoutput>
											</cfloop>
										</select>
									</div>

									<div class="input-group form-group">
										<label>Sort By</label>
										<select class="form-control required" name="strSortBy">
											<option value="" selected="">- Select One -</option>
											<option value="name asc">Property Name</option>
											<option value="bedrooms asc">Bedrooms Low to High</option>
											<option value="bedrooms desc">Bedrooms High to Low</option>
											<option value="sleeps asc">Occupancy Low to High</option>
											<option value="sleeps desc">Occupancy High to Low</option>
											<option value="price asc">Price - LOW to HIGH</option>
                                 			<option value="price desc">Price - HIGH to LOW</option>
										</select>
										<br /><em>(Search by Price requires an arrival date/departure date)</em>
									</div>
				 				</div>
			 				</div><!-- END panel -->

		 				</div><!-- END col- -->
	 				</div>

  			</div>
    	</div><!-- END panel -->

      <input type="submit" value="SEARCH" class="btn btn-primary btn-lg pull-right">
      <span class="ajaxResponse pull-right" style="padding-right:15px"></span>


  	</div><!-- END col- -->

	</div>
  </form>
</div>

<cf_htmlfoot>
<script type="text/javascript" defer="defer">
	$(window).bind("pageshow", function() {
	  $('#strpropid').val('');
	});
</script>
</cf_htmlfoot>

<cfinclude template="/components/footer.cfm">