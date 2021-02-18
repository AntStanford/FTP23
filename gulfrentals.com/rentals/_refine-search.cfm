<form class="refine-form mobile-hidden" id="refineForm" method="post" action="/<cfoutput>#settings.booking.dir#</cfoutput>/results.cfm">

  <!--- Page Count for Infinite Scroll --->
  <input type="hidden" name="page" value="0">
  <input type="hidden" name="camefromsearchform">
  <input type="hidden" name="mapBounds" id="mapBounds" value="">

  <!--- flex days - have we "flexed" (clicked a tab link)? this field will be either 'early', 'late', or blank --->
  <input type="hidden" name="flexed" id="flexed" <cfif isDefined('session.booking.flexed') and len(session.booking.flexed)><cfoutput>value="#session.booking.flexed#"</cfoutput></cfif>>

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
        <label for="startDateRefine" class="hidden">startDateRefine</label>
				<cfif isdefined('session.booking.strcheckin') and len(session.booking.strcheckin)>
				  <input type="text" name="strCheckin" id="startDateRefine" placeholder="Arrival" value="<cfoutput>#session.booking.strcheckin#</cfoutput>" readonly class="date-entered">
				<cfelse>
				  <input type="text" name="strCheckin" id="startDateRefine" placeholder="Arrival" value="" readonly>
				</cfif>
      </span>
      <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
      <span class="refine-departure">
        <i class="fa fa-calendar site-color-1" aria-hidden="true"></i>
        <label for="endDateRefine" class="hidden">endDateRefine</label>
				<cfif isdefined('session.booking.strcheckout') and len(session.booking.strcheckout)>
          <input type="text" name="strCheckout" id="endDateRefine" placeholder="Departure" value="<cfoutput>#session.booking.strcheckout#</cfoutput>" readonly class="date-entered">
				<cfelse>
          <input type="text" name="strCheckout" id="endDateRefine" placeholder="Departure" value="" readonly>
				</cfif>
      </span>
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown datepicker-wrap hidden">
      <div id="refineDatepicker"></div>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-left refine-close">Close</a>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-left refine-clear">Clear Dates</a>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-right refine-apply" id="refineDatesApply">Apply</a>
    </div>
  </div>

  <div class="refine-item refine-checkbox">
    <div class="refine-text">
      <cfif isdefined('session.booking.flex_dates') and session.booking.flex_dates eq 'on'>
        <input type="checkbox" id="flexDates" name="flex_dates" checked="checked">
      <cfelse>
        <input type="checkbox" id="flexDates" name="flex_dates">
      </cfif>
      <label for="flexDates" data-toggle="tooltip" data-placement="bottom" title="Search for Flexible Check-in Days">Flexible<span class="break"></span>Check-In</label>
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
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
			<cfif isdefined('session.booking.sleeps') and len(session.booking.sleeps) and session.booking.sleeps gt 0>
				<cfoutput><input type="hidden" name="sleeps" value="#session.booking.sleeps#"></cfoutput>
			<cfelse>
			  <cfoutput><input type="hidden" name="sleeps" value="#settings.booking.minOccupancy#"></cfoutput>
			</cfif>
    </div>
    <div class="refine-dropdown refine-counter text-center hidden">
      <i class="fa fa-minus site-color-2-bg site-color-2-lighten-bg-hover text-white disabled" aria-hidden="true"></i>
      <span class="refine-drop-count" data-min="<cfoutput>#settings.booking.minOccupancy#</cfoutput>" data-max="<cfoutput>#settings.booking.maxOccupancy#</cfoutput>">
        <cfif isdefined('session.booking.sleeps') and len(session.booking.sleeps) and session.booking.sleeps gt 0>
          <cfoutput>#session.booking.sleeps#</cfoutput>
        <cfelse>
          <cfoutput>#settings.booking.minOccupancy#</cfoutput>
        </cfif>
      </span>
      <i class="fa fa-plus site-color-2-bg site-color-2-lighten-bg-hover text-white" aria-hidden="true"></i>
      <a href="javascript:;" class="btn btn-block btn-sm btn-default text-center refine-apply" id="refineGuestsCountApply">Apply</a>
    </div>
  </div>

  <!--- Refine Bedrooms --->
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
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
			<cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms) and session.booking.bedrooms gt 0>
				<cfoutput><input type="hidden" name="bedrooms" value="#session.booking.bedrooms#"></cfoutput>
			<cfelse>
			  <cfoutput><input type="hidden" name="bedrooms" value="#settings.booking.minBed#"></cfoutput>
			</cfif>
    </div>
    <div class="refine-dropdown refine-counter text-center hidden">
      <i class="fa fa-minus site-color-2-bg site-color-2-lighten-bg-hover text-white disabled" aria-hidden="true"></i>
      <span class="refine-drop-count" data-min="<cfoutput>#settings.booking.minBed#</cfoutput>" data-max="<cfoutput>#settings.booking.maxBed#</cfoutput>">
        <cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms) and session.booking.bedrooms gt 0>
          <cfoutput>#session.booking.bedrooms#</cfoutput>
        <cfelse>
          <cfoutput>#settings.booking.minBed#</cfoutput>
        </cfif>
      </span>
      <i class="fa fa-plus site-color-2-bg site-color-2-lighten-bg-hover text-white" aria-hidden="true"></i>
      <a href="javascript:;" class="btn btn-block btn-sm btn-default text-center refine-apply" id="refineBedsCountApply">Apply</a>
    </div>
  </div>

  <!--- SLIDER VERSION
  <!--- Refine Bedrooms --->
  <div class="refine-item refine-bedrooms refine-slider refine-slider-bedrooms-wrap">
    <div class="refine-text">
      <i class="fa fa-bed site-color-1" aria-hidden="true"></i>
      <span class="refine-text-title">Bedrooms</span>
      <span class="refine-min-max hidden">
        <span id="refineBedroomsMin"></span> to <span id="refineBedroomsMax"></span> Bedrooms
      </span>
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown hidden">
      <span class="refine-dropdown-title">Bedrooms</span>
      <div class="refine-slider-wrap">
        <div id="refineBedroomsSlider"></div>
				<cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms)>
					<cfoutput><input type="hidden" name="bedrooms" value="#session.booking.bedrooms#"></cfoutput>
				<cfelse>
				  <input type="hidden" name="bedrooms">
				</cfif>
      </div>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-left refine-close" id="refineBedroomsClose">Close / Clear</a>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-right refine-apply" id="refineBedroomsApply">Apply</a>
    </div>
  </div>
  --->

  <!--- Refine Price --->
  <!---<div class="refine-item refine-price refine-slider refine-slider-price-wrap">
    <div class="refine-text">
      <i class="fa fa-tag site-color-1" aria-hidden="true"></i>
      <span class="refine-text-title">Price Range</span>
      <span class="refine-min-max hidden">
        $<span id="refinePriceMin"></span> to $<span id="refinePriceMax"></span>
      </span>
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown hidden">
      <span class="refine-dropdown-title">Price Range</span>
      <div class="refine-slider-wrap">
        <div id="refinePriceSlider"></div>
				<cfif isdefined('session.booking.rentalRate') and len(session.booking.rentalRate)>
			    <cfoutput><input type="hidden" name="rentalRate" value="#session.booking.rentalRate#"></cfoutput>
				<cfelse>
			    <input type="hidden" name="rentalRate">
				</cfif>
      </div>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-left refine-close" id="refinePriceClose">Close / Clear</a>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-right refine-apply" id="refinePriceApply">Apply</a>
    </div>
  </div>--->

  <!--- Refine More Filters --->
  <div class="refine-item refine-filters <cfif structkeyexists(url,'advanced-search')>active</cfif>">
    <div class="refine-text site-color-3-bg text-white">
      <div rel="tooltip" data-placement="bottom" title="Refine with Advanced Search Filters">
        <i class="fa toggle text-white" aria-hidden="true"></i> Filters <span id="filtersCount"></span> <i class="fa fa-chevron-down" aria-hidden="true"></i>
      </div>
    </div>
    <div class="refine-filter-box <cfif !structkeyexists(url,'advanced-search')>hidden</cfif>">
      <div class="refine-filter-box-auto">
        <span class="refine-filter-heading site-color-1">Filters</span>

          <!--- Other Filters --->
  	      <!---<div class="refine-filter-section refine-filter-area">
  	        <span class="refine-filter-heading-sub">Other Filters</span>
  	        <div class="row">
  	          <cfloop list="#otherFilters#" index="i">
  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
  		            <cfoutput>
    		            <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
    		            	<!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(i,'other')> --->
      		            <input class="refine-filter-checkbox" type="checkbox" id="#i#" name="must_haves" value="#i#"
      		            	<cfif isdefined('session.booking.must_haves') and ListFind(session.booking.must_haves,'#i#')> checked="checked"</cfif>>
      		            <label for="#i#">#i# <!--- (#filterCount#) ---></label>
        		        </div>
      		        </cfoutput>
  		          </div>
  	          </cfloop>
  	        </div>
  	      </div>--->

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
	  		            <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
	  		            	<!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(ListGetAt(amenityList,i),'amenity')> --->
                      <cfset cleanAmenityID = reReplace(ListGetAt(amenityList,i),'[^A-Za-z0-9]','','all')>

	  		            	<input class="refine-filter-checkbox" type="checkbox" id="#cleanAmenityID#" name="amenities" value="#ListGetAt(amenityListIDs,i)#"
	  		            		<cfif
	  		            			(isdefined('session.booking.amenities') and ListFind(session.booking.amenities,'#ListGetAt(amenityListIDs,i)#'))
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
                    <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
  			            	<!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(ListGetAt(amenityList,i),'amenity')> --->
                      <cfset cleanAmenityID = reReplace(ListGetAt(amenityList,i),'[^A-Za-z0-9]','','all')>

  			            	<input class="refine-filter-checkbox" type="checkbox" id="#cleanAmenityID#" name="amenities" value="#ListGetAt(amenityListIDs,i)#"
  			            	<cfif
	  		            			(isdefined('session.booking.amenities') and ListFind(session.booking.amenities,'#ListGetAt(amenityListIDs,i)#'))
	  		            			OR
	  		            			(isdefined('session.booking.must_haves') and ListFind(session.booking.must_haves,'#ListGetAt(amenityList,i)#'))
	  		            			> checked="checked"</cfif>>
                      <label for="#cleanAmenityID#">#ListGetAt(amenityList,i)# <!--- (#filterCount#) ---></label>
  			            </div>
  			            </cfoutput>
  			          </div>
  		          </cfloop>
  		        </div>
  		        <a href="javascript:;" class="refine-filter-see-all site-color-1">See all amenities <i class="fa fa-chevron-down" aria-hidden="true"></i></a>
  	        </cfif>
  	      </div>
        </cfif>

        <cfif listlen(amenitySubList)>
          <!--- Refine Filter Amenities --->
          <div class="refine-filter-section refine-filter-amenities">
            <span class="refine-filter-heading-sub">
              Subdivision
              <span class="refine-select-all-wrap">
                <input type="checkbox" class="refine-filter-select-all" id="selectAllAmenitiesSubs">
                <label for="selectAllAmenitiesSubs" class="select-all">Select All</label>
              </span>
            </span>

            <div class="row">
              <cfloop from="1" to="5" index="i">
                <cfif listlen(amenitySubList) GTE i>
                  <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <cfoutput>
                      <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
                        <!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(ListGetAt(amenityList,i),'amenity')> --->
                        <cfset cleanAmenityID = reReplace(ListGetAt(amenitySubList,i),'[^A-Za-z0-9]','','all')>

                        <input class="refine-filter-checkbox" type="checkbox" id="#cleanAmenityID#" name="amenities" value="#ListGetAt(amenitySubListIDs,i)#"
                          <cfif
                            (isdefined('session.booking.amenities') and ListFind(session.booking.amenities,'#ListGetAt(amenitySubListIDs,i)#'))
                            OR
                            (isdefined('session.booking.must_haves') and ListFind(session.booking.must_haves,'#ListGetAt(amenitySubListIDs,i)#'))
                            > checked="checked"</cfif>>
                        <label for="#cleanAmenityID#">#ListGetAt(amenitySubList,i)# <!--- (#filterCount#) ---></label>
                      </div>
                    </cfoutput>
                  </div>
                </cfif>
              </cfloop>
            </div>
          </div>
        </cfif>

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
                    <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
    		            	<!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(i,'type')> --->
                      <cfset cleanTypeID = reReplace(i,'[^A-Za-z0-9]','','all')>

      		            <input class="refine-filter-checkbox" type="checkbox" id="#cleanTypeID#" name="type" value="#i#"
	      		            <cfif isdefined('session.booking.must_haves') and ListFind(session.booking.must_haves,'#i#')>
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

        <cfif listlen(settings.booking.viewList)>
	        <!--- Refine Filter Views --->
	  	      <div class="refine-filter-section refine-filter-area">
	  	        <span class="refine-filter-heading-sub">
	  	          View
	    	        <span class="refine-select-all-wrap">
	      	        <input type="checkbox" class="refine-filter-select-all" id="selectAllViews">
	                <label for="selectAllViews" class="select-all">Select All</label>
	    	        </span>
	    	      </span>
	  	        <div class="row">
	  	          <cfloop list="#settings.booking.viewList#" index="i">
	  		          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	  		            <cfoutput>
	    		            <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
	    		            	<!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(i,'view')> --->
                        <cfset cleanViewID = reReplace(i,'[^A-Za-z0-9]','','all')>

	      		            <input class="refine-filter-checkbox" type="checkbox" id="#cleanViewID#" name="view" value="#i#"
	      		            	<cfif isdefined('session.booking.must_haves') and ListFind(session.booking.must_haves,'#i#')> checked="checked"</cfif>>
	      		            <label for="#cleanViewID#">#i# <!--- (#filterCount#) ---></label>
	        		        </div>
	      		        </cfoutput>
	  		          </div>
	  	          </cfloop>
	  	        </div>
	  	      </div>
          </cfif>
          
          <cfif listlen(settings.booking.locationList)>
            <!--- Refine Filter Views --->
              <div class="refine-filter-section refine-filter-location">
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
                        <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
                          <!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(i,'view')> --->
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

            <cfif listlen(settings.booking.NeighborhoodList)>
              <!--- Refine Filter Views --->
                <div class="refine-filter-section refine-filter-neighborhood">
                  <span class="refine-filter-heading-sub">
                    Neighborhood
                    <span class="refine-select-all-wrap">
                      <input type="checkbox" class="refine-filter-select-all" id="selectAllNeighborhoods">
                      <label for="selectAllNeighborhoods" class="select-all">Select All</label>
                    </span>
                  </span>
                  <div class="row">
                    <cfloop list="#settings.booking.NeighborhoodList#" index="i">
                      <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                        <cfoutput>
                          <div class="form-group"><!--- 2018-11-08 - hiding filtercount per A.Doute & J.Norman --->
                            <!--- <cfset filterCount = application.bookingObject.getSearchFilterCount(i,'view')> --->
                            <cfset cleanNeighborhoodID = reReplace(i,'[^A-Za-z0-9]','','all')>
    
                            <input class="refine-filter-checkbox" type="checkbox" id="#cleanNeighborhoodID#" name="Neighborhood" value="#i#"
                              <cfif isdefined('session.booking.Neighborhood') and ListFind(session.booking.Neighborhood,'#i#')> checked="checked"</cfif>>
                            <label for="#cleanNeighborhoodID#">#i# <!--- (#filterCount#) ---></label>
                          </div>
                        </cfoutput>
                      </div>
                    </cfloop>
                  </div>
                </div>
              </cfif>

        <!--- Refine Filter Specific Property --->
        <div class="refine-filter-section refine-filter-specific-property">
          <span class="refine-filter-heading-sub">Looking for a specific property?<br><small>Search by unit name or number.</small></span>
          <div class="row">
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
              <label>Name:</label>
            </div>
            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
              <label for="re-unitname" class="hidden">re-unitname</label>
              <select class="refine-filter-specific-property-select selectpicker" name="unitname" id="re-unitname">
                <option value="">- Choose One -</option>
                <cfloop query="settings.booking.properties">
                  <cfoutput><option value="/#settings.booking.dir#/#settings.booking.properties.seoPropertyName#">#settings.booking.properties.name#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <!---<div class="row">
            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
              <label>Number:</label>
            </div>
            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
              <label for="re-propertyid" class="hidden">re-propertyid</label>
              <select class="refine-filter-specific-property-select selectpicker" name="propertyid" id="re-propertyid">
                <option value="">- Choose One -</option>
                <cfloop query="settings.booking.propertiesByID">
                  <cfoutput><option value="/#settings.booking.dir#/#settings.booking.propertiesByID.seoPropertyName#">#settings.booking.propertiesById.propertyid#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>--->
        </div>

      </div>

      <!--- Refine Filter Actions --->
      <div class="refine-filter-action">
        <a href="javascript:;" class="btn site-color-3-bg site-color-3-lighten-bg-hover text-white refine-close pull-left">Close</a>
        <a href="javascript:;" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white refine-apply pull-right" id="refineMoreFiltersApply">Apply</a>
      </div>

    </div>
  </div>

  <div class="refine-item refine-clear-filters-wrap">
    <a href="/<cfoutput>#settings.booking.dir#</cfoutput>/results?all_properties=true" class="btn refine-clear-all text-black">Clear <i class="fa fa-recycle text-black" aria-hidden="true"></i></a>
  </div>
</form>