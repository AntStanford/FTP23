<cfinclude template="/sales/search-results_.cfm">
<cfinclude template="/sales/components/header.cfm">

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
        <form action="/sales/search-results.cfm" class="enhanced-form" method="POST">
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
            <cfquery datasource="#dsnmls#" name="getareas">
              SELECT *
              FROM masterareas_cleaned
              where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
              order by city
            </cfquery>
            <label for="area">Area(s)</label>
            <select id="area" multiple="multiple" name="area">
              <cfoutput query="getareas">
                <option value="#areashidden#"
                  <cfif isdefined('session.area')>
                    <cfloop index="a" list="#session.area#" delimiters=",">
                      <cfif getareas.areashidden is "#a#">selected</cfif>
                    </cfloop>
                  </cfif>
                >#city#</option>
              </cfoutput>
            </select>
          </div>
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
              <option value="1" <cfif isdefined('session.bedrooms') and session.bedrooms is "1">selected="selected"</cfif>>1 Bedroom(s)</option>
              <option value="2" <cfif isdefined('session.bedrooms') and session.bedrooms is "2">selected="selected"</cfif>>2 Bedroom(s)</option>
              <option value="3" <cfif isdefined('session.bedrooms') and session.bedrooms is "3">selected="selected"</cfif>>3 Bedroom(s)</option>
              <option value="4" <cfif isdefined('session.bedrooms') and session.bedrooms is "4">selected="selected"</cfif>>4 Bedroom(s)</option>
              <option value="5" <cfif isdefined('session.bedrooms') and session.bedrooms is "5">selected="selected"</cfif>>5 Bedroom(s)</option>
              <option value="6" <cfif isdefined('session.bedrooms') and session.bedrooms is "6">selected="selected"</cfif>>6 Bedroom(s)</option>
            </select>
          </div>
          <div class="form-field">
            <label for="baths_full">Bathrooms</label>
            <select data-wsid="1" id="baths_full" name="baths_full">
              <option <cfif isdefined('session.baths_full') and session.baths_full is "">selected="selected"</cfif> value="">No Preference</option>
              <option value="1" <cfif isdefined('session.baths_full') and session.baths_full is "1">selected="selected"</cfif>>1 Bathroom(s)</option>
              <option value="2" <cfif isdefined('session.baths_full') and session.baths_full is "2">selected="selected"</cfif>>2 Bathroom(s)</option>
              <option value="3" <cfif isdefined('session.baths_full') and session.baths_full is "3">selected="selected"</cfif>>3 Bathroom(s)</option>
              <option value="4" <cfif isdefined('session.baths_full') and session.baths_full is "4">selected="selected"</cfif>>4 Bathroom(s)</option>
              <option value="5" <cfif isdefined('session.baths_full') and session.baths_full is "5">selected="selected"</cfif>>5 Bathroom(s)</option>
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
            <cfinclude template="/sales/search-results-pagination_.cfm">
          </ul>
          <ul class="result-info">
            <cfinclude template="/sales/search-results-savesearch-count_.cfm">
          </ul>
        </div>
        <ul class="search-results">
          <cfoutput><script src="http://maps.google.com/maps?file=api&v=2&key=#mls.googleAPIKey#&sensor=false" type="text/javascript"></script></cfoutput>
          <cfif isdefined('ShowMap')>
            <div class="notice">
              <p>Note: Map View only shows properties that have longitude and latitude coordinates.<br>Zoom map in/out to see properties out of view.</p>	
            </div>
            <cfinclude template="/sales/includes/mapper.cfm">
          <cfelse>
            


            <!---START: STANDARD VIEW--->
            <cfset cnt = "0">
              <cfoutput query="GetListings">
                <cfset #cnt# = #cnt# + 1>
                <li class="search-result">
                  <a name="#cnt#"></a>
                  <cfinclude template="/sales/includes/image-handler.cfm">
                  <cfset seolink = optimizeMyURL(street_number,street_name,city,zip_code,mlsnumber,mlsid,wsid)>			
                  <a href="#seoLink#"><cfif HowManyPhotos gt 0><IMG src="#getmlscoinfo.imageurl#/#thephoto#" width="150" border="1" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="150" border="1" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif></a>
                  <!---
                    <a href="/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#"><cfif HowManyPhotos gt 0><IMG src="#getmlscoinfo.imageurl#/#thephoto#" width="150" border="1" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="150" border="1" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif></a>
                  --->
                  <cfif AddressDisplayYN is not "N">
                    <H3>#street_number# #street_name# <SPAN class="list-price">#dollarformat(list_price)# <cfif wsid is "4">/ Monthly</cfif></SPAN></H3>
                  </cfif>
                  <h4><cfif subdivision is not "" and subdivision is not "none">#subdivision#,</cfif> #city#</h4>
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
                          <a class="button light" href="/sales/search-results.cfm?action=removefromfavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('page')>&page=#page#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#" title="Add or Remove this property from your favorites.">Remove Favorite</a>
                        <cfelse>
                          <a class="button light" href="/sales/search-results.cfm?action=addtofavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('page')>&page=#page#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#" title="Add or Remove this property from your favorites.">Add Favorite</a>
                        </cfif>
                      <cfelse>
                        <a class="button light fb_dynamic" href="/sales/lightboxes/add-to-favorites.cfm?action=addtofavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('page')>&page=#page#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#&width=765&height=434" title="Add or Remove this property from your favorites.">Add Favorite</a>
                      </cfif>
                    </lI>
                    <li class="more-info"><a class="fb_dynamic button light" href="/sales/lightboxes/request-more-information.cfm?action=requestinformation&wsid=#wsid#&mlsid=#mlsid#&mlsnumber=#mlsnumber#&width=650&height=484" title="Request more information about this property.">Request Info</a></lI>
                    <li class="forward-friend"><a class="fb_dynamic button light" href="/sales/lightboxes/send-to-a-friend.cfm?action=SendToAFriend&SendToAFriendwsid=#wsid#&SendToAFriendmlsid=#mlsid#&SendToAFriendmlsnumber=#mlsnumber#&width=765&height=434" title="Send this property to a friend.">Send to a friend</a></lI>
                  </ul>
                </lI>
              </cfoutput>
              <!---END: STANDARD VIEW--->
            
            
            
            </cfif>
          </ul>
          <div class="box result-options">
            <ul class="pagination">
              <cfinclude template="/sales/search-results-pagination_.cfm">
            </ul>
            <ul class="result-info">
              <cfinclude template="/sales/search-results-savesearch-count_.cfm">
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
    <cfinclude template="/sales/components/footer.cfm">
    <cfif isdefined('ShowMap')>
      <script type="text/javascript">
      <!--- Create Google markers for each property--->
      <cfset cnt=0>
      <cfloop query="GetListings" >
        <cfset #cnt# = #cnt# + 1>
        <cfoutput>
          var propicon#cnt# = new GIcon();
          propicon#cnt#.image = "/sales/images/google-map/red#cnt#.png";
          propicon#cnt#.shadow = "/sales/images/google-map/images/shadow50.png";
          propicon#cnt#.iconSize = new GSize(20, 34);
          propicon#cnt#.shadowSize = new GSize(1, 1);
          propicon#cnt#.iconAnchor = new GPoint(9, 34);
          propicon#cnt#.infoWindowAnchor = new GPoint(18, 25);
        </cfoutput>
      </cfloop>
      <!--- Set up the map parameters --->
      var map = new GMap2(document.getElementById("map_canvas"));
      function showPropDetails(point,detail) {
        map.setCenter(point,10);
        map.openInfoWindowHtml(point,detail);
      }
      map.addControl(new GLargeMapControl()); 
      map.addControl(new GMapTypeControl()); 
      <cfoutput>var center = new GLatLng(#GetListings.latitude#, #GetListings.longitude#);</cfoutput>
      map.setCenter(center, 10); 
      <!--- Set the markers --->
      <cfset cnt=0>
      <cfloop query="GetListings" >
        <cfinclude template="/sales/includes/image-handler.cfm">
        <cfset #cnt# = #cnt# + 1>
        <cfoutput>
          var prop#cnt# = new GLatLng(#latitude#, #longitude#);
          var prop#cnt#Marker = new GMarker(prop#cnt#,propicon#cnt#);
          var prop#cnt#Detail = "<table width='215' height='200'><tr><td style='font-size:8pt; text-align:Left; font-family: Verdana;'>#city#<Br>MLS Number #mlsnumber#<br>Listing Price: $#trim(numberformat(list_price,'999,999,999'))#</td></tr><tr><td><cfif HowManyPhotos gt 0><IMG src='#getmlscoinfo.imageurl#/#thephoto#' width='150' border='1' alt='#mls.companyname# - MLS Number: #mlsnumber#'><cfelse><IMG src='http://mls.icoastalnet.com/mls/images/not_avail.jpg' width='150' border='1' alt='#mls.companyname#- MLS Number: #mlsnumber#'></cfif><br><a href='/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#&showmap=<cfif isdefined('start')>&start=#start#&page=#page#</cfif>'>Click for more information...</a></td></tr></table>";
          map.addOverlay(prop#cnt#Marker);
          GEvent.addListener(prop#cnt#Marker, "click", function(){prop#cnt#Marker.openInfoWindowHtml(prop#cnt#Detail);});
        </cfoutput>
      </cfloop>
    </script>
  </cfif>

