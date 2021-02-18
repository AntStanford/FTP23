<form class="refine-form mobile-hidden" id="refineForm" method="post" <cfoutput>action="/#settings.mls.dir#/results"</cfoutput>><!--- removed .cfm --->

  <!--- Page Count for Infinite Scroll --->
  <input type="hidden" name="page" value="0">
  <input type="hidden" name="camefromsearchform">
  <input type="hidden" name="mapBounds" id="mapBounds" value="">

  <!--- HIDDEN FIELDS FOR CUSTOM SEARCHES --->
  <cfoutput>
    <!--- mlsid, wsid, kind, area are already in the refine --->
    <cfif isdefined('form.customSearchId') and len(form.customSearchId)>
      <input type="hidden" name="customSearchId" value="#form.customSearchId#">
    <cfelseif isdefined('session.mlssearch.customSearchId') and len(session.mlssearch.customSearchId)>
      <input type="hidden" name="customSearchId" value="#session.mlssearch.customSearchId#">
    </cfif>

    <cfif isdefined('form.neighborhoodId') and len(form.neighborhoodId)>
      <input type="hidden" name="neighborhoodId" value="#form.neighborhoodId#">
    <cfelseif isdefined('session.mlssearch.neighborhoodId') and len(session.mlssearch.neighborhoodId)>
      <input type="hidden" name="neighborhoodId" value="#session.mlssearch.neighborhoodId#">
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

    <cfif isdefined('form.new_construction') and len(form.new_construction)>
      <input type="hidden" name="new_construction" value="#form.new_construction#">
    <cfelseif isdefined('session.mlssearch.new_construction') and len(session.mlssearch.new_construction)>
      <input type="hidden" name="new_construction" value="#session.mlssearch.new_construction#">
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

  <!--- Property Types --->
  <div class="refine-item refine-select">
    <select id="wsid" name="wsid" title="Property Types" class="selectpicker refine-text">
      <option data-hidden="true" value="">Property Types</option>
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

<!--- MOVE THIS TO FILTERS???
  <!--- City --->
  <div class="refine-item refine-select">
    <cfquery datasource="#settings.mls.propertydsn#" name="getareas">
      SELECT *
      FROM masterareas_cleaned
      where mlsid = '#settings.mls.MLSID#'
      order by city
    </cfquery>

    <select id="city" name="City" class="selectpicker refine-text">
      <option data-hidden="true" value="">City</option>
      <option value="">All Cities</option>
      <cfoutput query="getareas">
      <option value="#city#,"
        <cfif isdefined('session.mlssearch.city') and LEN(session.mlssearch.city)>
          <cfloop index="i" list="#session.mlssearch.city#" delimiters=",">
            <cfif LEFT(i,1) eq ','><cfset cleanedcity = RemoveChars(i, 1, 1)><cfelse><cfset cleanedcity = i></cfif>
           <cfif city eq cleanedcity>SELECTED</cfif>
          </cfloop>
        </cfif>
      >#city#</option>
      </cfoutput>
    </select>
  </div>
--->

  <!--- Areas --->
  <div class="refine-item refine-select">
    <select id="city" name="City" title="City" class="selectpicker refine-text">
      <option data-hidden="true" value="">City</option>
      <option value="">All Cities</option>
      <cfoutput query="application.settings.mls.getCities">
      <option value="#city#,"
        <cfif isdefined('session.mlssearch.city') and LEN(session.mlssearch.city)>
          <cfloop index="i" list="#session.mlssearch.city#" delimiters=",">
            <cfif LEFT(i,1) eq ','><cfset cleanedcity = RemoveChars(i, 1, 1)><cfelse><cfset cleanedcity = i></cfif>
           <cfif city eq cleanedcity>SELECTED</cfif>
          </cfloop>
        </cfif>
      >#city#</option>
      </cfoutput>
    </select>
  </div>

  <!--- <cfif cgi.remote_addr eq "216.99.119.254" or cgi.remote_addr eq "70.40.111.48" or cgi.remote_addr eq "66.56.226.129"> --->

  <!--- Refine Bedrooms --->
  <div class="refine-item refine-select refine-beds">
    <select id="bedrooms" name="bedrooms" title="Beds" class="selectpicker refine-text">
      <option data-hidden="true" value="">Beds</option>
      <option value="">All</option>
      <cfloop from="#application.settings.mls.minmaxes.minbed#" to="#application.settings.mls.minmaxes.maxbed#" index="i">
        <cfoutput>
          <option value="#i#"<cfif isdefined('session.mlssearch.bedrooms') and session.mlssearch.bedrooms is i> selected="selected"</cfif>>#i#+ Beds</option>
        </cfoutput>
      </cfloop>
    </select>
  </div>

