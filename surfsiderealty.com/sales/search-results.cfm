<cfif isdefined('page.slug')>
	<cfinclude template="/sales/includes/session-killer.cfm">
	<cfif page.slug eq 'sales/garden-city'>
		<cfset session.area = '30'>
	<cfelseif page.slug eq 'sales/litchfield-beaches'>
		<cfset session.area = '39'>
	<cfelseif page.slug eq 'sales/murrells-inlet'>
		<cfset session.area = '1,37,32'>
	<cfelseif page.slug eq 'sales/myrtle-beach'>
		<cfset session.area = '44,45,46,47,48,49,50'>
	<cfelseif page.slug eq 'sales/north-myrtle-beach'>
		<cfset session.area = '4,13,20,62,63,82'>
	<cfelseif page.slug eq 'sales/pawleys-island'>
		<cfset session.area = '66'>
	<cfelseif page.slug eq 'sales/surfside-beach'>
		<cfset session.area = '57,70'>
	<cfelseif page.slug eq 'sales/oceanfront'>
		<cfset session.lot_location = 'oceanfront'>
	<cfelseif page.slug eq 'sales/our-listings'>
		<cfset session.showlistings = 'Company'>
	<cfelseif page.slug eq 'sales/condos'>
		<cfset session.kind = 'condo'>
	<cfelseif page.slug eq 'sales/golf-oriented'>
		<cfset session.lot_location = 'golf'>


	</cfif>
</cfif>


<cfif isdefined('clearsession') or isdefined('form.SubmitMainForm')>
  <cfinclude template="/sales/includes/session-killer.cfm">
</cfif>

<!---START: ERROR TRAPPING--->
<cfif isdefined('pmin')>
  <cfif pmin gt pmax>
    <cfinclude template="/sales/components/header.cfm">
    <p>You selected a Maximum Price value less then your Minimum Price Value.</p>
    <p>Please <a hreflang="en" href="javascript:history.back()">go back </a>and check your Maximum and Minimum Price.</p>
    <cfinclude template="/sales/components/footer.cfm">
    <cfabort>
  </cfif>
</cfif>

<cfif isdefined('SQFtMin')>
  <cfif SQFtMin gt SQFtMax>
    <cfinclude template="/sales/components/header.cfm">
    <p>You selected a Maximum Square Footage value less then your Minimum Square Footage Value.</p>
    <p>Please <a hreflang="en" href="javascript:history.back()">go back </a>and check your Maximum and Minimum Square Footage.</p>
    <cfinclude template="/sales/components/footer.cfm">
    <cfabort>
  </cfif>
</cfif>
<!---END: ERROR TRAPPING--->

<!--- need to clear the session variables that were set for oceanfront, condo, golf course, and foreclosure --->
<cfif cgi.qUERY_STRING is "">
	<cfif isdefined('session.lot_description')><cfset session.lot_description = ""></cfif>
  <cfif isdefined('session.lot_location')><cfset session.lot_location = ""></cfif>
	<cfif isdefined('session.kind')><cfset session.kind = ""></cfif>
	<cfif isdefined('session.stipulations')><cfset session.stipulations = ""></cfif>
</cfif>
<!--- end the session clearing --->

