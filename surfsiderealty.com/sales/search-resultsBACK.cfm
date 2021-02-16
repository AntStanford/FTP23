<cfinclude template="/mls/search-results_.cfm">
<cfinclude template="/mls/components/header.cfm"> 

<div class="flashMessages"></div>
<div id="content" class="full-width">
  <div class="mls-search-results">
    <h1>
      <cfoutput>
      <cfif isdefined('thepage') and len(thepage.h1tag)>
          #thepage.h1tag#
        <cfelseif  isdefined('thepage') and len(thepage.name)> 
          #thepage.name#
        <cfelse>
           MLS Search Results
      </cfif>
      </cfoutput>
    </h1>
    <div class="side">
      <div class="box search-options">
        <h4>Search Options</h4>
        <form action="/mls/search-results.cfm" class="enhanced-form" method="POST">
          <cfoutput>
            <input type="hidden" value="#mls.mlsid#" name="mlsid"/>
          </cfoutput>
          <div class="form-field">
            <label for="sortby">Sort By</label>
            <select id="sortby" name="sortby">
              <option <cfif isdefined('sortby') and sortby is "list_price DESC">selected</cfif> value="list_price DESC">Price (High to Low)</option>
              <option value="list_price ASC" <cfif isdefined('sortby') and sortby is "list_price ASC">selected</cfif>>Price (Low to High)</option>
              <option value="bedrooms DESC" <cfif isdefined('sortby') and sortby is "bedrooms DESC">selected</cfif>>Bedrooms</option>
              <option value="baths_full DESC" <cfif isdefined('sortby') and sortby is "baths_full DESC">selected</cfif>>Bathrooms</option>
              <option value="created_at DESC" <cfif isdefined('sortby') and sortby is "created_at DESC">selected</cfif>>Listing Date (Old to New)</option>
              <option value="created_at ASC" <cfif isdefined('sortby') and sortby is "created_at ASC">selected</cfif>>Listing Date (New to Old)</option>
            </select>
          </div>
          <div class="form-field">
            <label for="wsid">Property Type</label>
            <select id="wsid" name="wsid">
              <option value="">All Types</option>
              <cfloop index="i" list="#getmlscoinfo.wsid#">
                <cfoutput>
                  <option value="#listgetat(i,'1','~')#" <cfif isdefined('session.wsid') and session.wsid is "#listgetat(i,'1','~')#">selected</cfif>>#listgetat(i,'2','~')#</option>
                </cfoutput>
              </cfloop>
            </select>
          </div>

<div class="form-field">
  <cfquery datasource="#dsnmls#" name="getCities" cachedwithin="#CreateTimeSpan(0, 12, 0, 0)#">  
    SELECT distinct(city)
    FROM mastertable
    where mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">) and city <> ''
    order by city
  </cfquery>
            <label for="city">City</label>
            <select id="city" multiple="multiple" name="city">
                <cfoutput query="getCities">
                    <option value="#city#"
                      <cfif isdefined('session.city')>
                        <cfloop index="a" list="#session.city#" delimiters=",">
                          <cfif getCities.city is "#a#">selected</cfif>
                        </cfloop>
                      </cfif>
                    >#city#</option>
                  </cfoutput>
        

            </select>
          </div>



<cfif isdefined('session.area') and LEN(session.area)>
          <div class="form-field">
            <cfquery datasource="#dsnmls#" name="getareas">
              SELECT *
              FROM masterareas_cleaned
              where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
              order by city
            </cfquery>
            <label for="area">Area(s)</label>
            <select id="area" multiple="multiple" name="area">