<!--- <cfelse>

  <!--- Refine Bedrooms --->
  <div class="refine-item refine-bedrooms">
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
      <a href="javascript:;" class="btn btn-block btn-sm btn-default text-center refine-apply" id="refineBedsApply">Apply</a>
    </div>
  </div>

</cfif> ---><!--- ip filter if --->

<!--- <cfif cgi.remote_addr eq "216.99.119.254" or cgi.remote_addr eq "70.40.111.48" or cgi.remote_addr eq "66.56.226.129"> --->

  <!--- Refine Bedrooms --->
  <div class="refine-item refine-select refine-baths">
    <select id="baths_full" name="baths_full" title="Baths" class="selectpicker refine-text">
      <option data-hidden="true" value="">Baths</option>
      <option value="">All</option>
      <cfloop from="#application.settings.mls.minmaxes.minbath#" to="#application.settings.mls.minmaxes.maxbath#" index="i">
        <cfoutput>
          <option value="#i#"<cfif isdefined('session.mlssearch.baths_full') and session.mlssearch.baths_full is i> selected="selected"</cfif>>#i#+ Baths</option>
        </cfoutput>
      </cfloop>
    </select>
  </div>

<!--- <cfelse>

  <!--- Refine Bathrooms --->
  <div class="refine-item refine-bathrooms">
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
      <a href="javascript:;" class="btn btn-block btn-sm btn-default text-center refine-apply" id="refineBathsApply">Apply</a>
    </div>
  </div>

</cfif> ---><!--- ip filter if --->