<cfparam name="session.wsid" default=""> <!--- varchar --->
<cfparam name="session.PMIN" default="0"> <!--- int --->
<cfparam name="session.PMAX" default="99999999"> <!--- int --->
<cfparam name="session.Bedrooms" default=""> <!--- int --->
<cfparam name="session.Baths_Full" default=""> <!--- int --->
<cfparam name="session.area" default=""> <!--- varchar --->
<cfparam name="session.mlsnumber" default=""> <!--- varchar, check for int --->
<cfparam name="session.subdivision" default=""> <!--- varchar --->
<cfparam name="session.StreetAddress" default=""> <!--- varchar --->
<cfparam name="session.showlistings" default=""> <!--- varchar --->
<cfparam name="session.KIND" default=""> <!--- varchar --->
<cfparam name="session.stipulations" default=""> <!--- varchar --->
<cfparam name="session.Elementary_School" default=""> <!--- varchar --->
<cfparam name="session.Middle_school" default=""> <!--- varchar --->
<cfparam name="session.High_School" default=""> <!--- varchar --->
<cfparam name="session.sortby" default="list_price DESC">
<cfparam name="session.FavoriteList" default="">
<cfparam name="session.DaysOnMarket" default=""> <!--- varchar --->
<cfparam name="session.NumericalDaysOnMarket" default=""> <!--- varchar --->
<cfparam name="session.SQFtMin" default=""> <!--- int --->
<cfparam name="session.SQFtMax" default=""> <!--- int --->
<cfparam name="session.WaterType" default=""> <!--- varchar --->
<cfparam name="session.Amentities" default=""> <!--- varchar --->
<cfparam name="session.association_fee" default=""> <!--- varchar --->
<cfparam name="session.enotifydate" default="">
<cfparam name="session.enotifydatesearchid" default="">
<cfparam name="session.Property_Type" default=""> <!--- varchar --->
<cfparam name="session.searchpage" default="1">
<cfparam name="session.remarks" default=""> <!--- varchar --->
<cfparam name="session.city" default=""> <!--- text --->
<cfparam name="session.lot_description" default=""> <!--- text --->
<cfparam name="session.lot_location" default=""> <!--- text --->

<!---START: SET SESSIONS TO USE THROUGH REMAINDER OF SEARCH--->
<cfif isdefined('wsid') and wsid is not "">
  <cfset session.wsid = "#wsid#">
<cfelse>
  <cfif isdefined('wsid') and wsid is not session.wsid>
    <cfset session.wsid = "#wsid#">
  </cfif>
</cfif>

<cfif isdefined('PMIN') and PMIN is not "">
  <cfset session.PMIN = "#PMIN#">
<cfelse>
  <cfif isdefined('PMIN') and PMIN is not session.PMIN>
    <cfset session.PMIN = "#PMIN#">
  </cfif>
</cfif>

<cfif isdefined('PMAX') and PMAX is not "">
  <cfset session.PMAX = "#PMAX#">
<cfelse>
  <cfif isdefined('PMAX') and PMAX is not session.PMAX>
    <cfset session.PMAX = "#PMAX#">
  </cfif>
</cfif>

<cfif isdefined('Bedrooms') and Bedrooms IS NOT "">
  <cfset session.Bedrooms = "#Bedrooms#">
<cfelse>
  <cfif isdefined('Bedrooms') and bedrooms is not session.Bedrooms>
    <cfset session.Bedrooms = "#Bedrooms#">
  </cfif>
</cfif>

<cfif isdefined('Baths_Full') and  Baths_Full IS NOT "">
  <cfset session.Baths_Full = "#Baths_Full#">
<cfelse>
  <cfif isdefined('Baths_Full') and Baths_Full is not session.Baths_Full>
    <cfset session.Baths_Full = "#Baths_Full#">
  </cfif>
</cfif>

<cfif cgi.request_method is 'POST' and isdefined('form') and NOT isdefined('form.area')>
  <cfset session.area = "">
<cfelseif isdefined('area') and area is not "">
  <cfset session.area = "#area#">
<cfelse>
  <cfif isdefined('area') and area is not session.area>
    <cfset session.area = "#area#">
  </cfif>
</cfif>

<cfif cgi.request_method is 'POST' and isdefined('form') and NOT isdefined('form.city')>
  <cfset session.city = "">
<cfelseif isdefined('city') and city is not "">
  <cfset session.city = "#city#">
<cfelse>
  <cfif isdefined('city') and city is not session.city>
    <cfset session.city = "#city#">
  </cfif>
</cfif>

<cfif isdefined('mlsnumber') and mlsnumber is not "">
  <cfset session.mlsnumber = "#mlsnumber#">
<cfelse>
  <cfif isdefined('mlsnumber') and mlsnumber is not session.mlsnumber>
    <cfset session.mlsnumber = "#mlsnumber#">
  </cfif>
</cfif>

<cfif isdefined('subdivision') and subdivision is not "">
  <cfset session.subdivision = "#subdivision#">
