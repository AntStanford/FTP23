<form class="refine-form mobile-hidden" id="refineForm" method="post" <cfoutput>action="/#settings.mls.dir#/results.cfm"</cfoutput>>

  <!--- Page Count for Infinite Scroll --->
  <input type="hidden" name="page" value="0">
  <input type="hidden" name="camefromsearchform">
  <!--- <input type="hidden" name="mapBounds" id="mapBounds" value=""> --->

  <!--- HIDDEN FIELDS FOR CUSTOM SEARCHES --->
  <cfoutput>
    <!--- mlsid, wsid, kind, area are already in the refine --->
    <cfif isdefined('form.customSearchId') and len(form.customSearchId)>
      <input type="hidden" name="customSearchId" value="#form.customSearchId#">
    <cfelseif isdefined('session.mlssearch.customSearchId') and len(session.mlssearch.customSearchId)>
      <input type="hidden" name="customSearchId" value="#session.mlssearch.customSearchId#">
    </cfif>

    <cfif isdefined('form.lotlocations') and len(form.lotlocations)>
      <input type="hidden" name="lotlocations" value="#form.lotlocations#">
    <cfelseif isdefined('session.mlssearch.lotlocations') and len(session.mlssearch.lotlocations)>
      <input type="hidden" name="lotlocations" value="#session.mlssearch.lotlocations#">
    </cfif>

    <cfif isdefined('form.watertype') and len(form.watertype)>
      <input type="hidden" name="watertype" value="#form.watertype#">
    <cfelseif isdefined('session.mlssearch.watertype') and len(session.mlssearch.watertype)>
      <input type="hidden" name="watertype" value="#session.mlssearch.watertype#">
    </cfif>

    <cfif isdefined('form.amentities') and len(form.amentities)>
      <input type="hidden" name="amentities" value="#form.amentities#">
    <cfelseif isdefined('session.mlssearch.amentities') and len(session.mlssearch.amentities)>
      <input type="hidden" name="amentities" value="#session.mlssearch.amentities#">
    </cfif>
  </cfoutput>

  <!---
  <cfoutput>
    <input type="hidden" value="#settings.mls.mlsid#" name="mlsid"/>
  </cfoutput>
  --->

  <!--- SortBy Hidden Input --->
  <cfif isdefined('session.mlssearch.sortBy') and len(session.mlssearch.sortBy)>
    <cfoutput><input type="hidden" name="sortBy" value="#session.mlssearch.sortBy#"></cfoutput>
  <cfelse>
    <input type="hidden" name="sortBy" value="RAND()">
  </cfif>

  <!--- <div class="refine-item refine-title site-color-1">Search Results</div> --->

  <div id="refineClose" class="refine-close">Hide Filters <i class="fa fa-close"></i></div>
  <!--- Property Types --->
  <div class="refine-item refine-select">
    <select id="wsid" name="wsid" class="selectpicker refine-text" title="Property Types">
      <!--- <option data-hidden="true" value="">Property Types</option> --->
      <option value="">All Types</option>
      <cfloop index="i" list="#application.settings.mls.getmlscoinfo.wsid#">
        <cfoutput>
        <option value="#listgetat(i,'1','~')#" <cfif isdefined('session.mlssearch.wsid') and session.mlssearch.wsid is "#listgetat(i,'1','~')#">selected</cfif>>#listgetat(i,'2','~')#</option>
        </cfoutput>
      </cfloop>
    </select>
  </div>

  <!--- MOVE THIS TO FILTERS???
  <!-- Search By Address -->
  <div class="refine-item refine-search">
    <div class="refine-text nopadding">
      <input type="text" name="quicksearch" placeholder="Address or MLS ID" <cfif isdefined('session.mlssearch.quicksearch')>value="<cfoutput>#session.mlssearch.quicksearch#</cfoutput>"</cfif>>
      <button type="submit" class="btn"><i class="fa fa-search" aria-hidden="true"></i></button>
    </div>
  </div>
  --->