<!--- <cfif cgi.remote_addr eq "216.99.119.254" or cgi.remote_addr eq "70.40.111.48" or cgi.remote_addr eq "66.56.226.129"> --->

  <!--- Refine Price --->
  <div class="refine-item refine-price">
    <div class="refine-text">
      <i class="fa fa-tag site-color-1" aria-hidden="true"></i>
      <span class="refine-text-title <cfif isdefined('session.mlssearch.pmin') and len(session.mlssearch.pmin) and session.mlssearch.pmin is not 0>hidden</cfif>">Price</span>
      <span class="refine-min-max <cfif isdefined('session.mlssearch.pmin') and len(session.mlssearch.pmin) and session.mlssearch.pmin is 0>hidden</cfif>">
        $<span id="refinePriceMin">
          <cfoutput>
            <cfif isdefined('session.mlssearch.pmin') and len(session.mlssearch.pmin) and  session.mlssearch.pmin is not 0>
              #trim(numberformat(session.mlssearch.pmin,'__,___,___'))#
            <cfelse>
              #trim(numberformat(application.settings.mls.pricerangemin,'__,___,___'))#
            </cfif>
          </cfoutput>
        </span> to $
        <span id="refinePriceMax">
          <cfoutput>
            <cfif isdefined('session.mlssearch.pmax') and len(session.mlssearch.pmax) and  session.mlssearch.pmax is not 999999999>
              #trim(numberformat(session.mlssearch.pmax,'__,___,___'))#
            <cfelse>
              #trim(numberformat(application.settings.mls.pricerangemax,'__,___,___'))#
            </cfif>
          </cfoutput>
        </span>
      </span>
      <i class="fa fa-chevron-down" aria-hidden="true"></i>
    </div>
    <div class="refine-dropdown hidden">
      <span class="refine-dropdown-title">Price Range</span>

      <div class="refine-selects">
        <label for="pmin">Minimum Price
          <select id="pmin" name="pmin" class="selectpicker">
            <option value="0" <cfif isdefined('session.mlssearch.pmin') is "No">selected</cfif>>No Min</option>
            <cfloop index="i" from="#application.settings.mls.pricerangemin#" to="#application.settings.mls.pricerangemax#" step="#application.settings.mls.incrementpricerange#">
              <cfoutput>
                <option value="#i#" <cfif isdefined('session.mlssearch.pmin') and session.mlssearch.pmin is i> selected="selected"</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#application.settings.mls.pricerangemax#" step="#application.settings.mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#" <cfif isdefined('session.mlssearch.pmin') and session.mlssearch.pmin is i> selected="selected"</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                </cfloop>
                <cfbreak>
              </cfif>
            </cfloop>
          </select>
        </label>

        <label for="pmax">Maximum Price
          <select id="pmax" name="pmax" class="selectpicker">
            <cfloop index="i" from="#application.settings.mls.pricerangemin#" to="#application.settings.mls.pricerangemax#" step="#application.settings.mls.incrementpricerange#">
              <cfoutput>
                <option value="#i#" <cfif isdefined('session.mlssearch.pmax') and session.mlssearch.pmax is i> selected="selected"</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#application.settings.mls.pricerangemax#" step="#application.settings.mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#"  <cfif isdefined('session.mlssearch.pmax') and session.mlssearch.pmax is i> selected="selected"</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                </cfloop>
                <cfbreak>
              </cfif>
            </cfloop>
            <option value="999999999" <cfif (!isdefined('session.mlssearch.pmax')) or session.mlssearch.pmax is 999999999 or len(trim(session.mlssearch.pmax)) is 0>selected="selected"</cfif>>No Max</option>
          </select>
        </label>
      </div>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-left refine-close" id="refinePriceClose">Close</a>
      <a href="javascript:;" class="btn btn-sm btn-default text-center pull-right refine-apply" id="refinePriceApply">Apply</a>
    </div>
  </div>

<!--- <cfelse>

  <!--- Refine Price --->
  <div class="refine-item refine-price">
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

