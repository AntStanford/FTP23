<!--- 2017-2019 TEMPLATE --->
<!--- Get the popular searches --->
<cfquery name="getPopularSearches" dataSource="#settings.dsn#">
	select slug,name,popularSearchPhoto from cms_pages where popularSearch = 'Yes'
</cfquery>

<!--- Set some defaults just in case --->
<cfif !isdefined('settings.booking.minOccupancy') or settings.booking.minOccupancy eq ''>
  <cfset settings.booking.minOccupancy = 1>
  <cfset settings.booking.maxOccupancy = 10>
  <cfset settings.booking.minbed = 1>
  <cfset settings.booking.maxbed = 10>
</cfif>

<div class="container i-quick-search" id="quickSearch">
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item active"><a href="#bookingSearch" class="nav-link" id="bookingSearchTab" aria-controls="bookingSearch" role="tab" data-toggle="tab" aria-selected="true">Start Your Adventure Now!</a></li>
    <cfif getPopularSearches.recordcount gt 0>
    	<li class="nav-item"><a href="#popularSearches" class="nav-link" id="popularSearchesTab" aria-controls="popularSearches" role="tab" data-toggle="tab" aria-selected="false">Popular Searches</a></li>
    </cfif>
  	<li class="nav-item"><a href="#mlsSearch" class="nav-link" id="mlsSearchTab" aria-controls="mlsSearch" role="tab" data-toggle="tab" aria-selected="true">Find Your Home Now!</a></li>
  </ul>
  <div class="tab-content" id="qs-TabContent">
    <div class="tab-pane active" id="bookingSearch" role="tabpanel" aria-labelledby="bookingSearchTab">
      <cfoutput><form method="post" action="/rentals/results"></cfoutput>
       <input type="hidden" name="camefromsearchform">
        <div class="row">

          <div class="col">
            <!--- Search Dates --->
            <div class="search-dates">
              <div class="search-text">
                <span class="search-arrival" id="searchArrival">
                  <label>Arrival</label>
        				  <input type="text" name="strCheckin" id="start-date" placeholder="Arrival" value="" readonly>
                </span>
                <span class="search-departure" id="searchDeparture">
                  <label>Departure</label>
                  <input type="text" name="strCheckout" id="end-date" placeholder="Departure" value="" readonly>
                </span>
              </div>
              <div class="datepicker-wrap hidden">
                <div id="searchDatepicker"></div>
                <a href="javascript:;" class="btn text-center float-left search-clear">Clear Dates</a>
                <a href="javascript:;" class="btn text-center float-right search-close">Close</a>
              </div>
            </div><!-- END search-dates -->
          </div>
          <div class="col">
            <div class="select-wrap">
              <select class="selectpicker" data-size="6" name="sleeps" title="Guests">
                <option data-hidden="true" value="">Guests</option>
                <cfloop from="#settings.booking.minOccupancy#" to="#settings.booking.maxOccupancy#" index="i">
                  <cfoutput><option value="#i#">#i#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="col">
            <div class="select-wrap">
              <select class="selectpicker" data-size="6" name="bedrooms" title="Bedrooms">
                <option data-hidden="true" value="">Bedrooms</option>
                <cfloop from="#settings.booking.minbed#" to="#settings.booking.maxbed#" index="i">
                  <cfoutput><option value="#i#,6">#i#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="col">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Must Haves" data-size="6" name="must_haves">
                <cfloop list="#mustHavesList#" index="i">
                	<cfoutput><option>#i#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="col">
            <input type="submit" value="Search" class="btn site-color-1-bg site-color-1-lighten-bg-hover">
          </div>
        </div>
      </form>
    </div>
    <cfif getPopularSearches.recordcount gt 0>
      <div class="tab-pane" id="popularSearches" role="tabpanel" aria-labelledby="popularSearchesTab">
        <div class="row">
	        <cfset colorcounter = 1>
	        <cfloop query="getPopularSearches">
            <div class="col">
  	        	<cfoutput><a href="/#slug#" class="btn btn-sm site-color-#colorcounter#-bg site-color-#colorcounter#-lighten-bg-hover text-white text-white-hover">#name#</a></cfoutput>
  	        	<cfif colorcounter eq 2>
  	        		<cfset colorcounter = 1>
  	        	<cfelse>
  	        		<cfset colorcounter = 2>
  	        	</cfif>
            </div>
          </cfloop>
	      </div>
	    </div>
    </cfif>
    <div class="tab-pane" id="mlsSearch" role="tabpanel" aria-labelledby="mlsSearchTab">
      <form method="post" action="<cfoutput>#application.mls.dir#/results</cfoutput>"><!--- removed .cfm --->
        <div class="row">
          <div class="col">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Any Price" data-size="6" name="pmax">
                <cfloop index="i" from="#application.settings.mls.pricerangemin#" to="#application.settings.mls.pricerangemax#" step="#application.settings.mls.incrementpricerange#">
                  <cfoutput>
                    <option value="#i#">up to $#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                  <cfif #i# eq "1000000">
                    <cfloop index="i" from="1500000" to="#application.settings.mls.pricerangemax#" step="#application.settings.mls.incrementpricerangemillion#">
                      <cfoutput>
                        <option value="#i#">up to $#trim(numberformat(i,'__,___,___'))#</option>
                      </cfoutput>
                    </cfloop>
                    <cfbreak>
                  </cfif>
                </cfloop>
                <option value="999999999">No Max</option>
              </select>
            </div>
          </div>
          <div class="col">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Bedrooms" data-size="6" name="bedrooms">
                <cfloop from="1" to="#settings.mls.minmaxes.maxbed#" index="i">
                  <cfoutput><option value="#i#">#i#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="col">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Baths" data-size="6" name="baths_full">
                <cfloop from="1" to="#settings.mls.minmaxes.maxbath#" index="i">
                  <cfoutput><option value="#i#">#i#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="col">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="City" data-size="6" name="city">
                <cfoutput query="application.settings.mls.getareas">
                  <option value="#city#,"
                    <cfif isdefined('session.mlssearch.city') and LEN(session.mlssearch.city)>
                      <cfloop index="i" list="#session.mlssearch.city#" delimiters=",">
                        <cfif LEFT(i,1) eq ','><cfset cleanedcity = RemoveChars(i, 1, 1)><cfelse><cfset cleanedcity = i></cfif>
                      </cfloop>
                    </cfif>
                  >#city#</option>
                  </cfoutput>
              </select>
            </div>
          </div>
          <div class="col">
            <cfoutput><a href="#application.mls.dir#/index.cfm" class="btn btn-block btn-advancedSearch site-color-2-bg site-color-2-lighten-bg-hover">Advanced Search</a></cfoutput>
          </div>
          <div class="col">
            <input type="submit" value="Search Now" class="btn site-color-1-bg site-color-1-lighten-bg-hover">
          </div>
        </div>
      </form>
    </div>
  </div>
</div>