<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">
			<!--- <cfif isdefined('Email') and email is "" > --->
			<cfif cgi.REQUEST_METHOD eq "POST">

				<cfif Cffp.testSubmission(form)>
					<p>Thank you for contacting us!  A representative will be in touch within one business day!</p>

					<script>
						(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
						(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
						m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
						})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
						ga('create', 'UA-15116429-1', 'auto');
						ga('nativeTracker.send', 'event', 'Contact', 'Submitted', 'Contact Us page', 1);
					</script>

					<cfif len(form.TheEmail)>
				    <cfset variables.encEmail = encrypt(form.TheEmail, application.contactInfoEncryptKey, 'AES')>
				  <cfelse>
				    <cfset variables.encEmail = ''>
				  </cfif>
				  <cfif len(form.phone)>
				    <cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
				  <cfelse>
				    <cfset variables.encPhone = ''>
				  </cfif>

				<!---START: LEADTRACKER CODING--->
					<cfquery datasource="#settings.dsn#" dbtype="ODBC">
						Insert
						Into cms_contacts
						(status,subject,firstnote,firstname,lastname,address1,city,State,zip,phone,email,comments,camefrom,Company,Fax,address2,Country,ContactVia,KeepInformedon,HowOftenVisit,SpecialInterests,HowFoundus<!---,MailBrochure--->,RentedinPast,YearsRented,Budget,TravellingWith)
				      Values
						('Follow Up','Surfside Realty Contact Form',<cfqueryparam cfsqltype="cf_sql_varchar" value='#further_details#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Title# #FirstName#'>, <cfqueryparam cfsqltype="cf_sql_varchar" value='#MiddleName# #LastName#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Address1#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#city#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#State#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#zip#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#variables.encPhone#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#variables.encEmail#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Further_Details#'>,'Surfside Contact Form',<cfqueryparam cfsqltype="cf_sql_varchar" value='#Company#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Fax#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Address2#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Country#'>,
						<cfif isdefined('ContactVia')><cfqueryparam cfsqltype="cf_sql_varchar" value='#ContactVia#'><cfelse>'N/A'</cfif>,<cfif isdefined('Keep_Informed_on')><cfqueryparam cfsqltype="cf_sql_varchar" value='#Keep_Informed_on#'><cfelse>'N/A'</cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#How_Often_Visit#'>,<cfif isdefined('Special_Interests')><cfqueryparam cfsqltype="cf_sql_varchar" value='#Special_Interests#'><cfelse>'N/A'</cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#How_Found_us#'><!---,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Mail_Brochure#'>--->,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Rented_in_Past#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Years_Rented#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Budget#'>,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Travelling_With#'>)
					</cfquery>

					<cfquery name="getmaxid" datasource="#settings.dsn#">
						select max(id) as maxid
						from cms_contacts
						where email = <cfqueryparam cfsqltype="cf_sql_varchar" value='#email#'>
					</cfquery>

					<cfset MessageMainID = "#getmaxid.maxid#">
					<!--- They don't even use their leadtracker --->
<!---
					<cfquery datasource="#settings.dsn#" dbtype="ODBC">
						Insert
						Into cl_ReplyByEmail
						(Subject,status,notes,mainid,FromORTo)
				      Values
						('Surfside Realty Contact Form','Follow Up','#further_details#','#MessageMainID#','To Company')
					</cfquery> --->
				<!---END: LEADTRACKER CODING--->

				<!--- Contacting Agent on Duty --->
				<cfif isdefined('form.toAgent') and LEN(form.toAgent)>
					<cfset agentemail = form.toAgent>
				<cfelse>
					<cfset agentemail = ''>
				</cfif>

				<!--- <cfmail to="#ClientNotificationEmail#" from="#CFMailUserNameSurfside#" replyto="#TheEmail#" server="#MailServer#"  username="#CFMailUserNameSurfside#" password="#CFMailPassword#" port="465" useSSL="true" subject="#TheCompany# General Contact Form" type="HTML"> --->
				<cfif cgi.remote_host eq '172.110.82.184'>
					<cfset mailto = 'cbarksdale@icoastalnet.com' />
					<cfset agentemail = 'cbarksdale@icoastalnet.com'>
				<cfelse>
					<cfset mailto = cfmail.clientEmail />
				</cfif>

				<cfmail subject="New  General Contact Form from #cgi.http_host#" to="#mailto#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#agentemail#,#cfmail.bcc#" cc="#cfmail.cc#">
				 		<p>
							Salutation: #Title#<br>
							First Name: #FirstName#<br>
							Middle Name: #MiddleName#<br>
							Last Name: #LastName#<br>
							Company: #Company#<br>
							Email: #TheEmail#<br>
							Phone: #Phone#<br>
							Fax: #Fax#<br>
							Address1: #Address1#<br>
							Address2: #Address2#<br>
							City: #City#<br>
							U.S. State: #State#<br>
							Zip: #Zip#<br>
							Country: #Country#<br>
							Contact Via: <cfif isdefined('ContactVia')>#ContactVia#<cfelse>N/A</cfif><br>
							Please keep me informed via email on: <cfif isdefined('Keep_Informed_on')>#Keep_Informed_on#<cfelse>N/A</cfif><br>
							How often do you visit the Surfside Beach area? #How_Often_Visit#<br>
							Please indicate your special interests: <cfif isdefined('Special_Interests')>#Special_Interests#<cfelse>N/A</cfif><br>
							How did you find us? #How_Found_us#<br>
							<!--- Would you like us to mail you our current brochure? #Mail_Brochure#<br> --->
							Have you rented with Surfside Realty Company in the past? #Rented_in_Past#<br>
							If yes, how many years have you been renting with us? #Years_Rented#<br>
							What is your preferred price range for a 1 week stay? #Budget#<br>
							What type of group will you be travelling with? #Travelling_With#<br>
						</p>
							<p>Comments:<br>
							#Further_Details#

					</cfmail>
					<!---
					<cfoutput><iframe src="/conversion-converted.cfm?ConversionEmail=#Theemail#" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0"></iframe></cfoutput>

					<br>
					<br>
					<br>
					<br>
					<br>
					--->


					<cfinclude template="/components/mailchimp.cfm">

					<cflocation url="/thanks" addtoken="false">

				<cfelse>
				   Error
				</cfif><!--- cfformprotect test --->

			</cfif>






			<cfoutput>#page.body#</cfoutput>

			<form action="<cfoutput>/#page.slug#</cfoutput>" method="POST" id="contactsurfside">
				<cfinclude template="/cfformprotect/cffp.cfm">

				<cfif isdefined('url.to') and LEN(url.to)>
					<!--- Contacting Agent on Duty --->
					<cfquery name="getToAgent" datasource="#settings.dsn#">
						SELECT email
						FROM cms_staff
						Where id = <cfqueryparam value="#url.to#" cfsqltype="cf_sql_varchar"> and email <> ''
						Limit 1
					</cfquery>
					<cfif getToAgent.recordcount eq 1>
						<cfoutput><input type="hidden" name="toAgent" value="#getToAgent.email#"></cfoutput>
					</cfif>
				</cfif>

					<input type="hidden" name="email" value="">

					<!---
						<input type="hidden" value="http://www.surfsiderealty.com/contact-thanks.html" name="redirect">
						<input type="hidden" value="rentals@surfsiderealty.com" name="recipient">
						<input type="hidden" value="Surfside Realty Contact Form" name="subject">
						<input type="hidden" value="FirstName,LastName,Email,City,Zip" name="required">
					--->
					<table class="contact-table">
						<tr>
							<td colspan="4" align="right">
								(<font color="red" size="1"><b>*</b></font> Indicates required field.)
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Salutation:</td>
							<td align="left" colspan="3">
								<select class="form-control" class="form-control" size="1" name="Title">
									<option value="">[Title]</option>
									<option value="Dr.">Dr.</option>
									<option value="Hon.">Hon.</option>
									<option value="Miss">Miss</option>
									<option value="Mr.">Mr.</option>
									<option value="Mrs.">Mrs.</option>
									<option value="Ms.">Ms.</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right" width="20%" colspan="1">First Name:</td>
							<td align="left" colspan="3">
								<input type="Text" name="FirstName" required visible="Yes" enabled="Yes" size="24" maxlength="24">
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Middle Name:</td>
							<td align="left" colspan="3">
								<input type="text" maxlength="24" size="24" value="" name="MiddleName">
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Last Name:</td>
							<td align="left" colspan="3">
								<input type="Text" name="LastName" required visible="Yes" enabled="Yes" size="32" maxlength="32">
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Company:</td>
							<td align="left" colspan="3">
								<input type="text" maxlength="64" size="32" value="" name="Company">
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Email:</td>
							<td align="left" colspan="3">
								<input type="Text" name="TheEmail" required visible="Yes" enabled="Yes" size="32" maxlength="64">
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Phone:</td>
							<td align="left" colspan="3">
								<input type="text" maxlength="16" size="16" value="" name="Phone">
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Fax:</td>
							<td align="left" colspan="3">
								<input type="text" maxlength="16" size="16" value="" name="fax">
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Address1:</td>
							<td align="left" colspan="3">
								<input type="text" maxlength="48" size="44" value="" name="Address1">
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Address2:</td>
							<td align="left" colspan="3">
								<input type="text" maxlength="48" size="44" value="" name="Address2">
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">City:</td>
							<td align="left" colspan="3">
								<input type="Text" name="City" required visible="Yes" enabled="Yes" size="24" maxlength="24">
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">U.S. State:</td>
							<td align="left" colspan="3">
								<select class="form-control required clear" required size="1" name="State">
									<option value="">[Please select one]</option>
									<option value="AL">AL-Alabama</option>
									<option value="AK">AK-Alaska</option>
									<option value="AZ">AZ-Arizona</option>
									<option value="AR">AR-Arkansas</option>
									<option value="CA">CA-California</option>
									<option value="CO">CO-Colorado</option>
									<option value="CT">CT-Connecticut</option>
									<option value="DC">DC-Washington D.C.</option>
									<option value="DE">DE-Delaware</option>
									<option value="FL">FL-Florida</option>
									<option value="GA">GA-Georgia</option>
									<option value="HI">HI-Hawaii</option>
									<option value="ID">ID-Idaho</option>
									<option value="IL">IL-Illinois</option>
									<option value="IN">IN-Indiana</option>
									<option value="IA">IA-Iowa</option>
									<option value="KS">KS-Kansas</option>
									<option value="KY">KY-Kentucky</option>
									<option value="LA">LA-Louisiana</option>
									<option value="ME">ME-Maine</option>
									<option value="MD">MD-Maryland</option>
									<option value="MA">MA-Massachusetts</option>
									<option value="MI">MI-Michigan</option>
									<option value="MN">MN-Minnesota</option>
									<option value="MS">MS-Mississippi</option>
									<option value="MO">MO-Missouri</option>
									<option value="MT">MT-Montana</option>
									<option value="NE">NE-Nebraska</option>
									<option value="NV">NV-Nevada</option>
									<option value="NH">NH-New Hampshire</option>
									<option value="NJ">NJ-New Jersey</option>
									<option value="NM">NM-New Mexico</option>
									<option value="NY">NY-New York</option>
									<option value="NC">NC-North Carolina</option>
									<option value="ND">ND-North Dakota</option>
									<option value="OH">OH-Ohio</option>
									<option value="OK">OK-Oklahoma</option>
									<option value="OR">OR-Oregon</option>
									<option value="PA">PA-Pennsylvania</option>
									<option value="PR">PR-Puerto Rico</option>
									<option value="RI">RI-Rhode Island</option>
									<option value="SC">SC-South Carolina</option>
									<option value="SD">SD-South Dakota</option>
									<option value="TN">TN-Tennessee</option>
									<option value="TX">TX-Texas</option>
									<option value="UT">UT-Utah</option>
									<option value="VT">VT-Vermont</option>
									<option value="VA">VA-Virginia</option>
									<option value="VI">VI-Virgin Islands - US</option>
									<option value="WA">WA-Washington</option>
									<option value="WV">WV-West Virginia</option>
									<option value="WI">WI-Wisconsin</option>
									<option value="WY">WY-Wyoming</option>
									<option value="ZZ">Other-Not Shown</option>
								</select>
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Zip:</td>
							<td align="left" colspan="3">
								<input type="Text" name="Zip" required visible="Yes" enabled="Yes" size="10" maxlength="10" >
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="1">Country:</td>
							<td align="left" colspan="3">
								<select class="form-control required" required size="1" name="Country">
									<option value="AF">Afghanistan</option><option value="AL">Albania</option><option value="DZ">Algeria</option><option value="AS">American Samoa</option><option value="AD">Andorra</option><option value="AO">Angola</option><option value="AI">Anguilla</option><option value="AQ">Antarctica</option><option value="AG">Antigua And Barbuda</option><option value="AR">Argentina</option><option value="AM">Armenia</option><option value="AW">Aruba</option><option value="AU">Australia</option><option value="AT">Austria</option><option value="AZ">Azerbaijan</option><option value="BS">Bahamas</option><option value="BH">Bahrain</option><option value="BD">Bangladesh</option><option value="BB">Barbados</option><option value="BY">Belarus</option><option value="BE">Belgium</option><option value="BZ">Belize</option><option value="BJ">Benin</option><option value="BM">Bermuda</option><option value="BT">Bhutan</option><option value="BO">Bolivia</option><option value="BA">Bosnia And Herzegowina</option><option value="BW">Botswana</option><option value="BV">Bouvet Island</option><option value="BR">Brazil</option><option value="IO">British Indian Ocean Territory</option><option value="BN">Brunei Darussalam</option><option value="BG">Bulgaria</option><option value="BF">Burkina Faso</option><option value="BI">Burundi</option><option value="KH">Cambodia</option><option value="CM">Cameroon</option><option value="CA">Canada</option><option value="CV">Cape Verde</option><option value="KY">Cayman Islands</option><option value="CF">Central African Republic</option><option value="TD">Chad</option><option value="CL">Chile</option><option value="CN">China</option><option value="CX">Christmas Island</option><option value="CC">Cocos (Keeling) Islands</option><option value="CO">Colombia</option><option value="KM">Comoros</option><option value="CG">Congo</option><option value="CK">Cook Islands</option><option value="CR">Costa Rica</option><option value="CI">Cote D'Ivoire</option><option value="HR">Croatia</option><option value="CU">Cuba</option><option value="CY">Cyprus</option><option value="CZ">Array</option><option value="DK">Denmark</option><option value="DJ">Djibouti</option><option value="DM">Dominica</option><option value="DO">Dominican Republic</option><option value="TP">East Timor</option><option value="EC">Ecuador</option><option value="EG">Egypt</option><option value="SV">El Salvador</option><option value="GQ">Equatorial Guinea</option><option value="ER">Eritrea</option><option value="EE">Estonia</option><option value="ET">Ethiopia</option><option value="FK">Falkland Islands</option><option value="FO">Faroe Islands</option><option value="FJ">Fiji</option><option value="FI">Finland</option><option value="FR">France</option><option value="FX">France, Metropolitan</option><option value="GF">French Guiana</option><option value="PF">French Polynesia</option><option value="TF">French Southern Territories</option><option value="GA">Gabon</option><option value="GM">Gambia</option><option value="GE">Georgia</option><option value="DE">Germany</option><option value="GH">Ghana</option><option value="GI">Gibraltar</option><option value="GR">Greece</option><option value="GL">Greenland</option><option value="GD">Grenada</option><option value="GP">Guadeloupe</option><option value="GU">Guam</option><option value="GT">Guatemala</option><option value="GN">Guinea</option><option value="GW">Guinea-Bissau</option><option value="GY">Guyana</option><option value="HT">Haiti</option><option value="HM">Heard And Mc Donald Islands</option><option value="HN">Honduras</option><option value="HK">Hong Kong</option><option value="HU">Hungary</option><option value="IS">Iceland</option><option value="IN">India</option><option value="ID">Indonesia</option><option value="IR">Iran</option><option value="IQ">Iraq</option><option value="IE">Ireland</option><option value="IL">Israel</option><option value="IT">Italy</option><option value="JM">Jamaica</option><option value="JP">Japan</option><option value="JO">Jordan</option><option value="KZ">Kazakhstan</option><option value="KE">Kenya</option><option value="KI">Kiribati</option><option value="KP">North Korea (People's Republic Of Korea)</option><option value="KR">South Korea (Republic Of Korea)</option><option value="KW">Kuwait</option><option value="KG">Kyrgyzstan</option><option value="LA">Lao People's Republic</option><option value="LV">Latvia</option><option value="LB">Lebanon</option><option value="LS">Lesotho</option><option value="LR">Liberia</option><option value="LY">Libyan Arab Jamahiriya</option><option value="LI">Liechtenstein</option><option value="LT">Lithuania</option><option value="LU">Luxembourg</option><option value="MO">Macau</option><option value="MK">Macedonia</option><option value="MG">Madagascar</option><option value="MW">Malawi</option><option value="MY">Malaysia</option><option value="MV">Maldives</option><option value="ML">Mali</option><option value="MT">Malta</option><option value="MH">Marshall Islands</option><option value="MQ">Martinique</option><option value="MR">Mauritania</option><option value="MU">Mauritius</option><option value="YT">Mayotte</option><option value="MX">Mexico</option><option value="FM">Micronesia</option><option value="MD">Moldova</option><option value="MC">Monaco</option><option value="MN">Mongolia</option><option value="MS">Montserrat</option><option value="MA">Morocco</option><option value="MZ">Mozambique</option><option value="MM">Myanmar</option><option value="NA">Namibia</option><option value="NR">Nauru</option><option value="NP">Nepal</option><option value="NL">Netherlands</option><option value="AN">Netherlands Antilles</option><option value="NC">New Caledonia</option><option value="NZ">New Zealand</option><option value="NI">Nicaragua</option><option value="NE">Niger</option><option value="NG">Nigeria</option><option value="NU">Niue</option><option value="NF">Norfolk Island</option><option value="MP">Northern Mariana Islands</option><option value="NO">Norway</option><option value="OM">Oman</option><option value="PK">Pakistan</option><option value="PW">Palau</option><option value="PA">Panama</option><option value="PG">Papua New Guinea</option><option value="PY">Paraguay</option><option value="PE">Peru</option><option value="PH">Philippines</option><option value="PN">Pitcairn</option><option value="PL">Poland</option><option value="PT">Portugal</option><option value="PR">Puerto Rico</option><option value="QA">Qatar</option><option value="RE">Reunion</option><option value="RO">Romania</option><option value="RU">Russian Federation</option><option value="RW">Rwanda</option><option value="KN">Saint Kitts And Nevis</option><option value="LC">Saint Lucia</option><option value="VC">Saint Vincent And The Grenadines</option><option value="WS">Samoa</option><option value="SM">San Marino</option><option value="ST">Sao Tome And Principe</option><option value="SA">Saudi Arabia</option><option value="SN">Senegal</option><option value="SC">Seychelles</option><option value="SL">Sierra Leone</option><option value="SG">Singapore</option><option value="SK">Slovakia</option><option value="SI">Slovenia</option><option value="SB">Solomon Islands</option><option value="SO">Somalia</option><option value="ZA">South Africa</option><option value="GS">South Georgia And The South Sandwich Islands</option><option value="ES">Spain</option><option value="LK">Sri Lanka</option><option value="SH">St Helena</option><option value="PM">St Pierre and Miquelon</option><option value="SD">Sudan</option><option value="SR">Suriname</option><option value="SJ">Svalbard And Jan Mayen Islands</option><option value="SZ">Swaziland</option><option value="SE">Sweden</option><option value="CH">Switzerland</option><option value="SY">Syrian Arab Republic</option><option value="TW">Taiwan</option><option value="TJ">Tajikistan</option><option value="TZ">Tanzania</option><option value="TH">Thailand</option><option value="TG">Togo</option><option value="TK">Tokelau</option><option value="TO">Tonga</option><option value="TT">Trinidad And Tobago</option><option value="TN">Tunisia</option><option value="TR">Turkey</option><option value="TM">Turkmenistan</option><option value="TC">Turks And Caicos Islands</option><option value="TV">Tuvalu</option><option value="UG">Uganda</option><option value="UA">Ukraine</option><option value="AE">United Arab Emirates</option><option value="GB">United Kingdom</option><option selected="" value="US">United States</option><option value="UM">United States Minor Outlying Islands</option><option value="UY">Uruguay</option><option value="UZ">Uzbekistan</option><option value="VU">Vanuatu</option><option value="VA">Vatican City State</option><option value="VE">Venezuela</option><option value="VN">Viet Nam</option><option value="VG">Virgin Islands (British)</option><option value="VI">Virgin Islands (U.S.)</option><option value="WF">Wallis And Futuna Islands</option><option value="EH">Western Sahara</option><option value="YE">Yemen</option><option value="ZR">Zaire</option><option value="ZM">Zambia</option><option value="ZW">Zimbabwe</option><option value="ZZ">Other-Not Shown</option>
								</select>
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="left" colspan="4">
								Surfside Realty Co., Inc. may contact me by any of the following methods:
								<font color="red"><b>*</b></font>
							</td>
						</tr>
						<tr>
							<td align="left" colspan="1">&nbsp;</td>
							<td align="left" width="25%" class="plain" colspan="1">
								<input type="checkbox" checked="checked" value="email" name="ContactVia" class="clear">email</td><td align="left" width="25%" class="plain" colspan="1">
								<input type="checkbox" checked="checked" value="mail" name="ContactVia" class="clear">mail</td><td align="left" width="30%" class="plain" colspan="1">
								<input type="checkbox" value="phone" name="ContactVia" class="clear">phone
							</td>
						</tr>

						<tr valign="top">
							<td align="left" colspan="4">
								<br>
								<div style="visibility: visible;" id="Q801">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="4">
												<b>Please keep me informed via email on:</b>
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Rate Reductions" name="Keep_Informed_on" class="clear">Rate Reductions
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Special Events" name="Keep_Informed_on" class="clear">Special Events
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Promotional Offers" name="Keep_Informed_on" class="clear">Promotional Offers
											</td>
										</tr>
									</table>
								</div>
								<div style="visibility: visible;" id="Q831">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="2">
												<b>How often do you visit the Surfside Beach area?</b>
											</td>
											<td align="left" width="30%" colspan="2" class="plain">
												<select class="form-control" name="How_Often_Visit">
													<option>-select one-</option>
													<option value="Once a year">Once a year</option>
													<option value="More than once a year">More than once a year</option>
													<option value="Less than once a year">Less than once a year</option>
												</select>
											</td>
										</tr>
									</table>
								</div>
								<div style="visibility: visible;" id="Q832">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="4">
												<b>Please indicate your special interests:</b>
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Beach Vacation" name="Special_Interests" class="clear">Beach Vacation
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Fishing" name="Special_Interests" class="clear">Fishing
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Water Sports" name="Special_Interests" class="clear">Water Sports
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Golf" name="Special_Interests" class="clear">Golf
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="checkbox" value="Shopping" name="Special_Interests" class="clear">Shopping
											</td>
										</tr>
									</table>
								</div>
								<div style="visibility: visible;" id="Q833">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="2">
												<b>How did you find us?</b>
											</td>
											<td align="left" width="30%" colspan="2" class="plain">
												<select class="form-control" name="How_Found_us">
													<option>-select one-</option><option value="Google">Google</option><option value="Yahoo!">Yahoo!</option><option value="MSN">MSN</option><option value="Ask.com">Ask.com</option><option value="AOL">AOL</option><option value="Print Advertising">Print Advertising</option><option value="Chamber of Commerce">Chamber of Commerce</option><option value="Radio Advertising">Radio Advertising
												</select>
											</td>
										</tr>
									</table>
								</div>
								<!---
								<div style="visibility: visible;" id="Q841">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="4">
												<b>Would you like us to mail you our current brochure?</b>
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="radio" value="Yes" name="Mail_Brochure" class="clear">Yes
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="radio" name="Mail_Brochure" value="No" checked class="clear">No
											</td>
										</tr>
									</table>
								</div>
								--->
								<div style="visibility: visible;" id="Q834">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="4">
												<b>Have you rented with Surfside Realty Company in the past?</b>
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="radio" value="Yes" name="Rented_in_Past" class="clear">Yes
											</td>
										</tr>
										<tr>
											<td align="left" colspan="4" class="plain">
												<input type="radio" name="Rented_in_Past" value="No" checked class="clear">No
											</td>
										</tr>
									</table>
								</div>
								<div style="visibility: visible;" id="Q835">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="2">
												<b>If yes, how many years have you been renting with us?</b>
											</td>
											<td align="left" width="30%" colspan="2" class="plain">
												<select class="form-control" name="Years_Rented">
													<option>-select one-</option>
													<option value="1 Year">1 year</option>
													<option value="2 Years">2 years</option>
													<option value="3 Years">3 years</option>
													<option value="4 Years">4 years</option>
													<option value="5 Years">5 years</option>
													<option value="6 Years">6 years</option>
													<option value="7 Years">7 years</option>
													<option value="8 years">8 years</option>
													<option value="9 Years">9 years</option>
													<option value="10 or More Years">10 or more years</option>
												</select>
											</td>
										</tr>
									</table>
								</div>
								<div style="visibility: visible;" id="Q836">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="2">
												<b>Surfside Realty Company has a large selection of rental homes and condos to meet any budget. What is your preferred price range for a 1 week stay?</b>
											</td>
											<td align="left" width="30%" colspan="2" class="plain">
												<select class="form-control" name="Budget">
													<option>-select one-</option>
													<option value="$1,000 - $3,000">$1,000 - $3,000</option>
													<option value="$3,0001 - $5,000">$3,001 - $5,000</option>
													<option value="$5,0001 - $8,000">$5,001 - $8,000</option>
													<option value="$8,000 +">$8,000+
												</select>
											</td>
										</tr>
									</table>
								</div>
								<div style="visibility: visible;" id="Q837">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="2">
												<b>What type of group will you be travelling with?</b>
											</td>
											<td align="left" width="30%" colspan="2" class="plain">
												<select class="form-control" name="Travelling_With">
													<option>-select one-</option>
													<option value="Family">Family</option>
													<option value="Couple">Couple</option>
													<option value="Adult">Adult
												</select>
											</td>
										</tr>
									</table>
								</div>
								<div style="visibility: visible;" id="Q926">
									<table border="0" width="70%">
										<tr>
											<td align="left" colspan="4">
												<b>Please give further details on any properties you are interested in, the dates you plan to visit, and a way and time to contact you:</b>
											</td>
										</tr>
										<tr>
											<td align="center" colspan="4">
												<textarea maxcols="1024" cols="45" rows="6" name="Further_Details" placeholder="Please provide information regarding..."></textarea>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
                        <tr>
							<td align="center" colspan="4">
								<div id="contactlongcaptcha"></div><br />
								<div class="g-recaptcha-error"></div>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="4">
								<div style="display: none; color: red;" id="formResults">There are some required fields you missed above.</div>
								<br>
								<input type="Submit" name="Submit" value="Submit Form" visible="Yes" enabled="Yes" class="button btn" onClick="ga('send', 'event', { eventCategory: 'contact', eventAction: 'submitted', eventLabel: 'contact-form-submitted'});">&nbsp;<!--- <input type="Submit" name="reset" value="Clear Fields" visible="Yes" enabled="Yes" class="button btn"> --->
								<!---
								<input type="Submit" name="Submit" value="Submit Form" visible="Yes" enabled="Yes" class="button">&nbsp;<input type="Submit" name="reset" value="Clear Fields" visible="Yes" enabled="Yes" class="button">
								--->
							</td>
						</tr>
					</table>

				</form>

<!--- 		CSS for validation --->
		<style>
			label.error{color:red;}
			label.valid{display:none !important;}
		</style>
		<script>
		$(document).ready(function () {

		    $('#contactsurfside').validate({
		        rules: {
		            FirstName: {
		                required: true
		            },
		            LastName: {
		                required: true
		            },
		            TheEmail: {
		                required: true,
		                email: true
		            },
		            City: {
		                required: true
		            },
		            State: {
		                required: true
		            },
		            Zip: {
		                minlength: 5,
		                required: true
		            },
		            ContactVia: {
		                required: true
		            },


		        },
		        highlight: function (element) {
		            $(element).closest('.control-group').removeClass('success').addClass('error');
		        },
		        success: function (element) {
		            element.text('OK!').addClass('valid')
		                .closest('.control-group').removeClass('error').addClass('success');
		        }
		    });

		});
		</script>


			<!--- </cfif> --->
		</div>
	</div>
</div>