<!--- MOVE THIS TO FILTERS???--->
  <!--- City --->
  <div class="refine-item refine-select">
    <!--- <cfquery datasource="#settings.mls.propertydsn#" name="getareas">
      SELECT *
      FROM masterareas_cleaned
      where mlsid = '#settings.mls.MLSID#'
      order by city
    </cfquery> --->

    <select id="city" name="City" class="selectpicker refine-text" title="Area" multiple <cfif mobiledetect>data-mobile="true"</cfif>>
     <!---  <option data-hidden="true" value="">City</option> --->
      <option value="">All Areas</option>
      <!--- <cfoutput query="getareas"> ---><cfoutput query="settings.mls.getcities">
      <option value="#settings.mls.getcities.city#" <cfif isdefined('session.mlssearch.city') and listFindNoCase(session.mlssearch.city, settings.mls.getcities.city)> selected="selected"</cfif>>#city#</option>
      </cfoutput>
    </select>
  </div>
  <cf_htmlfoot>
    <script>
      $('#city').on('hidden.bs.select', function(){
       if ($("#city").prop("selectedIndex") == 0){
        $("#city").val('default');
        $("#city").selectpicker("refresh");
       };

      });
    </script>
  </cf_htmlfoot>

  <!--- Areas --->
<!---   <div class="refine-item refine-select">
    <select id="area" name="area"  class="selectpicker refine-text" title="Areas" multiple <cfif mobiledetect>data-mobile="true"</cfif>>
      <!--- <option data-hidden="true" value="">Areas</option> (only need title OR this, depending on multiple or not) --->
      <option value="">All Areas</option>
      <cfoutput query="application.settings.mls.getMasterAreas">
        <option value="#application.settings.mls.getMasterAreas.areashidden#" <cfif isdefined('session.mlssearch.area') and listFindNoCase(session.mlssearch.area, application.settings.mls.getMasterAreas.areashidden)> selected="selected"</cfif>>#area#</option>
      </cfoutput>
    </select>
  </div> --->

  <!--- Refine Bedrooms --->
  <div class="refine-item refine-bedrooms refine-bedrooms-counter-wrap">
    <div class="refine-text">
      <i class="fa fa-bed" aria-hidden="true"></i>
      <span class="refine-count">
       <cfif isdefined('session.mlssearch.bedrooms') and len(session.mlssearch.bedrooms)>
         <cfoutput>#session.mlssearch.bedrooms#</cfoutput>
       <cfelse>
         <cfoutput>#application.settings.mls.minmaxes.minbed#</cfoutput>
       </cfif>
     </span> Beds
      <i class="fa fa-chevron-down" aria-hidden="true"></i>

			<cfif isdefined('session.mlssearch.bedrooms') and len(session.mlssearch.bedrooms)>
				<cfoutput><input type="hidden" name="bedrooms" value="#session.mlssearch.bedrooms#"></cfoutput>
			<cfelse>
			  <cfoutput><input type="hidden" name="bedrooms" value="#application.settings.mls.minmaxes.minbed#"></cfoutput>
			</cfif>

    </div>
    <div class="refine-dropdown refine-counter text-center hidden">
      <i class="fa fa-minus site-color-2-bg site-color-2-lighten-bg-hover text-white disabled" aria-hidden="true"></i>
      <span class="refine-drop-count refine-beds" data-min="<cfoutput>#application.settings.mls.minmaxes.minbed#</cfoutput>" data-max="<cfoutput>#application.settings.mls.minmaxes.maxbed#</cfoutput>">

        <cfif isdefined('session.mlssearch.bedrooms') and len(session.mlssearch.bedrooms)>
          <cfoutput>#session.mlssearch.bedrooms#</cfoutput>
        <cfelse>
          <cfoutput>#application.settings.mls.minmaxes.minbed#</cfoutput>
        </cfif>

      </span>
      <i class="fa fa-plus site-color-2-bg site-color-2-lighten-bg-hover text-white" aria-hidden="true"></i>
      <a href="javascript:;" class="btn btn-block btn-sm btn-default text-center refine-apply" id="refineBedsCountApply">Apply</a>
    </div>
  </div>

  <!--- Refine Bathrooms --->
  <div class="refine-item refine-bathrooms refine-bathrooms-counter-wrap">
    <div class="refine-text">
      <i class="fa fa-bath" aria-hidden="true"></i>
      <span class="refine-count">
       <cfif isdefined('session.mlssearch.baths_full') and len(session.mlssearch.baths_full)>
         <cfoutput>#session.mlssearch.baths_full#</cfoutput>
       <cfelse>
         <cfoutput>#application.settings.mls.minmaxes.minbath#</cfoutput>
       </cfif>
     </span> Baths
      <i class="fa fa-chevron-down" aria-hidden="true"></i>

      <cfif isdefined('session.mlssearch.baths_full') and len(session.mlssearch.baths_full)>
        <cfoutput><input type="hidden" name="baths_full" value="#session.mlssearch.baths_full#"></cfoutput>
      <cfelse>
        <cfoutput><input type="hidden" name="baths_full" value="#application.settings.mls.minmaxes.minbath#"></cfoutput>
      </cfif>

    </div>
    <div class="refine-dropdown refine-counter text-center hidden">
      <i class="fa fa-minus site-color-2-bg site-color-2-lighten-bg-hover text-white disabled" aria-hidden="true"></i>
      <span class="refine-drop-count refine-baths" data-min="<cfoutput>#application.settings.mls.minmaxes.minbath#</cfoutput>" data-max="<cfoutput>#application.settings.mls.minmaxes.maxbath#</cfoutput>">

        <cfif isdefined('session.mlssearch.baths_full') and len(session.mlssearch.baths_full)>
          <cfoutput>#session.mlssearch.baths_full#</cfoutput>
        <cfelse>
          <cfoutput>#application.settings.mls.minmaxes.minbath#</cfoutput>
        </cfif>

      </span>
      <i class="fa fa-plus site-color-2-bg site-color-2-lighten-bg-hover text-white" aria-hidden="true"></i>
      <a href="javascript:;" class="btn btn-block btn-sm btn-default text-center refine-apply" id="refineBathsCountApply">Apply</a>
    </div>
  </div>

  <!--- Refine Price --->
  <div class="refine-item refine-price refine-slider-price-wrap">
    <div class="refine-text">
      <i class="fa fa-tag" aria-hidden="true"></i>
      <span class="refine-text-title">Price</span>
      <span class="refine-min-max hidden">
        $<span id="refinePriceMin"></span> to $<span id="refinePriceMax"></span>
      </span>
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown hidden">
      <span class="refine-dropdown-title">Price Range</span>
      <div class="refine-slider-wrap">
        <div id="refinePriceSlider"></div>
				<cfif isdefined('session.mlssearch.listed_price') and len(session.mlssearch.listed_price)>
			    <cfoutput><input type="hidden" name="listed_price" value="#session.mlssearch.listed_price#"></cfoutput>
				<cfelse>
			    <input type="hidden" name="listed_price">
				</cfif>
      </div>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-left refine-close" id="refinePriceClose">Close / Clear</a>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-right refine-apply" id="refinePriceApply">Apply</a>
    </div>
  </div>

  <!--- Refine More Filters --->
  <div class="refine-item refine-filters">
    <div class="refine-text">
      <div rel="tooltip" data-placement="bottom" title="Refine with Advanced Search Filters">
        <i class="fa toggle" aria-hidden="true"></i> More <i class="fa fa-chevron-down" aria-hidden="true"></i>
      </div>
    </div>
    <div class="refine-filter-box hidden">
      <div class="refine-filter-box-auto">
        <span class="refine-filter-heading site-color-1">Filters</span>

