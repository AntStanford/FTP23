<cfif isdefined('session.booking.unitCodeList') and ListLen(session.booking.unitCodeList) gt 0 and isdefined('session.booking.getResults')>

  <!---<cfset ThreeDaysEarlier = dateadd('d','-3',Now())>
	<cfquery datasource="#settings.dsn#" NAME="GetPropertyViewsAll">
		SELECT DISTINCT TrackingEmail,UserTrackerValue,unitcode
		FROM be_prop_view_stats WHERE createdAt >= <cfqueryparam value="#ThreeDaysEarlier#" cfsqltype="CF_SQL_TIMESTAMP">
		and unitcode IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.unitCodeList#" list="Yes">)
		GROUP BY TrackingEmail,UserTrackerValue desc
	</cfquery>--->

	<!--- Counting each marker to use for highlighting on the map --->
	<cfif !isdefined('session.mapMarkerID') or !isdefined('form.page') or (isdefined('form.page') and LEN(form.page) eq 0)>
	  <cfset session.mapMarkerID ="0">
	</cfif>

  <!--- This section handles the scenario where a special links out to a results page --->
  <cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate and isdefined('session.booking.specialid') and len(session.booking.specialid) and session.booking.specialid gt 0>
    <!--- Check for any specials --->
    <cfquery name="checkForSpecials" dataSource="#settings.dsn#">
      select * from cms_specials where <cfqueryparam value="#createodbcdate(session.booking.strcheckin)#" cfsqltype="cf_sql_date">
      between allowedBookingStartDate and allowedBookingEndDate
      and id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.specialid#">
	  AND active = 'Yes'
    </cfquery>
    <cfif checkForSpecials.recordcount gt 0>
      <!--- We found a special, now get a list of units in the special --->
      <cfquery name="getSpecialUnits" dataSource="#settings.dsn#">
        select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.specialid#">
      </cfquery>
      <cfset unitsWithSpecialList = ValueList(getSpecialUnits.unitcode)>
    </cfif>
  <cfelseif isdefined('session.booking.searchByDate') and session.booking.searchByDate and isdefined('session.booking.strcheckin')>
    <!--- if we are searching with dates, check for any valid specials --->
    <cfquery name="checkForSpecials" dataSource="#settings.dsn#">
      select * from cms_specials where
      <cfqueryparam value="#createodbcdate(session.booking.strcheckin)#" cfsqltype="cf_sql_date"> between startdate and enddate and
      <cfqueryparam value="#createodbcdate(session.booking.strcheckin)#" cfsqltype="cf_sql_date"> between allowedBookingStartDate and allowedBookingEndDate
      and active = 'yes'
    </cfquery>
    <cfif checkForSpecials.recordcount gt 0>
      <!--- Now that we have found a valid special, find the units in that special --->
      <cfquery name="getSpecialUnits" dataSource="#settings.dsn#">
        select unitcode
        from cms_specials_properties
        where specialID IN( <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#valueList(checkForSpecials.id)#" List="Yes"> )
        AND active = 'Yes'
      </cfquery>
      <cfset unitsWithSpecialList = ValueList(getSpecialUnits.unitcode)>
	</cfif>
  <cfelse>
	<cfquery name="checkForSpecials" dataSource="#settings.dsn#">
		select * from cms_specials where active = 'yes'
	  </cfquery>
	  <cfif checkForSpecials.recordcount gt 0>
		<!--- Now that we have found a valid special, find the units in that special --->
		<cfquery name="getSpecialUnits" dataSource="#settings.dsn#">
		  select unitcode
		  from cms_specials_properties
		  where specialID IN( <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#valueList(checkForSpecials.id)#" List="Yes"> )
		  AND active = 'Yes'
		</cfquery>
		<cfset unitsWithSpecialList = ValueList(getSpecialUnits.unitcode)>
	  </cfif>
  </cfif>

  <cfquery name="getEnhancements" dataSource="#settings.booking.dsn#">
	select * 
	from cms_property_enhancements
  </cfquery>

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
      					  isdefined('unitsWithSpecialList') and
      						listlen(unitsWithSpecialList) gt 0 and
      						ListFind(unitsWithSpecialList,propertyid)>
  		            <!--- At this point, we know this unit has a special --->
  		            <button data-toggle="modal" data-target="##specialModal" class="results-list-property-special results-list-special site-color-2-bg site-color-2-lighten-bg-hover text-white">
  		              <i class="fa fa-tag text-white" aria-hidden="true"></i> Special
  		            </button>
                  <div class="special-modal-content hidden">
                      <cfquery name = "getSpecial" datasource = "#settings.dsn#">
                          select *
                          from cms_specials join cms_specials_properties ON(cms_specials.id = cms_specials_properties.specialID)
							where 1=1
							<cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate and isdefined('session.booking.strcheckin')>
								and <cfqueryparam value="#createodbcdate(session.booking.strcheckin)#" cfsqltype="cf_sql_date">
														between cms_specials.allowedBookingStartDate and cms_specials.allowedBookingEndDate
							</cfif>
							<cfif isDefined('session.booking.specialid') AND LEN(session.booking.specialid)>
								and cms_specials.id IN( <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.specialid#" List="yes">)
							</cfif>
                          AND cms_specials.active = <cfqueryparam value = "Yes" CFSQLType = "CF_SQL_VARCHAR">
                          and cms_specials_properties.active = <cfqueryparam value = "Yes" CFSQLType = "CF_SQL_VARCHAR">
                          and cms_specials_properties.unitcode = <cfqueryparam value = "#propertyid#" CFSQLType = "CF_SQL_VARCHAR">
                    	</cfquery>
						<cfoutput>
							<cfloop query="#getSpecial#">
								<h4>#getSpecial.title#</h4>
								<p>#getSpecial.description#</p>
							</cfloop>
                    	</cfoutput>
                  </div><!-- END special-modal-content -->
				  </cfif>
				  <cfquery name="getnew" dbtype="query">
					select new
					from getEnhancements 
					where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
				  </cfquery>
				  <cfif getnew.recordcount gt 0 and getnew.new eq 'Yes'>
								<span class="results-list-property-special results-list-new site-color-1-bg site-color-1-lighten-bg-hover text-white">
									<i class="fa fa-tag text-white" aria-hidden="true"></i> New
								</span>
							</cfif>
  	            <!--- FAVORITE HEART --->
  	            <a href="javascript:;" class="results-list-property-favorite add-to-favs add-to-fav-results">
  	              <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
  	              <i class="fa fa-heart under<cfif ListFind(cookie.favorites,propertyid)> favorited</cfif>" aria-hidden="true"></i>
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
											<h3>#getUnitInfo.name# 
												<!---<cfif getUnitInfo.has_hottub><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/hottub.png" alt="Hot Tub" title="Hot Tub"></span></cfif>
												<cfif getUnitInfo.has_pool><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/pool.png" alt="Pool" title="Pool"></span></cfif>
												<cfif getUnitInfo.has_elevator><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/elevator.png" alt="Elevator" title="Elevator"></span></cfif>
												<cfif getUnitInfo.petsallowed eq "pets allowed"><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/pets.png" alt="Pets" title="Pets"></span></cfif>--->
											</h3>
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
                    <cfif isdefined('checkForSpecials') and checkForSpecials.recordcount gt 0>
                      <!---
                        At this point, we know we have a valid special, now we just need to
                        see if the current property in the loop has any rates defined.
                      --->
                      <cfquery name="checkForSpecialRates" dataSource="#settings.dsn#">
                        select * from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#checkForSpecials.id#">
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
						<cfset baseRate = application.bookingObject.getPriceBasedOnDates(getUnitInfo.propertyid,session.booking.strcheckin,session.booking.strcheckout,getUnitInfo.has_beachgear)>
						  <!--- Search by dates, no special --->
						  <cfif isDefined('getSpecial') and (getSpecial.discountPercentage neq "" or getSpecial.discountPercentage gt 0)>
							<cfset specialPrice = baseRate - baseRate*getSpecial.discountPercentage>
							<span>
								Price was: <sup>$</sup>#baseRate# - Price reduced to: <sup>$</sup>#specialPrice# <small>+Taxes and Fees</small>
							  </span>
							<cfelseif isDefined('getSpecial') and (getSpecial.discountAmount neq "" or getSpecial.discountAmount gt 0)>
								<cfset specialPrice = baseRate - getSpecial.discountAmount>
								<span>
									Price was: <sup>$</sup>#baseRate# - Price reduced to: <sup>$</sup>#specialPrice# <small>+Taxes and Fees</small>
								  </span>
						  <cfelse>
							<!--- $#baseRate# <small>per Night +Taxes and Fees</small> --->
						  </cfif>
                      </cfif>
					<cfelse>
						<cfset baseRate = application.bookingObject.getPriceBasedOnDates(getUnitInfo.propertyid,session.booking.strcheckin,session.booking.strcheckout,getUnitInfo.has_beachgear)>
                    	 <!--- Search by dates, no special --->
						 <cfif isDefined('getSpecial') and (getSpecial.discountPercentage neq "" or getSpecial.discountPercentage gt 0)>
							<cfset specialPrice = baseRate - baseRate*getSpecial.discountPercentage>
							<span>
								Price was: <sup>$</sup>#baseRate# - Price reduced to: <sup>$</sup>#specialPrice#  <small>+Taxes and Fees</small>
							  </span>
							<cfelseif isDefined('getSpecial') and (getSpecial.discountAmount neq "" or getSpecial.discountAmount gt 0)>
								<cfset specialPrice = baseRate - getSpecial.discountAmount>
								<span>
									Price was: <sup>$</sup>#baseRate# - Price reduced to: <sup>$</sup>#specialPrice#  <small>+Taxes and Fees</small>
								  </span>
						  <cfelse>
							<!--- $#baseRate# <small>per Night +Taxes and Fees</small> --->
						  </cfif>
                    </cfif>
                  <cfelse>
                    <!--- Non-dated search, show price range --->
	                 <!---<cfset priceRange = application.bookingObject.getPropertyPriceRange(getUnitInfo.propertyid,"",getUnitInfo.has_beachgear)>
	                 #priceRange#--->
                  </cfif>
  	            </span>

  	            <!--- PROPERTY INFO --->
  	            <ul class="results-list-property-info">
  	              <cfif getUnitInfo.bedrooms gt 0>
                  	<li><i class="fa fa-bed site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bedrooms"></i> #getUnitInfo.bedrooms# Bedrooms</li></cfif>
                  <cfif getUnitInfo.bathrooms gt 0>
                  	<li><i class="fa fa-bath site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bathrooms"></i> #getUnitInfo.bathrooms# Baths <cfif getUnitInfo.half_bathrooms gt 0> #getUnitInfo.half_bathrooms# Half</cfif></li></cfif>
                  <cfif getUnitInfo.sleeps gt 0>
                  	<li><i class="fa fa-users site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Guests"></i> Sleeps #getUnitInfo.sleeps#</li>
                  </cfif>

                  <!---<cfquery dbtype="query" NAME="GetPropertyViews">
                  	SELECT DISTINCT TrackingEmail,UserTrackerValue
                  	FROM GetPropertyViewsAll
                  	where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
                  	GROUP BY TrackingEmail,UserTrackerValue
                  </cfquery>

                	<cfif GetPropertyViews.recordcount gte 10>
                		<li><i class="fa fa-binoculars site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="User Views"></i> #GetPropertyViews.recordcount#  Views</li>
                	<cfelse>
                    <li><i class="fa fa-binoculars site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="User Views"></i> 25 Views</li>
                  </cfif>--->
								</ul><!-- END results-list-property-info -->
								<!---
								<ul class="results-list-property-icons">
									<cfif getUnitInfo.has_hottub><li><img src="/rentals/images/icons/hottub.png" alt="Hot Tub" title="Hot Tub"></li></cfif>
									<cfif getUnitInfo.has_pool><li><img src="/rentals/images/icons/pool.png" alt="Pool" title="Pool"></li></cfif>
									<cfif getUnitInfo.has_elevator><li><img src="/rentals/images/icons/elevator.png" alt="Elevator" title="Elevator"></li></cfif>
									<cfif getUnitInfo.petsallowed eq "pets allowed"><li><img src="/rentals/images/icons/pets.png" alt="Pets" title="Pets"></li></cfif>
								</ul>
							--->
              </div><!-- END results-list-property-info-wrap -->
				<cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate and isdefined('session.booking.strcheckin') and session.booking.strcheckin neq '' and isdefined('session.booking.strcheckout') and session.booking.strcheckout neq ''>
					<!---<cfdump var="#DateDiff('d', now(), session.booking.strcheckin)#">--->
				<div class="results-list-property-book-btn">
					<cfif DateDiff('d', now(), session.booking.strcheckin) lt 2>
						<a class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white results-list-property-booknow-btn">Please call our office at 1-800-678-2306<br> to make your reservation.</a>
					<cfelse>
  	            	<cfif cgi.server_name eq settings.devURL>
  	            		<a target="_blank" href="/#settings.booking.dir#/book-now.cfm?propertyid=#propertyid#&strcheckin=#session.booking.strcheckin#&strcheckout=#session.booking.strcheckout#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white results-list-property-booknow-btn">Book Now</a>
  	            	<cfelse>
  	            	  <a target="_blank" href="#settings.booking.bookingURL#/#settings.booking.dir#/book-now.cfm?propertyid=#propertyid#&strcheckin=#session.booking.strcheckin#&strcheckout=#session.booking.strcheckout#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white results-list-property-booknow-btn">Book Now</a>
				  </cfif>
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
          <div class="col-sm-6 col-md-6 col-lg-6 col-xl-4">
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
											<h3>#name# 
											<!---<cfif randomProperties.has_hottub><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/hottub.png" alt="Hot Tub" title="Hot Tub"></span></cfif>
											<cfif randomProperties.has_pool><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/pool.png" alt="Pool" title="Pool"></span></cfif>
											<cfif randomProperties.has_elevator><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/elevator.png" alt="Elevator" title="Elevator"></span></cfif>
											<cfif randomProperties.petsallowed eq "pets allowed"><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/pets.png" alt="Pets" title="Pets"></span></cfif>--->
										</h3>
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
  	            <!---<span class="results-list-property-info-price">
  	            	<cfset priceRange = application.bookingObject.getPropertyPriceRange(propertyid)>
                  #priceRange#
  	            </span>--->
  	            <ul class="results-list-property-info">
  	              <li><i class="fa fa-bed site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bedrooms"></i> #bedrooms#</li>
  	              <li><i class="fa fa-bath site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Bathrooms"></i> #bathrooms#</li>
  	              <li><i class="fa fa-users site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Guests"></i> #sleeps#</li>
                  <!---<cfset ThreeDaysEarlier = dateadd('d','-3',Now())>
      						<cfquery datasource="#settings.dsn#" NAME="GetPropertyViews">
        						SELECT DISTINCT TrackingEmail,UserTrackerValue
        						FROM be_prop_view_stats WHERE createdAt >= <cfqueryparam value="#ThreeDaysEarlier#" cfsqltype="CF_SQL_TIMESTAMP">
        						and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
        						GROUP BY TrackingEmail,UserTrackerValue desc
      						</cfquery>
      						<!--- <cfif GetPropertyViews.recordcount gte 10> --->
                    <li><i class="fa fa-binoculars site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="User Views"></i> 25 Views</li>--->
                  <!--- </cfif> --->
  	            </ul><!-- END results-list-property-info -->
  	            <span class="results-list-property-info-type">#type#</span>
  	           </div><!-- END results-list-property-info-wrap -->
  	        </div>
  	      </div>
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
          <input id="" name="firstName" type="text" placeholder="First Name" class="form-control required">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <input id="" name="lastName" type="text" placeholder="Last Name" class="form-control required">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <input id="" name="phone" type="text" placeholder="Phone" class="form-control">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <input id="" name="email" type="text" placeholder="Email" class="form-control required">
		</div>
		<input type="hidden" name="numberOfBeds">
		<input type="hidden" name="budget">
        <!---<div class="form-group col-xs-12 col-md-6">
          <select class="selectpicker" name="numberOfBeds">
            <option data-hidden="true" value="">Number of Bedrooms</option>
            <cfloop from="1" to="6" index="i">
            	<option><cfoutput>#i#</cfoutput></option>
            </cfloop>
          </select>
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <input id="" name="budget" type="text" placeholder="Approximate Budget" class="form-control">
        </div>--->
        <div class="form-group col-xs-12 col-md-6">
          <input id="" name="arrivalDate" type="text" placeholder="Arrival Date" class="form-control datepicker datepicker-start">
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <input id="" name="departureDate" type="text" placeholder="Departure Date" class="form-control datepicker datepicker-end">
		</div>
		<input type="hidden" name="numAdults">
		<input type="hidden" name="numChildren">
        <!---<div class="form-group col-xs-12 col-md-6">
          <select class="selectpicker" name="numAdults">
            <option data-hidden="true" value="">Num Adults</option>
            <cfloop from="1" to="20" index="i">
            	<option><cfoutput>#i#</cfoutput></option>
            </cfloop>
          </select>
        </div>
        <div class="form-group col-xs-12 col-md-6">
          <select class="selectpicker" name="numChildren">
            <option data-hidden="true" value="">Num Children</option>
            <cfloop from="1" to="20" index="i">
            	<option><cfoutput>#i#</cfoutput></option>
            </cfloop>
          </select>
        </div>--->
        <div class="form-group form-group-full col-xs-12 col-md-12">
          <textarea id="comments" name="comments" placeholder="I am looking for...." class="form-control"></textarea>
        </div>
        <div class="form-group col-xs-12 col-md-12">
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