<cfelse>
  <cfif isdefined('subdivision') and subdivision is not session.subdivision>
    <cfset session.subdivision = "#subdivision#">
  </cfif>
</cfif>

<cfif parameterexists(StreetAddress) and streetaddress is not "">
  <cfset session.StreetAddress = "#StreetAddress#">
<cfelse>
  <cfif isdefined('StreetAddress') and StreetAddress is not session.StreetAddress>
    <cfset session.StreetAddress = "#StreetAddress#">
  </cfif>
</cfif>

<cfif isdefined('showlistings')>
  <cfset session.showlistings = "#showlistings#">
<cfelse>
  <cfif isdefined('showlistings') and showlistings is not session.showlistings>
    <cfset session.showlistings = "#showlistings#">
  </cfif>
</cfif>

<cfif isdefined('KIND') and KIND is not "">
  <cfset session.KIND = "#KIND#">
<cfelse>
  <cfif isdefined('KIND') and kind is not session.KIND>
    <cfset session.KIND = "#KIND#">
  </cfif>
</cfif>

<cfif IsDefined('stipulations') AND Len(stipulations)>
  <cfset session.stipulations = "#stipulations#">
<cfelseif isdefined('session.stipulations') and (session.stipulations contains "foreclosure" or session.stipulations contains "short")>
  <cfset session.stipulations = "#session.stipulations#">
<cfelse>
  <cfset session.stipulations = "">
</cfif>

<cfif isdefined('Elementary_School') and Elementary_School is not "">
  <cfset session.Elementary_School = "#Elementary_School#">
<cfelse>
  <cfif isdefined('Elementary_School') and  Elementary_School is not session.Elementary_School>
    <cfset session.Elementary_School = "#Elementary_School#">
  </cfif>
</cfif>

<cfif isdefined('Middle_school') and Middle_school is not "">
  <cfset session.Middle_school = "#Middle_school#">
<cfelse>
  <cfif isdefined('Middle_school') and Middle_school is not session.Middle_school>
    <cfset session.Middle_school = "#Middle_school#">
  </cfif>
</cfif>

<cfif isdefined('High_School') and High_School is not "">
  <cfset session.High_School = "#High_School#">
<cfelse>
  <cfif isdefined('High_School') and High_School is not session.High_School>
    <cfset session.High_School = "#High_School#">
  </cfif>
</cfif>

<cfif isdefined('sortby')>
  <cfset session.sortby = "#sortby#">
<cfelse>
  <cfif isdefined('sortby') and sortby is not session.sortby>
    <cfset session.sortby = "#sortby#">
  </cfif>
</cfif>

<cfif isdefined('FavoriteList') and FavoriteList is not "">
  <cfset session.FavoriteList = "#FavoriteList#">
<cfelse>
  <cfif isdefined('FavoriteList') and FavoriteList is not session.FavoriteList>
    <cfset session.FavoriteList = "#FavoriteList#">
  </cfif>
</cfif>

<cfif isdefined('DaysOnMarket') and DaysOnMarket is not "">
  <cfset session.NumericalDaysOnMarket = #daysonmarket#>
  <cfset session.DaysOnMarket = #DateAdd("d", Now(), DaysOnMarket)#>
  <cfset session.DaysOnMarket = #dateformat(session.DaysOnMarket,'yyyy-mm-dd')#>
<cfelse>
  <cfif isdefined('DaysOnMarket') and DaysOnMarket is not session.DaysOnMarket>
    <cfset session.NumericalDaysOnMarket = #daysonmarket#>
    <cfset session.DaysOnMarket = #DateAdd("d", Now(), DaysOnMarket)#>
    <cfset session.DaysOnMarket = #dateformat(session.DaysOnMarket,'yyyy-mm-dd')#>
  </cfif>
</cfif>

<cfif isdefined('SQFtMin') and SQFtMin is not "">
  <cfset session.SQFtMin = "#SQFtMin#">
<cfelse>
  <cfif isdefined('SQFtMin') and SQFtMin is not session.SQFtMin>
    <cfset session.SQFtMin = "#SQFtMin#">
  </cfif>
</cfif>

