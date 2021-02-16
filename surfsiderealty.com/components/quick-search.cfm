<!--- Get the popular searches --->
<cfquery name="getPopularSearches" dataSource="#settings.dsn#">
	select slug,name,popularSearchPhoto from cms_pages where popularSearch = 'Yes'
</cfquery>

<cfparam name="settings.booking.maxbed" default="10">

<div class="container i-quick-search">
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a hreflang="en" href="#bookingSearch" aria-controls="bookingSearch" role="tab" data-toggle="tab">Start Your Adventure Now!</a></li>
    <cfif getPopularSearches.recordcount gt 0>
    	<li role="presentation"><a hreflang="en" href="#popularSearches" aria-controls="popularSearches" role="tab" data-toggle="tab">Popular Searches</a></li>
    </cfif>
<!---   	<li role="presentation"><a hreflang="en" href="#mlsSearch" aria-controls="mlsSearch" role="tab" data-toggle="tab">Find Your Home Now!</a></li> --->
  </ul>
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="bookingSearch">
      <form method="post" action="/rentals/results.cfm">
       <input type="hidden" name="camefromsearchform">
        <div class="row">
          <div class="col-md-2 qs-md">
            <input type="text" placeholder="Arrival Date" id="start-date" name="strCheckIn" class="datepicker" readonly="readonly">
          </div>
          <div class="col-md-2 qs-md">
            <input type="text" placeholder="Departure Date" id="end-date" name="strCheckOut" class="datepicker" readonly="readonly">
          </div>
          <div class="col-md-2 qs-sm">
            <div class="select-wrap">
              <select class="selectpicker" data-size="6" name="bedrooms" multiple title="Bedrooms" data-max-options="1">
                <cfloop from="1" to="#settings.booking.maxbed#" index="i">
                  <cfoutput><option value="#i#">#i#</option></cfoutput>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="col-md-2">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Must Haves" data-size="6" name="amenities">
                <option>Dog Friendly</option>
                <option>Private Home</option>
                <option>Condo</option>
                <option>Private Pool</option>
              </select>
            </div>
          </div>
          <div class="col-md-2">
            <input type="submit" value="Search" class="btn site-color-1-bg site-color-1-lighten-bg-hover">
          </div>
          <div class="col-md-2">
            <a hreflang="en" href="/rentals/search.cfm" class="btn btn-block btn-advancedSearch site-color-2-bg site-color-2-lighten-bg-hover">Advanced Search</a>
          </div>
        </div>
      </form>
    </div>
    <cfif getPopularSearches.recordcount gt 0>
	    <div role="tabpanel" class="tab-pane" id="popularSearches">
	      <div class="btn-group btn-group-justified" role="group">
	        <cfset colorcounter = 1>
	        <cfloop query="getPopularSearches">
	        	<cfoutput><a hreflang="en" href="/#slug#" class="btn btn-sm site-color-#colorcounter#-bg site-color-#colorcounter#-lighten-bg-hover text-white text-white-hover">#name#</a></cfoutput>
	        	<cfif colorcounter eq 2>
	        		<cfset colorcounter = 1>
	        	<cfelse>
	        		<cfset colorcounter = 2>
	        	</cfif>
	        </cfloop>
	      </div>
	    </div>
    </cfif>
    <div role="tabpanel" class="tab-pane" id="mlsSearch">
      <form method="post" action="">
        <div class="row">
          <div class="col-md-2">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Any Price" data-size="6" name="anyprice">
                <option>Lorem</option>
              </select>
            </div>
          </div>
          <div class="col-md-2">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Bedrooms" data-size="6" name="bedrooms">
                <option>Lorem</option>
              </select>
            </div>
          </div>
          <div class="col-md-2">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="Baths" data-size="6" name="baths">
                <option>Lorem</option>
              </select>
            </div>
          </div>
          <div class="col-md-2">
            <div class="select-wrap">
              <select class="selectpicker" multiple title="City" data-size="6" name="city">
                <option>Lorem</option>
              </select>
            </div>
          </div>
          <div class="col-md-2">
            <a hreflang="en" href="" class="btn btn-block btn-advancedSearch site-color-2-bg site-color-2-lighten-bg-hover">Advanced Search</a>
          </div>
          <div class="col-md-2">
            <input type="submit" value="Search Now" class="btn site-color-1-bg site-color-1-lighten-bg-hover">
          </div>
        </div>
      </form>
    </div>
  </div>
</div>