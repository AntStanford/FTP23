<form class="refine-form mobile-hidden" id="refineForm" method="post" action="/<cfoutput>#settings.booking.dir#</cfoutput>/results.cfm">

  <!--- Page Count for Infinite Scroll --->
  <input type="hidden" name="page" value="0">
  <input type="hidden" name="camefromsearchform">
  <input type="hidden" name="mapBounds" id="mapBounds" value="">
  <cfif StructKeyExists(session.booking,'specialID')>
  	<input type="hidden" name="specialID" value="<cfoutput>#session.booking.specialID#</cfoutput>" />
  </cfif>
  <cfif StructKeyExists(session.booking,'properties')>
  	<input type="hidden" name="properties" value="<cfoutput>#session.booking.properties#</cfoutput>" />
  </cfif>

  <cfif
	isdefined('session.booking.strcheckin') and
	len(session.booking.strcheckin) and
	isvalid('date',session.booking.strcheckin) and
	isdefined('session.booking.strcheckout') and
	len(session.booking.strcheckout) and
	isvalid('date',session.booking.strcheckout)>
		<cfset numNights = DateDiff('d',session.booking.strcheckin,session.booking.strcheckout)>
		<cfif numNights lt 7>
			<input type="hidden" name="refineSearchType" value="nightly" id="refineSearchType">
		<cfelse>
		  <input type="hidden" name="refineSearchType" value="weekly" id="refineSearchType">
		</cfif>
  <cfelse>
		<input type="hidden" name="refineSearchType" value="weekly" id="refineSearchType">
  </cfif>

  <!--- SortBy Hidden Input --->
  <cfif isdefined('session.booking.strSortBy') and len(session.booking.strSortBy)>
    <cfoutput><input type="hidden" name="strSortBy" value="#session.booking.strSortBy#"></cfoutput>
  <cfelse>
    <input type="hidden" name="strSortBy" value="P">
  </cfif>

  <!--- Refine Dates --->
  <div class="refine-item refine-dates">
    <div class="refine-text">
      <span class="refine-arrival">
        <i class="fa fa-calendar site-color-1" aria-hidden="true"></i>
        <label for="startDateRefine" class="hidden">Arrival Date</label>
				<cfif isdefined('session.booking.strcheckin') and len(session.booking.strcheckin)>
				  <input type="text" name="strCheckin" id="startDateRefine" placeholder="Arrival" value="<cfoutput>#session.booking.strcheckin#</cfoutput>" readonly class="date-entered">
				<cfelse>
				  <input type="text" name="strCheckin" id="startDateRefine" placeholder="Arrival" value="" readonly>
				</cfif>
      </span>
      <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
      <span class="refine-departure">
        <i class="fa fa-calendar site-color-1" aria-hidden="true"></i>
        <label for="endDateRefine" class="hidden">Departure Date</label>
				<cfif isdefined('session.booking.strcheckout') and len(session.booking.strcheckout)>
          <input type="text" name="strCheckout" id="endDateRefine" placeholder="Departure" value="<cfoutput>#session.booking.strcheckout#</cfoutput>" readonly class="date-entered">
				<cfelse>
          <input type="text" name="strCheckout" id="endDateRefine" placeholder="Departure" value="" readonly>
				</cfif>
      </span>
      <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown datepicker-wrap">
      <div id="refineDatepicker"></div>
      <a href="javascript:;" class="btn btn-default site-color-6-bg-hover pull-left refine-clear">Clear Dates</a>
      <!--- <a href="javascript:;" class="btn site-color-3-bg site-color-2-bg-hover text-white pull-right refine-close">Close</a> --->
      <a href="javascript:;" class="btn btn-sm site-color-2-bg site-color-4-bg-hover text-white pull-right refine-apply" id="refineDatesApply">Apply</a>
    </div>
  </div>

  <!--- Refine Guests --->
  <div class="refine-item refine-guests refine-guests-counter-wrap">
    <div class="refine-text">
      <i class="fa fa-users site-color-1" aria-hidden="true"></i>
      <span class="refine-count">
        <cfif isdefined('session.booking.sleeps') and len(session.booking.sleeps) and session.booking.sleeps gt 0>
          <cfoutput>#session.booking.sleeps#</cfoutput>
        <cfelse>
          <cfoutput>#settings.booking.minOccupancy#</cfoutput>
        </cfif>
      </span> Guests
      <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i>
			<cfif isdefined('session.booking.sleeps') and len(session.booking.sleeps) and session.booking.sleeps gt 0>
				<cfoutput><input type="hidden" name="sleeps" value="#session.booking.sleeps#"></cfoutput>
			<cfelse>
			  <cfoutput><input type="hidden" name="sleeps" value="#settings.booking.minOccupancy#"></cfoutput>
			</cfif>
    </div>
    <div class="refine-dropdown refine-counter text-center">
      <i class="fa fa-minus site-color-2-bg site-color-2-lighten-bg-hover text-white disabled" aria-hidden="true"></i>
      <span class="refine-drop-count" data-min="<cfoutput>#settings.booking.minOccupancy#</cfoutput>" data-max="<cfoutput>#settings.booking.maxOccupancy#</cfoutput>">
        <cfif isdefined('session.booking.sleeps') and len(session.booking.sleeps) and session.booking.sleeps gt 0>
          <cfoutput>#session.booking.sleeps#</cfoutput>
        <cfelse>
          <cfoutput>#settings.booking.minOccupancy#</cfoutput>
        </cfif>
      </span>
      <i class="fa fa-plus site-color-2-bg site-color-2-lighten-bg-hover text-white" aria-hidden="true"></i>
      <a href="javascript:;" class="btn btn-block site-color-3-bg site-color-2-bg-hover text-white pull-right refine-close">Close</a>
      <!--- <a href="javascript:;" class="btn btn-block btn-default refine-apply" id="refineGuestsCountApply">Apply</a> --->
    </div>
  </div>

  <!--- Refine Bedrooms
  <div class="refine-item refine-bedrooms refine-bedrooms-counter-wrap">
    <div class="refine-text">
      <i class="fa fa-bed site-color-1" aria-hidden="true"></i>
      <span class="refine-count">
        <cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms) and session.booking.bedrooms gt 0>
          <cfoutput>#session.booking.bedrooms#</cfoutput>
        <cfelse>
          <cfoutput>#settings.booking.minBed#</cfoutput>
        </cfif>
      </span> Bedrooms
      <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i>
			<cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms) and session.booking.bedrooms gt 0>
				<cfoutput><input type="hidden" name="bedrooms" value="#session.booking.bedrooms#"></cfoutput>
			<cfelse>
			  <cfoutput><input type="hidden" name="bedrooms" value="#settings.booking.minBed#"></cfoutput>
			</cfif>
    </div>
    <div class="refine-dropdown refine-counter text-center">
      <i class="fa fa-minus site-color-2-bg site-color-2-lighten-bg-hover text-white disabled" aria-hidden="true"></i>
      <span class="refine-drop-count" data-min="<cfoutput>#settings.booking.minBed#</cfoutput>" data-max="<cfoutput>#settings.booking.maxBed#</cfoutput>">
        <cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms) and session.booking.bedrooms gt 0>
          <cfoutput>#session.booking.bedrooms#</cfoutput>
        <cfelse>
          <cfoutput>#settings.booking.minBed#</cfoutput>
        </cfif>
      </span>
      <i class="fa fa-plus site-color-2-bg site-color-2-lighten-bg-hover text-white" aria-hidden="true"></i>
      <a href="javascript:;" class="btn btn-block site-color-3-bg site-color-2-bg-hover text-white pull-right refine-close">Close</a>
      <!--- <a href="javascript:;" class="btn btn-block btn-default refine-apply" id="refineBedsCountApply">Apply</a> --->
    </div>
  </div> --->

  <!--- SLIDER VERSION--->
  <!--- Refine Bedrooms --->
  <div class="refine-item refine-bedrooms refine-slider refine-slider-bedrooms-wrap">
    <div class="refine-text">
      <i class="fa fa-bed site-color-1" aria-hidden="true"></i>
      <span class="refine-text-title">Bedrooms</span>
      <span class="refine-min-max hidden">
        <span id="refineBedroomsMin"></span> to <span id="refineBedroomsMax"></span> Bedrooms
      </span>
      <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown">
      <span class="refine-dropdown-title">Bedrooms</span>
      <div class="refine-slider-wrap">
        <div id="refineBedroomsSlider"></div>
				<cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms)>
					<cfoutput><input type="hidden" name="bedrooms" value="#session.booking.bedrooms#"></cfoutput>
				<cfelse>
				  <input type="hidden" name="bedrooms">
				</cfif>
      </div>
      <a href="javascript:;" class="btn btn-default site-color-6-bg-hover pull-left refine-close" id="refineBedroomsClear">Clear</a>
      <a href="javascript:;" class="btn site-color-3-bg site-color-2-bg-hover text-white pull-right refine-close">Close</a>
      <!--- <a href="javascript:;" class="btn btn-default site-color-6-bg-hover pull-right refine-apply" id="refineBedroomsApply">Apply</a> --->
    </div>
  </div>

  <div class="refine-item refine-bathrooms refine-slider refine-slider-bathrooms-wrap">
    <div class="refine-text">
      <i class="fa fa-bath site-color-1" aria-hidden="true"></i>
      <span class="refine-text-title">Bathrooms</span>
      <span class="refine-min-max hidden">
        <span id="refineBathroomsMin"></span> to <span id="refineBathroomsMax"></span> Bathrooms
      </span>
      <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown">
      <span class="refine-dropdown-title">Bathrooms</span>
      <div class="refine-slider-wrap">
        <div id="refineBathroomsSlider"></div>
				<cfif isdefined('session.booking.bathrooms') and len(session.booking.bathrooms)>
					<cfoutput><input type="hidden" name="bathrooms" value="#session.booking.bathrooms#"></cfoutput>
				<cfelse>
				  <input type="hidden" name="bathrooms">
				</cfif>
      </div>
      <a href="javascript:;" class="btn btn-default site-color-6-bg-hover pull-left refine-close" id="refineBathroomsClear">Clear</a>
      <a href="javascript:;" class="btn site-color-3-bg site-color-2-bg-hover text-white pull-right refine-close">Close</a>
      <!--- <a href="javascript:;" class="btn btn-default site-color-6-bg-hover pull-right refine-apply" id="refineBathroomsApply">Apply</a> --->
    </div>
  </div>

  <!--- Refine Price --->
  <div class="refine-item refine-price refine-slider refine-slider-price-wrap">
    <div class="refine-text">
      <i class="fa fa-tag site-color-1" aria-hidden="true"></i>
      <span class="refine-text-title">Price Range</span>
      <span class="refine-min-max hidden">
        $<span id="refinePriceMin"></span> to $<span id="refinePriceMax"></span>
      </span>
      <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown">
      <span class="refine-dropdown-title">Price Range</span>
      <div class="refine-slider-wrap">
        <div id="refinePriceSlider"></div>
				<cfif isdefined('session.booking.rentalRate') and len(session.booking.rentalRate)>
			    <cfoutput><input type="hidden" name="rentalRate" value="#session.booking.rentalRate#"></cfoutput>
				<cfelse>
			    <input type="hidden" name="rentalRate">
				</cfif>
      </div>
      <a href="javascript:;" class="btn btn-default site-color-6-bg-hover pull-left refine-close" id="refinePriceClear">Clear</a>
      <a href="javascript:;" class="btn site-color-3-bg site-color-2-bg-hover text-white pull-right refine-close">Close</a>
      <!--- <a href="javascript:;" class="btn btn-default site-color-6-bg-hover pull-right refine-apply" id="refinePriceApply">Apply</a> --->
    </div>
  </div>

  <!--- Refine More Filters --->
  <div class="refine-item refine-filters">
    <div class="refine-text site-color-3-bg text-white">
      <div rel="tooltip" data-placement="bottom" title="Refine with Advanced Search Filters">
        <i class="fa toggle text-white" aria-hidden="true"></i> Filters <span id="filtersCount"></span> <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i>
      </div>
    </div>
    <div class="refine-filter-box">
      <div class="refine-filter-box-auto">
        <span class="refine-filter-heading site-color-1">Filters</span>

  		  <cfif listlen(settings.booking.typeList)>
  	      <!--- Refine Filter Unit Type --->
  	      <div class="refine-filter-section refine-filter-unit-type">
  	        <span class="refine-filter-heading-sub">
  	          Unit Type
    	        <span class="refine-select-all-wrap">
      	        <input type="checkbox" class="refine-filter-select-all" id="selectAllUnitType">
                <label for="selectAllUnitType" class="select-all">Select All</label>
    	        </span>
    	      </span>
  	        <div class="row">
  	          <cfloop list="#settings.booking.typeList#" index="i">
  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
  		            <cfoutput>
                    <div class="form-group">
                      <cfset cleanTypeID = reReplace(i,'[^A-Za-z0-9]','','all')>

      		            <input class="refine-filter-checkbox" type="checkbox" id="#cleanTypeID#" name="type" value="#i#"
	      		            <cfif isdefined('session.booking.type') and ListFind(session.booking.type,'#i#')>
	      		            	checked="checked"
	      		            </cfif>
      		            >
      		            <label for="#cleanTypeID#">#i# <!--- (#filterCount#) ---></label>
  		            	</div>
  		            </cfoutput>
  		          </div>
  	          </cfloop>
  	        </div>
  	      </div>
        </cfif>

        <cfif listlen(settings.booking.locationList)>
	        <!--- Refine Filter Views --->
	  	      <div class="refine-filter-section refine-filter-area">
	  	        <span class="refine-filter-heading-sub">
	  	          Location
	    	        <span class="refine-select-all-wrap">
	      	        <input type="checkbox" class="refine-filter-select-all" id="selectAllLocations">
	                <label for="selectAllLocations" class="select-all">Select All</label>
	    	        </span>
	    	      </span>
	  	        <div class="row">
	  	          <cfloop list="#settings.booking.locationList#" index="i">
	  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	  		            <cfoutput>
	    		            <div class="form-group">
                        <cfset cleanLocationID = reReplace(i,'[^A-Za-z0-9]','','all')>

                        <input class="refine-filter-checkbox" type="checkbox" id="#cleanLocationID#" name="location" value="#i#"
	      		            	<cfif isdefined('session.booking.location') and ListFind(session.booking.location,'#i#')> checked="checked"</cfif>>
	      		            <label for="#cleanLocationID#">#i# <!--- (#filterCount#) ---></label>
	        		        </div>
	      		        </cfoutput>
	  		          </div>
	  	          </cfloop>
	  	        </div>
	  	      </div>
  	      </cfif>

        <cfif listlen(settings.booking.areaList)>
	        <!--- Refine Filter Views --->
	  	      <div class="refine-filter-section refine-filter-area">
	  	        <span class="refine-filter-heading-sub">
	  	          Area
	    	        <span class="refine-select-all-wrap">
	      	        <input type="checkbox" class="refine-filter-select-all" id="selectAllAreas">
	                <label for="selectAllAreas" class="select-all">Select All</label>
	    	        </span>
	    	      </span>
	  	        <div class="row">
	  	          <cfloop list="#settings.booking.areaList#" index="i">
	  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	  		            <cfoutput>
	    		            <div class="form-group">
                        <cfset cleanAreaID = reReplace(i,'[^A-Za-z0-9]','','all')>

                        <input class="refine-filter-checkbox" type="checkbox" id="#cleanAreaID#" name="area" value="#i#"
	      		            	<cfif isdefined('session.booking.area') and ListFind(session.booking.area,'#i#')> checked="checked"</cfif>>
	      		            <label for="#cleanAreaID#">#i# <!--- (#filterCount#) ---></label>
	        		        </div>
	      		        </cfoutput>
	  		          </div>
	  	          </cfloop>
	  	        </div>
	  	      </div>
  	      </cfif>

  		  <cfif listlen(amenityList)>
  	      <!--- Refine Filter Amenities --->
  	      <div class="refine-filter-section refine-filter-amenities">
  	        <span class="refine-filter-heading-sub">
  	          Amenities
    	        <span class="refine-select-all-wrap">
      	        <input type="checkbox" class="refine-filter-select-all" id="selectAllAmenities">
                <label for="selectAllAmenities" class="select-all">Select All</label>
    	        </span>
  	        </span>
  	        <div class="row">
  	          <cfloop from="1" to="4" index="i">
  		          <cfif listlen(amenityList) GTE i>
	  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	  		            <cfoutput>
	  		            <div class="form-group">
                      <cfset cleanAmenityID = reReplace(ListGetAt(amenityList,i),'[^A-Za-z0-9]','','all')>

	  		            	<input class="refine-filter-checkbox" type="checkbox" id="#cleanAmenityID#" name="amenities" value="#ListGetAt(amenityList,i)#"
	  		            		<cfif
	  		            			(isdefined('session.booking.amenities') and ListFind(session.booking.amenities,'#ListGetAt(amenityList,i)#'))
	  		            			OR
	  		            			(isdefined('session.booking.must_haves') and ListFind(session.booking.must_haves,'#ListGetAt(amenityList,i)#'))
	  		            			> checked="checked"</cfif>>
	    		            <label for="#cleanAmenityID#">#ListGetAt(amenityList,i)# <!--- (#filterCount#) ---></label>
			            	</div>
	  		            </cfoutput>
	  		          </div>
  		          </cfif>
  	          </cfloop>
  	        </div>
  	        <cfif listLen(amenityList) gt 4>
  		        <div class="row hidden">
  		          <cfloop from="5" to="#listLen(amenityList)#" index="i">
  			          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
  			            <cfoutput>
                    <div class="form-group">
  			            	<cfset cleanAmenityID = reReplace(ListGetAt(amenityList,i),'[^A-Za-z0-9]','','all')>

                      <input class="refine-filter-checkbox" type="checkbox" id="#cleanAmenityID#" name="amenities" value="#ListGetAt(amenityList,i)#"
  			            	<cfif
	  		            			(isdefined('session.booking.amenities') and ListFind(session.booking.amenities,'#ListGetAt(amenityList,i)#'))
	  		            			OR
	  		            			(isdefined('session.booking.must_haves') and ListFind(session.booking.must_haves,'#ListGetAt(amenityList,i)#'))
	  		            			> checked="checked"</cfif>>
                      <label for="#cleanAmenityID#">#ListGetAt(amenityList,i)# <!--- (#filterCount#) ---></label>
  			            </div>
  			            </cfoutput>
  			          </div>
  		          </cfloop>
  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
  		            <cfoutput>
                    <div class="form-group">
      		            <input class="refine-filter-checkbox" type="checkbox" id="monthlyRentals" name="monthlyRentals" value="Yes"
	      		            <cfif isdefined('session.booking.monthlyRentals') and session.booking.monthlyRentals EQ "Yes">
	      		            	checked="checked"
	      		            </cfif>
      		            >
      		            <label for="monthlyRentals">Monthly Rentals <!--- (#filterCount#) ---></label>
  		            	</div>
  		            </cfoutput>
  		          </div>

  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
  		            <cfoutput>
                    <div class="form-group">
      		            <input class="refine-filter-checkbox" type="checkbox" id="nightlyRentals" name="nightlyRentals" value="Yes"
	      		            <cfif isdefined('session.booking.nightlyRentals') and session.booking.nightlyRentals EQ "Yes">
	      		            	checked="checked"
	      		            </cfif>
      		            >
      		            <label for="nightlyRentals">Nightly Rentals <!--- (#filterCount#) ---></label>
  		            	</div>
  		            </cfoutput>
  		          </div>
  		        </div>
  		        <a href="javascript:;" class="refine-filter-see-all site-color-1">See all amenities <i class="fa-chevron fa fa-chevron-down" aria-hidden="true"></i></a>
  	        </cfif>
  	      </div>
        </cfif>



        <!--- Refine Filter Specific Property --->
        <div class="refine-filter-section refine-filter-specific-property">
          <span class="refine-filter-heading-sub">Looking for a specific property?<br><small>Search by unit name</small></span>
          <div class="row">
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
              <label>Name:</label>
            </div>
            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
              <label for="rs-unitname" class="hidden">rs-unitname</label>
              <select class="refine-filter-specific-property-select selectpicker" name="unitname" id="rs-unitname">
                <option value="">- Choose One -</option>
                <cfloop query="settings.booking.properties">
                  <cfoutput><option value="/#settings.booking.dir#/#settings.booking.properties.seoPropertyName#">#settings.booking.properties.name#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <!---
          <div class="row">
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
              <label>Number:</label>
            </div>
            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
              <label for="rs-propertyid" class="hidden">rs-propertyid</label>
              <select class="refine-filter-specific-property-select selectpicker" name="propertyid" id="rs-propertyid">
                <option value="">- Choose One -</option>
                <cfloop query="settings.booking.propertiesByID">
                  <cfoutput><option value="/#settings.booking.dir#/#settings.booking.propertiesByID.seoPropertyName#">#settings.booking.propertiesById.propertyid#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          --->
        </div>

      </div>

      <!--- Refine Filter Actions --->
      <div class="refine-filter-action">
        <a href="javascript:;" class="btn site-color-3-bg site-color-2-bg-hover text-white pull-left refine-close">Close</a>
        <a href="javascript:;" class="btn site-color-2-bg site-color-4-bg-hover text-white refine-apply pull-right" id="refineMoreFiltersApply">Apply</a>
      </div>

    </div>
  </div>

  <div class="refine-item refine-apply-item">
    <a href="javascript:;" class="btn site-color-2-bg site-color-4-bg-hover text-white refine-apply-all" id="refineApplyAll">Apply <i class="fa fa-arrow-circle-o-right text-white" aria-hidden="true"></i></a>
  </div>
  <div class="refine-item refine-clear-item">
    <a href="/rentals/results.cfm?all_properties=true" class="btn refine-clear-all text-black">Clear <i class="fa fa-eraser text-black" aria-hidden="true"></i></a>
  </div>

</form>