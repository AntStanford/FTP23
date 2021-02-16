<cfif NOT isdefined('url.strCheckin')>Check-In not defined<cfabort></cfif>
<cfif NOT isdefined('url.strCheckout')>Check-Out not defined<cfabort></cfif>
<cfif isdefined('url.strcheckin') and !isValid('date',url.strcheckin)>Check-In date not valid.<cfabort></cfif>
<cfif isdefined('url.strcheckout') and !isValid('date',url.strcheckout)>Check-Out date not valid.<cfabort></cfif>
<cfif NOT isdefined('url.propertyid')><!---you are a bot--->Propertyid is required.<cfabort></cfif>

<!--- QUERY TO GET PROPERTY INFO --->
<cfset property = application.bookingObject.getProperty(url.propertyid)>

<cfinclude template="/#settings.booking.dir#/components/header.cfm">

<title>Let's Book Your Rental</title>

<cfif DateCompare(url.strcheckin,settings.booking.qryNextYearsRates.displayRatesAfterYear) EQ 1>
	Rates and reservations are not yet available for your selected dates. Please call <a href="tel:18008338231">1-800-833-8231</a> for more information on renting this property.
  <cfabort>
<cfelseif DateDiff('d',url.strcheckin,url.strcheckout) MOD 7 NEQ 0>
	Weekly stays only. The number of days must be a multiple of 7.
  <cfabort>
</cfif>

<!---START: NEW CART ABANDOMENT FEATURE--->
<!---set the cookie b/c you made it to the booknow page--->
<cfcookie name="CartAbandonmentFooter" value="#url.propertyid#" expires="NEVER">
<cfcookie name="CartAbandonmentFooterCheckIn" value="#url.strCheckin#" expires="NEVER">
<cfcookie name="CartAbandonmentFooterCheckOut" value="#url.strCheckOut#" expires="NEVER">
<!---END: NEW CART ABANDONMENT FEATURE--->

<style>
  .tooltip { width: 500px !important; max-width: calc(100% - 20px) !important; }
  .tooltip-inner { max-width: 100% !important; }
