<cfif isdefined('session.booking.unitCodeList') and ListLen(session.booking.unitCodeList) gt 0 and isdefined('session.booking.getResults')>
  <cfset ThreeDaysEarlier = dateadd('d','-3',Now())>
	<cfquery datasource="#settings.dsn#" NAME="GetPropertyViewsAll">
		SELECT DISTINCT TrackingEmail,UserTrackerValue,unitcode
		FROM be_prop_view_stats WHERE createdAt >= <cfqueryparam value="#ThreeDaysEarlier#" cfsqltype="CF_SQL_TIMESTAMP">
		and unitcode IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.unitCodeList#" list="Yes">)
		GROUP BY TrackingEmail,UserTrackerValue desc
	</cfquery>

	<!--- Counting each marker to use for highlighting on the map --->
	<cfif !isdefined('session.mapMarkerID') or !isdefined('form.page') or (isdefined('form.page') and LEN(form.page) eq 0)>
	  <cfset session.mapMarkerID ="0">
	</cfif>

  <!--- This section handles the scenario where a special links out to a results page --->
  <cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate and isdefined('session.specialid') and len(session.specialid) and session.specialid gt 0>
    <!--- Check for any specials --->
    <cfquery name="checkForSpecials" dataSource="#settings.dsn#">
      select * from cms_specials where <cfqueryparam cfsqltype="cf_sql_date" value="#createodbcdate(session.booking.strcheckin)#">
      between allowedBookingStartDate and allowedBookingEndDate
      and id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.specialid#">
    </cfquery>
    <cfif checkForSpecials.recordcount gt 0>
      <!--- We found a special, now get a list of units in the special --->
      <cfquery name="getSpecialUnits" dataSource="#settings.dsn#">
        select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.specialid#">
      </cfquery>
      <cfset unitsWithSpecialList = ValueList(getSpecialUnits.unitcode)>
    </cfif>
  <cfelseif isdefined('session.booking.searchByDate') and session.booking.searchByDate and isdefined('session.booking.strcheckin')>
    <!--- if we are searching with dates, check for any valid specials --->
    <cfquery name="checkForSpecials" dataSource="#settings.dsn#">
      select id,title,description from cms_specials where
      <cfqueryparam cfsqltype="cf_sql_date" value="#createodbcdate(session.booking.strcheckin)#"> between startdate and enddate and
      <cfqueryparam cfsqltype="cf_sql_date" value="#createodbcdate(session.booking.strcheckin)#"> between allowedBookingStartDate and allowedBookingEndDate
      and active = 'yes'
    </cfquery>
    <cfif checkForSpecials.recordcount gt 0>
      <!--- Now that we have found a valid special, find the units in that special --->
      <cfquery name="getSpecialUnits" dataSource="#settings.dsn#">
        select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#checkForSpecials.id#">
      </cfquery>
      <cfset unitsWithSpecialList = ValueList(getSpecialUnits.unitcode)>
    </cfif>
  </cfif>

	<div class="results-list-properties <cfif StructKeyExists(request,'resortContent')>resorts-list-properties</cfif>">
	  <ul class="row">
  		<!--- Use the form page data to override url.loop values for infinite scroll --->
  		<cfif isdefined('form.page') and isvalid('integer',form.page)>
  		  <cfset url.loopStart = form.page * 12 + 1>
  		  <cfset url.loopend = (form.page + 1) * 12>
  		</cfif>

      <cfif url.loopend gt cookie.numresults>
        <cfset url.loopend = cookie.numresults>
      </cfif>
	    <cfloop from="#url.loopStart#" to="#url.loopEnd#" index="i">
        <cftry>
          <cfset propertyid = ListGetAt(session.booking.unitcodelist,i)>
          <cfcatch><cfbreak></cfcatch>
        </cftry>
      	<cfquery name="getUnitInfo" dbtype="query">
      		select * from session.booking.getResults where propertyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
      	</cfquery>
      	<cfset detailPage = '/#settings.booking.dir#/#getUnitInfo.seoPropertyName#'>
      	<cfoutput>
          <li class="col-sm-6 col-md-6 col-lg-6 col-xl-4">
  	        <div class="results-list-property" data-mapMarkerID="#session.mapMarkerID#" data-unitcode="#propertyid#" data-id="#getUnitInfo.seoPropertyName#" id="#getUnitInfo.seoPropertyName#" data-seoname="#getUnitInfo.seoPropertyName#" data-unitshortname="#getUnitInfo.name#" data-photo="#getUnitInfo.defaultPhoto#" data-latitude="#getUnitInfo.latitude#" data-longitude="#getUnitInfo.longitude#" data-straddress1="#getUnitInfo.address#" data-dblbeds="#getUnitInfo.bedrooms#" data-intoccu="#getUnitInfo.sleeps#" data-strlocation="#getUnitInfo.location#">
  	          <div class="results-list-property-img-wrap">
      					<cfif
                  isDefined('checkForSpecials') and
                  isQuery(checkForSpecials) and
      					  isdefined('unitsWithSpecialList') and
      						listlen(unitsWithSpecialList) gt 0 and
      						ListFind(unitsWithSpecialList,propertyid)>
  		            <!--- At this point, we know this unit has a special --->
  		            <button data-toggle="modal" data-target="##specialModal" class="results-list-property-special site-color-2-bg site-color-2-lighten-bg-hover text-white">
  		              <i class="fa fa-tag site-color-3" aria-hidden="true"></i> Special
  		            </button>
                  <div class="special-modal-content hidden">
                    <cfquery name="getSpecial" dbtype="query">
                    	select title,description from checkForSpecials where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#checkForSpecials.id#">
                    </cfquery>
                    <cfoutput>
                      <h4>#getSpecial.title#</h4>
                      <p>#getSpecial.description#</p>
                    </cfoutput>
                  </div><!-- END special-modal-content -->
  	            </cfif>

  	            <!--- FAVORITE HEART --->
  	            <a href="javascript:;" class="results-list-property-favorite add-to-favs add-to-fav-results">
  	              <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
  	              <i class="fa fa-heart under<cfif ListFind(cookie.favorites,propertyid)> favorited</cfif>" aria-hidden="true"></i>
  	              <span class="hidden">Favorite</span>
  	            </a>
  	            <!--- PROPERTY LINK --->
  	            <a href="#detailPage#" class="results-list-property-link" target="_blank">
  	              <span class="results-list-property-title-wrap">
      						  <cfif len(getUnitInfo.avgRating)>
  		                <!--- PROPERTY RATING --->
  		                <span class="results-list-property-rating">
  		                	<cfif ceiling(getUnitInfo.avgRating) eq 1>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(getUnitInfo.avgRating) eq 2>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(getUnitInfo.avgRating) eq 3>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(getUnitInfo.avgRating) eq 4>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(getUnitInfo.avgRating) eq 5>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  </cfif>
  		                </span>
  	                </cfif>
  	                <!--- PROPERTY NAME AND LOCATION --->
  	                <span class="results-list-property-title">
  	                  <h3>#getUnitInfo.name# <cfif getUnitInfo.petsallowed eq 'Pets Allowed' or getUnitInfo.petsallowed eq '-1' or getUnitInfo.petsallowed contains 'Pets Allowed'><span class="results-list-property-pet-friendly"><i class="fa fa-paw" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Pet Friendly"></i></span></cfif></h3>
      	            	<!--- PROPERTY TYPE --->
                      <cfif len(getUnitInfo.type)>
        	            	<span class="results-list-property-info-type">#getUnitInfo.type#</span>
        	            </cfif>
  	                  <!--- <em>#getUnitInfo.location#</em> --->
  	                </span>
  	              </span>
  	              <!--- PROPERTY IMAGE --->
  	              <cfif len(getUnitInfo.defaultPhoto)>
  	                <span class="results-list-property-img lazy" data-src="#getUnitInfo.defaultPhoto#"></span>
  	              <cfelse>
  	              	<span class="results-list-property-img lazy" data-src="/#settings.booking.dir#/images/no-img.jpg"></span>
  	              </cfif>
  	            </a>
              </div><!-- END results-list-property-img-wrap -->

  	          <div class="results-list-property-info-wrap">
  	            <!--- PROPERTY PRICE --->
  	            <span class="results-list-property-info-price">
                  <cfif session.booking.searchByDate>
                    <cfif isdefined('verifySpecial') and verifySpecial.recordcount gt 0>
                      <!---
                        At this point, we know we have a valid special, now we just need to
                        see if the current property in the loop has any rates defined.
                      --->
                      <cfquery name="checkForSpecialRates" dataSource="#settings.dsn#">
                        select * from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#verifySpecial.id#">
                        and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
                      </cfquery>
                      <cfif
                        checkForSpecialRates.recordcount gt 0 and
                        len(checkForSpecialRates.pricewas) and
                        len(checkForSpecialRates.pricereducedto) and
                        checkForSpecialRates.pricewas gt 0 and
                        checkForSpecialRates.pricereducedto gt 0>
                        <span>
                          Price was: <sup>$</sup>#checkForSpecialRates.pricewas# - Price reduced to: <sup>$</sup>#checkForSpecialRates.pricereducedto#
                        </span>
                      <cfelse>
                      	<!--- Search by dates, no special --->
                      	<cfset baseRate = application.bookingObject.getPriceBasedOnDates(getUnitInfo.propertyid,session.booking.strcheckin,session.booking.strcheckout)>
                      	#baseRate#
                      </cfif>
                    <cfelse>
                    	 <!--- Search by dates, no special --->
                      <cfset baseRate = application.bookingObject.getPriceBasedOnDates(getUnitInfo.propertyid,session.booking.strcheckin,session.booking.strcheckout)>
                      #baseRate#
                    </cfif>
                  <cfelse>
                    <!--- Non-dated search, show price range --->
	                 <cfset priceRange = application.bookingObject.getPropertyPriceRange(getUnitInfo.propertyid)>
	                 #priceRange#
                  </cfif>
  	            </span>

  	            <!--- PROPERTY INFO --->
  	            <ul class="results-list-property-info">
  	              <cfif getUnitInfo.bedrooms gt 0>
                  	<li><i class="fa fa-bed site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bedrooms"></i> #getUnitInfo.bedrooms# Beds</li></cfif>
                  <cfif getUnitInfo.bathrooms gt 0>
                  	<li><i class="fa fa-bath site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bathrooms"></i> #getUnitInfo.bathrooms# Baths</li></cfif>
                  <cfif getUnitInfo.sleeps gt 0>
                  	<li><i class="fa fa-users site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Guests"></i> Sleeps #getUnitInfo.sleeps#</li>
                  </cfif>

                  <cfquery dbtype="query" NAME="GetPropertyViews">
                  	SELECT DISTINCT TrackingEmail,UserTrackerValue
                  	FROM GetPropertyViewsAll
                  	where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
                  	GROUP BY TrackingEmail,UserTrackerValue
                  </cfquery>

                	<cfif GetPropertyViews.recordcount gte 10 and cgi.server_name neq settings.devURL>
                		<li><i class="fa fa-binoculars site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="User Views"></i> #GetPropertyViews.recordcount#  Views</li>
                	<cfelse>
                    <li><i class="fa fa-binoculars site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="User Views"></i> 25 Views</li>
                  </cfif>
  	            </ul><!-- END results-list-property-info -->
              </div><!-- END results-list-property-info-wrap -->
	            <cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate and isdefined('session.booking.strcheckin') and session.booking.strcheckin neq '' and isdefined('session.booking.strcheckout') and session.booking.strcheckout neq ''>
                <div class="results-list-property-book-btn">
  	            	<cfif cgi.server_name eq settings.devURL>
  	            		<a target="_blank" href="/#settings.booking.dir#/book-now.cfm?propertyid=#propertyid#&strcheckin=#session.booking.strcheckin#&strcheckout=#session.booking.strcheckout#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white results-list-property-booknow-btn">Book Now</a>
  	            	<cfelse>
  	            	  <a target="_blank" href="#settings.booking.bookingURL#/#settings.booking.dir#/book-now.cfm?propertyid=#propertyid#&strcheckin=#session.booking.strcheckin#&strcheckout=#session.booking.strcheckout#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white results-list-property-booknow-btn">Book Now</a>
                  </cfif>
                </div><!-- END results-list-property-book-btn -->
	            </cfif>
  	        </div><!-- END results-list-property -->
  	      </li>
        </cfoutput>

        <cfset session.mapMarkerID = session.mapMarkerID + 1>
      </cfloop>
    </ul>
  </div><!-- END results-list-properties -->

