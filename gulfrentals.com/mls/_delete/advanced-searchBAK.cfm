<cftry>
<cfinclude template="/#application.settings.mls.dir#/advanced-search_.cfm">
<!--- <cfinclude template="/components/header.cfm"> --->
<!--- <cfinclude template="components/m-header.cfm"> --->
<cfinclude template="/#application.settings.mls.dir#/components/header.cfm">
<cfif isdefined('LinkToLogin') and (isdefined('session.loggedin') is "No" or isdefined('cookie.loggedin') is "No")>
<cf_htmlfoot>
  <script>
    $(document).ready(function(){
      $.fancybox('<div style="width:780px"><iframe src="__lightboxes/create-account.cfm" width="765" height="434" frameborder="0"></iframe></div>',{'enableEscapeButton': false,'showCloseButton': false,'hideOnContentClick': true,'hideOnOverlayClick': false,'width': '75%','height': '75%','autoScale': false,'overlayOpacity': 0.9});
    });
  </script>
</cf_htmlfoot>
</cfif>
<div class="flashMessages"></div>
<!---
  <cfquery name="getAllProperties" dataSource="#settings.dsn#">
     select unitcode,unitshortname from escapia_properties order by unitshortname
  </cfquery>
  --->
<cf_htmlfoot>
  <script type="text/javascript">
    $(document).ready(function(){

    	$('form#advancedSearchForm').submit(function(){
    		var arrivaldate = $(this).find('input[name=strCheckin]').val();
    		var sortby = $(this).find('select[name=strSortBy]').val();
    		if(arrivaldate == '' && (sortby == 'rentalRate asc' || sortby == 'rentalRate desc')){
    			alert('"Sort by Price" requires an arrival date.');
    			return false;
    		}
    	});
    });
  </script>
</cf_htmlfoot>

