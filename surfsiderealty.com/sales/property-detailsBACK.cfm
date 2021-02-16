<cfinclude template="/sales/property-details_.cfm">

<cfif GetListings.recordcount eq 0>
  <cfset nofollow = true>
</cfif>

<cfinclude template="/sales/components/header.cfm">




    <div class="flashMessages"></div>
    <div id="content" class="full-width">

  <cfif GetListings.recordcount eq 0>  
    <p><strong>No listing found with this MLS Number. <br> Please visit our <a href="/mls">Advanced Search Page</a> and try again.</strong></p> 
    <p>&nbsp;</p>
  </cfif>

      <cfoutput query="Getlistings">
        <div class="mls-property-details">
          <cfif isdefined('session.PrevNextMLSNumbers')>
            <div class="results-navigation">
              <ul>
                <cfset PreviousMLSNumberPosition = "#evaluate(listFind(session.PrevNextMLSNumbers,mlsnumber) - 1)#">
                <cfif PreviousMLSNumberPosition gt "0">
                  <cfset PreviousMLSNumber = "#listgetat(session.PrevNextMLSNumbers,PreviousMLSNumberPosition)#"> 
                  <cfquery DATASOURCE="#DSNMLS#" NAME="GetWSIDNext">
                    SELECT *
                    FROM mastertable
                    where mlsnumber = '#PreviousMLSNumber#' and mlsid = '#mlsid#'
                  </cfquery>
                  <cfset seolinkPrev = optimizeMyURL(#GetWSIDNext.street_number#,#GetWSIDNext.street_name#,#GetWSIDNext.city#,#GetWSIDNext.zip_code#,#GetWSIDNext.mlsnumber#,#GetWSIDNext.mlsid#,#GetWSIDNext.wsid#)>
                  <li class="prev-property"><a href="#seolinkPrev#" class="button light">&lt; Previous Result</a></li>
                </cfif>
                <!--- <li><a href="/sales/search-results.cfm?1=1<cfif isdefined('showmap')>&showmap=</cfif><cfif isdefined('start')>&start=#start#&page=#page#</cfif>" class="button light">Back to Search Results</a></li> --->
                <li><a href="/sales/search-results.cfm<cfif isdefined('session.searchpage')>?page=#session.searchpage#</cfif>" class="button light">Back to Search Results</a></li>
                <cfset NextMLSNumberPosition = "#evaluate(listFind(session.PrevNextMLSNumbers,mlsnumber) + 1)#">
                <cfif NextMLSNumberPosition lte "#listlen(session.PrevNextMLSNumbers)#">
                  <cfset NextMLSNumberPosition = "#listgetat(session.PrevNextMLSNumbers,NextMLSNumberPosition)#"> 
                  <cfquery DATASOURCE="#DSNMLS#" NAME="GetNextWSID">
                    SELECT *
                    FROM mastertable
                    where mlsnumber = '#NextMLSNumberPosition#' and mlsid = '#mlsid#'
                  </cfquery>
                  <cfset seolinkNext = optimizeMyURL(#GetNextWSID.street_number#,#GetNextWSID.street_name#,#GetNextWSID.city#,#GetNextWSID.zip_code#,#GetNextWSID.mlsnumber#,#GetNextWSID.mlsid#,#GetNextWSID.wsid#)>
                  <li class="next-property"><a href="#seolinkNext#" class="button light">Next Result &gt;</a></li>
                </cfif>
              </ul>
            </div>
          </cfif>
          <div class="side">
            <div class="box property-images">
              <div class="property-images-slideshowX">
                <cfinclude template="/sales/includes/image-handler.cfm">
                <cfif HowManyPhotos gt 0>
                  <a class="various" rel="group1" href="#getmlscoinfo.imageurl#/#ThePhoto#"><img src="#getmlscoinfo.imageurl#/#ThePhoto#" alt="#mls.companyname# - MLS Number: #mlsnumber#" width="100%"></a>
                  <cfloop index="i" list="#AllPhotos#">
                    <a class="various" rel="group1" href="#getmlscoinfo.imageurl#/#i#" style="display:none;"><img src="#getmlscoinfo.imageurl#/#i#" alt="#mls.companyname# - MLS Number: #mlsnumber#" width="100%" ></a>
                  </cfloop>
                  <cfif HowManyPhotos gt 1><p align="center" class="additional-photos-text">(#HowManyPhotos#) Additional Images.<br>Click Photo Above.</p><cfelse><p>&nbsp;</p></cfif>
                <cfelse>
                  <img src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" alt="#mls.companyname# - MLS Number: #mlsnumber#" width="100%">
                </cfif>
                <!---shareit code--->
                <div align="center">
                  <span class="st_facebook_large" displayText="Facebook"></span>
                  <span class="st_twitter_large" displayText="Tweet"></span>
                  <span class="st_email_large" displayText="email"></span>
                  <span class="st_pinterest_large" displayText="Pinterest"></span>
                </div>
                <!--- <ul class="social">
                  <li><a href="http://pinterest.com/pin/create/button/?url=#cgi.SERVER_NAME#//sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#&media=#getmlscoinfo.imageurl#/#ThePhoto#&description=#mls.companyname# MLS: #mlsnumber#" target="_blank" class="pin-it-button" count-layout="horizontal"><img border="0" src="http://assets.pinterest.com/images/PinExt.png" title="Pin It" /></a></li>
                  <li><a href="http://www.facebook.com/sharer.php?u=http://#cgi.SERVER_NAME#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#&t=Check out this awesome listing!" target="_blank" class="facebook"></a></li>
                  <li><iframe allowtransparency="true" frameborder="0" role="presentation" scrolling="no" src="http://platform.twitter.com/widgets/tweet_button.html?count=horizontal&url=http://#cgi.SERVER_NAME#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#&amp;via=#mls.companyname#&amp;text=Check Out This Great listing: #mlsnumber#" width="90" height="22"></iframe></li>
                </ul> --->
              </div>
            </div>
            <div class="box quick-links">
              <ul>
                <li><a href="/sales/printer-friendly.cfm?mlsnumber=#mlsnumber#&wsid=#wsid#&mlsid=#mlsid#" class="d-printer button" target="_blank">Printer Friendly Version</a></li>
                <li><a href="http://nces.ed.gov/globallocator/index.asp?search=1&State=#mls.state#&city=&zipcode=#mls.zip#&miles=10&itemname=&sortby=name&School=1&PrivSchool=1" class="d-nearby button" target="_blank">Nearby Schools</a></li>
                <!--- <li><a class="fb_dynamic" id="mortgage" href="/sales/lightboxes/mortgage-calculator.cfm?listingprice=#list_price#" style="width: 244px;">Mortgage Calculator</a></li> --->
                <li style="height: 50px;"><a id="mortgage" href="javascript:;" class="button">Mortgage Calculator</a></li>

                <cfif LEN(Virtual_Tour)>
                  <li><a id="mortgage" href="#optimizeVirtualTour(Virtual_Tour)#" class="fb_dynamic button" target="_blank">View Virtual Tour</a></li>
                </cfif>

              </ul>
              <div id="mortgage-output">
                <h4>Mortgage Calculator</h4>
                <iframe title="Mortgage Calculator" frameborder="0" height="470px" scrolling="no" width="100%" src="http://www.zillow.com/mortgage/SmallMortgageLoanCalculatorWidget.htm?price=<cfoutput>#list_price#</cfoutput>&wtype=spc&rid=102001&wsize=small&textcolor=736c5f&backgroundColor=f7f5f4&advTabColor=969086&bgcolor=e2e0dc&bgtextcolor=736c5f&headerTextShadow=fff">Your browser doesn't support frames. Visit <a href="http://www.zillow.com/mortgage-calculator/##{scid=mor-wid-calc}" target="_blank">Zillow Mortgage Calculators</a> to see this content.</iframe>
              </div>
            </div>
            <div class="box additional-info" role="complimentary">
              <h4>Additional Information</h4>
              <dl>
                <cfif kind is not "">
                  <dt>Kind</dt>
                  <dd>#kind#</dd>
                </cfif>
                <cfif parking is not "" and parking is not "0">
                  <dt>Parking</dt>
                  <cfloop index="i" list="#parking#">
                    <dd>#i#</dd>
                  </cfloop>
                </cfif>
                <cfif Lot_Description is not "">
                  <dt>Lot Description</dt>
                  <cfloop index="i" list="#Lot_Description#">
                    <dd>#i#</dd>
                  </cfloop>
                </cfif>
                <cfif Elementary_school is not "">
                  <dt>Elementary School</dt>
                  <dd>#Elementary_school#</dd>
                </cfif>
                <cfif Middle_school is not "">
                  <dt>Middle School</dt>
                  <dd>#Middle_school#</dd>
                </cfif>
                <cfif high_school is not "">
                  <dt>High School</dt>
                  <dd>#high_school#</dd>
                </cfif>
              </dl>
            </div>

             <cfif GetListings.recordcount gt 0 and GetListings.area is not "">
            <div class="box market-trends">
              <cfquery name="GetMarketTrend" datasource="#DSNMLS#">
        				SELECT date,property_count,average_price,median_price,average_bedrooms,average_bathrooms,average_square_footage,average_price_per_sq_ft
        				FROM stats_by_area
        				where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#"> and  area = <cfqueryparam cfsqltype="cf_sql_integer" value="#area#"> 
                and date >   <cfqueryparam cfsqltype="cf_sql_date" value="#dateadd("d", -10, now())#">
        				order by date DESC
        			   limit 1
        			</cfquery>

              <h4>Market Trends <cfif isdefined('getareas.city')>for<br>#getareas.city#</cfif></h4>
              <ul id="trend-list">
                <li>Last Updated: <I>#DateFormat(GetMarketTrend.date,'m/d/yy')#</I></li>
                <li><I>Market Snapshot</I>
                  <ul>
                    <li>Total Properties listed: <I>#GetMarketTrend.property_count#</I></li>
                    <li>Average list Price: <I>#dollarformat(GetMarketTrend.average_price)#</I></li>
                    <li>Median list Price: <I>#dollarformat(GetMarketTrend.median_price)#</I></li>
                  </ul>
                </li>
                <li><I>Typical Property</I>
                  <ul>
                    <li>
                      <b>
                        <cfswitch expression="#wsid#">
                          <cfcase value="1">Residential</cfcase>
                          <cfcase value="2">Land</cfcase>
                          <cfcase value="3">Commercial</cfcase>
                          <cfcase	value="4">Rentals</cfcase>
                          <cfcase value="5">Condo / Villa</cfcase>
                          <cfcase value="6">Multi-Family</cfcase>
                          <cfcase value="7">Boat Slips</cfcase>
                          <cfdefaultcase>Other</cfdefaultcase>
                        </cfswitch>
                      </b>
                    </li>
                    <cfif wsid is "1" or wsid is "5">
                      <li>#GetMarketTrend.average_bedrooms# Bedrooms</li>
                      <li>#GetMarketTrend.average_bathrooms# Baths</li>
                    </cfif>
                    <li>#GetMarketTrend.average_square_footage# Square Feet</li>
                    <li>$#GetMarketTrend.average_price_per_sq_ft# / Sq. Ft.</li>
                  </ul>
                </li>
                <!--- <cfif wsid is "1" or wsid is "5">
                  <li><I>Average Price by Bedrooms</I>
                    <ul>
                      <cfset strData = CharsetEncode(GetMarketTrend.average_price_per_bedroom,"ISO-8859-1")>
                      <cfset strDataLength = "#listlen(strData,':')#">
                      <cfset cnt = 0>
                      <cfloop index="i" list="#strData#" delimiters=":">
                        <cfset cnt = #cnt# + 1>
                        <cfif cnt gt 1>
                          <cfset NumberOfRooms = "#listgetat(i,'2',',')#">
                          <cfset NumberOfRooms = #replacenocase(NumberOfRooms,'"','')#>
                          <cfset NumberOfRooms = #replacenocase(NumberOfRooms,'"','')#>
                          <cfset PricePerRoom = "#listgetat(i,'1',',')#">
                          <li>#NumberOfRooms# Bedroom(s) <I>#dollarformat(PricePerRoom)#</I></li>
                          <cfif strDataLength - 1 eq cnt>
                            <cfbreak>
                          </cfif>
                        </cfif>
                      </cfloop>
                    </ul>
                  </li>
                </cfif> --->
              </ul>
            </div>
          </cfif>



            <!---START: NEXT AGENT ON ROTATION--->
                <cfif isdefined('cookie.LoggedIn')>
                  <!---fyi - the getaccountinfo. query below is in the /components/header.cfm file--->
                  <cfquery name="GetAgent" datasource="#mls.dsn#">
                    select *
                    from cl_agents
                    where id = <cfqueryparam value="#GetAccountInfo.agentid#" cfsqltype="CF_SQL_VARCHAR">
                  </cfquery>
                <cfelse>
                  <cfquery name="GetAgent" datasource="#mls.dsn#">
                    select *
                    from cl_agents
                    where RoundRobinNow = 'Next'
                  </cfquery>
                </cfif>

            <cfif mls.EnableRoundRobin is "Yes" and GetAgent.recordcount gt 0>
              <div class="box area">
                <h4>Area Specialist</h4>
                #GetAgent.FirstName# #GetAgent.Lastname# <cfif isdefined('cookie.LoggedIn')>is your area specialist!</cfif><br>
                <img src="/sales/images/agents/sm_#GetAgent.agentphoto#">
                <cfif GetAgent.phone is not ""><br>#GetAgent.phone#</cfif>
                <cfif GetAgent.cellphone is not ""><br>#GetAgent.cellphone#</cfif>
                <br><a href="/sales/lightboxes/request-more-information.cfm?action=requestinformation&wsid=#wsid#&mlsid=#mlsid#&mlsnumber=#mlsnumber#&width=545&height=474" class="fb_dynamic" title="Request more information about this property.">Contact Me Today!</a>
              </div>
            </cfif>
   
            <!--- For the Lightbox   --->     
            <cfset returnlink = #optimizeMyURL(GetListings.street_number,GetListings.street_name,GetListings.city,GetListings.zip_code,GetListings.mlsnumber,GetListings.mlsid,GetListings.wsid)#>

          <!---START: NEXT AGENT ON ROTATION--->
          </div>
          <div class="box main">
            <h1><em>#dollarformat(list_price)# <cfif wsid is "4">/ Monthly</cfif></em> #street_number# #street_name# <cfif LEN(unit_number)>#FormatUnit(unit_number)#</cfif></h1>
            <ul class="box details-list">
              <li><b>MLS##:</b>#mlsnumber#</li>
              <li><b>Address:</b> <cfif AddressDisplayYN is not "N">#street_number# #street_name# <cfif LEN(unit_number)>#FormatUnit(unit_number)#</cfif><cfelse>N/A</cfif></li>
              <li><b>City / Zip:</b>#city#, #state# #zip_code#</li>
              <li><b>Area:</b><cfif isdefined('getareas.city')>#getareas.city#</cfif></li>
              <li><b>County:</b>#county#</li>
              <cfif subdivision is not ""><li><b>Neighborhood:</b>#subdivision#</li></cfif>
              <cfif bedrooms is not ""><li><b>Bedrooms:</b>#bedrooms#</li></cfif>
              <cfif baths_full is not ""><li><b>Bathrooms:</b>#baths_full#</li></cfif>
              <cfif baths_half is not ""><li><b>1/2 Bathrooms:</b>#baths_half#</li></cfif>
              <cfif total_heated_square_feet is not ""><li><b>Sq Ft:</b>#trim(numberformat(total_heated_square_feet,'__,___,___'))#</li></cfif>
              <cfif building_square_feet is not ""><li><b>Sq Ft:</b>#trim(numberformat(building_square_feet,'__,___,___'))#</li></cfif>
              <cfif ACREAGE is not ""><li><b>Acres:</b>#ACREAGE#</li></cfif>
              <cfif stories is not "0" and stories is not ""><li><b>Stories:</b>#stories#</li></cfif>
              <cfif year_built is not "0" and year_built is not ""><li><b>Year Built:</b>#year_built#</li></cfif>
              <cfif zoning is not ""><li><b>Zoning:</b>#zoning#</li></cfif>
              <li><b>Date Listed:</b>#dateformat(GetDatelisted.created_at,'mm/dd/yyyy')#</li>
              <cfif association_fee is not ""><li><b>POA Fees:</b>#association_fee#</li></cfif>
              <cfif property_type is not ""><li><b>Property Type:</b> #property_type# </li></cfif>
            </ul>
            <ul class="box take-action">This listing is provided courtesy by <b>#listing_office_name#</b>.</ul>
            <ul class="box take-action">
              <li class="favorite">
                <cfif isdefined('cookie.LoggedIn')>
                  <cfquery name="CheckFavorite" dbtype="query">
                    SELECT *
                    FROM CheckFavorites
                    where clientid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#cookie.loggedin#"> and mlsnumber = '#mlsnumber#' and wsid = '#wsid#' and mlsid = '#mlsid#'
                  </cfquery>
                  <cfif CheckFavorite.recordcount gt 0>
                    <a class="button light" href="/sales/property-details.cfm?action=removefromfavorites&FavoriteWSID=#wsid#&FavoritemLSID=#mlsid#&Favoritemlsnumber=#mlsnumber#" title="Add or remove this property from your favorites.">Remove Favorite</a>
                  <cfelse>
                    <a class="button light" href="/sales/property-details.cfm?action=addtofavorites&FavoriteWSID=#wsid#&FavoritemLSID=#mlsid#&Favoritemlsnumber=#mlsnumber#" title="Add or remove this property from your favorites.">Add Favorite</a>
                  </cfif>
                <cfelse>
                  <a class="button light fb_dynamic" href="/sales/lightboxes/add-to-favorites.cfm?action=addtofavorites&FavoriteWSID=#wsid#&FavoritemLSID=#mlsid#&Favoritemlsnumber=#mlsnumber#&width=765&height=384" title="Add or remove this property from your favorites.">Add Favorite</a>
                </cfif>
              </li>
<!---               <li class="more-info"><a class="button light fb_dynamic" href="/sales/lightboxes/request-more-information.cfm?action=requestinformation&wsid=#wsid#&mlsid=#mlsid#&mlsnumber=#mlsnumber#&width=600&height=474" title="Request more information about this property.">Request More Info</a></li></li> --->
              <li class="more-info"><a class="button light" href="##inquire" title="Request more information about this property.">Request More Info</a></li></li>
              <li class="forward-friend"><a class="button light fb_dynamic" href="/sales/lightboxes/send-to-a-friend.cfm?action=SendtoAFriend&SendtoAFriendwsid=#wsid#&SendtoAFriendmlsid=#mlsid#&SendtoAFriendmlsnumber=#mlsnumber#&width=765&height=434">Send to a friend</a></li>
            </ul>
            <div class="box agent-comments contained">
              <h4>Agent's Comments</h4>
              <p>#remarks#</p>
            </div>
            
            
            
            <!---START: IF ALLOWED TO SHOW THE ADDRESS THEN SHOW THE MAPS--->
            <cfif AddressDisplayYN is not "N">
                <cfif  isdefined('latitude') and isdefined('longitude') and LEN(latitude) and LEN(longitude)>
                  <div class="box streetview contained">
                  <!---          
                  <h4>Street View</h4>
                  <div class="google-map" id="google-street-view" style="width:100%;height:250px;"></div>            
                  <script type="text/javascript">
                  function initializeMap(){load_map_and_street_view_from_address("#street_number# #street_name#, #city#, #state# #zip_code#");}
                  </script>            
                  --->     
                  <cfinclude template="/sales/includes/street-view.cfm">
                  </div>
                </cfif>

              <div class="box walkscore contained">
                <script type="text/javascript">
                var ws_wsid='';var ws_width='545';var ws_height='268';var ws_layout='horizontal';var ws_transit_score='true';var ws_commute='true';var ws_map_modules='all';var ws_address="#street_number# #street_name#, #city#, #state# #zip_code#";
                </script>            
                <style type='text/css'>
                ##ws-walkscore-tile{position:relative;text-align:left}
                ##ws-walkscore-tile *{float:none}
                ##ws-footer a,##ws-footer a:link{font:11px/14px Verdana,Arial,Helvetica,sans-serif;margin-right:6px;white-space:nowrap;padding:0;color:##000;font-weight:bold;text-decoration:none}
                ##ws-footer a:hover{color:##777;text-decoration:none}
                ##ws-footer a:active{color:##b14900}
                </style>
                <div id='ws-walkscore-tile'>
                  <div id='ws-footer' style='position:absolute;top:286px;left:8px;width:100%'></div>
                </div>
                <script type='text/javascript' src='http://www.walkscore.com/tile/show-walkscore-tile.php'></script>
              </div>            
            </cfif>
            <!---END: IF ALLOWED TO SHOW THE ADDRESS THEN SHOW THE MAPS--->
           
            
   <!--- START: determine how many amentities are listed below and what is the last section to be listed --->
<cfset amenitylist = "0">
<cfset lastamenity = "none">
<cfif LEN(interior_features)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "interior_features"></cfif>
<cfif LEN(exterior_features) or LEN(Miscellaneous_Exterior)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "exterior_features"></cfif>
<cfif LEN(rooms)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "rooms"></cfif>
<cfif LEN(utilities)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "utilities"></cfif>
<cfif LEN(Flooring)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "Flooring"></cfif>
<cfif LEN(appliances)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "appliances"></cfif>
<cfif LEN(cooling)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "cooling"></cfif>
<cfif LEN(fireplace)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "fireplace"></cfif>
<cfif LEN(roof)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "roof"></cfif>
<cfif LEN(dining_description)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "dining_description"></cfif>
<cfif LEN(lotfront)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "lotfront"></cfif>
<!--- <cfif LEN(lot_description)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "lot_description"></cfif> --->
<cfif LEN(waterfront_type) or LEN(water_view_type)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "waterfront_type"></cfif>
 <!--- Determine if its odd amount --->
<cfif amenitylist mod 2 neq 0><cfset oddamenities = "yes"></cfif>

 
<cfif amenitylist neq "0">
            <div class="box property-amenities">
              <h2>Property Amenities</h2>
              <ul class="amenities-list">
                <cfif interior_features is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'interior_features'>style="width:100%;"</cfif>>
                  <h4>Interior Features</h4>
                  <ul>
                    <cfloop index="i" list="#interior_features#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif exterior_features is not "" or Miscellaneous_Exterior is not "">
                <li class="item" <cfif isdefined('oddamenities') and (lastamenity eq 'exterior_features' or lastamenity eq 'Miscellaneous_Exterior')>style="width:100%;"</cfif>>
                  <h4>Exterior Features</h4>
                  <ul>
                    <cfloop index="i" list="#exterior_features#">
                      <li>#i#</li>
                    </cfloop>
                    <cfloop index="i" list="#Miscellaneous_Exterior#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif rooms is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'rooms'>style="width:100%;"</cfif>>
                  <h4>Rooms</h4>
                  <ul>
                    <cfloop index="i" list="#rooms#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif utilities is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'utilities'>style="width:100%;"</cfif>>
                  <h4>Utilities to Site</h4>
                  <ul>
                    <cfloop index="i" list="#utilities#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif Flooring is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'Flooring'>style="width:100%;"</cfif>>
                  <h4>Flooring</h4>
                  <ul>
                    <cfloop index="i" list="#Flooring#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif appliances is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'appliances'>style="width:100%;"</cfif>>
                  <h4>Appliances</h4>
                  <ul>
                    <cfloop index="i" list="#appliances#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif cooling is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'cooling'>style="width:100%;"</cfif>>
                  <h4>Cooling / Heating</h4>
                  <ul>
                    <cfloop index="i" list="#cooling#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif fireplace is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'fireplace'>style="width:100%;"</cfif>>
                  <h4>Fireplace</h4>
                  <ul>
                    <cfloop index="i" list="#fireplace#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif roof is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'roof'>style="width:100%;"</cfif>>
                  <h4>Roof</h4>
                  <ul>
                    <cfloop index="i" list="#roof#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif dining_description is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'dining_description'>style="width:100%;"</cfif>>
                  <h4>Dining Area</h4>
                  <ul>
                    <cfloop index="i" list="#dining_description#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif lotfront is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'lotfront'>style="width:100%;"</cfif>>
                  <h4>Lot Size</h4>
                  <ul>
                    <li>#lotfront# front</li>
                    <li>#lotright# right</li>
                    <li>#lotrear# rear</li>
                    <li>#lotleft# left</li>
                  </ul>
                </li>
              </cfif>
<!---               <cfif lot_description is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'lot_description'>style="width:100%;"</cfif>>
                  <h4>Lot Description</h4>
                  <ul>
                    <cfloop index="i" list="#lot_description#" delimiters=",">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif> --->
              <cfif waterfront_type is not "" or water_view_type is not "">
                <li class="item" <cfif isdefined('oddamenities') and (lastamenity eq 'waterfront_type' or lastamenity eq 'water_view_type')>style="width:100%;"</cfif>>
                  <h4>Waterfront / View</h4>
                  <ul>
                    <cfif waterfront_type is not ""><li>#waterfront_type#</li></cfif>
                    <cfif water_view_type is not "" and #water_view_type# is not #waterfront_type#><li>#water_view_type#</li></cfif>
                  </ul>
                </li>
              </cfif>
            </ul>
          </div>
</cfif>

            <!--- <cfif Find('216.99.114.157',#cgi.REMOTE_ADDR#)> --->
              <div class="box property-amenities">
                <a name="inquire"></a>
                <cfinclude template="/sales/lightboxes/request-more-information-form.cfm">
              </div>
            <!--- </cfif> --->
            
        </div>
        <div class="box disclaimer">
          <cfoutput>
            <p>Listings provided courtesy of #getmlscoinfo.displayname#<!---  and #listing_office_name# --->.</p>
            <p><I>Information Deemed Reliable But Not Guaranteed</I></p>
            <p class="copyright">Copyright &copy; #dateformat(now(),'YYYY')# #getmlscoinfo.displayname# - All Rights Reserved</p>
          </cfoutput>
        </div>
      </div>
    </cfoutput>
  </div>

<cfinclude template="/sales/components/footer.cfm">

<!---START: liMITED DETAIL VIEWS ALLOWED UNTIL emAIL IS CAPTURED--->
<cfif isdefined('cookie.detailview')>
  <cfset HowManyViews = #cookie.detailview# + 1>
  <cfcookie name="detailview" value="#HowManyViews#" expires="NEVER">
<cfelse>
  <cfcookie name="detailview" value="1" expires="NEVER">
</cfif>

 

<cfif isdefined('cookie.loggedin') is "No" and #cookie.detailview# gt #NumberOfViews# and isdefined('dashboard') is "No" and isdefined('dcr') is "No">
  <cfoutput>
  <script>
  jQuery(document).ready(function() {
    $.fancybox('<div style="width:780px"><iframe src="/sales/lightboxes/create-account.cfm?nomoreviewsallowed=" width="775" height="480" frameborder="0"></iframe></div>', {'enableEscapeButton': false,'showCloseButton': false, 'hideOnContentClick': true,'scrolling': false, 'hideOnOverlayClick': false, 'afterClose'  : function() {location.href = "/sales/search-results.cfm";}, 'width': '75%', 'height': '75%', 'autoScale': false, 'overlayOpacity': 0.9 });
  });
  </script>
  </cfoutput>
</cfif>