<cfelse>

  <!--- HIDES LOADER ANIMATION --->
  <style>
    #bottom-result { display: none; }
  </style>

  <div class="alert alert-danger no-search-results">
    Sorry, there are no properties matching your search criteria. <br />However, here are 2 random properties that you may like:
  </div>

  <cfset randomProperties = application.bookingObject.getRandomProperties()>

  <div class="results-list-properties results-list-suggested-properties">
    <div class="row">
      <cfloop query="randomProperties">
        <cfset detailPage = '/#settings.booking.dir#/#seoPropertyName#'>
        <cfoutput>
          <li class="col-sm-6 col-md-6 col-lg-6 col-xl-4">
  	        <div class="results-list-property">
  	          <div class="results-list-property-img-wrap">
  	            <a href="javascript:;" class="results-list-property-favorite add-to-fav-results">
  	              <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
  	              <i class="fa fa-heart under" aria-hidden="true"></i>
  	            </a>
  	            <a href="#detailPage#" class="results-list-property-link" target="_blank">
  	              <span class="results-list-property-title-wrap">
  	              	<cfif len(avgRating)>
  		                <span class="results-list-property-rating">
  		                	<cfif ceiling(avgRating) eq 1>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(avgRating) eq 2>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(avgRating) eq 3>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(avgRating) eq 4>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star-o" aria-hidden="true"></i>
  		                  <cfelseif ceiling(avgRating) eq 5>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  	<i class="fa fa-star" aria-hidden="true"></i>
  		                  </cfif>
  		                </span>
  	                </cfif>
  	                <!--- PROPERTY NAME AND LOCATION --->
  	                <span class="results-list-property-title">
  	                  <h3>#name# <cfif petsallowed eq 'Pets Allowed' or petsallowed eq '-1' or petsallowed contains 'Pets Allowed'><span class="results-list-property-pet-friendly"><i class="fa fa-paw" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Pet Friendly"></i></span></cfif></h3>
      	            	<!--- PROPERTY TYPE --->
                      <cfif len(type)>
        	            	<span class="results-list-property-info-type">#type#</span>
        	            </cfif>
  	                </span>
  	              </span>
  	              <cfif len(defaultPhoto)>
  	                <span class="results-list-property-img lazy" data-src="#defaultPhoto#"></span>
  	              <cfelse>
  	              	<span class="results-list-property-img lazy" data-src="/#settings.booking.dir#/images/no-img.jpg"></span>
  	              </cfif>
  	            </a>
              </div><!-- END results-list-property-img-wrap -->
  	          <div class="results-list-property-info-wrap">
  	            <span class="results-list-property-info-price">
  	            	<cfset priceRange = application.bookingObject.getPropertyPriceRange(propertyid)>
                  #priceRange#
  	            </span>
  	            <ul class="results-list-property-info">
  	              <li><i class="fa fa-bed site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bedrooms"></i> #bedrooms#</li>
  	              <li><i class="fa fa-bath site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bathrooms"></i> #bathrooms#</li>
  	              <li><i class="fa fa-users site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Guests"></i> #sleeps#</li>
                  <cfset ThreeDaysEarlier = dateadd('d','-3',Now())>
      						<cfquery datasource="#settings.dsn#" NAME="GetPropertyViews">
        						SELECT DISTINCT TrackingEmail,UserTrackerValue
        						FROM be_prop_view_stats WHERE createdAt >= <cfqueryparam value="#ThreeDaysEarlier#" cfsqltype="CF_SQL_TIMESTAMP">
        						and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
        						GROUP BY TrackingEmail,UserTrackerValue desc
      						</cfquery>
      						<!--- <cfif GetPropertyViews.recordcount gte 10> --->
                    <li><i class="fa fa-binoculars site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="User Views"></i> 25 Views</li>
                  <!--- </cfif> --->
  	            </ul><!-- END results-list-property-info -->
  	            <span class="results-list-property-info-type">#type#</span>
              </div><!-- END results-list-property-info-wrap -->
  	        </div>
  	      </li>
  	  	</cfoutput>
      </cfloop>
    </div>
  </div><!-- END results-list-properties -->

  <cf_htmlfoot>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js" defer type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js" defer type="text/javascript"></script>
    <script>
      $('form#noResultsContactForm').validate({
  			submitHandler: function(form){
  				$.ajax({
  					type: "POST",
  					url: "_submit.cfm",
  					data: $('form#noResultsContactForm').serialize(),
  					dataType: "text",
  					success: function (response) {
  						response = $.trim(response);
  						console.log(response);
  						if(response === "success") {
  							$('.caption').hide();
  							$('form#noResultsContactForm').hide();
  							$('div#noResultsContactFormMSG').html("<font color='green'>Thanks! Your email has been sent!</font>");
  						}
  					}
  				});
  				return false;
  			}
  		});
    </script>
  </cf_htmlfoot>

  <script>
    if (window.jQuery) {
      $('form#noResultsContactForm').validate({
  			submitHandler: function(form){
  				$.ajax({
  					type: "POST",
  					url: "_submit.cfm",
  					data: $('form#noResultsContactForm').serialize(),
  					dataType: "text",
  					success: function (response) {
  						response = $.trim(response);
  						console.log(response);
  						if(response === "success") {
  							$('.caption').hide();
  							$('form#noResultsContactForm').hide();
  							$('div#noResultsContactFormMSG').html("<font color='green'>Thanks! Your email has been sent!</font>");
  						}
  					}
  				});
  				return false;
  			}
  		});
    }
  </script>

  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
  <div class="results-inquiry-form-wrap">
    <div class="results-inquiry-form-text">
      <div class="results-inquiry-form-caption">Tell us what you're looking for and someone will contact you with available options.</div>
      <div id="noResultsContactFormMSG"></div>
    </div>
    <form class="results-inquiry-form" id="noResultsContactForm" method="post">
      <cfinclude template="/cfformprotect/cffp.cfm">
      <input type="hidden" name="noResultsContactForm">
      <fieldset>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-firstName">First Name</label>
          <input id="ri-firstName" name="firstName" type="text" placeholder="First Name" class="form-control required">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-lastName">Last Name</label>
          <input id="ri-lastName" name="lastName" type="text" placeholder="Last Name" class="form-control required">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-phone">Phone Number</label>
          <input id="ri-phone" name="phone" type="text" placeholder="Phone" class="form-control">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-email">Email Address</label>
          <input id="ri-email" name="email" type="text" placeholder="Email" class="form-control required">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-numberOfBeds">Number of Bedrooms</label>
          <select id="ri-numberOfBeds" class="selectpicker" name="numberOfBeds" title="Number of Bedrooms">
            <option data-hidden="true" value="">Number of Bedrooms</option>
            <cfloop from="1" to="6" index="i">
              <option>
                <cfoutput>#i#</cfoutput>
              </option>
            </cfloop>
          </select>
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-budget">Approximate Budget</label>
          <input id="ri-budget" name="budget" type="text" placeholder="Approximate Budget" class="form-control">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-arrivalDate">Arrival Date</label>
          <input id="ri-arrivalDate" name="arrivalDate" type="text" placeholder="Arrival Date" class="form-control datepicker datepicker-start">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-departureDate">Departure Date</label>
          <input id="ri-departureDate" name="departureDate" type="text" placeholder="Departure Date" class="form-control datepicker datepicker-end">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-numAdults">Number of Adults</label>
          <select id="ri-numAdults" class="selectpicker" name="numAdults" title="Number of Adults">
            <option data-hidden="true" value="">Number of Adults</option>
            <cfloop from="1" to="20" index="i">
              <option>
                <cfoutput>#i#</cfoutput>
              </option>
            </cfloop>
          </select>
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <label for="ri-numChildren">Number of Children</label>
          <select id="ri-numChildren" class="selectpicker" name="numChildren" title="Number of Children">
            <option data-hidden="true" value="">Number of Children</option>
            <cfloop from="1" to="20" index="i">
              <option>
                <cfoutput>#i#</cfoutput>
              </option>
            </cfloop>
          </select>
        </div>
        <div class="form-group form-group-full col-xs-12 col-md-12">
          <label for="comments">Comments</label>
          <textarea id="comments" name="comments" placeholder="I am looking for...." class="form-control"></textarea>
        </div>
        <div class="form-group form-group-full col-xs-12 col-md-12">
          <div id="suggestedpropertiescaptcha"></div>
          <br />
          <div class="g-recaptcha-error"></div>
        </div>
        <div class="form-group form-group-full col-xs-12 col-md-12">
          <div class="well input-well">
            <input id="optinNoResults" name="optin" type="checkbox" value="Yes"> <label for="optinNoResults">I agree to receive information about your rentals, services and specials via phone, email or SMS.<br >
            You can unsubscribe at anytime. <a href="/privacy-policy.cfm" target="_blank">Privacy Policy</a></label>
          </div>
        </div>
        <div class="form-group col-xs-12 col-md-12 nomargin">
          <input type="submit" value="Submit" id="contactform" name="contactform" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white text-white-hover">
        </div>
      </fieldset>
    </form>
  </div><!-- END results-inquiry-form-wrap -->
</cfif>