<cfif isdefined('SQFtMax') and SQFtMax is not "">
  <cfset session.SQFtMax = "#SQFtMax#">
<cfelse>
  <cfif isdefined('SQFtMax') and SQFtMax is not session.SQFtMax>
    <cfset session.SQFtMax = "#SQFtMax#">
  </cfif>
</cfif>

<cfif isdefined('WaterType') and WaterType is not "">
  <cfset session.WaterType = "#WaterType#">
<cfelse>
  <cfif isdefined('watertype') and watertype is not session.watertype>
    <cfset session.WaterType = "#WaterType#">
  </cfif>
</cfif>

<cfif IsDefined('Amentities') AND Len(Amentities)>
  <cfset session.Amentities = "#Amentities#">
<cfelseif isdefined('session.Amentities')>
  <cfset session.Amentities = "#session.Amentities#">
<cfelse>
  <cfset session.Amentities = "">
</cfif>

<cfif IsDefined('association_fee') AND Len(association_fee)>
  <cfset session.association_fee = "#association_fee#">
<cfelseif isdefined('session.association_fee')>
  <cfset session.association_fee = "#session.association_fee#">
<cfelse>
  <cfset session.association_fee = "">
</cfif>

<cfif IsDefined('enotifydate') AND Len(enotifydate)>
  <cfset session.enotifydate = "#enotifydate#">
<cfelseif isdefined('session.enotifydate')>
  <cfset session.enotifydate = "#session.enotifydate#">
<cfelse>
  <cfset session.enotifydate = "">
</cfif>

<cfif IsDefined('enotifydatesearchid') AND Len(enotifydatesearchid)>
  <cfset session.enotifydatesearchid = "#enotifydatesearchid#">
<cfelseif isdefined('session.enotifydatesearchid')>
  <cfset session.enotifydatesearchid = "#session.enotifydatesearchid#">
<cfelse>
  <cfset session.enotifydatesearchid = "">
</cfif>

<cfif IsDefined('Property_Type') AND Len(Property_Type)>
  <cfset session.Property_Type = "#Property_Type#">
<cfelseif isdefined('session.Property_Type')>
  <cfset session.Property_Type = "#session.Property_Type#">
<cfelse>
  <cfset session.Property_Type = "">
</cfif>

<cfif IsDefined('url.searchpage') AND Len(url.searchpage)>
  <cfset session.searchpage = "#url.searchpage#">
<cfelseif isdefined('session.searchpage')>
  <cfset session.searchpage = "#session.searchpage#">
<cfelse>
  <cfset session.searchpage = "">
</cfif>

<cfif isdefined('remarks')>
  <cfset session.remarks = "#remarks#">
<cfelse>
  <cfif isdefined('remarks') and remarks is not session.remarks>
    <cfset session.remarks = "#remarks#">
  </cfif>
</cfif>

<cfif isdefined('lot_description')>
  <cfset session.lot_description = "#lot_description#">
<cfelse>
  <cfif isdefined('lot_description') and lot_description is not session.lot_description>
    <cfset session.lot_description = "#lot_description#">
  </cfif>
</cfif>

<cfif isdefined('lot_location')>
  <cfset session.lot_location = "#lot_location#">
<cfelse>
  <cfif isdefined('lot_location') and lot_location is not session.lot_location>
    <cfset session.lot_location = "#lot_location#">
  </cfif>
</cfif>
<!---END: SET SESSIONS TO USE THROUGH REMAINDER OF SEARCH--->


<cfif NOT isdefined('page.slug')>
	<cfinclude template="/sales/components/header.cfm">
</cfif>

<cfinclude template="/sales/search-results_.cfm">