</style>

	<div class="booking book-now container-fluid">
		<div class="row clearfix">
			<div class="col-md-12">
				<div class="page-header">
					<p class="h3 site-color-1 nomargin"><cfoutput>Let's Book Your Rental From #url.strCheckin# to #url.strCheckout#</cfoutput></p>
				</div>
			</div>
		</div>
		<div class="row clearfix">

			<!-- PROPERTY INFO / TRAVEL INSURANCE / PROMO CODE -->
			<div class="col-md-5 col-sm-6" id="propertyinfo">
				<div class="panel panel-default">
					<div class="panel-heading site-color-1-bg">
						<p class="h3 text-white nomargin"><cfoutput>#property.name#</cfoutput></p>
					</div>
					<div class="panel-body npbot">
						<div class="row row-fluid">
							<div class="span12 col-md-12">

								<cfoutput><img class="lazy" data-src="#property.defaultPhoto#" src="/images/layout/1x1.png" width="100%" alt="Property Photo"></cfoutput><br><br>

								<div id="summaryContainer">

									<h4>Summary of Fees</h4>
									<div id="apiresponse"><img src="/images/layout/loader.gif"/></div> <!--- Here is where the summary of fees are loaded in via Ajax --->
									<hr>
									<form id="promocodeform"> <!--- promo code form --->
										<cfoutput>
											<input type="hidden" name="propertyid" value="#url.propertyid#">
											<input type="hidden" name="strcheckin" value="#url.strcheckin#">
											<input type="hidden" name="strcheckout" value="#url.strcheckout#">
											<input type="hidden" name="addInsurancePromoCode" value="remove_insurance">
											<cfif settings.booking.pms eq 'Escapia'>
												<input type="hidden" name="chargetemplateid" value="" class="chargetemplateid">
											<cfelseif settings.booking.pms eq 'Barefoot'>
												<input type="hidden" name="leaseid" class="leaseid">
											</cfif>
										</cfoutput>
										<div class="input-group form-group">
											<label class="promo-code" for="promocode">Promo Code</label>
											<input id="promocode" type="text" class="form-control" autocomplete="off" name="promocode" value=""><br />
											<input class="btn btn-sm btn-info" type="submit" name="submit" value="Submit">
										</div>
									</form>
									<hr>


                  <cfquery dataSource="#variables.settings.booking.dsn#" name="qryCartAddOns">
                  SELECT *
                  FROM cms_checkout_addons
                  </cfquery>

                  <h3>Add-Ons</h3>
                  <form id="addonform" method="post" action="">
                  <table class="table table-striped add-on-table">
                  <cfoutput query="qryCartAddOns">
                    <tr>
                      <td>
                        <cfif len(trim(qryCartAddOns.photo)) GT 0><img src="/images/addons/#qryCartAddOns.photo#" width="100" align="left" style="margin-right:10px;" /></cfif>
                        <label for="addon#qryCartAddOns.id#">#qryCartAddOns.title# #DollarFormat(qryCartAddOns.amount)#</label><br />
                        #qryCartAddOns.description#
                      </td>
                      <td>
                        <select id="addon#qryCartAddOns.id#" name="addon#qryCartAddOns.id#" class="form-control" onchange="updateAddOns();">
                          <cfloop index="i" from="0" to="#qryCartAddOns.maxAmount#">
                            <option>#i#</option>
                          </cfloop>
                        </select>
                      </td>
                    </tr>
                  </cfoutput>
                  </table>
                  </form>

								</div><!--- End #summaryContainer --->
							</div>
						</div>
					</div>
				</div>
			</div><!-- END #propertyinfo -->

			<!--- FORM COLUMN --->
			<div class="col-md-7 col-sm-6" id="bookingform">

        <cfoutput>
				<form role="form" method="post" action="#settings.booking.bookingURL#/#settings.booking.dir#/book-now-confirm.cfm" id="bookNowForm" class="validate">

					<!--- These input fields are common to any PMS --->
					<input type="hidden" name="propertyId" value="#url.propertyid#">
					<input type="hidden" name="propertyName" value="#property.name#">
					<input type="hidden" name="propertyCity" value="#property.city#">
					<input type="hidden" name="propertyState" value="#property.state#">
					<input type="hidden" name="strCheckin" value="#url.strCheckin#">
					<input type="hidden" name="strCheckout" value="#url.strCheckout#">
					<input type="hidden" name="hiddenPromoCode" value="">
					<input type="hidden" name="key" value="#cfid##cftoken#">
					<input type="hidden" name="Total" value="" id="Total">
					<input type="hidden" name="tripinsuranceamount" value="0" id="tripinsuranceamount">
					<input type="hidden" name="addInsurance" value="false" id="addInsurance">
          <input type="hidden" name="escapiaDepositGeneratedKey" value="" id="escapiaDepositGeneratedKey"> <!--- this will be populated via Ajax on page load --->
          <input type="hidden" name="chargetemplateid" value="" class="chargetemplateid"> <!--- this will be populated via Ajax on page load --->
          <input type="hidden" name="checkintime" value="#property.checkintime#">
          <input type="hidden" name="checkouttime" value="#property.checkouttime#">
          <input type="hidden" name="baseRentPlusFees" value="" id="baseRentPlusFees"> <!--- this will be populated via Ajax on page load --->
          <input type="hidden" name="totalTaxes" value="" id="totalTaxes"> <!--- this will be populated via Ajax on page load --->
					<input type="hidden" name="selectedAddOns" value="" id="selectedAddOns" />

					</cfoutput>

					<div class="panel panel-default">
  					<div class="panel-heading site-color-1-bg">
							<p class="h3 text-white nomargin">First, We'll Need Your Contact Information</p>
  					</div>
						<div class="panel-body booking-panel">
							<fieldset>

							  <cfinclude template="_remind-book-later.cfm">

								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="contactFirstName">First Name</label>
										<input class="form-control required" type="text" name="firstname" id="contactFirstName">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="contactLastName">Last Name</label>
										<input class="form-control required" type="text" name="lastname" id="contactLastName">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="bn-email">Email address</label>
										<input type="email" class="form-control required email" name="email" id="bn-email">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="bn-phone">Phone</label>
										<input type="text" class="form-control required" name="phone" id="bn-phone">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="address1">Address 1</label>
										<input type="text" class="form-control required" name="address1" id="address1">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="address2">Address 2</label>
										<input type="text" class="form-control" name="address2" id="address2">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="contactCity">City</label>
										<input type="text" class="form-control required" name="city" id="contactCity">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="contactState">State/Province</label>
										<select id="contactState" name="state" class="form-control required">
											<option selected="" value=" "> </option>
											<option value="AK">AK - ALASKA</option>
											<option value="AL">AL - ALABAMA</option>
											<option value="AR">AR - ARKANSAS</option>
											<option value="AZ">AZ - ARIZONA</option>
											<option value="CA">CA - CALIFORNIA</option>
											<option value="CO">CO - COLORADO</option>
											<option value="CT">CT - CONNECTICUT</option>
											<option value="DC">DC - DISTRICT OF COLUMBIA</option>
											<option value="DE">DE - DELAWARE</option>
											<option value="FL">FL - FLORIDA</option>
											<option value="GA">GA - GEORGIA</option>
											<option value="GU">GU - GUAM</option>
											<option value="HI">HI - HAWAII</option>
											<option value="IA">IA - IOWA</option>
											<option value="ID">ID - IDAHO</option>
											<option value="IL">IL - ILLINOIS</option>
											<option value="IN">IN - INDIANA</option>
											<option value="KS">KS - KANSAS</option>
											<option value="KY">KY - KENTUCKY</option>
											<option value="LA">LA - LOUISIANA</option>
											<option value="MA">MA - MASSACHUSETTS</option>
											<option value="MD">MD - MARYLAND</option>
											<option value="ME">ME - MAINE</option>
											<option value="MI">MI - MICHIGAN</option>
											<option value="MN">MN - MINNESOTA</option>
											<option value="MO">MO - MISSOURI</option>
											<option value="MS">MS - MISSISSIPPI</option>
											<option value="MT">MT - MONTANA</option>
											<option value="NC">NC - NORTH CAROLINA</option>
											<option value="ND">ND - NORTH DAKOTA</option>
											<option value="NE">NE - NEBRASKA</option>
											<option value="NH">NH - NEW HAMPSHIRE</option>
											<option value="NJ">NJ - NEW JERSEY</option>
											<option value="NM">NM - NEW MEXICO</option>
											<option value="NV">NV - NEVADA</option>
											<option value="NY">NY - NEW YORK</option>
											<option value="OH">OH - OHIO</option>
											<option value="OK">OK - OKLAHOMA</option>
											<option value="OR">OR - OREGON</option>
											<option value="PA">PA - PENNSYLVANIA</option>
											<option value="PR">PR - PUERTO RICO</option>
											<option value="RI">RI - RHODE ISLAND</option>
											<option value="SC">SC - SOUTH CAROLINA</option>
											<option value="SD">SD - SOUTH DAKOTA</option>
											<option value="TN">TN - TENNESSEE</option>
											<option value="TX">TX - TEXAS</option>
											<option value="UT">UT - UTAH</option>
											<option value="VA">VA - VIRGINIA</option>
											<option value="VI">VI - VIRGIN ISLANDS</option>
											<option value="VT">VT - VERMONT</option>
											<option value="WA">WA - WASHINGTON</option>
											<option value="WI">WI - WISCONSIN</option>
											<option value="WV">WV - WEST VIRGINIA</option>
											<option value="WY">WY - WYOMING</option>
											<option value='' style="font-weight: bold;">- Canadian Provinces</option>
											<option value="AB">AB - ALBERTA</option>
											<option value="BC">BC - BRITISH COLUMBIA</option>
											<option value="MB">MB - MANITOBA</option>
											<option value="NB">NB - NEW BRUNSWICK</option>
											<option value="NL">NL - NEWFOUNDLAND AND LABRADOR</option>
											<option value="NS">NS - NOVA SCOTIA</option>
											<option value="ON">ON - ONTARIO</option>
											<option value="PE">PE - PRINCE EDWARD ISLAND</option>
											<option value="QC">QC - QUEBEC</option>
											<option value="SK">SK - SASKATCHEWAN</option>
											<option value="NT">NT - NORTHWEST TERRITORIES</option>
											<option value="NU">NU - NUNAVUT</option>
											<option value="YT">YT - YUKON</option>
										</select>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="contactZip">Zip</label>
										<input type="text" class="form-control required" name="zip" id="contactZip">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="contactCountry">Country</label>
										<select name="country" id="contactCountry" class="form-control required">
											<option value="US" selected="selected">United States</option>
											<option value="CA">Canada</option>
											<option value="AF">Afghanistan</option>
											<option value="AL">Albania</option>
											<option value="DZ">Algeria</option>
											<option value="AS">American Samoa</option>
											<option value="AD">Andorra</option>
											<option value="AO">Angola</option>
											<option value="AI">Anguilla</option>
											<option value="AQ">Antarctica</option>
											<option value="AG">Antigua and Barbuda</option>
											<option value="AR">Argentina</option>
											<option value="AM">Armenia</option>
											<option value="AW">Aruba</option>
											<option value="AU">Australia</option>
											<option value="AT">Austria</option>
											<option value="AZ">Azerbaidjan</option>
											<option value="BS">Bahamas</option>
											<option value="BH">Bahrain</option>
											<option value="BD">Bangladesh</option>
											<option value="BB">Barbados</option>
											<option value="BY">Belarus</option>
											<option value="BE">Belgium</option>
											<option value="BZ">Belize</option>
											<option value="BJ">Benin</option>
											<option value="BM">Bermuda</option>
											<option value="BT">Bhutan</option>
											<option value="BO">Bolivia</option>
											<option value="BA">Bosnia-Herzegovina</option>
											<option value="BW">Botswana</option>
											<option value="BV">Bouvet Island</option>
											<option value="BR">Brazil</option>
											<option value="IO">British Indian Ocean Territory</option>
											<option value="BN">Brunei Darussalam</option>
											<option value="BG">Bulgaria</option>
											<option value="BF">Burkina Faso</option>
											<option value="BI">Burundi</option>
											<option value="KH">Cambodia</option>
											<option value="CM">Cameroon</option>
											<option value="CV">Cape Verde</option>
											<option value="KY">Cayman Islands</option>
											<option value="CF">Central African Republic</option>
											<option value="TD">Chad</option>
											<option value="CL">Chile</option>
											<option value="CN">China</option>
											<option value="CX">Christmas Island</option>
											<option value="CC">Cocos (Keeling) Islands</option>
											<option value="CO">Colombia</option>
											<option value="KM">Comoros</option>
											<option value="CG">Congo</option>
											<option value="CK">Cook Islands</option>
											<option value="CR">Costa Rica</option>
											<option value="HR">Croatia</option>
											<option value="CU">Cuba</option>
											<option value="CY">Cyprus</option>
											<option value="CZ">Czech Republic</option>
											<option value="DK">Denmark</option>
											<option value="DJ">Djibouti</option>
											<option value="DM">Dominica</option>
											<option value="DO">Dominican Republic</option>
											<option value="TP">East Timor</option>
											<option value="EC">Ecuador</option>
											<option value="EG">Egypt</option>
											<option value="SV">El Salvador</option>
											<option value="GQ">Equatorial Guinea</option>
											<option value="ER">Eritrea</option>
											<option value="EE">Estonia</option>
											<option value="ET">Ethiopia</option>
											<option value="FK">Falkland Islands</option>
											<option value="FO">Faroe Islands</option>
											<option value="FJ">Fiji</option>
											<option value="FI">Finland</option>
											<option value="CS">Former Czechoslovakia</option>
											<option value="SU">Former USSR</option>
											<option value="FR">France</option>
											<option value="FX">France (European Territory)</option>
											<option value="GF">French Guyana</option>
											<option value="TF">French Southern Territories</option>
											<option value="GA">Gabon</option>
											<option value="GM">Gambia</option>
											<option value="GE">Georgia</option>
											<option value="DE">Germany</option>
											<option value="GH">Ghana</option>
											<option value="GI">Gibraltar</option>
											<option value="GB">Great Britain</option>
											<option value="GR">Greece</option>
											<option value="GL">Greenland</option>
											<option value="GD">Grenada</option>
											<option value="GP">Guadeloupe (French)</option>
											<option value="GU">Guam (USA)</option>
											<option value="GT">Guatemala</option>
											<option value="GN">Guinea</option>
											<option value="GW">Guinea Bissau</option>
											<option value="GY">Guyana</option>
											<option value="HT">Haiti</option>
											<option value="HM">Heard and McDonald Islands</option>
											<option value="HN">Honduras</option>
											<option value="HK">Hong Kong</option>
											<option value="HU">Hungary</option>
											<option value="IS">Iceland</option>
											<option value="IN">India</option>
											<option value="ID">Indonesia</option>
											<option value="INT">International</option>
											<option value="IR">Iran</option>
											<option value="IQ">Iraq</option>
											<option value="IE">Ireland</option>
											<option value="IL">Israel</option>
											<option value="IT">Italy</option>
											<option value="CI">Ivory Coast</option>
											<option value="JM">Jamaica</option>
											<option value="JP">Japan</option>
											<option value="JO">Jordan</option>
											<option value="KZ">Kazakhstan</option>
											<option value="KE">Kenya</option>
											<option value="KI">Kiribati</option>
											<option value="KW">Kuwait</option>
											<option value="KG">Kyrgyzstan</option>
											<option value="LA">Laos</option>
											<option value="LV">Latvia</option>
											<option value="LB">Lebanon</option>
											<option value="LS">Lesotho</option>
											<option value="LR">Liberia</option>
											<option value="LY">Libya</option>
											<option value="LI">Liechtenstein</option>
											<option value="LT">Lithuania</option>
											<option value="LU">Luxembourg</option>
											<option value="MO">Macau</option>
											<option value="MK">Macedonia</option>
											<option value="MG">Madagascar</option>
											<option value="MW">Malawi</option>
											<option value="MY">Malaysia</option>
											<option value="MV">Maldives</option>
											<option value="ML">Mali</option>
											<option value="MT">Malta</option>
											<option value="MH">Marshall Islands</option>
											<option value="MQ">Martinique (French)</option>
											<option value="MR">Mauritania</option>
											<option value="MU">Mauritius</option>
											<option value="YT">Mayotte</option>
											<option value="MX">Mexico</option>
											<option value="FM">Micronesia</option>
											<option value="MD">Moldavia</option>
											<option value="MC">Monaco</option>
											<option value="MN">Mongolia</option>
											<option value="MS">Montserrat</option>
											<option value="MA">Morocco</option>
											<option value="MZ">Mozambique</option>
											<option value="MM">Myanmar</option>
											<option value="NA">Namibia</option>
											<option value="NR">Nauru</option>
											<option value="NP">Nepal</option>
											<option value="NL">Netherlands</option>
											<option value="AN">Netherlands Antilles</option>
											<option value="NT">Neutral Zone</option>
											<option value="NC">New Caledonia (French)</option>
											<option value="NZ">New Zealand</option>
											<option value="NI">Nicaragua</option>
											<option value="NE">Niger</option>
											<option value="NG">Nigeria</option>
											<option value="NU">Niue</option>
											<option value="NF">Norfolk Island</option>
											<option value="KP">North Korea</option>
											<option value="MP">Northern Mariana Islands</option>
											<option value="NO">Norway</option>
											<option value="OM">Oman</option>
											<option value="PK">Pakistan</option>
											<option value="PW">Palau</option>
											<option value="PA">Panama</option>
											<option value="PG">Papua New Guinea</option>
											<option value="PY">Paraguay</option>
											<option value="PE">Peru</option>
											<option value="PH">Philippines</option>
											<option value="PN">Pitcairn Island</option>
											<option value="PL">Poland</option>
											<option value="PF">Polynesia (French)</option>
											<option value="PT">Portugal</option>
											<option value="PR">Puerto Rico</option>
											<option value="QA">Qatar</option>
											<option value="RE">Reunion (French)</option>
											<option value="RO">Romania</option>
											<option value="RU">Russian Federation</option>
											<option value="RW">Rwanda</option>
											<option value="GS">S. Georgia &amp; S. Sandwich Isls.</option>
											<option value="SH">Saint Helena</option>
											<option value="KN">Saint Kitts &amp; Nevis Anguilla</option>
											<option value="LC">Saint Lucia</option>
											<option value="PM">Saint Pierre and Miquelon</option>
											<option value="ST">Saint Tome (Sao Tome) and Principe</option>
											<option value="VC">Saint Vincent &amp; Grenadines</option>
											<option value="WS">Samoa</option>
											<option value="SM">San Marino</option>
											<option value="SA">Saudi Arabia</option>
											<option value="SN">Senegal</option>
											<option value="SC">Seychelles</option>
											<option value="SL">Sierra Leone</option>
											<option value="SG">Singapore</option>
											<option value="SK">Slovak Republic</option>
											<option value="SI">Slovenia</option>
											<option value="SB">Solomon Islands</option>
											<option value="SO">Somalia</option>
											<option value="ZA">South Africa</option>
											<option value="KR">South Korea</option>
											<option value="ES">Spain</option>
											<option value="LK">Sri Lanka</option>
											<option value="SD">Sudan</option>
											<option value="SR">Suriname</option>
											<option value="SJ">Svalbard and Jan Mayen Islands</option>
											<option value="SZ">Swaziland</option>
											<option value="SE">Sweden</option>
											<option value="CH">Switzerland</option>
											<option value="SY">Syria</option>
											<option value="TJ">Tadjikistan</option>
											<option value="TW">Taiwan</option>
											<option value="TZ">Tanzania</option>
											<option value="TH">Thailand</option>
											<option value="TG">Togo</option>
											<option value="TK">Tokelau</option>
											<option value="TO">Tonga</option>
											<option value="TT">Trinidad and Tobago</option>
											<option value="TN">Tunisia</option>
											<option value="TR">Turkey</option>
											<option value="TM">Turkmenistan</option>
											<option value="TC">Turks and Caicos Islands</option>
											<option value="TV">Tuvalu</option>
											<option value="UG">Uganda</option>
											<option value="UA">Ukraine</option>
											<option value="AE">United Arab Emirates</option>
											<option value="GB">United Kingdom</option>
											<option value="UY">Uruguay</option>
											<option value="MIL">USA Military</option>
											<option value="UM">USA Minor Outlying Islands</option>
											<option value="UZ">Uzbekistan</option>
											<option value="VU">Vanuatu</option>
											<option value="VA">Vatican City State</option>
											<option value="VE">Venezuela</option>
											<option value="VN">Vietnam</option>
											<option value="VG">Virgin Islands (British)</option>
											<option value="VI">Virgin Islands (USA)</option>
											<option value="WF">Wallis and Futuna Islands</option>
											<option value="EH">Western Sahara</option>
											<option value="YE">Yemen</option>
											<option value="YU">Yugoslavia</option>
											<option value="ZR">Zaire</option>
											<option value="ZM">Zambia</option>
											<option value="ZW">Zimbabwe</option>
										</select>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6 num">
										<label for="bn-numAdults"># Adults</label>
										<select name="numAdults" id="bn-numAdults" class="form-control required">
											<cfloop from="2" to="#property.sleeps#" index="i">
											<option><cfoutput>#i#</cfoutput></option>
											</cfloop>
										</select>
									</div>
									<div class="col-xs-12 col-sm-6 num">
										<label for="bn-numChildren"># Children</label>
										<select name="numChildren" id="bn-numChildren" class="form-control required">
											<cfloop from="0" to="#property.sleeps#" index="i">
											<option><cfoutput>#i#</cfoutput></option>
											</cfloop>
										</select>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-12">
                    <!--- <label class="control-label" for="comments"></label> --->
        								<cfoutput><i>(This unit has max occupancy of #property.sleeps# people)</i>
        								<input type="hidden" name="maxOccupancy" value="#property.sleeps#"></cfoutput>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-12">
  									<label class="control-label" for="comments">Comments</label>
        								<textarea class="form-control" cols="40" id="comments" name="comments" rows="5"></textarea>
									</div>
								</div>
							</fieldset>
						</div>
	        </div><!-- END panel -->
					<div class="panel panel-default">
  					<div class="panel-heading site-color-1-bg">
							<p class="h3 text-white nomargin">Next, We'll Need Your Billing Information</p>
  					</div>
						<div class="panel-body booking-panel">
							<fieldset>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="billingAddress">Address</label>
										<input type="text" class="form-control required" name="billingAddress" id="billingAddress">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="billingCity">City</label>
										<input type="text" class="form-control required" name="billingCity" id="billingCity">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="billingState">State/Province</label>
										<select id="billingState" name="billingState" class="form-control required">
											<option selected="" value=" "> </option>
											<option value="AK">AK - ALASKA</option>
											<option value="AL">AL - ALABAMA</option>
											<option value="AR">AR - ARKANSAS</option>
											<option value="AZ">AZ - ARIZONA</option>
											<option value="CA">CA - CALIFORNIA</option>
											<option value="CO">CO - COLORADO</option>
											<option value="CT">CT - CONNECTICUT</option>
											<option value="DC">DC - DISTRICT OF COLUMBIA</option>
											<option value="DE">DE - DELAWARE</option>
											<option value="FL">FL - FLORIDA</option>
											<option value="GA">GA - GEORGIA</option>
											<option value="GU">GU - GUAM</option>
											<option value="HI">HI - HAWAII</option>
											<option value="IA">IA - IOWA</option>
											<option value="ID">ID - IDAHO</option>
											<option value="IL">IL - ILLINOIS</option>
											<option value="IN">IN - INDIANA</option>
											<option value="KS">KS - KANSAS</option>
											<option value="KY">KY - KENTUCKY</option>
											<option value="LA">LA - LOUISIANA</option>
											<option value="MA">MA - MASSACHUSETTS</option>
											<option value="MD">MD - MARYLAND</option>
											<option value="ME">ME - MAINE</option>
											<option value="MI">MI - MICHIGAN</option>
											<option value="MN">MN - MINNESOTA</option>
											<option value="MO">MO - MISSOURI</option>
											<option value="MS">MS - MISSISSIPPI</option>
											<option value="MT">MT - MONTANA</option>
											<option value="NC">NC - NORTH CAROLINA</option>
											<option value="ND">ND - NORTH DAKOTA</option>
											<option value="NE">NE - NEBRASKA</option>
											<option value="NH">NH - NEW HAMPSHIRE</option>
											<option value="NJ">NJ - NEW JERSEY</option>
											<option value="NM">NM - NEW MEXICO</option>
											<option value="NV">NV - NEVADA</option>
											<option value="NY">NY - NEW YORK</option>
											<option value="OH">OH - OHIO</option>
											<option value="OK">OK - OKLAHOMA</option>
											<option value="OR">OR - OREGON</option>
											<option value="PA">PA - PENNSYLVANIA</option>
											<option value="PR">PR - PUERTO RICO</option>
											<option value="RI">RI - RHODE ISLAND</option>
											<option value="SC">SC - SOUTH CAROLINA</option>
											<option value="SD">SD - SOUTH DAKOTA</option>
											<option value="TN">TN - TENNESSEE</option>
											<option value="TX">TX - TEXAS</option>
											<option value="UT">UT - UTAH</option>
											<option value="VA">VA - VIRGINIA</option>
											<option value="VI">VI - VIRGIN ISLANDS</option>
											<option value="VT">VT - VERMONT</option>
											<option value="WA">WA - WASHINGTON</option>
											<option value="WI">WI - WISCONSIN</option>
											<option value="WV">WV - WEST VIRGINIA</option>
											<option value="WY">WY - WYOMING</option>
											<option value='' style="font-weight: bold;">- Canadian Provinces</option>
											<option value="AB">AB - ALBERTA</option>
											<option value="BC">BC - BRITISH COLUMBIA</option>
											<option value="MB">MB - MANITOBA</option>
											<option value="NB">NB - NEW BRUNSWICK</option>
											<option value="NL">NL - NEWFOUNDLAND AND LABRADOR</option>
											<option value="NS">NS - NOVA SCOTIA</option>
											<option value="ON">ON - ONTARIO</option>
											<option value="PE">PE - PRINCE EDWARD ISLAND</option>
											<option value="QC">QC - QUEBEC</option>
											<option value="SK">SK - SASKATCHEWAN</option>
											<option value="NT">NT - NORTHWEST TERRITORIES</option>
											<option value="NU">NU - NUNAVUT</option>
											<option value="YT">YT - YUKON</option>
										</select>
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="billingZip">Zip</label>
										<input type="text" class="form-control required" name="billingZip" id="billingZip">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="billingCountry">Country</label>
										<select name="billingCountry" id="billingCountry" class="form-control required">
											<option value="US" selected="selected">United States</option>
											<option value="CA">Canada</option>
											<option value="AF">Afghanistan</option>
											<option value="AL">Albania</option>
											<option value="DZ">Algeria</option>
											<option value="AS">American Samoa</option>
											<option value="AD">Andorra</option>
											<option value="AO">Angola</option>
											<option value="AI">Anguilla</option>
											<option value="AQ">Antarctica</option>
											<option value="AG">Antigua and Barbuda</option>
											<option value="AR">Argentina</option>
											<option value="AM">Armenia</option>
											<option value="AW">Aruba</option>
											<option value="AU">Australia</option>
											<option value="AT">Austria</option>
											<option value="AZ">Azerbaidjan</option>
											<option value="BS">Bahamas</option>
											<option value="BH">Bahrain</option>
											<option value="BD">Bangladesh</option>
											<option value="BB">Barbados</option>
											<option value="BY">Belarus</option>
											<option value="BE">Belgium</option>
											<option value="BZ">Belize</option>
											<option value="BJ">Benin</option>
											<option value="BM">Bermuda</option>
											<option value="BT">Bhutan</option>
											<option value="BO">Bolivia</option>
											<option value="BA">Bosnia-Herzegovina</option>
											<option value="BW">Botswana</option>
											<option value="BV">Bouvet Island</option>
											<option value="BR">Brazil</option>
											<option value="IO">British Indian Ocean Territory</option>
											<option value="BN">Brunei Darussalam</option>
											<option value="BG">Bulgaria</option>
											<option value="BF">Burkina Faso</option>
											<option value="BI">Burundi</option>
											<option value="KH">Cambodia</option>
											<option value="CM">Cameroon</option>
											<option value="CV">Cape Verde</option>
											<option value="KY">Cayman Islands</option>
											<option value="CF">Central African Republic</option>
											<option value="TD">Chad</option>
											<option value="CL">Chile</option>
											<option value="CN">China</option>
											<option value="CX">Christmas Island</option>
											<option value="CC">Cocos (Keeling) Islands</option>
											<option value="CO">Colombia</option>
											<option value="KM">Comoros</option>
											<option value="CG">Congo</option>
											<option value="CK">Cook Islands</option>
											<option value="CR">Costa Rica</option>
											<option value="HR">Croatia</option>
											<option value="CU">Cuba</option>
											<option value="CY">Cyprus</option>
											<option value="CZ">Czech Republic</option>
											<option value="DK">Denmark</option>
											<option value="DJ">Djibouti</option>
											<option value="DM">Dominica</option>
											<option value="DO">Dominican Republic</option>
											<option value="TP">East Timor</option>
											<option value="EC">Ecuador</option>
											<option value="EG">Egypt</option>
											<option value="SV">El Salvador</option>
											<option value="GQ">Equatorial Guinea</option>
											<option value="ER">Eritrea</option>
											<option value="EE">Estonia</option>
											<option value="ET">Ethiopia</option>
											<option value="FK">Falkland Islands</option>
											<option value="FO">Faroe Islands</option>
											<option value="FJ">Fiji</option>
											<option value="FI">Finland</option>
											<option value="CS">Former Czechoslovakia</option>
											<option value="SU">Former USSR</option>
											<option value="FR">France</option>
											<option value="FX">France (European Territory)</option>
											<option value="GF">French Guyana</option>
											<option value="TF">French Southern Territories</option>
											<option value="GA">Gabon</option>
											<option value="GM">Gambia</option>
											<option value="GE">Georgia</option>
											<option value="DE">Germany</option>
											<option value="GH">Ghana</option>
											<option value="GI">Gibraltar</option>
											<option value="GB">Great Britain</option>
											<option value="GR">Greece</option>
											<option value="GL">Greenland</option>
											<option value="GD">Grenada</option>
											<option value="GP">Guadeloupe (French)</option>
											<option value="GU">Guam (USA)</option>
											<option value="GT">Guatemala</option>
											<option value="GN">Guinea</option>
											<option value="GW">Guinea Bissau</option>
											<option value="GY">Guyana</option>
											<option value="HT">Haiti</option>
											<option value="HM">Heard and McDonald Islands</option>
											<option value="HN">Honduras</option>
											<option value="HK">Hong Kong</option>
											<option value="HU">Hungary</option>
											<option value="IS">Iceland</option>
											<option value="IN">India</option>
											<option value="ID">Indonesia</option>
											<option value="INT">International</option>
											<option value="IR">Iran</option>
											<option value="IQ">Iraq</option>
											<option value="IE">Ireland</option>
											<option value="IL">Israel</option>
											<option value="IT">Italy</option>
											<option value="CI">Ivory Coast</option>
											<option value="JM">Jamaica</option>
											<option value="JP">Japan</option>
											<option value="JO">Jordan</option>
											<option value="KZ">Kazakhstan</option>
											<option value="KE">Kenya</option>
											<option value="KI">Kiribati</option>
											<option value="KW">Kuwait</option>
											<option value="KG">Kyrgyzstan</option>
											<option value="LA">Laos</option>
											<option value="LV">Latvia</option>
											<option value="LB">Lebanon</option>
											<option value="LS">Lesotho</option>
											<option value="LR">Liberia</option>
											<option value="LY">Libya</option>
											<option value="LI">Liechtenstein</option>
											<option value="LT">Lithuania</option>
											<option value="LU">Luxembourg</option>
											<option value="MO">Macau</option>
											<option value="MK">Macedonia</option>
											<option value="MG">Madagascar</option>
											<option value="MW">Malawi</option>
											<option value="MY">Malaysia</option>
											<option value="MV">Maldives</option>
											<option value="ML">Mali</option>
											<option value="MT">Malta</option>
											<option value="MH">Marshall Islands</option>
											<option value="MQ">Martinique (French)</option>
											<option value="MR">Mauritania</option>
											<option value="MU">Mauritius</option>
											<option value="YT">Mayotte</option>
											<option value="MX">Mexico</option>
											<option value="FM">Micronesia</option>
											<option value="MD">Moldavia</option>
											<option value="MC">Monaco</option>
											<option value="MN">Mongolia</option>
											<option value="MS">Montserrat</option>
											<option value="MA">Morocco</option>
											<option value="MZ">Mozambique</option>
											<option value="MM">Myanmar</option>
											<option value="NA">Namibia</option>
											<option value="NR">Nauru</option>
											<option value="NP">Nepal</option>
											<option value="NL">Netherlands</option>
											<option value="AN">Netherlands Antilles</option>
											<option value="NT">Neutral Zone</option>
											<option value="NC">New Caledonia (French)</option>
											<option value="NZ">New Zealand</option>
											<option value="NI">Nicaragua</option>
											<option value="NE">Niger</option>
											<option value="NG">Nigeria</option>
											<option value="NU">Niue</option>
											<option value="NF">Norfolk Island</option>
											<option value="KP">North Korea</option>
											<option value="MP">Northern Mariana Islands</option>
											<option value="NO">Norway</option>
											<option value="OM">Oman</option>
											<option value="PK">Pakistan</option>
											<option value="PW">Palau</option>
											<option value="PA">Panama</option>
											<option value="PG">Papua New Guinea</option>
											<option value="PY">Paraguay</option>
											<option value="PE">Peru</option>
											<option value="PH">Philippines</option>
											<option value="PN">Pitcairn Island</option>
											<option value="PL">Poland</option>
											<option value="PF">Polynesia (French)</option>
											<option value="PT">Portugal</option>
											<option value="PR">Puerto Rico</option>
											<option value="QA">Qatar</option>
											<option value="RE">Reunion (French)</option>
											<option value="RO">Romania</option>
											<option value="RU">Russian Federation</option>
											<option value="RW">Rwanda</option>
											<option value="GS">S. Georgia &amp; S. Sandwich Isls.</option>
											<option value="SH">Saint Helena</option>
											<option value="KN">Saint Kitts &amp; Nevis Anguilla</option>
											<option value="LC">Saint Lucia</option>
											<option value="PM">Saint Pierre and Miquelon</option>
											<option value="ST">Saint Tome (Sao Tome) and Principe</option>
											<option value="VC">Saint Vincent &amp; Grenadines</option>
											<option value="WS">Samoa</option>
											<option value="SM">San Marino</option>
											<option value="SA">Saudi Arabia</option>
											<option value="SN">Senegal</option>
											<option value="SC">Seychelles</option>
											<option value="SL">Sierra Leone</option>
											<option value="SG">Singapore</option>
											<option value="SK">Slovak Republic</option>
											<option value="SI">Slovenia</option>
											<option value="SB">Solomon Islands</option>
											<option value="SO">Somalia</option>
											<option value="ZA">South Africa</option>
											<option value="KR">South Korea</option>
											<option value="ES">Spain</option>
											<option value="LK">Sri Lanka</option>
											<option value="SD">Sudan</option>
											<option value="SR">Suriname</option>
											<option value="SJ">Svalbard and Jan Mayen Islands</option>
											<option value="SZ">Swaziland</option>
											<option value="SE">Sweden</option>
											<option value="CH">Switzerland</option>
											<option value="SY">Syria</option>
											<option value="TJ">Tadjikistan</option>
											<option value="TW">Taiwan</option>
											<option value="TZ">Tanzania</option>
											<option value="TH">Thailand</option>
											<option value="TG">Togo</option>
											<option value="TK">Tokelau</option>
											<option value="TO">Tonga</option>
											<option value="TT">Trinidad and Tobago</option>
											<option value="TN">Tunisia</option>
											<option value="TR">Turkey</option>
											<option value="TM">Turkmenistan</option>
											<option value="TC">Turks and Caicos Islands</option>
											<option value="TV">Tuvalu</option>
											<option value="UG">Uganda</option>
											<option value="UA">Ukraine</option>
											<option value="AE">United Arab Emirates</option>
											<option value="GB">United Kingdom</option>
											<option value="UY">Uruguay</option>
											<option value="MIL">USA Military</option>
											<option value="UM">USA Minor Outlying Islands</option>
											<option value="UZ">Uzbekistan</option>
											<option value="VU">Vanuatu</option>
											<option value="VA">Vatican City State</option>
											<option value="VE">Venezuela</option>
											<option value="VN">Vietnam</option>
											<option value="VG">Virgin Islands (British)</option>
											<option value="VI">Virgin Islands (USA)</option>
											<option value="WF">Wallis and Futuna Islands</option>
											<option value="EH">Western Sahara</option>
											<option value="YE">Yemen</option>
											<option value="YU">Yugoslavia</option>
											<option value="ZR">Zaire</option>
											<option value="ZM">Zambia</option>
											<option value="ZW">Zimbabwe</option>
										</select>
									</div>
								</div>
							</fieldset>
						</div>
					</div><!-- END panel -->
          <div class="panel panel-default">
  					<div class="panel-heading site-color-1-bg">
							<p class="h3 text-white nomargin">Then, Fill Out Your Payment Information</p>
  					</div>
						<div class="panel-body booking-panel">
							<fieldset>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="ccFirstName">First Name</label>
										<input type="text" class="form-control required" pattern="\w+.*" title="The first name shown on your credit card" name="ccFirstName" id="ccFirstName">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="ccLastName">Last Name</label>
										<input type="text" class="form-control required" pattern="\w+.*" title="The last name shown on your credit card" name="ccLastName" id="ccLastName">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6">
										<label for="ccNumber">Credit Card Number</label>
										<input type="text" class="form-control required" name="ccNumber" id="ccNumber">
									</div>
									<div class="col-xs-12 col-sm-6">
										<label for="ccCVV">CVV</label>
										<input type="text" class="form-control required" name="ccCVV" id="ccCVV" maxlength="5">
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-12 col-sm-6 book-now-card">
										<label for="ccType">Credit Card Type</label>
										<select class="form-control required" name="ccType" id="ccType">
											<option value=""> - Select Credit Card Type - </option>
											<cfif settings.booking.pms eq 'Escapia'>
												<option value="VI">Visa</option>
												<option value="MC">MasterCard</option>
												<option value="DS">Discover</option>
<!--- 												<option value="AX">American Express</option> --->
											<cfelseif settings.booking.pms eq 'Barefoot'>
												<option value="2">Visa</option>
												<option value="1">MasterCard</option>
												<option value="3">Discover</option>
<!--- 												<option value="4">American Express</option> --->
											<cfelseif settings.booking.pms eq 'Homeaway'>
												<option value="VISA">Visa</option>
												<option value="MC">MasterCard</option>
												<option value="DISC">Discover</option>
<!--- 												<option value="AMEX">American Express</option> --->
											<cfelseif settings.booking.pms eq 'Streamline'>
												<option value="1">Visa</option>
												<option value="2">MasterCard</option>
												<option value="4">Discover</option>
<!--- 												<option value="3">American Express</option> --->
											</cfif>
										</select>
									</div>
									<div class="col-xs-12 col-sm-6 book-now-exp">
										<label for="ccMonth">Card Expiration Date</label>
										<div class="form-group">
											<select class="form-control required col-xs-3" name="ccMonth" id="ccMonth">
												<option value="01">January</option>
												<option value="02">February</option>
												<option value="03">March</option>
												<option value="04">April</option>
												<option value="05">May</option>
												<option value="06">June</option>
												<option value="07">July</option>
												<option value="08">August</option>
												<option value="09">September</option>
												<option value="10">October</option>
												<option value="11">November</option>
												<option value="12">December</option>
											</select>
											<label for="ccYear" class="hidden">ccYear</label>
											<select class="form-control required col-xs-3" name="ccYear" id="ccYear">
												<cfloop index="y" from="0" to="10" step="1">
												<cfset YearlyDate = "#dateadd('yyyy',y,now())#">
												<cfoutput><option value="#dateformat(YearlyDate,'yy')#">#dateformat(YearlyDate,'yyyy')#</option></cfoutput>
												</cfloop>
											</select>
										</div>
									</div>
								</div>
							</fieldset>

									<div class="alert alert-success">
										<i class="fa fa-star"></i> Your Information is 100% Secure
									</div>
									<div class="cc-logos" align="center">
										<p><b>Book With Confidence - our site is safe and secure.</b></p>
										<i class="fa fa-cc-visa" aria-hidden="true"></i>
										<i class="fa fa-cc-mastercard" aria-hidden="true"></i>
										<i class="fa fa-cc-discover" aria-hidden="true"></i>
									</div>

    				  <cfquery name="getTerms" dataSource="#settings.dsn#">
  				  		select terms from cms_terms where id = 1
    				  </cfquery>

              <div id="termsAndConditionsWrap" class="terms-and-conditions-wrap">
                <cfoutput>#getTerms.terms#</cfoutput>
              </div>

  		      	<div class="well input-well terms-and-conditions-agree" id="termsAndConditionsAgree">
    						<input type="checkbox" id="termsAndConditions" name="termsAndConditions" class="required"><label for="termsAndConditions">I Agree to the Terms and Conditions</label>
    					</div>

  		      	<div class="well input-well">
  						  <input type="checkbox" id="optinBooking" name="optin" value="yes"><label for="optinBooking">I agree to receive information about your rentals, services and specials via phone, email or SMS.<br>
  						  You can unsubscribe at anytime. <a href="/privacy-policy.cfm" target="_blank" class="site-color-1" title="Click here to View the Enrolment Information"><strong>Privacy Policy</strong></a></label>
			      	</div>

							<input type="submit" id="confirmBooking" class="btn btn-lg btn-block site-color-2-bg site-color-2-lighten-bg-hover text-white booking-btn" value="Confirm Booking">

						</div>
					</div><!-- END panel -->
				</form>
			</div><!-- END #bookingform -->
		</div>
	</div>

<cf_htmlfoot>

<script src="javascripts/vendors/jquery-autofill/jquery.autofill.min.js"></script>
<script type="text/javascript">

	function removeAddOn(id){
		$(id).val(0);
		updateAddOns();
	}

	function updateAddOns(){
		$('#apiresponse').fadeOut("1000");

		var formdata = $.param( $("#bookNowForm input").not('input[name=ccNumber]').not('input[name=ccCVV]').not('input[name=cardnum]').not('input[name=cc_cvv2]').not('input[name=cc_exp_month]').not('input[name=routingNumber]').not('input[name=accountNumber]') );
		formdata = formdata + '&' + $.param( $("#addonform select"));

		var useraction = '';

		if($('#addinsurance').is(':checked')){
				useraction = 'add_insurance';
		}
		if($('#removeinsurance').is(':checked')){
				useraction = 'remove_insurance';
		}

		var serviceid = $('#addinsurance').data('serviceid');


		$.ajax({
			url: "ajax/add-remove-insurance.cfm?useraction="+useraction+"&serviceid="+serviceid,
			data: formdata,
			success: function( data ) {

				$("#apiresponse").html(data);

				// UPDATE OUR HIDDEN INPUT FIELD ACCORDINGLY
				if(useraction == 'add_insurance'){
					$('input[name=addInsurance]').val('true');
					$('input[name=addInsurancePromoCode]').val(useraction);
				}else{
					$('input[name=addInsurance]').val('false');
					$('input[name=addInsurancePromoCode]').val(useraction);
				}
			}
		});

		$('#apiresponse').fadeIn("1000");
	}

	$(document).ready(function(){



		$('form#bookNowForm').validate({
			submitHandler: function(form){
				<!--- DISABLE THE CONFIRM BUTTON ON-CLICK SO THEY CANT SUBMIT TWICE --->
				$(window).on('beforeunload', function () {
					$("input[type=submit].booking-btn").prop("disabled", "disabled");
				});

				<!--- iPhone specific: Does *not* support beforeunload --->
				var isOnIOS = navigator.userAgent.match(/iPad/i)|| navigator.userAgent.match(/iPhone/i);
				if(isOnIOS) {
					$("input[type=submit].booking-btn").prop("disabled", "disabled");
				}

				form.submit();

			}
		});



		// ON PAGE LOAD, ATTEMPT TO GRAB THE SUMMAR OF FEES
		$.ajax({
			url: "<cfoutput>ajax/get-booknow-rates.cfm?propertyid=#url.propertyid#&strcheckin=#url.strcheckin#&strcheckout=#url.strcheckout#</cfoutput>",
			success: function( data ) {

				if(data.indexOf('Error') == 0){
					$('div#summaryContainer').hide();
					$('div#bookingform').html('<b>' + data + '</b>').show();
				}else{
					$("#apiresponse").html(data);

					<cfif settings.booking.pms eq 'Homeaway'>
						$("#Total").val($("#totalfromapi").attr("amount"));
					</cfif>

				}
			}
		});

		// USER IS TRYING TO ADD/REMOVE TRAVEL INSURANCE TO THER RESERVATION
		$("body").on('click','input[name="travel_insurance"]',function(){
			$('#apiresponse').fadeOut("1000");

			var formdata = $.param( $("#bookNowForm input").not('input[name=ccNumber]').not('input[name=ccCVV]').not('input[name=cardnum]').not('input[name=cc_cvv2]').not('input[name=cc_exp_month]').not('input[name=routingNumber]').not('input[name=accountNumber]') );
			formdata = formdata + '&' + $.param( $("#addonform select"));
			var useraction = $(this).val(); // ADD OR REMOVE
			var serviceid = $(this).data('serviceid');

			if(useraction == 'remove_insurance'){
				$("#travelInsuranceAlert").modal();
			}

			$.ajax({
				url: "ajax/add-remove-insurance.cfm?useraction="+useraction+"&serviceid="+serviceid,
				data: formdata,
				success: function( data ) {

					$("#apiresponse").html(data);

          // UPDATE OUR HIDDEN INPUT FIELD ACCORDINGLY
					if(useraction == 'add_insurance'){
						$('input[name=addInsurance]').val('true');
						$('input[name=addInsurancePromoCode]').val(useraction);
					}else{
						$('input[name=addInsurance]').val('false');
						$('input[name=addInsurancePromoCode]').val(useraction);
					}
				}
			});

			$('#apiresponse').fadeIn("1000");
		});


		$('#addTravelInsurance2').click(function(){
			var formdata = $.param( $("#bookNowForm input").not('input[name=ccNumber]').not('input[name=ccCVV]').not('input[name=cardnum]').not('input[name=cc_cvv2]').not('input[name=cc_exp_month]').not('input[name=routingNumber]').not('input[name=accountNumber]') );
			formdata = formdata + '&' + $.param( $("#addonform select"));
			var serviceid = $(this).data('serviceid');

			$.ajax({
				url: "ajax/add-remove-insurance.cfm?useraction=add_insurance&serviceid="+serviceid,
				data: formdata,
				success: function( data ) {
					$("#apiresponse").html(data);
				// UPDATE OUR HIDDEN INPUT FIELD ACCORDINGLY
					$('input[name=addInsurance]').val('true');
					$('input[name=addInsurancePromoCode]').val(useraction);
				}
			});
		});


		// PROCESS THE PROMO CODE FROM SUBMISSION
		$('form#promocodeform').submit(function(){
			var promocode = $(this).find('input[name=promocode]').val();

			if(promocode == ''){
				alert('Whoops! Looks like you forgot to enter your promo code.');
			}else{

				var formdata = $.param( $("#promocodeform input") );
				formdata = formdata + '&' + $.param( $("#addonform select"));

				$.ajax({
					url: "ajax/submit-promo-code.cfm",
					data: formdata,
					success: function( data ) {

						if(data.indexOf('Error') == 0){
							alert('Sorry, that promo code was invalid.');
						}else{

							$('#apiresponse').fadeOut("1000");
							$("#apiresponse").html(data);
							$('#apiresponse').fadeIn("1000");

							$('input[name=hiddenPromoCode]').val(promocode);
						}

					}
				});
			}
			return false;
		});

		// Disable Booking Button Until Terms Are Checked
		confirmTheBooking();
    $( "#termsAndConditions" ).click(function() {
      confirmTheBooking();
    });

    function confirmTheBooking() {

      var customChecked = $('#termsAndConditions:checked');
      console.log(customChecked);
      if (customChecked.length == 1) {
				if (($('#removeinsurance').is(':checked') || $('#addinsurance').is(':checked'))) {
						$("#confirmBooking").attr("disabled", false);
				} else {
					 alert('Please check one of the Travel Insurance boxes to continue.');
						$('#termsAndConditions').prop('checked', false);
						$("#confirmBooking").attr("disabled", true);
				}
      } else {
        console.log('not checked');
        $("#confirmBooking").attr("disabled", true);
      }
    }


    // AUTOFILL FOR FORM
    $("#contactFirstName").autofill({
      fieldId : "ccFirstName",
      overrideFieldEverytime : true
    });
    $("#contactLastName").autofill({
      fieldId : "ccLastName",
      overrideFieldEverytime : true
    });
    $("#address1").autofill({
      fieldId : "billingAddress",
      overrideFieldEverytime : true
    });
    $("#contactCity").autofill({
      fieldId : "billingCity",
      overrideFieldEverytime : true
    });
    $("#contactState").autofill({
      fieldId : "billingState",
      overrideFieldEverytime : true
    });
    $("#contactZip").autofill({
      fieldId : "billingZip",
      overrideFieldEverytime : true
    });
    $("#contactCountry").autofill({
      fieldId : "billingCountry",
      overrideFieldEverytime : true
    });


	});
</script>

<cfif settings.booking.pms eq 'Escapia' or settings.booking.pms eq 'Barefoot'>

	<script type="text/javascript">

		$(document).ready(function(){

			 //re-calculate the totals when user changes/updates the num adults or num children; we must call EVRN_UnitStay again because pricing is based on those values
			 $('select[name=numAdults],select[name=numChildren]').change(function(){

			 		$('#apiresponse').fadeOut("1000");

			 		var numAdults = $('select[name=numAdults]').val();
			 		var numChildren = $('select[name=numChildren]').val();

			 		if($('input[name=travel_insurance]').length){
			 			var useraction = $('input[name=travel_insurance]:checked').val(); //options will be add or remove
			 		}else{
			 			var useraction = $('input[name=current_state_of_ti]').val();
			 		}

			 		var chargetemplateid = $('input[name=chargetemplateid]').val();


				 	$.ajax({
		            type: "GET",
		            url: '<cfoutput>/rentals/ajax/get-booknow-rates.cfm?propertyid=#url.propertyid#&strcheckin=#url.strcheckin#&strcheckout=#url.strcheckout#&maxoccupancy=#property.sleeps#</cfoutput>&numAdults='+numAdults+'&numChildren='+numChildren+'&useraction='+useraction+'&chargetemplateid='+chargetemplateid,
		            success: function(data) {
		                $('div#apiresponse').html(data);
		            }
		        });

		        $('#apiresponse').fadeIn("1000");

			 });

		});

	</script>

</cfif>

<div id="travelInsuranceAlert" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Are You Sure You Wish To Decline Travel Insurance?</h4>
      </div>
      <div class="modal-body">
        <p>The Coverage Extends To You and Your Traveling Companions and also a Few Benefits Include:</p>
        <ul>
          <li>Sickness</li>
          <li>Job Loss</li>
          <li>Jury Duty</li>
          <li>Mandatory Evacuation</li>
          <li>Traffic Accidents</li>
        </ul>
        <p>Please Choose Purchase or Decline Below.</p>
        <p>If You Have Any Questions, Please Call Us About Our Coverage. (800-833-8231)</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn site-color-4-bg site-color-3-bg-hover text-white" data-dismiss="modal">Decline Travel Insurance</button>
        <button type="button" class="btn site-color-2-bg site-color-3-bg-hover text-white" id="addTravelInsurance2" data-dismiss="modal">Purchase Travel Insurance</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


</cf_htmlfoot>

<cfinclude template="/#settings.booking.dir#/components/footer.cfm">