<!--- Make this mobile only please --->
        <!--- Other Filters --->
        <div class="refine-filter-section">
          <span class="refine-filter-heading-sub">Search Properties Near You</span>
          <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
              <div class="form-group">
                <input class="refine-filter-checkbox" onclick="getLocation();" type="checkbox" id="nearMe" name="nearMe" value="1" <cfif isdefined('session.mlssearch.nearMe')>checked="checked"</cfif>>
                <label for="nearMe">Yes</label>
              </div>
            </div>
          </div>
        </div>
<!--- /Make this mobile only please --->

        <div class="refine-filter-section">
          <span class="refine-filter-heading-sub">Area</span>
          <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
              <div class="form-group">
                <input class="refine-filter-checkbox" type="checkbox" id="mls_county_Brunswick" name="mls_county" value="Brunswick" <cfif isdefined('session.mlssearch.mls_county') and findNoCase('Brunswick', session.mlssearch.mls_county)>checked="checked"</cfif>>
                <label for="mls_county_Brunswick">Brunswick County</label>
              </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
              <div class="form-group">
                <input class="refine-filter-checkbox" type="checkbox" id="mls_city_Wilmington" name="mls_city" value="Wilmington" <cfif isdefined('session.mlssearch.mls_city') and findNoCase('Wilmington', session.mlssearch.mls_city)>checked="checked"</cfif>>
                <label for="mls_city_Wilmington">Wilmington</label>
              </div>
            </div>
          </div>
        </div>

        <div class="refine-filter-section">
          <span class="refine-filter-heading-sub">Plantation</span>
          <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <div class="form-group">
                <select id="subdivision" name="subdivision" class="selectpicker">
                  <option selected="selected" value="">Any</option>
                  <cfoutput>
                    <cfloop index="i" list="#application.settings.mls.getSubdivisions#">
                      <option value="#i#" <cfif isdefined('session.mlssearch.subdivision') and session.mlssearch.subdivision is i>selected="selected"</cfif>>#i#</option>
                    </cfloop>
                  </cfoutput>
                </select>
              </div>
            </div>
          </div>
        </div>

        <div class="refine-filter-section refine-search-section">
          <span class="refine-filter-heading-sub">Property Specifics</span>
          <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <div class="form-group">
                <label>Street Address or MLS Number</label>
                <input type="text" name="quicksearch" placeholder="Street Address or MLS Number" <cfif isdefined('session.mlssearch.quicksearch') and len(session.mlssearch.quicksearch)><cfoutput>value="#session.mlssearch.quicksearch#"</cfoutput></cfif>>
              </div>
            </div>
            <!---
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
              <div class="form-group">
                <input class="refine-filter-checkbox" type="checkbox" id="frmKind" name="kind" value="condo" <cfif isdefined('session.mlssearch.kind') and findNoCase('condo', session.mlssearch.kind)>checked="checked"</cfif>>
                <label for="frmKind">Condos Only</label>
              </div>
            </div>
            --->
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <div class="form-group">
                <input class="refine-filter-checkbox" type="checkbox" id="frmGolf" name="golf" value="golf" <cfif isdefined('session.mlssearch.golf') and findNoCase('golf', session.mlssearch.golf)>checked="checked"</cfif>>
                <label for="frmGolf">Golf Course</label>
              </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <div class="form-group">
                <!--- <label for="waterViewFront">Water View / Front</label> --->
                <!--- <select id="waterViewFront" name="waterViewFront" class="selectpicker"> --->
                <label for="watertype">Water View / Front</label>
                <select id="watertype" name="watertype" class="selectpicker">
                  <option selected="selected" value="">Any</option>
                  <cfoutput>
                    <cfloop index="i" list="#application.settings.mls.getwatertypes#">
                      <!--- <option value="#i#" <cfif isdefined('session.mlssearch.waterViewFront') and session.mlssearch.waterViewFront is i>selected="selected"</cfif>>#i#</option> --->
                      <option value="#i#" <cfif isdefined('session.mlssearch.watertype') and session.mlssearch.watertype is i>selected="selected"</cfif>>#i#</option>
                    </cfloop>
                  </cfoutput>
                </select>
              </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <div class="form-group">
                <label for="kind">Kind</label>
                <select id="kind" name="kind" class="selectpicker">
                  <option selected="selected" value="">Any</option>
                  <cfoutput>
                    <cfloop index="i" list="#application.settings.mls.getKinds#">
                      <!--- <option value="#i#" <cfif isdefined('session.mlssearch.waterViewFront') and session.mlssearch.waterViewFront is i>selected="selected"</cfif>>#i#</option> --->
                      <option value="#i#" <cfif isdefined('session.mlssearch.kind') and session.mlssearch.kind is i>selected="selected"</cfif>>#i#</option>
                    </cfloop>
                  </cfoutput>
                </select>
              </div>
            </div>
          </div>
        </div>

        <div class="refine-filter-section">
          <span class="refine-filter-heading-sub">Square Footage (Min - Max)</span>
          <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <div class="form-group">
                <label>Sq. Footage Min</label>
                <select id="SQFtMin" name="SQFtMin" class="selectpicker sqfootage">
                  <option selected="selected" value="">Min</option>
                  <cfloop index="i" from="500" to="5000" step="500">
                    <cfoutput>
                      <option value="#i#" <cfif isdefined('session.mlssearch.SQFtMin') and session.mlssearch.SQFtMin is i>selected="selected"</cfif>>#i#</option>
                    </cfoutput>
                  </cfloop>
                  <option value="999999999" <cfif isdefined('session.mlssearch.SQFtMin') and session.mlssearch.SQFtMin is 999999999>selected="selected"</cfif>>5000+</option>
                </select>
              </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <div class="form-group">
                <label>Sq. Footage Max</label>
                <select id="SQFtMax" name="SQFtMax" class="selectpicker sqfootage">
                  <option selected="selected" value="">Min</option>
                  <cfloop index="i" from="500" to="5000" step="500">
                    <cfoutput>
                      <option value="#i#" <cfif isdefined('session.mlssearch.SQFtMax') and session.mlssearch.SQFtMax is i>selected="selected"</cfif>>#i#</option>
                    </cfoutput>
                  </cfloop>
                  <option value="999999999" <cfif isdefined('session.mlssearch.SQFtMax') and session.mlssearch.SQFtMax is 999999999>selected="selected"</cfif>>5000+</option>
                </select>
              </div>
            </div>
          </div>
        </div>

        <div class="refine-filter-section">
          <span class="refine-filter-heading-sub">Days On Market</span>
          <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <div class="form-group">
                <select name="DaysOnMarket" class="selectpicker"> <!---  this value is converted into NumericalDaysOnMarket   --->
                  <option selected="selected" value="">All Days</option>
                  <option value="-1" <cfif isdefined('session.mlssearch.NumericalDaysOnMarket') and session.mlssearch.NumericalDaysOnMarket is -1>selected="selected"</cfif>>1 Day</option>
                  <option value="-7" <cfif isdefined('session.mlssearch.NumericalDaysOnMarket') and session.mlssearch.NumericalDaysOnMarket is -7>selected="selected"</cfif>>7 Days</option>
                  <option value="-14" <cfif isdefined('session.mlssearch.NumericalDaysOnMarket') and session.mlssearch.NumericalDaysOnMarket is -14>selected="selected"</cfif>>14 Days</option>
                  <option value="-30" <cfif isdefined('session.mlssearch.NumericalDaysOnMarket') and session.mlssearch.NumericalDaysOnMarket is -30>selected="selected"</cfif>>30 Days</option>
                </select>
              </div>
            </div>
          </div>
        </div>

        <!--- Other Filters --->
	      <div class="refine-filter-section">
	        <span class="refine-filter-heading-sub">Stipulations</span>
	        <div class="row">
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	            <div class="form-group">
		            <input class="refine-filter-checkbox" type="checkbox" id="stip-foreclosure" name="stipulations" value="foreclosure" <cfif isdefined('session.mlssearch.stipulations') and findNoCase('foreclosure', session.mlssearch.stipulations)>checked="checked"</cfif>>
		            <label for="stip-foreclosure">Foreclosures</label>
  		        </div>
	          </div>
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	            <div class="form-group">
		            <input class="refine-filter-checkbox" type="checkbox" id="stip-short" name="stipulations" value="short" <cfif isdefined('session.mlssearch.stipulations') and findNoCase('short', session.mlssearch.stipulations)>checked="checked"</cfif>>
		            <label for="stip-short">Short Sales</label>
  		        </div>
	          </div>
	        </div>
	      </div>

	      <div class="refine-filter-section">
	        <span class="refine-filter-heading-sub">Listing Company </span>
	        <div class="row">
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	            <div class="form-group">
		            <input class="refine-filter-checkbox" type="radio" id="showlistings-Company" name="showlistings" value="Company" <cfif isdefined('session.mlssearch.showlistings') and findNoCase('Company', session.mlssearch.showlistings)>checked="checked"</cfif>>
		            <cfoutput><label for="showlistings-Company">#settings.company# Listings</label></cfoutput>
  		        </div>
	          </div>
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	            <div class="form-group">
		            <input class="refine-filter-checkbox" type="radio" id="showlistings-all" name="showlistings" value="All" <cfif !isdefined('session.mlssearch.showlistings') or  (isdefined('session.mlssearch.showlistings') and !findNoCase('Company', session.mlssearch.showlistings))>checked="checked"</cfif>>
		            <label for="showlistings-all">All Listings</label>
  		        </div>
	          </div>
	        </div>
	      </div>

	      <div class="refine-filter-section refine-search-section">
	        <span class="refine-filter-heading-sub">Schools</span>
	        <div class="row">
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
	            <div class="form-group">
		            <label for="elementary_school">Elementary Schools</label>
                <select id="elementary_school" name="elementary_school" class="selectpicker">
                  <option selected="selected" value="">Any</option>
                  <cfoutput query="settings.mls.getElementarySchools">
                    <option value="#settings.mls.getElementarySchools.elementary_school#" <cfif isdefined('session.mlssearch.elementary_school') and session.mlssearch.elementary_school is settings.mls.getElementarySchools.elementary_school>selected="selected"</cfif>>#settings.mls.getElementarySchools.elementary_school#</option>
                  </cfoutput>
                </select>
  		        </div>
	          </div>
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
	            <div class="form-group">
		            <label for="middle_school">Middle Schools</label>
                <select id="middle_school" name="middle_school" class="selectpicker">
                  <option selected="selected" value="">Any</option>
                  <cfoutput query="settings.mls.getMiddleSchools">
                    <option value="#settings.mls.getMiddleSchools.middle_school#" <cfif isdefined('session.mlssearch.middle_school') and session.mlssearch.middle_school is settings.mls.getMiddleSchools.middle_school>selected="selected"</cfif>>#settings.mls.getMiddleSchools.middle_school#</option>
                  </cfoutput>
                </select>
  		        </div>
	          </div>
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <div class="form-group">
  	            <label for="high_school">High Schools</label>
                <select id="high_school" name="high_school" class="selectpicker">
                  <option selected="selected" value="">Any</option>
                  <cfoutput query="settings.mls.getHighSchools">
                    <option value="#settings.mls.getHighSchools.high_school#" <cfif isdefined('session.mlssearch.high_school') and session.mlssearch.high_school is settings.mls.getHighSchools.high_school>selected="selected"</cfif>>#settings.mls.getHighSchools.high_school#</option>
                  </cfoutput>
                </select>
  		        </div>
            </div>
	        </div>
	      </div>

        <!--- <cfinclude template="/#settings.mls.dir#/includes/disclaimer.cfm"> --->
      </div><!-- END refine-filter-box-auto -->

      <!--- Refine Filter Actions --->
      <div class="refine-filter-action">
        <a href="javascript:;" class="btn site-color-3-bg site-color-3-lighten-bg-hover text-white refine-close pull-left">Close</a>
        <a href="javascript:;" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white refine-apply pull-right" id="refineMoreFiltersApply">Apply</a>
      </div>

    </div>
  </div>

  <!--- Clear Filters --->

  <div class="refine-item">
    <a href="/mls/results.cfm" class="refine-text site-color-1-bg text-white">
      <!-- <i class="fa fa-eraser text-white" aria-hidden="true"></i> -->
      <span class="refine-text-title">Clear Filters</span>
    </a>
  </div>

</form>