<!---                            
                <cfoutput query="getareas">
                    <option value="#areashidden#"
                      <cfif isdefined('session.area')>
                        <cfloop index="a" list="#session.area#" delimiters=",">
                          <cfif getareas.areashidden is "#a#">selected</cfif>
                        </cfloop>
                      </cfif>
                    >#city#</option>
                  </cfoutput>
                   --->


              <cfoutput query="getareas">
                <option value="#areashidden#;"
                  <cfif isdefined('session.area') and LEN(session.area)>
                    <cfloop index="i" list="#session.area#" delimiters=";">
                      <cfif LEFT(i,1) eq ','><cfset cleanedarea = RemoveChars(i, 1, 1)><cfelse><cfset cleanedarea = i></cfif>
                     <cfif areashidden eq cleanedarea>SELECTED</cfif>
                    </cfloop>
                  </cfif>
                >#city#</option>
              </cfoutput>

            </select>
          </div>
</cfif>



          <div class="form-field">
            <label for="pmin">Minimum Price</label>
            <select id="pmin" name="pmin">
              <option value="0" <cfif isdefined('session.PMIN') is "No">selected</cfif>>No Min</option>
              <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
                <cfoutput>
                  <option value="#i#" <cfif isdefined('session.PMIN') and session.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                </cfoutput>
                <cfif #i# eq "1000000">
                  <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
                    <cfoutput>
                      <option value="#i#" <cfif isdefined('session.PMIN') and session.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                    </cfoutput>
                  </cfloop>
                  <cfbreak>
                </cfif>
              </cfloop>
            </select>
          </div>
          <div class="form-field">
            <label for="pmax">Maximum Price</label>
            <select id="pmax" name="pmax">
              <option value="999999999" selected>No Max</option>
              <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
                <cfoutput>
                  <option value="#i#" <cfif isdefined('session.PMAX') and session.pmax is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                </cfoutput>
                <cfif #i# eq "1000000">
                  <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
                    <cfoutput>
                      <option value="#i#" <cfif isdefined('session.PMAX') and session.pmax is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                    </cfoutput>
                  </cfloop>
                  <cfbreak>
                </cfif>
              </cfloop>
              <cfif isdefined('session.pmax') is "No" or isdefined('session.pmax') and session.pmax is "">
                <option value="999999999" selected>No Max</option>
              <cfelse>
                <option value="999999999" <cfif isdefined('session.PMAX') and session.pmax is "999999999">selected</cfif>>No Max</option>
              </cfif>
            </select>
          </div>
          <div class="form-field">
            <label for="bedrooms">Bedrooms</label>
            <select data-wsid="1" id="bedrooms" name="bedrooms">
              <option <cfif isdefined('session.bedrooms') and session.bedrooms is "">selected="selected"</cfif> value="">No Preference</option>
              <option value="1" <cfif isdefined('session.bedrooms') and session.bedrooms is "1">selected="selected"</cfif>>1+ Bedrooms</option>
              <option value="2" <cfif isdefined('session.bedrooms') and session.bedrooms is "2">selected="selected"</cfif>>2+ Bedrooms</option>
              <option value="3" <cfif isdefined('session.bedrooms') and session.bedrooms is "3">selected="selected"</cfif>>3+ Bedrooms</option>
              <option value="4" <cfif isdefined('session.bedrooms') and session.bedrooms is "4">selected="selected"</cfif>>4+ Bedrooms</option>
              <option value="5" <cfif isdefined('session.bedrooms') and session.bedrooms is "5">selected="selected"</cfif>>5+ Bedrooms</option>
              <option value="6" <cfif isdefined('session.bedrooms') and session.bedrooms is "6">selected="selected"</cfif>>6+ Bedrooms</option>
            </select>
          </div>
          <div class="form-field">
            <label for="baths_full">Bathrooms</label>
            <select data-wsid="1" id="baths_full" name="baths_full">
              <option <cfif isdefined('session.baths_full') and session.baths_full is "">selected="selected"</cfif> value="">No Preference</option>
              <option value="1" <cfif isdefined('session.baths_full') and session.baths_full is "1">selected="selected"</cfif>>1+ Bathrooms</option>
              <option value="2" <cfif isdefined('session.baths_full') and session.baths_full is "2">selected="selected"</cfif>>2+ Bathrooms</option>
              <option value="3" <cfif isdefined('session.baths_full') and session.baths_full is "3">selected="selected"</cfif>>3+ Bathrooms</option>
              <option value="4" <cfif isdefined('session.baths_full') and session.baths_full is "4">selected="selected"</cfif>>4+ Bathrooms</option>
              <option value="5" <cfif isdefined('session.baths_full') and session.baths_full is "5">selected="selected"</cfif>>5+ Bathrooms</option>
            </select>
          </div>
          <input class="button modify" type="submit" value="Update Search"/>
        </form>
      </div>
      <div class="box market-trends">
        <cfquery name="GetMarketTrend" datasource="#DSNMLS#">
          SELECT *
          FROM stats_by_mls
          where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
	  and `date` > <cfqueryparam value="#dateadd('d','-1',now())#" cfsqltype="CF_SQL_DATE">
          order by date desc
          limit 1;
        </cfquery>
        <cfoutput query="GetMarketTrend">
          <h4>Market Trends for<br>#getmlscoinfo.displayname#</h4>
          <ul id="trend-list">
            <lI>Last Updated: <I>#dateformat(date,'m/d/yy')#</I></lI>
            <lI><I>Market Snapshot</I>
              <ul>
                <lI>Total Properties Listed: <I>#GetMarketTrend.property_count#</I></lI>
                <lI>Average List Price: <I>#dollarformat(GetMarketTrend.average_price)#</I></lI>
                <lI>Median List Price: <I>#dollarformat(GetMarketTrend.median_price)#</I></lI>
              </ul>
            </lI>
          </ul>
        </cfoutput>
      </div>
    </div>
    <div class="box main">
      <cfif isdefined('ShowSEOText')>
        <cfoutput>
          <cfif listlen(thepage.body,'~') gt 1>
            #listgetat(thepage.body,'1','~')#
            <a href="#script_name#?slug=#slug###more">Read More...</a>
            <cfset remainingcopy = "#listgetat(thepage.body,'2','~')#">
          <cfelse>
            #ThePage.body#
          </cfif>
        </cfoutput>
      </cfif>
      <cfif getlistings.recordcount gt 0>
        <div class="box result-options">
          <ul class="pagination">
            <cfinclude template="/mls/search-results-pagination_.cfm">
          </ul>
          <ul class="result-info">
            <cfinclude template="/mls/search-results-savesearch-count_.cfm">
          </ul>
        </div>
        <ul class="search-results">
          <!--- <cfoutput><script src="http://maps.google.com/maps?file=api&v=2&key=#mls.googleAPIKey#&sensor=false" type="text/javascript"></script></cfoutput> --->
          <cfif isdefined('ShowMap')>
            <div class="notice">
              <p>Note: Map View only shows properties that have longitude and latitude coordinates.<br>Zoom map in/out to see properties out of view.</p>	
            </div>
            <cfinclude template="/mls/includes/mapper.cfm">		
          <cfelse>
            


            <!---START: STANDARD VIEW--->
            <cfset cnt = "0">
              <cfoutput query="GetListings">
                <cfset #cnt# = #cnt# + 1>
                <li class="search-result">
                  <a name="#cnt#"></a>
                  <cfinclude template="/mls/includes/image-handler.cfm">
                  <cfset seolink = optimizeMyURL(GetListings.street_number,GetListings.street_name,GetListings.city,GetListings.zip_code,GetListings.mlsnumber,GetListings.mlsid,GetListings.wsid)>			
                  <a href="#seoLink#"><cfif HowManyPhotos gt 0><IMG src="#getmlscoinfo.imageurl#/#thephoto#" width="150" border="1" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="150" border="1" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif></a>
                  <!---
                    <a href="/mls/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#"><cfif HowManyPhotos gt 0><IMG src="#getmlscoinfo.imageurl#/#thephoto#" width="150" border="1" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="150" border="1" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif></a>
                  --->
                  <cfif AddressDisplayYN is not "N">
                    <H3>#street_number# #street_name# <cfif LEN(unit_number)>#FormatUnit(unit_number)#</cfif><SPAN class="list-price">#dollarformat(list_price)# <cfif wsid is "4">/ Monthly</cfif></SPAN></H3>
                  </cfif>
                  <h4><cfif subdivision is not "" and subdivision is not "none">#subdivision#,</cfif> #city#, #state# #zip_code#</h4>
                  <P class="attributes">
                    <cfif bedrooms is not "">Bedroom(s): #bedrooms#  &nbsp;&nbsp;</cfif>
                    <cfif baths_full is not "">Full Baths: #baths_full#  &nbsp;&nbsp;</cfif>
                    <cfif acreage is not "">#acreage# Acres &nbsp;&nbsp;</cfif> 
                    <cfif zoning is not ""> Zoning: #zoning# &nbsp;&nbsp;</cfif> 
                    <cfif kind is not ""> Kind: #kind# &nbsp;&nbsp;</cfif>
                  </P>
                  <!--- <P class="provider">Courtesy of #listing_office_name#</P> --->
                  <ul class="actions">
                    <li class="view-property"><a class="button light" href="#seolink#" title="View MLS##: #mlsnumber#">View Property</a></lI>
                    <li class="favorite">
                      <cfif isdefined('cookie.LoggedIn')>
                        <cfquery name="CheckFavorite" dbtype="query">
                          SELECT *
                          FROM CheckFavorites
                          where clientid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#cookie.loggedin#"> and mlsnumber = '#mlsnumber#' and wsid = '#wsid#' and mlsid = '#mlsid#'
                        </cfquery>
                        <cfif CheckFavorite.recordcount gt 0>
                          <a class="button light" href="/mls/search-results.cfm?action=removefromfavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('page')>&page=#page#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#" >Remove Favorite</a>
                        <cfelse>
                          <a class="button light" href="/mls/search-results.cfm?action=addtofavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('page')>&page=#page#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#">Add Favorite</a>
                        </cfif>
                      <cfelse>
                        <a class="fb_dynamic button light" href="/mls/lightboxes/add-to-favorites.cfm?action=addtofavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('page')>&page=#page#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#&width=765&height=434">Add Favorite</a>
                      </cfif>
                    </lI>
                    <li class="more-info"><a class="fb_dynamic button light" href="/mls/lightboxes/request-more-information.cfm?action=requestinformation&wsid=#wsid#&mlsid=#mlsid#&mlsnumber=#mlsnumber#">Request Info</a></lI>
                    <li class="forward-friend"><a class="fb_dynamic button light" href="/mls/lightboxes/send-to-a-friend.cfm?action=SendToAFriend&SendToAFriendwsid=#wsid#&SendToAFriendmlsid=#mlsid#&SendToAFriendmlsnumber=#mlsnumber#&width=765&height=434">Send to a friend</a></lI>
                  </ul>
                </lI>
              </cfoutput>
              <!---END: STANDARD VIEW--->
            
            
            
            </cfif>
          </ul>
          <div class="box result-options">
            <ul class="pagination">
              <cfinclude template="/mls/search-results-pagination_.cfm">
            </ul>
            <ul class="result-info">
              <cfinclude template="/mls/search-results-savesearch-count_.cfm">
            </ul>
          </div>
          <cfelse>
            <h3>Your search did not produce any results.<br><br>  Please <a href="javascript:history.back()">go back</a> and adjust your search fields.</h3>
          </cfif>
          <cfif isdefined('remainingcopy')>
            <a name="more"></a>
            <cfoutput>#remainingcopy#</cfoutput>
          </cfif>
        </div>
      </div>
    </div>
    <cfinclude template="/mls/components/footer.cfm">
    <cfif isdefined('ShowMap')>
    <cfif getlistings.recordcount gt 0>
        <!--- START: Create center point --->
        <cfset cpoint_lat = "0">
        <cfset cpoint_long = "0">
        <cfoutput query="getlistings">
          <cfif LEN(latitude) and LEN(longitude)>
            <cfset cpoint_lat = cpoint_lat + latitude>
            <cfset cpoint_long = cpoint_long + longitude>
          </cfif>
        </cfoutput>
        <cfset cpoint_lat = cpoint_lat / getlistings.recordcount>
        <cfset cpoint_long = cpoint_long / getlistings.recordcount>
        <!--- END: Create center point --->


        <!--- Start: Map Data --->
        <script type="text/javascript">
            //  Make an array of the LatLng's of the markers you want to show
            var LatLngList = new Array (<cfoutput query="getlistings">new google.maps.LatLng (#latitude#, #longitude#)<cfif currentrow neq getlistings.recordcount>,</cfif></cfoutput>);

            // Set up the map
          google.maps.event.addDomListener(window, 'load', function() {
            var map = new google.maps.Map(document.getElementById('map'), {
              zoom: 8,
              <cfoutput>center: new google.maps.LatLng(#cpoint_lat#, #cpoint_long#),</cfoutput>
              mapTypeId: google.maps.MapTypeId.ROADMAP
            });

            // Handles infowindows from clicking pinpoint
            var infoWindow = new google.maps.InfoWindow();

            var onMarkerClick = function() {
              var marker = this;
              var markerinfo = marker.title;
              var latLng = marker.getPosition();
              infoWindow.setContent(marker.propdetail);
              infoWindow.open(map, marker);
            };

            google.maps.event.addListener(map, 'click', function() {
              infoWindow.close();
            });

           var infowindow = new google.maps.InfoWindow();

            // Loop through results and create map markers 
            <cfoutput query="getlistings">
              <cfinclude template="/mls/includes/image-handler.cfm">
              <cfset seolink = optimizeMyURL(GetListings.street_number,GetListings.street_name,GetListings.city,GetListings.zip_code,GetListings.mlsnumber,GetListings.mlsid,GetListings.wsid)>
                var marker#currentrow# = new google.maps.Marker({
                  map: map,
                  position: new google.maps.LatLng(#latitude#, #longitude#),
                  title: '$#trim(numberformat(list_price,"999,999,999"))#  #city#  MLS Number## #mlsnumber# ',
                  propdetail: "<table width='215' height='200'><tr><td style='font-size:8pt; text-align:Left; font-family: Verdana;'>#city#<Br>MLS Number #mlsnumber#<br>Listing Price: $#trim(numberformat(list_price,'999,999,999'))#</td></tr><tr><td><cfif HowManyPhotos gt 0><IMG src='#getmlscoinfo.imageurl#/#thephoto#' width='150' border='1' alt='#mls.companyname# - MLS Number: #mlsnumber#'><cfelse><IMG src='http://mls.icoastalnet.com/mls/images/not_avail.jpg' width='150' border='1' alt='#mls.companyname#- MLS Number: #mlsnumber#'></cfif><br><a href='#seolink#'>Click for more information...</a></td></tr></table>"
                });

              google.maps.event.addListener(marker#currentrow#, 'click', onMarkerClick);

              // Handles external link for infowindow
              google.maps.event.addDomListener(document.getElementById('locationid#currentrow#'), 'click',
                function(){
                  infowindow.setContent(marker#currentrow#.propdetail);
                  infowindow.open(map, marker#currentrow#);
                });

            </cfoutput>


            //  Create a new viewpoint bound
            var bounds = new google.maps.LatLngBounds ();
            //  Go through each...
            for (var i = 0, LtLgLen = LatLngList.length; i < LtLgLen; i++) {
            //  And increase the bounds to take this point
            bounds.extend (LatLngList[i]);
            }
            //  Fit these bounds to the map
            map.fitBounds (bounds);
         

          });
        </script> 
        <!--- End: Map Data --->
    </cfif>
    </cfif>
<!--- old prop url code /mls/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#&showmap=<cfif isdefined('start')>&start=#start#&page=#page#</cfif> --->