</cfif><!--- ip filter if ---> --->

  <!--- Refine More Filters --->
  <div class="refine-item refine-filters">
    <div class="refine-text site-color-3-bg text-white">
      <div rel="tooltip" data-placement="bottom" title="Refine with Advanced Search Filters">
        <i class="fa toggle text-white" aria-hidden="true"></i> Filters <span id="filtersCount"></span> <i class="fa fa-chevron-down" aria-hidden="true"></i>
      </div>
    </div>
    <div class="refine-filter-box hidden">
      <div class="refine-filter-box-auto">
        <span class="refine-filter-heading site-color-1">Filters</span>

        <!--- Other Filters --->
	      <!---<div class="refine-filter-section">
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
	      </div>--->

	      <div class="refine-filter-section">
	        <span class="refine-filter-heading-sub">Listing Company</span>
	        <div class="row">
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	            <div class="form-group">
		            <input class="refine-filter-checkbox" type="radio" id="showlistings-Company" name="showlistings" value="Company" <cfif isdefined('session.mlssearch.showlistings') and findNoCase('Company', session.mlssearch.showlistings)>checked="checked"</cfif>>
		            <label for="showlistings-Company"><cfoutput>#settings.company#</cfoutput> Listings</label>
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

	      <!---<div class="refine-filter-section">
	        <span class="refine-filter-heading-sub">Days On Market</span>
	        <div class="row">
	          <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
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
	      </div>--->

	      <div class="refine-filter-section">
	        <span class="refine-filter-heading-sub">Square Footage (Min - Max)</span>
	        <div class="row">
	          <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <div class="form-group-wrap">
		            <div class="form-group">
  		            <label>Sq. Footage Min</label>
                  <select id="SQFtMin" name="SQFtMin" class="selectpicker">
                    <option selected="selected" value="">Min</option>
                    <cfloop index="i" from="500" to="5000" step="500">
                      <cfoutput>
                        <option value="#i#" <cfif isdefined('session.mlssearch.SQFtMin') and session.mlssearch.SQFtMin is i>selected="selected"</cfif>>#i#</option>
                      </cfoutput>
                    </cfloop>
                    <option value="999999999" <cfif isdefined('session.mlssearch.SQFtMin') and session.mlssearch.SQFtMin is 999999999>selected="selected"</cfif>>5000+</option>
                  </select>
    		        </div>
                <div class="dash"><span>&dash;</span></div>
		            <div class="form-group">
  		            <label>Sq. Footage Max</label>
                  <select id="SQFtMax" name="SQFtMax" class="selectpicker">
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
	      </div>

	      <div class="refine-filter-section refine-search-section">
	        <span class="refine-filter-heading-sub">Property Specifics</span>
	        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <div class="form-group input-group">
                <label>Street Address or MLS Number</label>
                <input type="text" name="quicksearch" placeholder="Street Address or MLS Number" <cfif isdefined('session.mlssearch.quicksearch') and len(session.mlssearch.quicksearch)><cfoutput>value="#session.mlssearch.quicksearch#"</cfoutput></cfif>>
              </div>
            </div>
            <!---
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <div class="form-group">
                <label>Subdivision</label>
                <select id="subdivision" name="subdivision" class="selectpicker" data-live-search="true">
                  <option value="">Any</option>
                  <cfoutput>
                    <cfloop query="settings.mls.getSubdivisions">
                      <option value="#subdivision#" <cfif isdefined('session.mlssearch.subdivision') and session.mlssearch.subdivision is subdivision>selected="selected"</cfif>>#subdivision#</option>
                    </cfloop>
                  </cfoutput>
                </select>
              </div>
            </div>
            --->
            <!---<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <div class="form-group">
                <label for="waterViewFront">Water View / Front</label>
                <select id="waterViewFront" name="waterViewFront" class="selectpicker">
                  <option selected="selected" value="">Any</option>
                  <cfoutput>
                    <cfloop index="i" list="#application.settings.mls.watertypes#">
                      <option value="#i#" <cfif isdefined('session.mlssearch.waterViewFront') and session.mlssearch.waterViewFront is i>selected="selected"</cfif>>#i#</option>
                    </cfloop>
                  </cfoutput>
                </select>
              </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
              <div class="form-group">
                <input class="refine-filter-checkbox" type="checkbox" id="frmKind" name="kind" value="condo" <cfif isdefined('session.mlssearch.kind') and findNoCase('condo', session.mlssearch.kind)>checked="checked"</cfif>>
                <label for="frmKind">Condos Only</label>
              </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
              <div class="form-group">
                <input class="refine-filter-checkbox" type="checkbox" id="frmGolf" name="golf" value="golf" <cfif isdefined('session.mlssearch.golf') and findNoCase('golf', session.mlssearch.golf)>checked="checked"</cfif>>
                <label for="frmGolf">Golf Course</label>
              </div>
            </div>--->
          </div>
	      </div>

	      <!---<div class="refine-filter-section refine-search-section">
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
	      </div>--->

        <!--- <cfinclude template="/#settings.mls.dir#/includes/disclaimer.cfm"> --->

      </div><!-- END refine-filter-box-auto -->

      <!--- Refine Filter Actions --->
      <div class="refine-filter-action">
        <a href="javascript:;" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white refine-close pull-left">Close</a>
        <a href="javascript:;" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white refine-apply pull-right" id="refineMoreFiltersApply">Apply</a>
      </div>

    </div>
  </div>

  <!--- Clear Filters --->
  <div class="refine-item">
    <a href="/mls/results" class="btn refine-clear-all text-black">
      Clear <i class="fa fa-recycle text-black" aria-hidden="true"></i>
    </a>
    <!---
    <a href="/mls/results" class="refine-text"><!--- removed .cfm --->
      <i class="fa fa-eraser text-white" aria-hidden="true"></i>
      <span class="refine-text-title">Clear</span>
    </a>
    --->
  </div>

</form>