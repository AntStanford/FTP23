<!--- 2019-CURRENT TEMPLATE --->
<!--- Set some defaults just in case --->
<cfif !isdefined('settings.booking.minOccupancy') or settings.booking.minOccupancy eq ''>
  <cfset settings.booking.minOccupancy = 1>
  <cfset settings.booking.maxOccupancy = 10>
  <cfset settings.booking.minbed = 1>
  <cfset settings.booking.maxbed = 10>
</cfif>
<div class="i-quick-search-wrap lazy" data-src="/images/layout/burlap-bg.png">
  <div class="container i-quick-search" id="quickSearch">
    <ul class="nav nav-tabs" role="tablist">
      <li class="nav-item active"><a href="#bookingSearch" class="nav-link" id="bookingSearchTab" aria-controls="bookingSearch" role="tab" data-toggle="tab" aria-selected="true">Search Rentals</a></li>
      <li class="nav-item"><a href="#propertySearch" class="nav-link" id="propertySearchTab" aria-controls="propertySearch" role="tab" data-toggle="tab" aria-selected="true">Search By Property Name</a></li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="bookingSearch">
        <form method="post" action="/<cfoutput>#settings.booking.dir#</cfoutput>/results">
          <input type="hidden" name="camefromsearchform">
          <div class="row">
            <div class="col-lg-2 dates-col">
              <label for="start-date" class="hidden">Arrival</label>
              <div class="input-wrap">
                <input type="text" name="strCheckin" id="start-date" placeholder="Arrival Date" value="" readonly>
              </div>
            </div>
            <div class="col col-lg-2 dates-col">
              <label for="end-date" class="hidden">Departure</label>
              <div class="input-wrap">
                <input type="text" name="strCheckout" id="end-date" placeholder="Departure Date" value="" readonly>
              </div>
            </div>
            <div class="col-lg-2">
              <label for="bedrooms" class="hidden">Bedrooms</label>
              <div class="select-wrap">
                <select class="selectpicker" data-size="6" id="bedrooms" name="bedrooms" title="bedrooms">
                  <option value="" disabled selected hidden>Bedrooms</option>
                  <cfloop from="#settings.booking.minbed#" to="#settings.booking.maxbed#" index="i">
                    <cfoutput><option value="#i#">#i#</option></cfoutput>
                  </cfloop>
                </select>
              </div>
            </div>
            <div class="col-lg-2">
              <label for="location" class="hidden">Locations</label>
              <div class="select-wrap">
                <select class="selectpicker" id="location" name="location" title="locations">
                  <option value="" disabled selected hidden>Locations</option>
                  <cfloop list="#settings.booking.locationList#" index="i">
                    <cfoutput><option value="#i#">#i#</option></cfoutput>
                  </cfloop>
                </select>
              </div>
            </div>
            <!---
            <div class="col">
              <label for="bedrooms" class="hidden">Bedrooms</label>
              <div class="select-wrap">
                <select class="selectpicker" data-size="6" id="bedrooms" name="bedrooms" title="Bedrooms">
                  <cfloop from="#settings.booking.minbed#" to="#settings.booking.maxbed#" index="i">
                    <cfoutput><option value="#i#">#i#</option></cfoutput>
                  </cfloop>
                </select>
              </div>
            </div>
            <div class="col">
              <label for="must_haves" class="hidden">Must Haves</label>
              <div class="select-wrap must-haves-wrap">
                <select class="selectpicker" multiple data-size="6" id="must_haves" name="must_haves" title="Must Haves">
                  <cfloop list="#mustHavesList#" index="i">
                    <cfoutput><option>#i#</option></cfoutput>
                  </cfloop>
                </select>
              </div>
            </div>
          --->
            <div class="col-lg-2 submit-col">
              <input type="submit" value="Search Now" class="btn site-color-6-bg site-color-2-bg-hover">
            </div>
            <div class="col-lg-2 last-btns">
              <a href="/<cfoutput>#settings.booking.dir#</cfoutput>/results" class="site-color-1-bg text-white btn site-color-2-bg-hover">BROWSE ALL PROPERTIES</a>
              <a href="/<cfoutput>#settings.booking.dir#</cfoutput>/results?advanced-search" class="site-color-1-bg text-white btn site-color-2-bg-hover">ADVANCED SEARCH</a>
            </div>
          </div>
        </form>
      </div>
      <div class="tab-pane" id="propertySearch">
        <form method="post">
          <div class="row">
            <div class="col-md-9">
              <div id="searchWrapper" class="header-site-search">
                <input type="text" id="headerSiteSearch" placeholder="Site Search">
                <div id="headerSearchResults"></div>
              </div>
            </div>
            <div class="col-md-3">
              <input type="submit" value="Search Now" class="btn site-color-6-bg site-color-2-bg-hover">
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
