<cfinclude template="/sales/index_.cfm">
<cfinclude template="/sales/components/header.cfm">

<cfif isdefined('LinkToLogin') and (isdefined('session.loggedin') is "No" or isdefined('cookie.loggedin') is "No")>
  <script>
  $(document).ready(function(){
    $.fancybox('<div style="width:780px"><iframe src="/sales/lightboxes/create-account.cfm" width="765" height="434" frameborder="0"></iframe></div>',{'enableEscapeButton': false,'showCloseButton': false,'hideOnContentClick': true,'hideOnOverlayClick': false,'width': '75%','height': '75%','autoScale': false,'overlayOpacity': 0.9});
  });
  </script>
</cfif>



<!--- Start: Used to close Lightbox and Reload page --->
<cfset session.RememberMePage = "#script_name#?#query_string#">
<!--- End: Used to close Lightbox and Reload page --->



<div class="flashMessages"></div>
<div id="content" class="full-width">
  <div class="mls-advanced-search">
    <h1>MLS Advanced Search</h1>
    <div class="adv-welcome">
      <div class="welcome-user">
        <cfif isdefined('session.loggedin') or isdefined('cookie.loggedin')>
          <cfoutput>
            <h2>Welcome, #capFirstTitle(lcase(cookie.UserFirstName))#</h2>
            <p>You are currently logged in.  If you are on a public computer, please don't forget to <a href="/sales/index.cfm?logout=">logout</a>.</p>
          </cfoutput>
        <cfelse>
          <h2>Welcome Guest</h2>
          <P>It appears you aren't logged in, please <A href="/sales/lightboxes/login.cfm" class="fb2_login">login now</A> to activate the saved search and favorite property features.</P>
          <P>If you don't have an account with us, you can take a minute to <A href="/sales/lightboxes/create-account.cfm" class="fb2_register">register</A> for our site.</P>
        </cfif>
      </div>
    </div>
    
    
          
    <cfif cgi.path_info contains 'commercial'>
      <form action="/commercial/search-results.cfm" class="mls-search-form enhanced-form" method="POST">
    <cfelse>
      <form action="/sales/search-results.cfm" class="mls-search-form enhanced-form" method="POST">
    </cfif>
    
   
      <cfoutput>
        <input type="hidden" value="#mls.mlsid#" name="mlsid"/>
      </cfoutput>
      <div class="search-details">
        <h3><em>Step 1 |</em> Search Details</h3>
        <cfquery name="getmlscoinfo" datasource="#DSNMLS#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
          SELECT *
          FROM mlsfeeds
          where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
        </cfquery>
        <div class="form-field">
          <label for="wsid">Property Type</label>
          <select id="wsid" name="wsid">
            <option value="">All Types</option>
            <cfloop index="i" list="#getmlscoinfo.wsid#">
              <cfoutput>
                <option value="#listgetat(i,'1','~')#">#listgetat(i,'2','~')#</option>
              </cfoutput>
            </cfloop>
          </select>
        </div>
        <div class="form-field">
          <label for="sortby">Sort By</label>
          <select id="sortby" name="sortby">
            <option value="list_price DESC">Price (High to Low)</option>
            <option value="list_price ASC">Price (Low to High)</option>
            <option value="bedrooms DESC">Bedrooms</option>
            <option value="baths_full DESC">Bathrooms</option>
            <option value="created_at DESC">Listing Date (Old to New)</option>
            <option value="created_at ASC">Listing Date (New to Old)</option>
          </select>
        </div>
        <fieldset class="stipulation-options">
          <legend>Stipulations</legend>
          <div class="checkbox-form-field">         
            <input id="stipulation-foreclosure" name="stipulations" type="checkbox" value="foreclosure"/>
            <label for="stipulation-foreclosure">Foreclosures</label>
          </div>
          <div class="checkbox-form-field">         
            <input id="stipulation-short-sale" name="stipulations" type="checkbox" value="short"/>
            <label for="stipulation-short-sale">Short Sales</label>
          </div>
        </fieldset>
      </div>
      <div class="basic-criteria">
      <cfquery name="getKinds" datasource="#DSNMLS#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
          SELECT distinct KIND
          FROM mastertable
          where mlsid = <cfqueryparam value="#mls.mlsid#" cfsqltype="cf_sql_integer"> and kind <> <cfqueryparam value="" cfsqltype="cf_sql_varchar">
          order by Kind ASC
        </cfquery>
        <h3><em>Step 2 |</em> Basic Criteria</h3>
        <div class="form-field">
          <label for="pmin">Minimum Price</label>
          <select id="pmin" name="pmin">
            <option value="0" <cfif isdefined('PMIN') is "No">selected</cfif>>No Min</option>
            <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
              <cfoutput>
                <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
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
                <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#" <cfif #mls.pricerangemax# is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                </cfloop>
                <cfbreak>
              </cfif>
            </cfloop>
            <option value="999999999" <cfif isdefined('PMAX') is "No">selected</cfif>>No Max</option>
          </select>
        </div>
        <div class="form-field">
          <label for="bedrooms">Bedrooms</label>
          <select data-wsid="1" id="bedrooms" name="bedrooms">
            <option selected="selected" value="">No Preference</option>
            <option value="1">1+ Bedrooms</option>
            <option value="2">2+ Bedrooms</option>
            <option value="3">3+ Bedrooms</option>
            <option value="4">4+ Bedrooms</option>
            <option value="5">5+ Bedrooms</option>
            <option value="6">6+ Bedrooms</option>
          </select>
        </div>
        <div class="form-field">
          <label for="baths_full">Bathrooms</label>
          <select data-wsid="1" id="baths_full" name="baths_full">
            <option selected="selected" value="">No Preference</option>
            <option value="1">1+ Bathrooms</option>
            <option value="2">2+ Bathrooms</option>
            <option value="3">3+ Bathrooms</option>
            <option value="4">4+ Bathrooms</option>
            <option value="5">5+ Bathrooms</option>
          </select>
        </div>
        <div class="form-field">
          <label for="DaysOnMarket">Days On Market</label>
          <select id="DaysOnMarket" name="DaysOnMarket">
            <option selected="selected" value="">All Days</option>
            <option value="-1">1 Day</option>
            <option value="-7">7 Days</option>
            <option value="-14">14 Days</option>
            <option value="-30">30 Days</option>
          </select>
        </div>
        <div class="form-field">
          <label for="Kind">Kind</label>
          <select id="Kind" name="Kind">
            <option selected="selected" value="">Any</option>
            <cfoutput query="getKinds"><option value="#kind#">#kind#</option></cfoutput>
          </select>
        </div>
        <div class="form-field">
          <label for="SQFtMin">Sq. Footage Min.</label>
          <select id="SQFtMin" name="SQFtMin">
            <option selected="selected" value="0">Min</option>
            <cfloop index="i" from="500" to="5000" step="500">
              <cfoutput>
                <option value="#i#">#i#</option>
              </cfoutput>
            </cfloop>
            <option value="999999">5000+</option>
          </select>
        </div>
        <div class="form-field">
          <label for="SQFtMax">Sq. Footage Max.</label>
          <select id="SQFtMax" name="SQFtMax">
            <option selected="selected" value="999999999">Max</option>
            <cfloop index="i" from="500" to="5000" step="500">
              <cfoutput>
                <option value="#i#">#i#</option>
              </cfoutput>
            </cfloop>
            <option value="999999">5000+</option>
          </select>
        </div>
      </div>
      <div class="area-selection">
        <h3><em>Step 3 |</em> Area Selection</h3>            
        <cfquery datasource="#dsnmls#" name="getareas">
          SELECT *
          FROM masterareas_cleaned
          where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and latitude <> '' and longitude <> ''
          order by city
        </cfquery>
        <div id="gMap_Areas" class="google-map"></div>


        <div class="form-field">
          <label for="area">Area(s)</label>
          <select id="area" multiple="multiple" name="area">
            <cfoutput query="getareas">
              <option value="#areashidden#;">#city#</option>
            </cfoutput>
          </select>
        </div>


  <cfquery datasource="#dsnmls#" name="getCities" cachedwithin="#CreateTimeSpan(0, 12, 0, 0)#">  
    SELECT distinct(city)
    FROM mastertable
    where mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">) and city <> ''
    order by city
  </cfquery>

        <div class="form-field">
          <label for="city">City</label>
          <select id="city" multiple="multiple" name="city">
            <cfoutput query="getCities">
              <option value="#city#">#city#</option>
            </cfoutput>
          </select>
        </div>

        <!--- For looping through lat longs to get map center point --->
        <cfset latlongcount = 1>
        
        <!---refer to the /javascripts/_plugins/google-maps/mappings.js file for more settings--->
        <script type="text/javascript">
        var map;
        var markers = new Array();
        var markerCoords = new Array();            
        function initializeMap() {
        var mapOptions = {
          // CENTER code is for IE compatibility
          center: new google.maps.LatLng(<cfoutput query="getareas">#latitude#, #longitude#<cfif latlongcount neq getareas.recordcount>,</cfif><cfset latlongcount = latlongcount + 1></cfoutput>),
        zoom: 8,
        disableDefaultUI: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        scrollwheel: false
        };            
        map = new google.maps.Map(document.getElementById("gMap_Areas"), mapOptions);
        <cfoutput query="getareas">
          var pos = markerCoords.push( new google.maps.LatLng(#latitude#, #longitude#) ) - 1;
          markers[pos] = new google.maps.Marker({
            position: markerCoords[pos],
            map: map,
            title: "#city#",
            icon: 'http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=flag|EDA528'
          });
            google.maps.event.addListener(markers[pos], 'click', function() {
            var areaSelect = $('select##area');
            var currentValues = areaSelect.val() || [];
            var pos = $.inArray("#areashidden#;", currentValues)
            if (pos >= 0) {
            currentValues.splice(pos, pos);
          } else {
            currentValues.push("#areashidden#;");
          }
            areaSelect.val(currentValues).trigger("liszt:updated");
          });
        </cfoutput>            
          markerClusterer = new MarkerClusterer(map, markers);        
           
          mapFitMarkerBounds();
        }       
        </script>
      </div>
      <div class="property-specifics">
        <h3><em>Step 4 |</em> Property Specifics</h3>
        <div class="form-field">
          <label for="mlsnumber">MLS Number</label>
          <input id="mlsnumber" name="mlsnumber" type="text" value=""/>
        </div>
        <div class="form-field">
          <label for="streetaddress">Street Address</label>
          <input id="streetaddress" name="streetaddress" type="text" value=""/>
        </div>
        <div class="form-field">
          <label for="subdivision">Subdivision</label>
          <input id="subdivision" name="subdivision" type="text" value=""/>
        </div>
        


        <!---START: WATERVIEW inputS--->
        <cfquery name="Watertype" datasource="#DSNMLS#" >
          SELECT distinct concat_ws(',',mastertable.waterfront_type,mastertable.water_view_type) as WaterTypes
          FROM mastertable
          where mlsid= <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
        </cfquery>
        <cfif Watertype.recordcount gt 0 and Watertype.watertypes is not "">
          <cfset TheWaterTypes = #valuelist(Watertype.WaterTypes)#>
          <cfset TheWaterTypes = #listRemoveDuplicates(TheWaterTypes)#> 
          <cfset TheWaterTypes = #listsort(TheWaterTypes,'text','asc',',')#>
          <div class="form-field">
            <label for="subdivision">Water View / Front</label>
            <select id="WaterType" name="WaterType" >
              <option selected="selected" value="">All</option>
              <cfloop index="i" list="#TheWaterTypes#">
                <cfoutput>
                  <option value="#i#">#i#</option>
                </cfoutput>
              </cfloop>
            </select>
          </div>
        </cfif>
        <!---END: WATERVIEW inputS--->
        


        <!---START: COMMUNITY FEATURES inputS--->
        <cfquery name="CommunityFeatures" datasource="#DSNMLS#" >
          SELECT *
          FROM custom_search_features
          where mlsid= <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and `grouping` = 'Community Features'
          order by displayname
        </cfquery>
        <cfif CommunityFeatures.recordcount gt 0>
          <fieldset class="stipulation-options">
            <legend>Community Feature(s)</legend>
            <cfoutput query="CommunityFeatures">
              <div class="checkbox-form-field">   
                <input id="stipulation-foreclosure" type="checkbox" name="#MastertableFieldName#" value="#actualvalue#">
                <label for="stipulation-foreclosure">#displayname#</label>
              </div>
            </cfoutput>
          </fieldset>
        </cfif>
        <!---END: COMMUNITY FEATURES inputS--->
      
      
      
      </div>
      <div class="advanced-criteria">
        <h3><em>Step 5 |</em> Advanced Search Criteria</h3>
        


        <!---START: BUILDING KINDS            
        <cfquery name="BuildingKind" datasource="#DSNMLS#" >
        SELECT *
        FROM custom_search_features
        where mlsid= '3' and grouping = 'Kind'
        order by displayname
        </cfquery>            
        <cfif BuildingKind.recordcount gt 0>
          <div class="form-field">            
            <label for="kind">Building Kind</label>
            <select id="kind" multiple="multiple" name="kind">
            <cfoutput query="BuildingKind">
              <option value="#actualvalue#">#displayname#</option>
            </cfoutput>
          </select>
        </div>            
        </cfif>--->
        


        <!---START: COMMERCIAL BUILDING KINDS
        <cfquery name="CommercialBuildingKind" datasource="#DSNMLS#" >
        SELECT *
        FROM custom_search_features
        where mlsid= '3' and grouping = 'Commercial Property Type'
        order by displayname
        </cfquery>
        <cfif CommercialBuildingKind.recordcount gt 0>
          <div class="form-field">
            <label for="PropertyType">Building Kind</label>
            <select id="PropertyType" multiple="multiple" name="property_type">
            <cfoutput query="BuildingKind">
              <option value="#actualvalue#">#displayname#</option>
            </cfoutput>
          </select>
        </div>
        </cfif>--->
        <div class="form-field">
          <cfquery datasource="#DSNMLS#" name="getelemen">
            SELECT distinct (Elementary_School)
            FROM mastertable
            where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and Elementary_School <> ''
            order by Elementary_School
          </cfquery>
          <label for="elementary_school">Elementary Schools</label>
          <select id="elementary_school" multiple="multiple" name="elementary_school">
            <option selected="selected" value=""></option>
            <cfoutput query="getelemen">
              <option value="#Elementary_School#">#Elementary_School#</option>
            </cfoutput>
          </select>
        </div>
        <div class="form-field">
          <cfquery datasource="#DSNMLS#" name="getmiddle">
            SELECT distinct (Middle_school)
            FROM mastertable
            where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and Middle_school <> ''
            order by Middle_school
          </cfquery>
          <label for="middle_school">Middle Schools</label>
          <select id="middle_school" multiple="multiple" name="middle_school">
            <option selected="selected" value=""></option>
            <cfoutput query="getmiddle">
              <option value="#Middle_school#">#Middle_school#</option>
            </cfoutput>
          </select>
        </div>
        <div class="form-field">
          <cfquery datasource="#DSNMLS#" name="gethigh">
            SELECT distinct (High_School)
            FROM mastertable
            where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> and High_School <> ''
            order by High_School
          </cfquery>
          <label for="high_school">High Schools</label>
          <select id="high_school" multiple="multiple" name="high_school">
            <option selected="selected" value=""></option>
            <cfoutput query="gethigh">
              <option value="#High_School#">#High_School#</option>
            </cfoutput>
          </select>
        </div>
        <fieldset class="showlisting-options">
          <legend>Listing Company</legend>
          <div class="checkbox-form-field">
            <input checked="checked" id="showlistings-all" name="showlistings" type="radio" value="All"/><label for="showlistings-all"> All Listings</label>
          </div>
          <cfif mls.CompanyMLSID is not "">
            <div class="checkbox-form-field">
              <input id="showlistings-company" name="showlistings" type="radio" value="Company"/>
              <label for="showlistings-company"><cfoutput>#mls.companyname#</cfoutput> Listings</label>
            </div>
          </cfif>
        </fieldset>
      </div>
      <div class="run-search">
        <h3><em>Step 6 |</em> Run Search</h3>       
        <input type="submit" value="Search For Properties" class="button" name="SubmitMainform">
        <input type="reset" value="Reset Search Values" class="button light" onclick="location.href='/sales/includes/reset-form.cfm'">
      </div>
    </form>
  </div>
</div>

<cfinclude template="/sales/components/footer.cfm">