<div class="adv-search-container container">
  <h1>Advanced Search</h1>
  <div class="welcome-user">
    <cfif isdefined('session.loggedin') or isdefined('cookie.loggedin')>
    <cfoutput>
      <h3>Welcome, #capFirstTitle(lcase(cookie.UserFirstName))#</h3>
      <p>You are currently logged in.  If you are on a public computer, please don't forget to <a href="/#application.settings.mls.dir#/index.cfm?logout=">logout</a>.</p>
    </cfoutput>
    <cfelse>
    <h3>Welcome Guest</h3>
    <p>It appears you aren't logged in, please <a href="/#application.settings.mls.dir#/components/mls-account.cfm?action=login" width="765" height="434" class="fb_dynamic">login now</a> to activate the saved search and favorite property features.</p>
    <p>If you don't have an account with us, you can take a minute to <a href="/#application.settings.mls.dir#/components/mls-account.cfm?action=register" width="765" height="434" class="fb_dynamic">register</a> for our site.</p>
    </cfif>
  </div><!-- END welcome-user -->
  <div id="advSearchWrap" name="inquire" class="adv-search-wrap">
    <div class="heading site-color-1-bg text-white"><i class="fa fa-search" aria-hidden="true"></i> Enhance your Search</div>

    <form action="/<cfoutput>#application.settings.mls.dir#</cfoutput>/results.cfm" role="form" class="mls-search-form" method="POST">
      <input type="hidden" name="camefromsearchform">
      <fieldset class="row">
        <div class="form-group col-xs-12">
          <em>Search by any of the options to get the best results.</em>
        </div>
        <cfif application.oFields.showOnAdvanced(16)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="mlsnumber">MLS Number</label>
            <input id="mlsnumber" name="mlsnumber" type="text" value="">
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(17)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="streetaddress">Street Address</label>
            <input id="streetaddress" name="streetaddress" type="text" value="">
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(15)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="subdivision">
              <cfoutput>#application.oFields.cLabel(15)#</cfoutput>
            </label>
            <input id="subdivision" name="subdivision" type="text" value="">
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(14)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <!-- WATERVIEW -->
            <cfif settings.mls.getWaterTypes.recordcount gt 0 and settings.mls.getWaterTypes.watertypes is not "">
              <cfset TheWaterTypes = #valuelist(settings.mls.getWaterTypes.WaterTypes)#>
              <cfset TheWaterTypes = #listRemoveDuplicates(TheWaterTypes)#>
              <cfset TheWaterTypes = #listsort(TheWaterTypes,'text','asc',',')#>
              <label for="subdivision"><cfoutput>#application.oFields.cLabel(14)#</cfoutput></label>
              <select class="selectpicker" id="WaterType" name="WaterType">
                <option selected="selected" value="">All</option>
                <cfloop index="i" list="#TheWaterTypes#">
                  <cfoutput>
                    <option value="#i#">#i#</option>
                  </cfoutput>
                </cfloop>
              </select>
            </cfif>
          </div>
        </cfif>
        <!-- COMMUNITY FEATURES -->
        <cfif settings.mls.getCommunityFeatures.recordcount gt 0>
          <div class="form-group stipulation-options col-xs-12 col-sm-12">
            <h4><cfoutput>#application.oFields.cLabel(69)#</cfoutput></h4>
            <cfif application.oFields.showOnAdvanced(12)>
              <cfoutput query="settings.mls.getCommunityFeatures">
                <input id="stipulation-foreclosure" type="checkbox" name="#MastertableFieldName#" value="#actualvalue#"><label for="stipulation-foreclosure">#displayname#</label>
              </cfoutput>
            </cfif>
          </div>
        </cfif>
      </fieldset>

      <fieldset class="row">
        <div class="form-group col-xs-12">
          <div class="heading">Search Details</div>
        </div>
        <div class="form-group col-xs-6 col-sm-6 col-md-4">
          <label>
            <cfoutput>#application.oFields.cLabel(70)#</cfoutput>
          </label>
          <select class="selectpicker" id="wsid" name="wsid">
            <option value="">All Types</option>
            <cfloop index="i" list="#settings.mls.getmlscoinfo.wsid#">
              <cfoutput>
                <option value="#listgetat(i,'1','~')#">#listgetat(i,'2','~')#</option>
              </cfoutput>
            </cfloop>
          </select>
        </div>
        <div class="form-group col-xs-6 col-sm-6 col-md-4">
          <label>Sort By</label>
          <select class="selectpicker" id="sortby" name="sortby">
            <option value="list_price DESC">Price (High to Low)</option>
            <option value="list_price ASC">Price (Low to High)</option>
            <option value="bedrooms DESC">Bedrooms</option>
            <option value="baths_full DESC">Bathrooms</option>
            <option value="created_at DESC">Listing Date (New to Old)</option>
            <option value="created_at ASC">Listing Date (Old to New)</option>
          </select>
        </div>
        <cfif application.oFields.showOnAdvanced(12) OR application.oFields.showOnAdvanced(13) >
          <div class="form-group col-xs-12">
            <h4><cfoutput>#application.oFields.cLabel(71)#</cfoutput></h4>
            <cfif application.oFields.showOnAdvanced(12)>
              <input id="stipulation-foreclosure" name="stipulations" type="checkbox" value="foreclosure"><label for="stipulation-foreclosure">Foreclosures</label>
            </cfif>
            <br>
            <cfif application.oFields.showOnAdvanced(13)>
              <input id="stipulation-short-sale" name="stipulations" type="checkbox" value="short"><label for="stipulation-short-sale">Short Sales</label>
            </cfif>
          </div>
        </cfif>
      </fieldset>

      <fieldset class="row">
          <div class="form-group col-xs-12">
          <div class="heading">Basic Criteria</div>
        </div>
        <div class="form-group col-xs-6 col-sm-6 col-md-4">
          <label for="pmin">Minimum Price</label>
          <select class="selectpicker" id="pmin" name="pmin">
            <option value="0" <cfif isdefined('PMIN') is "No">selected</cfif>>No Min</option>
            <cfloop index="i" from="#settings.mls.pricerangemin#" to="#settings.mls.pricerangemax#" step="#settings.mls.incrementpricerange#">
              <cfoutput>
                <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#settings.mls.pricerangemax#" step="#settings.mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                </cfloop>
                <cfbreak>
              </cfif>
            </cfloop>
          </select>
        </div>
        <div class="form-group col-xs-6 col-sm-6 col-md-4">
          <label for="pmax">Maximum Price</label>
          <select class="selectpicker" id="pmax" name="pmax">
            <cfloop index="i" from="#settings.mls.pricerangemin#" to="#settings.mls.pricerangemax#" step="#settings.mls.incrementpricerange#">
              <cfoutput>
                <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#settings.mls.pricerangemax#" step="#settings.mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#" <cfif #settings.mls.pricerangemax# is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                  </cfloop>
                <cfbreak>
              </cfif>
            </cfloop>
            <option value="999999999" <cfif isdefined('PMAX') is "No">selected</cfif>>No Max</option>
          </select>
        </div>
        <div class="form-group col-xs-6 col-sm-6 col-md-4">
          <label for="bedrooms">Bedrooms</label>
          <select class="selectpicker" data-wsid="1" id="bedrooms" name="bedrooms">
            <option selected="selected" value="">No Preference</option>
            <option value="1">1+ Bedrooms</option>
            <option value="2">2+ Bedrooms</option>
            <option value="3">3+ Bedrooms</option>
            <option value="4">4+ Bedrooms</option>
            <option value="5">5+ Bedrooms</option>
            <option value="6">6+ Bedrooms</option>
          </select>
        </div>
        <div class="form-group col-xs-6 col-sm-6 col-md-4">
          <label for="baths_full">Bathrooms</label>
          <select class="selectpicker" data-wsid="1" id="baths_full" name="baths_full">
            <option selected="selected" value="">No Preference</option>
            <option value="1">1+ Bathrooms</option>
            <option value="2">2+ Bathrooms</option>
            <option value="3">3+ Bathrooms</option>
            <option value="4">4+ Bathrooms</option>
            <option value="5">5+ Bathrooms</option>
          </select>
        </div>
        <cfif application.oFields.showOnAdvanced(1)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="DaysOnMarket">Days On Market</label>
            <select class="selectpicker" id="DaysOnMarket" name="DaysOnMarket">
              <option selected="selected" value="">All Days</option>
              <option value="-1">1 Day</option>
              <option value="-7">7 Days</option>
              <option value="-14">14 Days</option>
              <option value="-30">30 Days</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(2)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="Kind">Kind</label>
            <select class="selectpicker" id="Kind" name="Kind">
              <option selected="selected" value="">Any</option>
              <cfoutput query="settings.mls.getKinds">
                <option value="#kind#">#kind#</option>
              </cfoutput>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(3)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="SQFtMin">Sq. Footage Min.</label>
            <select class="selectpicker" id="SQFtMin" name="SQFtMin">
              <option selected="selected" value="0">Min</option>
              <cfloop index="i" from="500" to="5000" step="500">
                <cfoutput>
                  <option value="#i#">#i#</option>
                </cfoutput>
              </cfloop>
              <option value="999999">5000+</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(4)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="SQFtMax">Sq. Footage Max.</label>
            <select class="selectpicker" id="SQFtMax" name="SQFtMax">
              <option selected="selected" value="999999999">Max</option>
              <cfloop index="i" from="500" to="5000" step="500">
                <cfoutput>
                  <option value="#i#">#i#</option>
                </cfoutput>
              </cfloop>
              <option value="999999">5000+</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(88)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="centralair">Central Air</label>
            <select class="selectpicker" id="centralair" name="centralair">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(89)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="gasheat">Gas Heat</label>
            <select class="selectpicker" id="gasheat" name="gasheat">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(90)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="garage">Garage</label>
            <select class="selectpicker" id="garage" name="garage">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(91)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="pool">Pool</label>
            <select class="selectpicker" id="pool" name="pool">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(92)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="fence">Fence</label>
            <select class="selectpicker" id="fence" name="fence">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(93)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="boatslip">Boat Slip</label>
            <select class="selectpicker" id="boatslip" name="boatslip">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(94)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="waterviews">Water Views</label>
            <select class="selectpicker" id="waterviews" name="waterviews">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(95)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="fireplace">Fireplace</label>
            <select class="selectpicker" id="fireplace" name="fireplace">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(96)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="patio">Patio</label>
            <select class="selectpicker" id="patio" name="patio">
              <option value="">Any</option>
              <option value="Yes">Yes</option>
              <option value="No">No</option>
            </select>
          </div>
        </cfif>
        <div class="form-group col-xs-6 col-sm-6 col-md-4">
          <label for="high_school">Elevator</label>
          <select class="selectpicker" id="elevator" multiple name="elevator">
            <option value="Yes">Yes</option>
            <option value="">No or Not Specified</option>
          </select>
        </div>
      </fieldset>

      <fieldset class="row">
        <div class="form-group col-xs-12">
          <div class="heading">Select An Area</div>
        </div>
        <cfif application.oFields.showOnAdvanced(5)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="area">Area</label>
            <select class="selectpicker multiselect" name="area" id="area" style="" size="8" multiple="" title="Select an Area">
              <cfoutput>
                <cfset areaAS = application.oFields.getSearchAreas('advanced')>
                <!--- <option class="all-selected" value="99">- All Areas -</option> --->
                <!--- <option class="all-selected" value="99">- Test -</option> --->
                <cfloop query="areaAS">
                  <option value="#areashidden#">#area#</option>
                </cfloop>
              </cfoutput>
            </select>
          </div>
        </cfif>
        <cfif application.oFields.showOnAdvanced(6)>
          <div class="form-group col-xs-6 col-sm-6 col-md-4">
            <label for="city">City</label>
            <select class="selectpicker multiselect" name="city" id="city" multiple="" title="Select a City">
              <!--- <option class="all-selected" value="" selected>- All Cities -</option> --->
              <cfoutput>
                <cfset citiesAS = application.oFields.getSearchCities('advanced')>
                <cfloop query="citiesAS">
                  <option value="#city#">#city#</option>
                </cfloop>
              </cfoutput>
            </select>
          </div>
        </cfif>
      </fieldset>

      <cfif settings.mls.AsShowAdvancedSearchPanel is "1">
        <fieldset class="row">
          <div class="form-group col-xs-12">
            <div class="heading">Advanced Search Criteria</div>
          </div>
          <cfif settings.mls.getElementarySchools.recordcount gt 0>
            <div class="form-group col-xs-6 col-sm-6 col-md-4">
              <label for="elementary_school">Elementary Schools</label>
              <select class="selectpicker" id="elementary_school" multiple name="elementary_school">
                <!--- <option selected="selected" value="">- All Schools -</option> --->
                <cfoutput query="settings.mls.getElementarySchools">
                  <option value="#Elementary_School#">#Elementary_School#</option>
                </cfoutput>
              </select>
            </div>
            <div class="form-group col-xs-6 col-sm-6 col-md-4">
              <label for="middle_school">Middle Schools</label>
              <select class="selectpicker" id="middle_school" multiple name="middle_school">
                <!--- <option selected="selected" value="">- All Schools -</option> --->
                <cfoutput query="settings.mls.getMiddleSchools">
                  <option value="#Middle_school#">#Middle_school#</option>
                </cfoutput>
              </select>
            </div>
            <div class="form-group col-xs-6 col-sm-6 col-md-4">
              <label for="high_school">High Schools</label>
              <select class="selectpicker" id="high_school" multiple name="high_school">
                <!--- <option selected="selected" value="">- All Schools - </option> --->
                <cfoutput query="settings.mls.getHighSchools">
                  <option value="#High_School#">#High_School#</option>
                </cfoutput>
              </select>
            </div>
          </cfif>
          <div class="form-group col-xs-12">
            <h4>Listing Company</h4>
            <input checked="checked" id="showlistings-all" name="showlistings" type="radio" value="All"><label for="showlistings-all">All Listings</label>
            <br>
            <cfif settings.mls.CompanyMLSID is not "">
              <input id="showlistings-company" name="showlistings" type="radio" value="Company"><label for="showlistings-company"><cfoutput>#settings.mls.sitename#</cfoutput> Listings</label>
            </cfif>
          </div>
        </fieldset>
      </cfif>

      <div class="row">
        <div class="form-group col-xs-12">
          <input type="submit" value="Submit" class="btn pull-right site-color-1-bg site-color-1-lighten-bg-hover text-white" onClick="ga('send', 'event', { eventCategory: 'Advanced Search', eventAction: 'Submitted', eventLabel: 'Advanced Search', eventValue: 1});"  >
        </div>
        <div class="form-group col-xs-12">
          <div class="ajaxResponse pull-right" style="padding-right:15px"></div>
        </div>
      </div>
    </form>
  </div><!-- END adv-search-wrap -->
</div>

<cfinclude template="/#application.settings.mls.dir#/components/footer.cfm">
<cfcatch>
  <cfdump var="#cfcatch#">
</cfcatch>
</cftry>