<div class="flashMessages"></div>
<div class="content" id="mls-wrapper">
	<div class="container">
		<div class="row">
			<div class="col-md-12">

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
<!--- 			  <cfquery datasource="#dsnmls#" name="getCities" cachedwithin="#CreateTimeSpan(0, 12, 0, 0)#">
			    SELECT distinct(city)
			    FROM mastertable
			    where mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">) and city <> ''
			    order by city
			  </cfquery> --->
			  	<Cfset citylist = 'Surfside Beach,Garden City,Conway,Garden City Beach,Georgetown,Little River,Murrells Inlet,Myrtle Beach,North Myrtle Beach,Pawleys Island,Surfside Beach'>
			            <label for="city">City</label>
			            <select id="city" multiple="multiple" name="city">
			                <cfoutput>
			                	<cfloop list="#citylist#" index="i">
				                    <option value="#i#"
				                      <cfif isdefined('session.city')>
				                        <cfloop index="a" list="#session.city#" delimiters=",">
				                          <cfif i is "#a#">selected</cfif>
				                        </cfloop>
				                      </cfif>
				                    >#i#</option>
			                	</cfloop>

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
			            <a hreflang="en" href="#script_name#?slug=#slug###more">Read More...</a>
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
			          <!--- <cfoutput><script src="http://maps.google.com/maps?file=api&v=2&key=#mls.googleAPIKey#&sensor=false" type="text/javascript"></script></cfoutput> --->
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
			                  <cfinclude template="/sales/includes/image-handler.cfm">.
			                  <cfset seolink = optimizeMyURL(GetListings.street_number,GetListings.street_name,GetListings.city,GetListings.zip_code,GetListings.mlsnumber,GetListings.mlsid,GetListings.wsid)>
			                  <a hreflang="en" href="#Replace(seolink,'mls','sales')#"><cfif HowManyPhotos gt 0><IMG src="#Replace(thephoto,'http:','')#" width="150" border="1" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="150" border="1" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif></a>
			                  <!---
			                    <a hreflang="en" href="/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#"><cfif HowManyPhotos gt 0><IMG src="#getmlscoinfo.imageurl#/#thephoto#" width="150" border="1" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="150" border="1" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif></a>
			                  --->
			                  <cfif AddressDisplayYN is not "N">
			                    <H3>#street_number# #street_name# <cfif LEN(unit_number)>#unit_number#</cfif><SPAN class="list-price">#dollarformat(list_price)# <cfif wsid is "4">/ Monthly</cfif></SPAN></H3>
			                  </cfif>
			                  <h4><cfif subdivision is not "" and subdivision is not "none" and subdivision is not "NOT WITHIN A SUBDIVISION">#subdivision#,</cfif> #city#, #state# #zip_code#</h4>
			                  <P class="attributes">
			                    <cfif bedrooms is not "">Bedroom(s): #bedrooms#  &nbsp;&nbsp;</cfif>
			                    <cfif baths_full is not "">Full Baths: #baths_full#  &nbsp;&nbsp;</cfif>
			                    <cfif acreage is not "">#acreage# Acres &nbsp;&nbsp;</cfif>
			                    <cfif zoning is not ""> Zoning: #zoning# &nbsp;&nbsp;</cfif>
			                    <cfif kind is not ""> Kind: #kind# &nbsp;&nbsp;</cfif>
			                  </P>
			                  <!--- <P class="provider">Courtesy of #listing_office_name#</P> --->
			                  <ul class="actions">
			                    <li class="view-property"><a class="button light" href="#Replace(seolink,'mls','sales')#" title="View MLS##: #mlsnumber#">View Property</a></lI>
			                    <li class="favorite">
			                      <cfif isdefined('cookie.LoggedIn')>
			                        <cfquery name="CheckFavorite" dbtype="query">
			                          SELECT *
			                          FROM CheckFavorites
			                          where clientid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#cookie.loggedin#"> and mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'> and wsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#wsid#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsid#'>
			                        </cfquery>
			                        <cfif CheckFavorite.recordcount gt 0>
			                          <a class="button light" href="/sales/search-results.cfm?action=removefromfavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('searchpage')>&searchpage=#searchpage#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#" >Remove Favorite</a>
			                        <cfelse>
			                          <a class="button light" href="/sales/search-results.cfm?action=addtofavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('searchpage')>&searchpage=#searchpage#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#">Add Favorite</a>
			                        </cfif>
			                      <cfelse>
		<!--- 	                        <a class="fb_dynamic button light" href="/sales/lightboxes/add-to-favorites.cfm?action=addtofavorites<cfif isdefined('start')>&start=#start#</cfif><cfif isdefined('searchpage')>&searchpage=#searchpage#</cfif>&FavoriteWSID=#wsid#&FavoriteMLSID=#mlsid#&Favoritemlsnumber=#mlsnumber####cnt#&width=765&height=434">Add Favorite</a> --->
			                     <a class="button light" href="##" data-toggle="modal" data-target="##mlsModalCreate">Add Favorite</a>
			                      </cfif>
			                    </lI>
			                    <li class="more-info"><a class="button light"data-toggle="modal" data-target="##mlsModalMoreInfo" data-mlsnum="#mlsnumber#" data-mlsid="#mlsid#" data-wsid="#wsid#" data-msg="MLS ## #mlsnumber#, #street_number# #street_name#, #city#">Request Info</a></lI> <!--- href="/sales/lightboxes/request-more-information.cfm?action=requestinformation&wsid=#wsid#&mlsid=#mlsid#&mlsnumber=#mlsnumber#" --->
			                     <cfif isdefined('cookie.LoggedIn')>
			                     	<li class="forward-friend"><a data-toggle="modal" data-target="##mlsModalSTAF" data-mlsnum="#mlsnumber#" data-mlsid="#mlsid#" data-wsid="#wsid#" data-msg="Check out this property listed on #mls.companyname#.  MLS ## #mlsnumber# http://#cgi.HTTP_HOST#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#" class="button light">Send to a friend</a></lI> <!--- href="/sales/lightboxes/send-to-a-friend.cfm?action=SendToAFriend&SendToAFriendwsid=#wsid#&SendToAFriendmlsid=#mlsid#&SendToAFriendmlsnumber=#mlsnumber#&width=765&height=434" --->
			                     	<cfelse>
			                     	<li class="forward-friend"><a class="button light" href="##" data-toggle="modal" data-target="##mlsModalCreate" >Send to a friend</a></lI>
			                     </cfif>
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
			            <h3>Your search did not produce any results.<br><br>  Please <a hreflang="en" href="javascript:history.back()">go back</a> and adjust your search fields.</h3>
			          </cfif>
			          <cfif isdefined('remainingcopy')>
			            <a name="more"></a>
			            <cfoutput>#remainingcopy#</cfoutput>
			          </cfif>
			        </div>
			      </div>

			</div>
		</div>
	</div>
