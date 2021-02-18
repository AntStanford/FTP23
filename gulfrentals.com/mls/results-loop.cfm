<div class="results-list-properties">
  <div class="row">
<!--- <p><cfoutput>variables.loopStart: #variables.loopStart#, variables.loopEnd: #variables.loopEnd#</cfoutput></p> --->

  <cfif isdefined('session.mls.qResults.query') and session.mls.qResults.query.recordcount gt 0>
  	<cfloop query="session.mls.qResults.query" startrow="#variables.loopStart#" endrow="#variables.loopEnd#">
      <cfif settings.mls.getmlscoinfo.imageurl eq "">
         <cfset ThePhoto = application.oMLS.firstPhoto(photo_link)>
      <cfelse>
         <cfset ThePhoto = settings.mls.getmlscoinfo.imageurl & '/' & session.mls.qResults.query.wsid & '/' & application.oMLS.firstPhoto(photo_link)>
      </cfif>

     <cfset detailPage = application.oHelpers.optimizeMyURL(session.mls.qResults.query.street_number,
                                                            session.mls.qResults.query.street_name,
                                                            session.mls.qResults.query.city,
                                                            session.mls.qResults.query.zip_code,
                                                            session.mls.qResults.query.mlsnumber,
                                                            session.mls.qResults.query.mlsid,
                                                            session.mls.qResults.query.wsid)>

  <!---
        <cfset detailPage = session.mls.qResults.query.proplink />
        <cfset seoAddress = replace('#session.mls.qResults.query.street_number#-#session.mls.qResults.query.street_name#', ' ','-','all') />
        <cfset seoAddress = replace(seoAddress, "'","","all") />
        <cfset seoAddress = lcase(seoAddress) />

        <cfset thismapMarkerID = session.mls.qResults.query.currentrow - 1 />
  --->

        <cfset thismapMarkerID = session.mls.qResults.query.currentrow - 1 />

        <cfif listing_office_name contains('carolina plantations')>
          <cfset isCarolina = true>
        <cfelse>
          <cfset isCarolina = false>
        </cfif>
        <cfif isCarolina></cfif>

      	<cfoutput>
  	      <div class="col-sm-6 col-md-6 col-lg-6 col-xl-4">
            <!--- data-mapMarkerID needs to be a sequential array index - the same query needs to be used for boththe list & the map.
            Also, the system needs to be changed to do a single query & store it in session, pagination will use the stored query (limit, offset) --->
            <div class="results-list-property" data-mapMarkerID="#thismapMarkerID#" data-unitcode="#session.mls.qResults.query.mlsnumber#" data-id="#session.mls.qResults.query.mlsnumber#" id="#session.mls.qResults.query.mlsnumber#" data-strcity="#session.mls.qResults.query.city#" data-listprice="$#numberformat(session.mls.qResults.query.list_price,',')#" data-photo="#ThePhoto#" data-latitude="#session.mls.qResults.query.latitude#" data-longitude="#session.mls.qResults.query.longitude#" data-wsid="#session.mls.qResults.query.wsid#" data-mlsid="#session.mls.qResults.query.mlsid#">
  	          <div class="results-list-property-img-wrap">
                <!--- PROPERTY STATUS --->
                <!---
                <span class="property-status-wrap">
                  <cfswitch expression="#session.mls.qResults.query.status_name#">
                    <cfcase value="Active">
                      <span class="property-status property-status-active">Active</span>
                    </cfcase>
                    <cfcase value="Pending">
                      <span class="property-status property-status-pending">Pending</span>
                    </cfcase>
                    <cfcase value="Sold">
                      <span class="property-status property-status-sold">Sold</span>
                    </cfcase>
                    <cfdefaultcase>
                      <span class="property-status property-status-other">#session.mls.qResults.query.status_name#</span>
                    </cfdefaultcase>
                  </cfswitch>
                  <!--- <span class="property-status property-status-active">Active</span>
                  <span class="property-status property-status-pending">Pending</span>
                  <span class="property-status property-status-sold">Sold</span>
                  <span class="property-status property-status-other">Other</span> --->
                </span>
                --->
  	            <!--- FAVORITE HEART --->
  	            <a href="javascript:;" class="results-list-property-favorite add-to-favs add-to-fav-results" <cfif isdefined('cookie.GuestFocusLoggedInID')>data-guestfocus="loggedin"<cfelse>data-guestfocus="loggedout"</cfif>>
  	              <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
  	              <i class="fa fa-heart under<cfif ListFind(cookie.mlsfavorites,mlsnumber)> favorited</cfif>" aria-hidden="true"></i>
  	            </a>
  	            <!--- PROPERTY LINK --->
  	            <a href="#detailPage#" class="results-list-property-link" target="_blank">
  	              <span class="results-list-property-title-wrap">
  	                <!--- PROPERTY NAME AND LOCATION --->
  	                <span class="results-list-property-title">
  	                  <h3><cfif wsid eq 2>Land<cfelseif wsid eq 3>Commercial Property<cfelse>House</cfif>  for Sale</h3>
      	            	<!--- PROPERTY TYPE --->
        	            <cfif AddressDisplayYN is not "N">
          	            <span class="results-list-property-info-type">#street_number# #street_name# <cfif LEN(unit_number) and application.oFields.showOnResults(86)>#application.oHelpers.FormatUnit(unit_number)#</cfif></span>
                      </cfif>
  	                </span>
  	              </span>
  	              <!--- PROPERTY IMAGE --->
                  <cfif thephoto is not ''>
  	                <span class="results-list-property-img" style="background:url('#thephoto#');"></span>
  	              <cfelse>
  	              	<span class="results-list-property-img" style="background:url('/#application.settings.mls.dir#/images/no-img.jpg');"></span>
  	              </cfif>
  	            </a>
              </div><!-- END results-list-property-img-wrap -->

  	          <div class="results-list-property-info-wrap">
  	            <!--- PROPERTY PRICE --->
  	            <span class="results-list-property-info-price">
                  $<cfif status eq 6 AND isdefined('soldprice') AND isValid('numeric',soldprice) AND soldprice gt 0>#NumberFormat(soldprice)#<cfelse>#NumberFormat(list_price)#</cfif>
  	            </span>

                <!--- PROPERTY INFO --->
  	            <ul class="results-list-property-info">
                  <cfif mlsnumber is not "">
      	            <li><i class="fa fa-hashtag site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="MLS Number"></i> MLS##: #mlsnumber#</li>
                  </cfif>
                  <cfif wsid eq 1 or wsid eq 5>
                    <li><i class="fa fa-bed site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bedrooms"></i> #bedrooms# Beds</li>
                    <li><i class="fa fa-bath site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bathrooms"></i> #baths_full# Baths</li>
                  </cfif>
                  <cfif acreage is not "">
                    <li><i class="fa fa-leaf site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Acreage"></i> #acreage# Acres</li>
                  </cfif>
                  <cfif zoning is not "">
                    <li><i class="fa fa-home site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Zoning"></i> Zoning: #zoning#</li>
                  </cfif>
                  <cfif style is not "">
                    <li><i class="fa fa-paint-brush site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Style"></i> Style: #style#</li>
                  </cfif>
                </ul><!-- END results-list-property-info -->
              </div><!-- END results-list-property-info-wrap -->
  	        </div><!-- END results-list-property -->
  	      </div>
        </cfoutput>

  <!--- THIS NEEDS TO BE UPDATED --->
  <!--- <cfset session.mapMarkerID = session.mapMarkerID + 1> --->

      </cfloop>
    <cfelse>
      <div class="results-no-properties">
        <p>No active listings were found matching your criteria.</p>
        <p>Please adjust your search fields.</p>
      </div>
    </cfif>
  </div>
</div><!-- END results-list-properties -->