</div>


<cfif isdefined('page.slug')>
  <cf_htmlfoot>
    <cfinclude template="/sales/includes/mls-modals.cfm" />
  </cf_htmlfoot>
<cfelse>
	<cfinclude template="/sales/components/footer.cfm">
</cfif>


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
              <cfinclude template="/sales/includes/image-handler.cfm">
              <cfset seolink = optimizeMyURL(GetListings.street_number,GetListings.street_name,GetListings.city,GetListings.zip_code,GetListings.mlsnumber,GetListings.mlsid,GetListings.wsid)>
                var marker#currentrow# = new google.maps.Marker({
                  map: map,
                  position: new google.maps.LatLng(#latitude#, #longitude#),
                  title: '$#trim(numberformat(list_price,"999,999,999"))#  #city#  MLS Number## #mlsnumber# ',
                  propdetail: "<table width='215' height='200'><tr><td style='font-size:8pt; text-align:Left; font-family: Verdana;'>#city#<Br>MLS Number #mlsnumber#<br>Listing Price: $#trim(numberformat(list_price,'999,999,999'))#</td></tr><tr><td><cfif HowManyPhotos gt 0><IMG src='#thephoto#' width='150' border='1' alt='#mls.companyname# - MLS Number: #mlsnumber#'><cfelse><IMG src='http://mls.icoastalnet.com/mls/images/not_avail.jpg' width='150' border='1' alt='#mls.companyname#- MLS Number: #mlsnumber#'></cfif><br><a hreflang="en" href='#Replace(seolink,'mls','sales')#'>Click for more information...</a></td></tr></table>"
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
<!--- old prop url code /sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#&showmap=<cfif isdefined('start')>&start=#start#&searchpage=#searchpage#</cfif> --->
