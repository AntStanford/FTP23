<!---
Function index:

bookNow

checkOut

getCalendarData

getCalendarRates

getDetailRates

getFeaturedProperties

getMinMaxAmenities

getMinMaxPrice

getProperty

getPropertyAmenities

getPropertyPhotos

getPropertyPriceRange

getPropertyRates

getPropertyReviews

getSearchResults

getSearchResultsProperty

setGoogleAnalytics

setMetaData

submitLeadToThirdParty

getDistinctTypes

getDistinctAreas

getDistinctViews

getAllProperties

insertAPILogEntry

getRandomProperties

getSearchFilterCount

getPriceBasedOnDates

getPropertyCleans
--->


<cfcomponent hint="Escapia CFC">

   <cffunction name="init" access="public" output="false" hint="constructor">
      <cfargument name="settings" type="struct" required="true" hint="settings" />
      <cfset variables.settings = arguments.settings>

      <cfset ravenConfig = structNew()>

	    <cfset ravenConfig.publicKey = settings.sentry_publickey>
	    <cfset ravenConfig.privateKey = settings.sentry_privatekey>
	    <cfset ravenConfig.sentryUrl = settings.sentry_url>
	    <cfset ravenConfig.projectID = settings.sentry_projectid>
	    <cfset ravenClient = createObject('component', 'error.components.client').init(argumentCollection=ravenConfig)>

      <cfreturn this />
   </cffunction>

   <cffunction name="booknow" returnType="string" hint="Used in book-now_.cfm to check availability and get pricing for the checkout page">

	   	<cfargument name="unitcode" required="true">
	   	<cfargument name="strcheckin" required="true">
	   	<cfargument name="strcheckout" required="true">
	   	<cfargument name="useraction" required="false" default="">
	   	<cfargument name="promocode" required="false" default="">
	   	<cfargument name="chargetemplateid" required="false" default="0">
	   	<cfargument name="numAdults" required="false" default="2">
	   	<cfargument name="numChildren" required="false" default="0">
	   	<cfargument name="addons" required="false" default="">

            <cfset var totalFees = 0>
            <cfset var travelinsuranceAmt = 0>
            <cfset var qryAddOns = "">
            <cfset session.chargetemplateid = chargetemplateid>
            <cfset var timestamp = DateFormat(now(),'yyyy-mm-dd') & 'T' & TimeFormat(now(),'HH:mm:ss')>
            <cfset var addonAmount = 0>
            <cfset var i = 0>
            <cfset var displayTaxes = 0>
            <cfset var displayTotal = 0>

            <cfset var XMLvar = ''>
            <cfset var AdditionalChargesArray = ''>
            <cfset var chargetemplateid = ''>
            <cfset var DepositPaymentsArray = ''>
            <cfset var discountAmount = ''>
            <cfset var apiresponse = ''>
            <cfset var discountAmount = ''>
            <cfset var FeesArray = ''>


			<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="XMLvar">
				<cfoutput>
				<?xml version="1.0" encoding="UTF-8"?>
				<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
					<s:Header>
						<ActivityId CorrelationId="4f58be7c-ccfb-4afe-9937-65f36735683c" xmlns="http://schemas.microsoft.com/2004/09/ServiceModel/Diagnostics">2ecee460-6cb8-4175-b6a6-716782f54d18</ActivityId>
					</s:Header>
					<s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
						<EVRN_UnitStayRQ TransactionIdentifier="#CreateUUID()#" TimeStamp="#timestamp#" EchoToken="request" Version="1.0" xmlns="http://www.escapia.com/EVRN/2007/02">
							<POS>
								<Source>
									<RequestorID ID="#variables.settings.booking.username#" MessagePassword="#variables.settings.booking.password#"/>
								</Source>
							</POS>
				         <cfif StructKeyExists(arguments,'promocode') and len(arguments.promocode)>
							   <UnitStay PromotionCode="#arguments.promocode#">
							<cfelse>
							   <UnitStay>
							</cfif>
								<UnitRef UnitCode="#arguments.unitcode#"/>
								<StayDateRange Start="#arguments.strCheckin#" End="#arguments.strCheckout#"/>
								<GuestCounts>
									<GuestCount AgeQualifyingCode="10" Count="#arguments.numAdults#"/>
									<GuestCount AgeQualifyingCode="8" Count="#arguments.numChildren#"/>
								</GuestCounts>
								<cfif arguments.useraction is "add_insurance">
									<AdditionalCharges OptionalChargesIndicator="IncludeSpecified">
										<AdditionalCharge ChargeTemplateID="#session.chargetemplateid#" Quantity="1"/>
									</AdditionalCharges>
								<cfelseif arguments.useraction is 'remove_insurance'>
									<AdditionalCharges OptionalChargesIndicator="ExcludeAll">
										<AdditionalCharge ChargeTemplateID="#session.chargetemplateid#" Quantity="1"/>
									</AdditionalCharges>
								</cfif>
							</UnitStay>
						</EVRN_UnitStayRQ>
					</s:Body>
				</s:Envelope>
				</cfoutput>
			</cfsavecontent>
		</cfprocessingdirective>

		<cfset XMLVar = trim(XMLVar)>

		<!--- Log the API request --->
		<cfset insertAPILogEntry(cgi.script_name,xmlVar,'Log the request')>

		<cftry>

			<cfhttp url="https://api.escapia.com/EVRNService.svc" timeout="30" method="post">
			   <cfhttpparam type="header" name="Content-Type" value="text/xml;charset=utf-8"/>
			   <cfhttpparam type="header" name="Content-Length" value="#len(XMLVar)#" />
			   <cfhttpparam type="header" name="SOAPAction" value="UnitStay" />
			   <cfhttpparam type="body" value="#trim(XMLVar)#" />
			</cfhttp>

			<cfif isdefined('cfhttp.FileContent')>
				<cfset RES = cfhttp.filecontent>
            </cfif>

			<cfcatch>
				<cfset APIresponse = "Sorry, there was an error processing your request here.">
				<cfif isdefined("ravenClient")>
					<cfset ravenClient.captureException(cfcatch,50)>
				</cfif>
			</cfcatch>

		</cftry>

		<cfif isdefined('RES') and isXML(RES)>
			<cftry>

				<cfset XMLString = xmlparse(RES)>

				<!--- Log the API response --->
				<cfset insertAPILogEntry(cgi.script_name,xmlVar,RES)>

				<cfif structkeyexists(XMLString.Envelope.Body.EVRN_UnitStayRS,'Errors')>
					<cfset var errorText = XMLString.Envelope.Body.EVRN_UnitStayRS.Errors.Error.XmlText>
					<cfsavecontent variable="apiresponse">
						<cfoutput>
							Error = #errorText#
							<input type="hidden" name="current_state_of_ti" value="#arguments.useraction#">
						</cfoutput>
					</cfsavecontent>
				<cfelse>
					<cfset var baseRent = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Base.xmlAttributes.AmountBeforeTax>
					<cfset var baseRentPlusFees = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.Total.xmlAttributes.AmountBeforeTax>
					<cfset var TotalTaxes = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.Total.Taxes.xmlAttributes.Amount>
					<cfset var Total = baseRentPlusFees + TotalTaxes>
					<cfif structKeyExists(XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Fees,'Fee')>
						<cfset FeesArray = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Fees.Fee>
					</cfif>
					<cfif structKeyExists(XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.AdditionalCharges,'AdditionalCharge')>
						<cfset AdditionalChargesArray = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.AdditionalCharges.AdditionalCharge>
						<cfset chargetemplateid = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.AdditionalCharges.AdditionalCharge.xmlattributes.chargetemplateid>
					</cfif>
					<cfif structKeyExists(XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay,'DepositPayments')>
						<cfset DepositPaymentsArray = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.DepositPayments.GuaranteePayment>
						<cfquery dataSource="#variables.settings.booking.dsn#" result="insertDepositArray">
						    insert into escapia_deposits(unitcode,strcheckin,strcheckout,depositArray)
						    values(
						       <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">,
						       <cfqueryparam CFSQLType="CF_SQL_DATE" value="#DateFormat(arguments.strcheckin,'yyyy-mm-dd')#">,
						       <cfqueryparam CFSQLType="CF_SQL_DATE" value="#DateFormat(arguments.strcheckout,'yyyy-mm-dd')#">,
						       <cfqueryparam CFSQLType="cf_sql_varchar" value="#XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.DepositPayments#">
						    )
						</cfquery>
						<cfset escapiaDepositGeneratedKey = insertDepositArray.generatedKey>
						<cfif structKeyExists(XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate,'Discount')>
							<cfset discountAmount = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Discount.xmlattributes.amountbeforetax>
						</cfif>
						<cfsavecontent variable="apiresponse">
							<cfoutput>
               		<input type="hidden" name="new_escapiaDepositGeneratedKey" value="#escapiaDepositGeneratedKey#">
               		<table class="table table-striped">
								<cfif StructKeyExists(arguments,'promocode') and len(arguments.promocode)>
									<tr class="alert alert-success">
										<th>Discounted Rate (Promo code: #arguments.promocode#)</th>
										<td align="right">#DollarFormat(baseRent)#</td>
									</tr>
								<cfelse>
									<tr>
										<th>Base Rate</th>
										<td align="right">#DollarFormat(baseRent)#</td>
									</tr>
								</cfif>
								<cfif isdefined('FeesArray') and arraylen(FeesArray) gt 0>
									<cfloop from="1" to="#arraylen(FeesArray)#" index="i">
										<cfif FeesArray[i].Description[1].Text.xmlText EQ "Sec Deposits for Monthly Stays">
                    	                   <cfset total = total - FeesArray[i].xmlAttributes.Amount>
                                        <cfelse>
                                          <tr>
                                            <th>#FeesArray[i].Description[1].Text.xmlText#
                    												    <cfif FindNoCase('Peace of Mind',FeesArray[i].Description[1].Text.xmlText)>
                                                	&nbsp;&nbsp;<span class="glyphicon glyphicon-question-sign" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Peace of Mind Protection is a mandatory fee that covers the Guest up to $500 (condo) or up to $1,000.00 (house) for any accidental damage that occurs to property belonging to the Owner of the Premises where the Guest is staying. The Protection does not cover any other property. The Protection does not cover any property owned by Guest or brought onto the Premises by Guest or any other person. In order for the Protection to apply, Guest must immediately report any and all accidental damage to Surfside Realty staff within 24 hours of the event causing damage. Upon timely report, Surfside Realty staff will investigate the claim and Surfside Realty staff will then, in its sole discretion, determine whether the Protection applies to cover the loss. The failure of the Guest to timely report incidents will result in the loss of the Protection. The Protection does NOT cover acts of God, intentional acts of a Guest, gross negligence or willful and wanton conduct, any damage not timely reported to Surfside Realty's staff within 24 hours, normal wear and tear, theft without a police report, and/or damages caused by any pet or other animal brought into the premises."></span>
                    															<script type="application/javascript" language="javascript">$('[data-toggle="tooltip"]').tooltip();</script>
                                                <cfelseif FindNoCase('Linen',FeesArray[i].Description[1].Text.xmlText)>
                                                	&nbsp;&nbsp;<span class="glyphicon glyphicon-question-sign" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="If you would like to decline the linen package, you must decline on the Deposit Request Agreement which will be emailed to you shortly after booking.  The linen package charge will then come off of your second payment or current balance if your reservation is booked within 30 days of arrival."></span>
                    															<script type="application/javascript" language="javascript">$('[data-toggle="tooltip"]').tooltip();</script>
                                                </cfif>
                                            </th>
                                            <td align="right">#DollarFormat(FeesArray[i].xmlAttributes.Amount)#</td>
                                          </tr>
                                          <cfset totalFees = totalFees + #FeesArray[i].xmlAttributes.Amount#>
                                        </cfif>
									</cfloop>
								</cfif>
								<cfif isdefined('AdditionalChargesArray') and arraylen(AdditionalChargesArray) GT 0>
									<cfloop from="1" to="#arraylen(AdditionalChargesArray)#" index="i">
										<cfset var AddlChargeText = AdditionalChargesArray[i].Description[1].Text.xmlText>
										<cfset var AddlChargeQty = AdditionalChargesArray[i].xmlAttributes.Quantity>
										<cfif arguments.useraction is "add_insurance">
											<tr class="warning">
												<th>#AddlChargeText#</th>
												<td align="right">#DollarFormat(AdditionalChargesArray[i].Amount.xmlAttributes.AmountBeforeTax)#</td>
											</tr>
										</cfif>
									</cfloop>
								</cfif>
								<!--- Add Ons --->
                <cfif ListLen(arguments.addons) GT 0>
                  <cfquery name="qryAddOns" dataSource="#variables.settings.booking.dsn#">
                  SELECT id, title, amount, tax
                  FROM cms_checkout_addons
                  WHERE 1 = 0
                        <cfloop list="#arguments.addons#" index="i">
                          OR id = <cfqueryparam value="#ListFirst(i,'-')#" cfsqltype="cf_sql_integer">
                        </cfloop>
                  </cfquery>
                  <cfloop query="qryAddOns">
					<cfset var addonAmount = 0 >
                    <cfloop list="#arguments.addons#" index="i">
                      <cfif qryAddOns.id EQ ListFirst(i,'-')>
                        <tr>
                          <th>#qryAddOns.title# <cfif ListLast(i,'-') GT 1>(#ListLast(i,'-')#)</cfif> &nbsp;&nbsp; <a href="javascript:void(0);" onclick="removeAddOn('##addon#qryAddOns.id#');">Remove</a></th>
                              <cfset addonAmount = qryAddOns.amount * ListLast(i,'-')>
                              <cfset displayTaxes = displayTaxes + (qryAddOns.tax * ListLast(i,'-'))>
                              <cfset displayTotal = displayTotal + addonAmount + (qryAddOns.tax * ListLast(i,'-'))>
                          <td align="right">#DollarFormat(addonAmount)#</td>
                        </tr>
                      </cfif>
                    </cfloop>
                  </cfloop>
                </cfif>
                <tr>
									<th>Taxes</th>
									<cfset displayTaxes = displayTaxes + TotalTaxes>
									<td align="right">#DollarFormat(displayTaxes)#</td>
								</tr>
								<tr>
									<th><strong>Total</strong></th>
                  <cfset displayTotal = displayTotal + total>
									<td align="right"><strong>#DollarFormat(displayTotal)#</strong></td>
								</tr>
	            		</table>
							<b>Deposits</b>
							<table class="table table-striped">
								<cfif isdefined('DepositPaymentsArray') and arraylen(DepositPaymentsArray) GT 0>
									<cfloop from="1" to="#arraylen(DepositPaymentsArray)#" index="i">
										<cfset var DepositType = DepositPaymentsArray[i].xmlattributes.type>
										<cfif DepositType eq 'RequiredPayment'>
											<cfset var DepositAmount = DepositPaymentsArray[i].AmountPercent.xmlattributes.Amount>
											<cfset var DepositDate = DepositPaymentsArray[i].Deadline.xmlattributes.absolutedeadline>
											<tr>
												<td colspan="2">#DollarFormat(DepositAmount)# is due on #DepositDate#</td>
											</tr>
										</cfif>
									</cfloop>
								</cfif>
							</table>
							<cfif isdefined('AdditionalChargesArray') and arraylen(AdditionalChargesArray) GT 0>
								<cfloop from="1" to="#arraylen(AdditionalChargesArray)#" index="i">
									<cfset var AddlChargeText = AdditionalChargesArray[i].Description[1].Text.xmlText>
									<cfset var AddlChargeQty = AdditionalChargesArray[i].xmlAttributes.Quantity>
									<cfif AddlChargeText eq 'Travel Insurance'>

										<cfset tripinsurance="add">
										<cfset travelinsuranceAmt = AdditionalChargesArray[i].Amount.xmlAttributes.AmountBeforeTax>

										<script type="text/javascript">
								         $('input##tripinsuranceamount').val("<cfoutput>#travelinsuranceAmt#</cfoutput>");
								      </script>

										<h3>Protect Your Trip</h3>
										<b>Travel Insurance</b> - Protect your payments should you have to cancel.
										<p><input type="radio" name="travel_insurance" value="add_insurance"    id="addinsurance"    data-serviceid="" data-tripinsuranceamount="#travelinsuranceAmt#" <cfif arguments.useraction EQ 'add_insurance'>CHECKED</cfif>> <label for="addinsurance">Add travel insurance for #DollarFormat(AdditionalChargesArray[i].Amount.xmlAttributes.AmountBeforeTax)#</label></p>
										<p><input type="radio" name="travel_insurance" value="remove_insurance" id="removeinsurance" data-serviceid="" data-tripinsuranceamount="#travelinsuranceAmt#" <cfif arguments.useraction EQ 'remove_insurance'>CHECKED</cfif> > <label class="nothanks" for="removeinsurance">No thanks, I am not interested in travel insurance</label></p>
                    <p><i>Guest must initial to accept or decline trip insurance on the Deposit Request Agreement within 14 days of booking for selection to be valid.</i></p>
									</cfif>
								</cfloop>
							</cfif>
							</cfoutput>

						</cfsavecontent>

						<!--- This script loads the data from the API call to the hidden input fields in the checkout form --->
						<script type="text/javascript">
				         $('input#Total').val("<cfoutput>#total#</cfoutput>");
								 $('input#selectedAddOns').val("<cfoutput>#arguments.addons#</cfoutput>");
				         $('input#baseRentPlusFees').val("<cfoutput>#baseRentPlusFees#</cfoutput>");
				         $('input#totalTaxes').val("<cfoutput>#totalTaxes#</cfoutput>");
				         $('input.chargetemplateid').val("<cfoutput>#chargetemplateid#</cfoutput>");
				         $('input#escapiaDepositGeneratedKey').val("<cfoutput>#escapiaDepositGeneratedKey#</cfoutput>");
				      </script>

					</cfif>
				</cfif>
				<cfcatch>
					<cfsavecontent variable="apiresponse">Sorry, there was an error processing your request.<cfoutput>#cfcatch#</cfoutput></cfsavecontent>
					<cfif isdefined("ravenClient")>
						<cfset ravenClient.captureException(cfcatch,50)>
					</cfif>
				</cfcatch>
			</cftry>
		</cfif>

		<cfreturn apiresponse>

   </cffunction> <!--- end of booknow function --->



   <cffunction name="checkout" returnType="string" hint="Book and confirm the reservation">

	   	<cfargument name="form" required="true">

			<cfset var reservationCode = ''>
            <cfset var mydata = ''>
            <cfset var XMLVar = ''>
            <cfset var APIresponse = ''>
            <cfset var RES = ''>

            <cfset var MaskedCardNumber =  ''>
            <cfset var CardToken = ''>

	   	<!--- Start HAPI token --->
			<cfset var ServerUrl = variables.settings.booking.hapiTokenURL>
			<cfset var ClientId = variables.settings.booking.hapiTokenClientID>
			<cfset var ApiKey = variables.settings.booking.hapiTokenApiKey>

			<cfif ServerUrl eq '' OR ClientId eq '' OR ApiKey eq ''>
			   <cfset session.errormessage = 'Some or all of the HAPI settings have not been defined in the settings table.'>
			   <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
			</cfif>

			<!--- Time in milliseconds --->
			<cfset var localTimeUTCSeconds = #DateDiff("s", "December 31 1969 19:00:00", now())#>
			<cfset var timeinMilliseconds = localTimeUTCSeconds & '000'>

			<!--- digest is created by appending the time and api key and then encrypting it --->
			<cfset var secureKey = GenerateSecretKey('AES')>
			<cfset var digest = timeinMilliseconds & ApiKey>
			<cfset digest = Hash(digest,'SHA-256')>
			<cfset digest = Trim(digest)>
			<cfset digest = Lcase(digest)>
			<cfset var finalUrl = "#ServerUrl#/tokens?time=#timeinMilliseconds#&digest=#digest#&clientId=#ClientId#">

			<cfprocessingdirective suppresswhitespace="yes">
			<cfsavecontent variable="mydata">
			<cfoutput>
				<tokenForm>
					<tokenType>CC</tokenType>
					<value>#form.ccnumber#</value>
				</tokenForm>
			</cfoutput>
			</cfsavecontent>
			</cfprocessingdirective>

			<cfset XMLVar = trim(mydata)>

            <cfset var HEADERS = ''>
			<cfsavecontent variable="HEADERS">
			<cfoutput>Content-Type: application/xml; charset=utf-8#variables.settings.booking.crlf#Content-Length: #len(XMLVar)##variables.settings.booking.crlf#</cfoutput>
			</cfsavecontent>

			<cftry>

				<cfhttp method="post" timeout="30" url="#finalUrl#" result="APIresponse">
					<cfhttpparam type="header" name="Content-Type" value="application/xml;"/>
					<cfhttpparam type="header" name="Content-Length" value="#len(XMLVar)#" />
					<cfhttpparam type="header" name="SOAPAction" value="UnitStay" />
					<cfhttpparam type="body" name="body" value="#trim(XMLVar)#" />
				</cfhttp>

                <cfif isdefined('APIresponse')>
					<cfset RES = APIresponse.filecontent>
                </cfif>

			<cfcatch>
			  <cfif isdefined("ravenClient")>
			     <cfset ravenClient.captureException(cfcatch,50)>
			  </cfif>
			  <cfset session.errorMessage = cfcatch.message>
			  <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
			</cfcatch>

			</cftry>

			<cfif !isdefined('RES')>
			   <cfset session.errorMessage = 'RES is undefined.'>
			   <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
			</cfif>

			<cfif isXML(RES)>

			  <cfset XMLString = XMLParse(RES)>

			  <cfif isDefined("XMLString.error.msg.xmltext")>

			    <cfif isdefined("ravenClient")>
			      <cfset ravenClient.captureMessage('Escapia.cfc->checkout. Location B. XMLString = ' & XMLString)>
			    </cfif>
			    <cfset session.errorMessage = XMLString.error.msg.xmltext>
			    <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">

			  <cfelse>
                <cftry>

    			    <cfset MaskedCardNumber = xmlstring.token.maskedvalue.xmltext>
    			    <cfset CardToken = xmlstring.token.xmlattributes.id>

				<cfcatch type="any">
                    <cfset ravenClient.captureException(cfcatch)>

                    <cfset session.errorMessage = "Issue with Payment.">
                    <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
                </cfcatch>
				</cftry>
			  </cfif>

			<cfelse>
			   <cfset session.errorMessage = ''>
			   <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
			</cfif>
			<!--- end of HAPI token --->

			<cfif isDefined('MaskedCardNumber') AND LEN(MaskedCardNumber) and isDefined('CardToken') AND LEN(CardToken) and isdefined('form.escapiaDepositGeneratedKey')>

					<cfquery name="getEscapiaDeposits" dataSource="#variables.settings.booking.dsn#">
						select depositArray
						from escapia_deposits
						where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.escapiaDepositGeneratedKey#">
					</cfquery>

					<!---Create timestamp for the api call --->
					<cfset var timestamp = DateFormat(now(),'yyyy-mm-dd') & 'T' & TimeFormat(now(),'HH:mm:ss')>

					<cfprocessingdirective suppresswhitespace="yes">
					<cfsavecontent variable="XMLvar">
					<cfoutput>
					<?xml version="1.0" encoding="utf-8"?>
					<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
						<s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
							<EVRN_UnitResRQ TransactionIdentifier="#CreateUUID()#" TimeStamp="#timestamp#" EchoToken="UnitResHelper" Version="1.0" xmlns="http://www.escapia.com/EVRN/2007/02">
								<POS>
									<Source>
										<RequestorID ID="#variables.settings.booking.username#" MessagePassword="#variables.settings.booking.password#"/>
									</Source>
								</POS>
								<UnitReservations>
									<UnitReservation>
										<UnitStays>
											<cfif isdefined('form.hiddenPromoCode') and len(form.hiddenPromoCode)>
												<UnitStay PromotionCode="#form.hiddenPromoCode#">
											<cfelse>
												<UnitStay PromotionCode="">
											</cfif>
					   			          <cfif isdefined('form.addInsurance') and form.addInsurance is "true">
					                        <UnitRates>
					                           <UnitRate>
					                              <Rates>
					                                 <Rate>
					                                    <AdditionalCharges AmountBeforeTax="0.00" AmountAfterTax="0.00">
					                                       <AdditionalCharge Quantity="1" ChargeTemplateID="#form.chargetemplateid#">
					                                          <Amount AmountBeforeTax="#form.tripinsuranceamount#">
					                                             <Taxes Amount="0.00"/>
					                                          </Amount>
					                                          <Description Name="Charge Description">
					                                             <Text> Travel Protection Insurance</Text>
					                                          </Description>
					                                          <Description Name="Charge Type">
					                                             <Text>Travel Insurance</Text>
					                                          </Description>
					                                       </AdditionalCharge>
					                                    </AdditionalCharges>
					                                 </Rate>
					                              </Rates>
					                           </UnitRate>
					                         </UnitRates>
					                     </cfif>
												<GuestCounts>
													<GuestCount AgeQualifyingCode="10" Count="#form.numAdults#"/>
													<GuestCount AgeQualifyingCode="8" Count="#form.numChildren#"/>
												</GuestCounts>
												<TimeSpan End="#form.strCheckout# #form.checkouttime#" Start="#form.strCheckin# #form.checkintime#"/>
												<Total AmountBeforeTax="#form.baseRentPlusFees#">
													<Taxes Amount="#form.TotalTaxes#"/>
												</Total>
												<BasicUnitInfo UnitCode="#form.propertyid#" UnitName="#XMLFormat(form.propertyName)#"></BasicUnitInfo>
											</UnitStay>
										</UnitStays>
										<ResGuests>
											<ResGuest ResGuestRPH="1">
												<Profiles>
													<ProfileInfo>
														<Profile ProfileType="1">
															<Customer>
																<PersonName>
																	<GivenName>#XMLFormat(form.firstname)#</GivenName>
																	<Surname>#XMLFormat(form.lastname)#</Surname>
																</PersonName>
																<Telephone PhoneNumber="#form.phone#"/>
																<Email DefaultInd="true">#form.email#</Email>
																<Address>
																	<AddressLine>#form.address1# <cfif StructKeyExists(form,'address2') AND len(form.address2)>#form.address2#</cfif></AddressLine>
																	<CityName>#form.city#</CityName>
																	<PostalCode>#form.zip#</PostalCode>
																	<StateProv StateCode="#form.state#"/>
																	<CountryName Code="#form.country#"/>
																</Address>
															</Customer>
														</Profile>
													</ProfileInfo>
												</Profiles>
											</ResGuest>
										</ResGuests>
										<ResGlobalInfo>
											<ResGuestRPHs>
												<ResGuestRPH RPH="1"/>
											</ResGuestRPHs>
											<cfif isdefined('getEscapiaDeposits') and getEscapiaDeposits.recordcount gt 0>
					   						<cfset xmlstring = xmlparse(getEscapiaDeposits.depositArray)>
					   						<cfset numPayments = arraylen(xmlstring.depositpayments.guaranteepayment)>
					   						<DepositPayments>
					                        <cfloop from="1" to="#numPayments-1#" index="i">
					                              <cfset amount = xmlstring.depositpayments.guaranteepayment[i].amountpercent.xmlattributes.amount>
					         							<GuaranteePayment>
					         								<AcceptedPayments>
					         									<AcceptedPayment>
					         										<PaymentCard ExpireDate="#form.ccMonth##form.ccYear#" MaskedCardNumber="#MaskedCardNumber#" CardToken="#CardToken#" CardType="1" CardCode="#form.ccType#">
					         											<CardHolderName>#form.ccFirstName# #form.ccLastName#</CardHolderName>
					         											<Address>
					         												<AddressLine>#form.billingAddress#</AddressLine>
					         												<CityName>#form.billingCity#</CityName>
					         												<PostalCode>#form.billingZip#</PostalCode>
					         												<StateProv StateCode="#form.billingState#"/>
					         												<CountryName Code="#form.billingCountry#"/>
					         											</Address>
					         										</PaymentCard>
					         									</AcceptedPayment>
					         								</AcceptedPayments>
					         								<AmountPercent Amount="#amount#"/>
					         							</GuaranteePayment>
					   							</cfloop>
					   						</DepositPayments>
											</cfif>
										</ResGlobalInfo>
									</UnitReservation>
								</UnitReservations>
							</EVRN_UnitResRQ>
						</s:Body>
					</s:Envelope>
					</cfoutput>
					</cfsavecontent>
					</cfprocessingdirective>

					<cfset XMLVar = trim(XMLVar)>

					<cfsavecontent variable="HEADERS">
					<cfoutput>Content-Type: text/xml; charset=utf-8#variables.settings.booking.crlf#Content-Length: #len(XMLVar)##variables.settings.booking.crlf#SOAPAction:UnitRes#variables.settings.booking.crlf#</cfoutput>
					</cfsavecontent>

					<cftry>

					   <cfhttp method="post" timeout="30" url="https://api.escapia.com/EVRNService.svc" result="APIresponse">
					   	<cfhttpparam type="header" name="Content-Type" value="text/xml; charset=utf-8;"/>
							<cfhttpparam type="header" name="Content-Length" value="#len(trim(XMLVar))#" />
							<cfhttpparam type="header" name="SOAPAction" value="UnitRes" />
							<cfhttpparam type="body" name="body" value="#trim(XMLVar)#" />
						 </cfhttp>

                         <cfif isdefined('APIresponse')>
						 	<cfset RES = APIresponse.filecontent>
                         </cfif>

                         <cfset insertAPILogEntry(cgi.script_name & ' EVRN_UnitResRQ',xmlVar,RES)>

					   <cfcatch>
					      <cfif isdefined("ravenClient")>
					         <cfset ravenClient.captureException(cfcatch,50)>
					      </cfif>
					      <cfset insertAPILogEntry(cgi.script_name,xmlVar,cfcatch.message)>
					      <cfset session.errormessage = cfcatch.message>
					      <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
					   </cfcatch>

					</cftry>

					<cfif isdefined('RES') and isXML(RES)>
					   <cfset insertAPILogEntry(cgi.script_name,xmlVar,RES)>
					   <cftry>
					   	<cfset XMLString = XMLParse(RES)>
					   	<cfif isdefined("XMLString.Envelope.Body.EVRN_UnitResRS.Errors")>
					   		<cfset var errorMesssageST = XMLString.Envelope.Body.EVRN_UnitResRS.Errors.Error.xmlAttributes.ShortText>
					   		<cfset var errorMesssageXT = XMLString.Envelope.Body.EVRN_UnitResRS.Errors.Error.xmlText>
						   <cfif isdefined("ravenClient")>
						      <cfset ravenClient.captureMessage('Escapia.cfc->checkout. Location D. XMLString contained errors =' & XMLString)>
						   </cfif>
					   		<cfset session.errormessage = "MessageST = #errorMesssageST#, MessageXT = #errorMesssageXT#">
					   		<cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
					   	<cfelseif StructKeyExists(XMLString.Envelope.Body.EVRN_UnitResRS.UnitReservations.UnitReservation.ResGlobalInfo.UnitReservationIDs,'UnitReservationID')>
					   		<cfset reservationCode = XMLString.Envelope.Body.EVRN_UnitResRS.UnitReservations.UnitReservation.ResGlobalInfo.UnitReservationIDs.UnitReservationID[2].xmlattributes.resid_value>
					   		<!--- START: NEW CART ABANDONMENT FEATURE --->
								<!--- kill the cookie b/c the viewer checked out sucessfully --->
								<cfif isdefined('ClickedCartAbandomentFooterLink')>
									<cftry>
										<cfquery datasource="#variables.settings.dsn#">INSERT INTO cart_abandoment_tracker_footer (typeclick,quotenumber,amount) VALUES('BookingConfirmed',<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#reservationCode#">,<cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#form.Total#">)</cfquery>
										<cfcatch></cfcatch>
									</cftry>
								</cfif>
								<cfcookie name="CartAbandomentFooter" expires="NOW">
								<cfcookie name="CartAbandomentFooterCheckIn" expires="NOW">
								<cfcookie name="CartAbandomentFooterCheckOut" expires="NOW">
								<cfcookie name="ClickedCartAbandomentFooterLink" expires="NOW">
								<!--- END: NEW CART ABANDONMENT FEATURE --->
					   	</cfif>
					   <cfcatch>
					   	<cfif isdefined("ravenClient")>
						      <cfset ravenClient.captureException(cfcatch,50)>
						   </cfif>
						   <cfset session.errormessage = cfcatch.message>
						   <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
					   </cfcatch>
					   </cftry>
					<cfelse>
					   <cfset session.errormessage = 'RES variable is undefined.'>
					   <cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
					</cfif>

			</cfif> <!--- end of <cfif isDefined('MaskedCardNumber') and isDefined('CardToken') and isdefined('form.escapiaDepositGeneratedKey')> --->

			<cfreturn reservationCode>

	 </cffunction>




   <cffunction name="getCalendarData" returnType="string" hint="Used in _calendar-tab.cfm to get all the non-available dates">

   	<cfargument name="unitcode" required="true">

   	<cfset theYear = DatePart('yyyy',now())>
		<cfset theMonth = DatePart('m',now())>

		<cfquery name="nonavaildates" dataSource="#variables.settings.booking.dsn#">
			select Date_Format(thedate,'%m/%d/%Y') as mydate from escapia_dailyavailabilities
			where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#"> and code = 'U'
			and thedate >= <cfqueryparam cfsqltype="cf_sql_date" value="#theYear#-#theMonth#-01">
		</cfquery>

		<cfset nonAvailList = ValueList(nonavaildates.mydate)>

		<cfreturn nonAvailList>

   </cffunction> <!--- end of getCalenderData function --->



   <cffunction name="getCalendarRates" returnType="numeric" hint="Used in _calendar-tab.cfm to display weekly price on the calendar">

   	<cfargument name="unitcode" required="true">
   	<cfargument name="thedate" required="true">

		<cfset var qryGetCalendarRates = ''>

		<cfquery name="qryGetCalendarRates" dataSource="#variables.settings.booking.dsn#">
			select maxrent*7 as theRate
			from escapia_rates where ratetype = 'Weekly'
			and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
			and <cfqueryparam cfsqltype="cf_sql_date" value="#thedate#"> between startdate and enddate
		</cfquery>

		<cfif qryGetCalendarRates.recordcount gt 0 and qryGetCalendarRates.theRate gt 0>
			<cfreturn qryGetCalendarRates.theRate>
		<cfelse>
			<cfreturn 0>
		</cfif>

   </cffunction> <!--- end of getCalendarRates function --->



   <cffunction name="getDetailRates" returnType="string" hint="Used on the property detail page to check availability and retrieve summary of fees">

   	<cfargument name="unitcode" required="true">
   	<cfargument name="strcheckin" required="true">
   	<cfargument name="strcheckout" required="true">

		<cfset variables.timestamp = DateFormat(now(),'yyyy-mm-dd') & 'T' & TimeFormat(now(),'HH:mm:ss')>
		<cfset var totalfees = 0>
		<cfset var ti = 0>
		<cfset var addlcharges = 0>
		<cfset var apiresponse = ''>
    <cfset var qryNextYearsRates = "">

    <cfquery name="qryNextYearsRates" dataSource="#settings.dsn#">
    SELECT displayRatesAfterYear
    FROM cms_nextyear
    WHERE id = 1
    </cfquery>

		<cfif DateDiff('d',arguments.strcheckin,arguments.strcheckout) GT 27>
      <cfsavecontent variable="APIResponse">
        <cfoutput><div class="alert alert-danger">To make a monthly reservation please call our office to book <a href="tel:18008338231">1-800-833-8231</a></div></cfoutput>
      </cfsavecontent>
    <cfelseif DateCompare(arguments.strcheckin,qryNextYearsRates.displayRatesAfterYear) EQ 1>
      <cfsavecontent variable="APIResponse">
        <cfoutput><div class="alert alert-danger">Rates and reservations are not yet available for your selected dates. Please call <a href="tel:18008338231">1-800-833-8231</a> for more information on renting this property.</div></cfoutput>
      </cfsavecontent>
    <cfelse>
      <cfprocessingdirective suppresswhitespace="yes">
      <cfsavecontent variable="XMLvar">
      <cfoutput>
      <?xml version="1.0" encoding="UTF-8"?>
      <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
        <s:Header>
          <ActivityId CorrelationId="4f58be7c-ccfb-4afe-9937-65f36735683c" xmlns="http://schemas.microsoft.com/2004/09/ServiceModel/Diagnostics">2ecee460-6cb8-4175-b6a6-716782f54d18</ActivityId>
        </s:Header>
        <s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
          <EVRN_UnitStayRQ TransactionIdentifier="#CreateUUID()#" TimeStamp="#variables.timestamp#" EchoToken="request" Version="1.0" xmlns="http://www.escapia.com/EVRN/2007/02">
            <POS>
              <Source>
                <RequestorID ID="#variables.settings.booking.username#" MessagePassword="#variables.settings.booking.password#"/>
              </Source>
            </POS>
            <UnitStay>
              <UnitRef UnitCode="#arguments.unitcode#"/>
              <StayDateRange Start="#DateFormat(arguments.strcheckin,'yyyy-mm-dd')#" End="#DateFormat(arguments.strcheckout,'yyyy-mm-dd')#"/>
              <GuestCounts>
                <GuestCount AgeQualifyingCode="10" Count="1"/>
                <GuestCount AgeQualifyingCode="8" Count="0"/>
              </GuestCounts>
              <CancelPenalties SendData="true"/>
              <RentalAgreement SendData="true"/>
            </UnitStay>
          </EVRN_UnitStayRQ>
        </s:Body>
      </s:Envelope>
      </cfoutput>
      </cfsavecontent>
      </cfprocessingdirective>

      <cfset XMLVar = trim(XMLVar)>

      <cftry>
          <cfhttp url="https://api.escapia.com/EVRNService.svc" timeout="30" method="post">
             <cfhttpparam type="header" name="Content-Type" value="text/xml;charset=utf-8"/>
             <cfhttpparam type="header" name="Content-Length" value="#len(trim(XMLVar))#" />
             <cfhttpparam type="header" name="SOAPAction" value="UnitStay" />
             <cfhttpparam type="body" value="#trim(XMLVar)#" />
          </cfhttp>

  		  <cfif isdefined('cfhttp.FileContent')>
          	<cfset RES = cfhttp.filecontent>
          </cfif>


          <cfcatch>

              <cfsavecontent variable="apiresponse">
                <cfoutput>#cfcatch.message#</cfoutput>
              </cfsavecontent>

              <cfif isdefined("ravenClient")>
              <cfset ravenClient.captureException(cfcatch)>
            </cfif>

          </cfcatch>

      </cftry>

      <!--- Get min number of nights from the db --->
        <cfquery name="getMinLOS" dataSource="#variables.settings.booking.dsn#">
          select minLOS from escapia_rates where
          unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
          and <cfqueryparam cfsqltype="cf_sql_date" value="#createodbcdate(arguments.strcheckin)#"> between startdate and enddate
        </cfquery>

      <cfif isdefined('RES') and isXML(RES)>
        <cftry>
          <cfsavecontent variable="apiresponse">
            <cfset XMLString = xmlparse(RES)>
            <cfif structkeyexists(XMLString.Envelope.Body.EVRN_UnitStayRS,'Errors')>
              <cfset errorText = XMLString.Envelope.Body.EVRN_UnitStayRS.Errors.Error.XmlText>
							<cfoutput>
                <cfif getMinLOS.recordcount gt 0 and getMinLOS.minLOS gt 0>
                      <div class="alert alert-success">
                        This unit has a <b>#getMinLOS.minLOS# night</b> minimum.
                      </div>
                    </cfif>
                <div class="alert alert-danger" style="margin-top:10px">#errorText#</div>
              </cfoutput>
            <cfelse>
              <cfset baseRent = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Base.xmlAttributes.AmountBeforeTax>
              <cfset baseRentPlusFees = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.Total.xmlAttributes.AmountBeforeTax>
              <cfset TotalTaxes = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.Total.Taxes.xmlAttributes.Amount>
              <cfset Total = baseRentPlusFees + TotalTaxes>
              <cfif structKeyExists(XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Fees,'Fee')>
                <cfset FeesArray = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Fees.Fee>
              </cfif>
              <cfif structKeyExists(XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.AdditionalCharges,'AdditionalCharge')>
                <cfset AdditionalChargesArray = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.AdditionalCharges.AdditionalCharge>
              </cfif>
              <cfif structKeyExists(XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate,'Discount')>
                <cfset discountAmount = XMLString.Envelope.Body.EVRN_UnitStayRS.UnitStay.UnitRates.UnitRate.Rates.Rate.Discount.xmlattributes.amountbeforetax>
              </cfif>



              <cfoutput>
              <!---
                   <cfif getMinLOS.recordcount gt 0 and getMinLOS.minLOS gt 0>
                    <div class="alert alert-success">
                      This unit has a <b>#getMinLOS.minLOS# night</b> minimum.
                    </div>
                   </cfif>
									 --->
              <ul class="property-cost-list">
                <li>Rent <span class="text-right">#DollarFormat(baseRent)#</li>
                <li>(Excluding Taxes &amp; Fees)</li>
                <cfif isdefined('FeesArray') and arraylen(FeesArray) gt 0>
                  <cfloop from="1" to="#arraylen(FeesArray)#" index="i">
                <!---
                    <li>#FeesArray[i].Description[1].Text.xmlText# <span class="text-right">#DollarFormat(FeesArray[i].xmlAttributes.Amount)#</span></li>
                --->
                    <cfset totalfees += FeesArray[i].xmlAttributes.Amount>
                  </cfloop>
                </cfif>
                <cfif isdefined('AdditionalChargesArray') and arraylen(AdditionalChargesArray) GT 0>
                  <cfloop from="1" to="#arraylen(AdditionalChargesArray)#" index="i">
                    <cfset AddlChargeQty = #AdditionalChargesArray[i].xmlAttributes.Quantity#>
                      <cfif AdditionalChargesArray[i].Description[1].Text.xmlText is "Travel Insurance">
                        <cfset ti = AdditionalChargesArray[i].Amount.xmlAttributes.AmountBeforeTax>
                      </cfif>
                <!---
                    <li>#AdditionalChargesArray[i].Description[1].Text.xmlText# <span class="text-right">#DollarFormat(AdditionalChargesArray[i].Amount.xmlAttributes.AmountBeforeTax)#</span></li>
                --->
                    <cfset addlcharges += #AdditionalChargesArray[i].Amount.xmlAttributes.AmountBeforeTax#>
                  </cfloop>
                </cfif>
                <!---
                <li>Taxes <span class="text-right">#DollarFormat(TotalTaxes)#</span></li>
                </tr>
                --->
                <cfset totalAmount = total + ti>
                <!---
                <li><strong>Total <span class="text-right">#DollarFormat(totalAmount)#</span></strong></li>
                --->
              </ul>
              <!-- BOOK NOW BUTTON -->
              <a id="detailBookBtn" class="btn detail-book-btn btn-loader site-color-1-bg site-color-1-lighten-bg-hover text-white" href="#variables.settings.booking.bookingURL#/#variables.settings.booking.dir#/book-now.cfm?propertyid=#arguments.unitcode#&strcheckin=#arguments.strcheckin#&strcheckout=#arguments.strcheckout#">
                <span class="btn-text"><i class="fa fa-check"></i> Book Now</span>
                <span class="btn-loading-text"><i class="loading-icon fa fa-spinner fa-pulse"></i> Submitting</span>
              </a>
              <cfset numNights = DateDiff('d',arguments.strcheckin,arguments.strcheckout)>
              <a onclick="clearModalFields()" id="splitCostCalc" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" type="button" data-toggle="modal" data-target="##splitCostModal" href="/#variables.settings.booking.dir#/_family-calculator.cfm?total=#totalAmount#&numnights=#numnights#"><i class="fa fa-calculator"></i> Split Cost Calc</a>
              <input type="hidden" id="splitCalcTotalVal" name="splitCalcTotalVal" value="#totalAmount#">
              <input type="hidden" id="splitCalcNumNightVal" name="splitCalcNumNightVal" value="#numnights#">
              </cfoutput>
            </cfif><!--- end of <cfif structkeyexists(XMLString.Envelope.Body.EVRN_UnitStayRS,'Errors')> --->
          </cfsavecontent>

         <cfcatch>

            <cfsavecontent variable="APIResponse">
              <cfif getMinLOS.recordcount gt 0 and getMinLOS.minLOS gt 0>
                <div class="alert alert-success">
                  This unit has a <b>#getMinLOS.minLOS# night</b> minimum.
                </div>
                </cfif>
              <cfoutput><div class="alert alert-danger">here#cfcatch#</div></cfoutput>
            </cfsavecontent>

            <cfif isdefined("ravenClient")>
              <cfset ravenClient.captureException(cfcatch,50)>
            </cfif>

         </cfcatch>

         </cftry>

      </cfif> <!--- end of <cfif isdefined('RES')> --->
    </cfif>


		<cfreturn apiresponse>

   </cffunction> <!--- end of getDetailRates function --->

   <cffunction name="getFeaturedProperties" returnType="query" hint="Returns the featured properties typically displayed on the homepage">

         <cfquery name="propertyCheck" dataSource="#variables.settings.dsn#">
            select strpropid from cms_featured_properties order by rand()
         </cfquery>

         <cfif propertyCheck.recordcount gt 0 and len(propertyCheck.strpropid)>

            <cfset var propList = ValueList(propertyCheck.strpropid)>

            <cfquery name="getProperties" dataSource="#variables.settings.booking.dsn#">
               select
                  unitcode as propertyid,
                  unitshortname as name,
                  bedrooms,
                  bathrooms,
                  maxoccupancy as sleeps,
                  mapPhoto as photo,
                  seopropertyname,
                  address
               from escapia_properties
               where unitcode IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propList#" list="yes">)
            </cfquery>

         <cfelse>

            <cfquery name="getProperties" dataSource="#variables.settings.booking.dsn#">
               select
                  unitcode as propertyid,
                  unitshortname as name,
                  bedrooms,
                  bathrooms,
                  maxoccupancy as sleeps,
                  mapPhoto as photo,
                  seopropertyname,
                  address
               from escapia_properties
               order by rand()
               limit 6
            </cfquery>

         </cfif>

         <cfreturn getProperties>

   </cffunction> <!--- end of getFeaturedProperties --->


   <cffunction name="getMinMaxAmenities" returnType="struct" hint="Returns min/max values for common amenities like bedrooms,bathrooms and occupancy, typically used on refine search sliders">

		<cfset var qryGetMinMaxAmenities = ''>

		<cfquery name="qryGetMinMaxAmenities" datasource="#variables.settings.booking.dsn#">
			SELECT
				min(bedrooms) as minBed,
				max(bedrooms) as maxBed,
				min(bathrooms) as minBath,
				max(bathrooms) as maxBath,
				min(maxoccupancy) as minOccupancy,
				max(maxoccupancy) as maxOccupancy
			FROM
				escapia_properties
		</cfquery>

		<cfset localStruct = StructNew()>

		<cfset localStruct['minBed'] = qryGetMinMaxAmenities.minBed>
		<cfset localStruct['maxBed'] = qryGetMinMaxAmenities.maxBed>
		<cfset localStruct['minBath'] = qryGetMinMaxAmenities.minBath>
		<cfset localStruct['maxBath'] = qryGetMinMaxAmenities.maxBath>
		<cfset localStruct['minOccupancy'] = qryGetMinMaxAmenities.minOccupancy>
		<cfset localStruct['maxOccupancy'] = qryGetMinMaxAmenities.maxOccupancy>

		<cfreturn localStruct>

   </cffunction>



   <cffunction name="getMinMaxPrice" returnType="struct" hint="Returns min/max rates for the refine search price range slider">

		<cfargument name="strcheckin" type="date" required="false">
		<cfargument name="strcheckout" type="date" required="false">

		<cfset var qryGetMinMaxPrice = ''>
		<cfset var numNights = 7>
		<cfset var rateType = 'Weekly'>

		<cfif
			isdefined('arguments.strcheckin') and
			len(arguments.strcheckin) and
			isvalid('date',arguments.strcheckin) and
			isdefined('arguments.strcheckout') and
			len(arguments.strcheckout) and
			isvalid('date',arguments.strcheckout) and
			DateDiff('d',arguments.strcheckin,arguments.strcheckout) lt 7
			>

			<cfset numNights = DateDiff('d',arguments.strcheckin,arguments.strcheckout)>
			<cfset rateType = 'Nightly'>

	   </cfif>

		<cfquery name="qryGetMinMaxPrice" datasource="#variables.settings.booking.dsn#">
			SELECT
                IF( (min(minrent*7) IS NULL OR min(minrent*7) = 0), 500, min(minrent*7) ) as minPrice,
                IF( (max(maxrent*7) IS NULL OR max(maxrent*7) = 0), 7000, max(maxrent*7) ) as maxPrice
			FROM
				escapia_rates
			WHERE
                startdate >= (
                    select IF( YEAR(max(startdate)) < YEAR(NOW()), max(startdate), Date_format(NOW(), "%Y-%M-%d")  )
                    from escapia_rates
                )
		   AND
		      ratetype = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rateType#">
		</cfquery>

		<cfset localStruct = StructNew()>
		<cfset localStruct['minprice'] = int(qryGetMinMaxPrice.minPrice)>
		<cfset localStruct['maxprice'] = ceiling(qryGetMinMaxPrice.maxPrice)>

		<cfreturn localStruct>

   </cffunction>



   <cffunction name="getProperty" returnType="query" hint="Returns all the basic information for a given property">

   	<cfargument name="unitcode" required="false">
   	<cfargument name="slug" required="false">

		<cfset var qryGetProperty = ''>

   	<cfquery name="qryGetProperty" dataSource="#variables.settings.booking.dsn#">
			SELECT
			unitshortname as name,
			longdescription as description,
			seopropertyname,
			unitcode as propertyid,
			mapPhoto as defaultPhoto,
			(select original from escapia_photos where unitcode = escapia_properties.unitcode and isdefault = 'true' limit 1) as largePhoto,
			unitcategory as type,
			petsallowedcode as petsallowed,
			cityname as location,
			maxoccupancy as sleeps,
			bedrooms,
			bathrooms,
			latitude,
			longitude,
			cityname as city,
			statecode as state,
			checkouttime,
			checkintime,
			address,
			postalcode as zip,
			(select categoryvalue from escapia_amenities where unitcode = escapia_properties.unitcode and `category` = 'LOCATION' limit 1) as area,
			(select categoryvalue from escapia_amenities where unitcode = escapia_properties.unitcode and category = 'Nightly Rentals' AND categoryvalue LIKE '%Yes%' limit 1) as allowsNightly,
			(select categoryvalue from escapia_amenities where unitcode = escapia_properties.unitcode and category = 'Monthly Rentals' AND categoryvalue LIKE '%Yes%' limit 1) as allowsMonthly,
			(select categoryvalue from escapia_amenities where unitcode = escapia_properties.unitcode and `category` = 'LOCATION_TYPE' limit 1) as view
			from escapia_properties
			<cfif len(arguments.unitcode)>
				where unitcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.unitcode#">
			<cfelseif len(arguments.slug)>
				where seopropertyname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.slug#">
			</cfif>
		</cfquery>

		<cfreturn qryGetProperty>

   </cffunction> <!--- end of getProperty --->



   <cffunction name="getPropertyAmenities" returnType="query" hint="Returns all the amenities for a given property">

   	<cfargument name="unitcode" required="true">

		<cfset var qryGetPropertyAmenities = ''>

		<cfquery name="qryGetPropertyAmenities" dataSource="#variables.settings.booking.dsn#">
		SELECT categoryvalue , category
    FROM escapia_amenities
    WHERE unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
          AND category NOT IN ('Safety','Monthly Rentals','DisplayRate','LocationField','Complex','Nightly Rentals')
          AND category NOT like ('%Custom%')
    ORDER BY category, categoryvalue
		</cfquery>


		<cfreturn qryGetPropertyAmenities>

   </cffunction> <!--- end of getPropertyAmenities --->



   <cffunction name="getPropertyPhotos" returnType="query" hint="Returns all the photos for a given property">

   	<cfargument name="unitcode" required="true">

		<cfset var qryGetPropertyPhotos = ''>

		<cfquery name="qryGetPropertyPhotos" dataSource="#variables.settings.booking.dsn#">
			select
				original as original,
				large as large,
				thumbnail as thumbnail,
				caption,
				sort
			from escapia_photos
			where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
			order by sort
		</cfquery>

		<cfreturn qryGetPropertyPhotos>

   </cffunction> <!--- end of getPropertyPhotos --->



   <cffunction name="getPropertyPriceRange" returnType="string" hint="Returns the min/max price for a given property">

   	<cfargument name="unitcode" required="true" type="string">

		<cfset var qryGetPropertyPriceRange = ''>

		<cfquery name="qryGetPropertyPriceRange" dataSource="#variables.settings.booking.dsn#">
			select min(minRent*7) as minPrice, max(maxRent*7) as maxPrice
			from escapia_rates
			where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
			and startdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(now(),"YYYY")#-01-01">
			and ratetype = 'Weekly'
		</cfquery>

		<cfif qryGetPropertyPriceRange.recordcount gt 0 and len(qryGetPropertyPriceRange.minPrice) and len(qryGetPropertyPriceRange.maxPrice) and qryGetPropertyPriceRange.minPrice neq qryGetPropertyPriceRange.maxPrice>
		  <cfset tempReturn = DollarFormat(qryGetPropertyPriceRange.minPrice) & ' - ' & DollarFormat(qryGetPropertyPriceRange.maxPrice) & ' <small>Per Week</small>'>
		<cfelseif qryGetPropertyPriceRange.recordcount gt 0 and len(qryGetPropertyPriceRange.minPrice) and len(qryGetPropertyPriceRange.maxPrice) and qryGetPropertyPriceRange.minPrice eq qryGetPropertyPriceRange.maxPrice>
			<cfset tempReturn = DollarFormat(qryGetPropertyPriceRange.maxPrice) & '<small>Per Week</small>'>
		<cfelse>
		  <cfset tempReturn = ''>
		</cfif>

		<cfreturn tempReturn>

   </cffunction>



   <cffunction name="getPropertyRates" returnType="query" hint="Returns all the rates for a given property">

   	<cfargument name="unitcode" required="true">

		<cfset var qryGetPropertyRates = ''>

   	<cfquery name="qryGetPropertyRates" dataSource="#variables.settings.booking.dsn#">
			select startdate as start_date,enddate as end_date,
			   (SELECT maxrent from escapia_rates er2 where unitcode=<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#"> and er2.startdate=escapia_rates.startdate and ratetype='nightly' LIMIT 1) as nightly_rate,
			   (SELECT maxrent*7 from escapia_rates er3 where unitcode=<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#"> and er3.startdate=escapia_rates.startdate and ratetype='weekly' LIMIT 1) as weekly_rate
			from
				escapia_rates where
   			unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
			group by start_date
			order by start_date
		</cfquery>

		<cfreturn qryGetPropertyRates>

   </cffunction> <!--- end of getPropertyRates --->



   <cffunction name="getPropertyReviews" returnType="struct" hint="Returns reviews from be_reviews and escapia_reviews tables">

   	<cfargument name="unitcode" required="true">

		<cfset var qryGetPropertyReviews = ''>

		<cfquery name="qryGetPropertyReviews" dataSource="#variables.settings.booking.dsn#">
			select rvw.* , rsp.response, rsp.createdAt AS responseCreatedAt
			from be_reviews rvw
				left join be_responses_to_reviews rsp ON rvw.id = rsp.reviewID
			where rvw.unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
			and approved = 'Yes'
			order by createdat
		</cfquery>

		<cfset reviewStruct = StructNew()>

		<cfloop query="qryGetPropertyReviews">

			<cfset localStruct = structnew()>

			<cfset localStruct.createdat = qryGetPropertyReviews.createdat>
			<cfset localStruct.title = qryGetPropertyReviews.title>
			<cfset localStruct.firstname = qryGetPropertyReviews.firstname>
			<cfset localStruct.lastname = qryGetPropertyReviews.lastname>
			<cfset localStruct.review = qryGetPropertyReviews.review>
			<cfset localStruct.rating = qryGetPropertyReviews.rating>
			<cfset localStruct.hometown = qryGetPropertyReviews.hometown>
			<cfset localStruct.response = qryGetPropertyReviews.response>
			<cfset localStruct.responseCreatedAt = qryGetPropertyReviews.responseCreatedAt>

			<cfset StructInsert(reviewStruct,qryGetPropertyReviews.id,localStruct)>

		</cfloop>

		<cfquery name="getReviewsFromEscapia" dataSource="#variables.settings.booking.dsn#">
			select * from escapia_reviews where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
			order by reviewdate
		</cfquery>

		<cfloop query="getReviewsFromEscapia">

			<cfset localStruct = structnew()>

			<cfset localStruct.createdat = getReviewsFromEscapia.reviewdate>
			<cfset localStruct.title = getReviewsFromEscapia.title>
			<cfset localStruct.firstname = getReviewsFromEscapia.reviewername>
			<cfset localStruct.lastname = ''>
			<cfset localStruct.review = getReviewsFromEscapia.review>
			<cfset localStruct.rating = ''>
			<cfset localStruct.hometown = getReviewsFromEscapia.reviewercity>
			<cfset localStruct.response = ''>
			<cfset localStruct.responseCreatedAt = ''>

			<cfset StructInsert(reviewStruct,getReviewsFromEscapia.id,localStruct)>

		</cfloop>

		<cfreturn reviewStruct>

   </cffunction> <!--- end of getPropertyReviews function --->



   <cffunction name="getSearchResults" hint="Calls the API and returns search results based on user's chosen parameters">

	  	<cfset var qryGetSearchResults = ''>

	  	<!--- Only use API for dated searches --->
	  	<cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate>

			<cfset variables.timestamp = DateFormat(now(),'yyyy-mm-dd') & 'T' & TimeFormat(now(),'HH:mm:ss')> <!---Create timestamp for the api call --->
			<cfset session.booking.unitcodelist = ''>
			<cfparam name="session.booking.strSortBy" default="rand()">

			<cfsavecontent variable="XMLvar">
			<cfoutput>
			<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.escapia.com/EVRN/2007/02">
			   <soapenv:Header/>
			      <soapenv:Body>		       <!--- Always sort by 'name' by default, we will use local query to filter results later on --->
			         <ns:EVRN_UnitSearchRQ SortOrder="N" PictureSize="Thumbnail" EchoToken="yy" TimeStamp="#variables.timestamp#" Target="Production" Version="1.0" TransactionIdentifier="#CreateUUID()#" SequenceNmbr="1" TransactionStatusCode="Start" RetransmissionIndicator="false" MaxResponses="50000" SendRateDetails="true" SendUnitSummary="true" ResponseType="PropertyList">
			            <ns:POS>
			               <ns:Source>
			                  <ns:RequestorID ID="#variables.settings.booking.username#" MessagePassword="#variables.settings.booking.password#"/>
			               </ns:Source>
			            </ns:POS>
			               <ns:Criteria AvailableOnlyIndicator="true">
			               <ns:Criterion>
			                  <ns:Region>
			                     <ns:CountryCode>US</ns:CountryCode>
			                  </ns:Region>
			                  <ns:StayDateRange Start="#session.booking.strcheckin#" End="#session.booking.strcheckout#"></ns:StayDateRange>
			                  <ns:UnitStayCandidate>
		                        <ns:GuestCounts>
		                           <ns:GuestCount AgeQualifyingCode="10" Count="2"/> <!--- Num adults = 2, default --->
		                        </ns:GuestCounts>
			                  </ns:UnitStayCandidate>
			               </ns:Criterion>
			            </ns:Criteria>
			    </ns:EVRN_UnitSearchRQ>
			   </soapenv:Body>
			</soapenv:Envelope>
			</cfoutput>
			</cfsavecontent>

			<cfhttp url="https://api.escapia.com/EVRNService.svc" timeout="60" method="post" result="apiResponse">
			   <cfhttpparam type="header" name="Content-Type" value="text/xml;charset=utf-8"/>
			   <cfhttpparam type="header" name="Content-Length" value="#len(XMLVar)#" />
			   <cfhttpparam type="header" name="SOAPAction" value="UnitSearch" />
			   <cfhttpparam type="body" value="#trim(XMLVar)#" />
			</cfhttp>

			<cfif isXML(apiResponse.filecontent)>

				<cfset XMLString = XMLParse(apiResponse.filecontent)>

				<cfif isdefined('xmlstring.Envelope.Body.EVRN_UnitSearchRS.Units.Unit')>

					<cfloop from="1" to="#arraylen(xmlstring.Envelope.Body.EVRN_UnitSearchRS.Units.Unit)#" index="i">

						<cfset unitcode = xmlstring.Envelope.Body.EVRN_UnitSearchRS.Units.Unit[i].xmlattributes.unitcode>

				      <cfset session.booking.unitcodelist = ListAppend(session.booking.unitcodelist,unitcode)>

					</cfloop>

				<cfelse>
                    <cfset session.booking.unitcodelist = '99999999'>
				</cfif>

			<cfelse>
				<cfset session.errorMessage = "Error Detail = " & apiResponse.ErrorDetail & '<br />Error Message = ' & apiResponse.filecontent>
				<cflocation addToken="no" url="/#variables.settings.booking.dir#/booking-error.cfm">
			</cfif>

		</cfif>

	   <cfquery name="qryGetSearchResults" datasource="#variables.settings.booking.dsn#">

			      select

				      unitcode as propertyid,
				      unitshortname as name,
				      seopropertyname,
				      mapPhoto as defaultPhoto,
				      latitude,
				      longitude,
				      address,
				      bedrooms,
				      maxoccupancy as sleeps,
				      cityname,
				      unitcategory as type,
				      petsallowedcode as petsallowed,
				      cityname as location,
				      bathrooms,
				      longdescription as description,
				      (select avg(rating) as average from be_reviews where unitcode = escapia_properties.unitcode) as avgRating,
				      (select min(minRent*7) from escapia_rates where rateType = 'weekly' and unitcode = escapia_properties.unitcode) as unitMinWeeklyPrice,
				      (select max(maxRent*7) from escapia_rates where rateType = 'weekly' and unitcode = escapia_properties.unitcode) as unitMaxWeeklyPrice

				      <cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate>

				      	 <cfset numNights = DateDiff('d',session.booking.strcheckin,session.booking.strcheckout)>

				      	 <cfif numNights gte 7>
				      	 	,(select minRent*7 from escapia_rates where <cfqueryparam cfsqltype="cf_sql_date" value="#session.booking.strcheckin#"> between startdate and enddate and rateType = 'weekly' and unitcode = escapia_properties.unitcode limit 1) as 'price'
				      	 <cfelse>
				      	 	,(select minRent*#numNights# from escapia_rates where #createodbcdate(session.booking.strcheckin)# between startdate and enddate and rateType = 'nightly' and unitcode = escapia_properties.unitcode limit 1) as 'price'
						 </cfif>

			      	 	,(select minRent from escapia_rates where <cfqueryparam cfsqltype="cf_sql_date" value="#session.booking.strcheckin#"> between startdate and enddate and rateType = 'nightly' and unitcode = escapia_properties.unitcode limit 1) as 'MapPrice'

	 		      	  <cfelse>

			      	 	,(select min(minRent) from escapia_rates where rateType = 'nightly' and unitcode = escapia_properties.unitcode) as 'MapPrice'

					  </cfif>

			      from escapia_properties

			      where 1=1

					<cfif isdefined('session.booking.unitcodelist') and ListLen(session.booking.unitcodelist)>
			      	and escapia_properties.unitcode in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#session.booking.unitcodelist#">)
			      </cfif>

			      <cfinclude template="/#variables.settings.booking.dir#/results-search-query-common.cfm">

			      <!--- sanitize the order by value --->
			      <cfset variables.allowedSortList = "rand(),name,bedrooms asc,bedrooms desc,sleeps asc,sleeps desc,price asc,price desc">
			      <cfif listFindNoCase(variables.allowedSortList, session.booking.strSortBy)>
			      	<cfset variables.allowedSort = session.booking.strSortBy>
			      <cfelse>
			      	<cfset variables.allowedSort = "rand()">
			      </cfif>

            <cfif listFindNoCase("price asc,price desc", session.booking.strSortBy) AND NOT (isdefined('session.booking.searchByDate') and session.booking.searchByDate)>
			      	<cfset variables.allowedSort = "rand()">
            </cfif>

			      order by #variables.allowedSort#

			</cfquery>

			<!--- User is filtering results using the Price Range slider --->
			<cfif isdefined('session.booking.rentalrate') and len(session.booking.rentalrate)>

				<!--- Obtain the min and max values from the slider --->
				<cfset minSearchValue = #ListGetAt(session.booking.rentalrate,1)#>
				<cfset maxSearchValue = #ListGetAt(session.booking.rentalrate,2)#>

			   <cfif isdefined('session.booking.searchByDate') and session.booking.searchByDate>
			   	<!--- Filter by base rent since the user selected dates --->
					<cfquery name="qryGetSearchResults" dbtype="query">
						select * from qryGetSearchResults where
						price between <cfqueryparam cfsqltype="cf_sql_varchar" value="#minSearchValue#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#maxSearchValue#">
					</cfquery>
				<cfelse>
					<!--- Filter by the price range with a non-dated search --->
					<cfquery name="qryGetSearchResults" dbtype="query">
						select * from qryGetSearchResults where
						unitMinWeeklyPrice >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#minSearchValue#"> and unitMaxWeeklyPrice <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#maxSearchValue#">
					</cfquery>
				</cfif>

			</cfif>

			<cfif qryGetSearchResults.recordcount gt 0>

				<cfset cookie.numResults = qryGetSearchResults.recordcount>
				<cfset session.booking.getResults = qryGetSearchResults>
				<cfset session.booking.UnitCodeList = valueList(qryGetSearchResults.propertyid)>

			<cfelse>

				<cfset cookie.numResults = 0>

			</cfif>

   </cffunction> <!--- end of getSearchResults function --->



   <cffunction name="getSearchResultsProperty" returnType="query" hint="Returns property results if the user does a sitewide search for a given term like 'ocean front rentals'">

   	<cfargument name="searchterm" required="true">

		<cfquery DATASOURCE="#variables.settings.booking.dsn#" NAME="results">
			SELECT seoPropertyName,unitcode as propertyid,unitshortname as propertyname,descriptivetext as propertydesc
			FROM escapia_properties
			where unitshortname like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or longdescription like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or unitcategory like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or descriptivetext like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or cityname like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or address like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or marketing_headline like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
		</cfquery>

		<cfreturn results>

   </cffunction> <!--- end of getSearchResultsProperty function --->



   <cffunction name="setGoogleAnalytics" returnType="string" hint="Sets the Google analytics script for the booking confirmation page">

      <cfargument name="settings" required="true">
      <cfargument name="form" required="true">
      <cfargument name="reservationNumber" required="true" type="string">

      <cfsavecontent variable="temp">
      <cfoutput>
         <script type="text/javascript" defer>
           (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
           (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
           m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
           })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

           ga('create', '#variables.settings.googleAnalytics#', '#settings.website#');
           ga('send', 'pageview');

           ga('require', 'ecommerce', 'ecommerce.js');

         	ga('ecommerce:addTransaction', {
         	id: '#reservationNumber#', // Transaction ID - this is normally generated by your system.
         	affiliation: '#variables.settings.company#', // Affiliation or store name
         	revenue: '#form.Total#', // Grand Total
         	shipping: '0' , // Shipping cost
         	tax: '0' }); // Tax.

         	ga('ecommerce:addItem', {
         	id: '#reservationNumber#', // Transaction ID.
         	sku: '#form.propertyid#', // SKU/code.
         	name: '#Replace(form.propertyname,"'","","All")#', // Product name.
         	category: 'Rental', // Category or variation.
         	price: '#form.Total#', // Unit price.
         	quantity: '1'}); // Quantity.

         	ga('ecommerce:send');
         </script>
      </cfoutput>
      </cfsavecontent>

      <cfreturn temp>

   </cffunction> <!--- end of setGoogleAnalytics function --->



  	<cffunction name="setPropertyMetaData" returnType="string" hint="Sets the meta data for the property detail page">

      <cfargument name="property" required="true">

      <cfsavecontent variable="temp">
         <cfoutput>
         <title>#property.name# - #property.city# #property.type# Rental | #variables.settings.company#</title>
         <cfset tempDescription = striphtml(mid(property.description,1,300))>
         <meta name="description" content="#stripHTML(tempDescription)#">
         <meta property="og:title" content="#property.name# - #variables.settings.company#">
         <meta property="og:description" content="#tempDescription#">
         <meta property="og:url" content="http://#cgi.http_host#/#variables.settings.booking.dir#/#property.seopropertyname#">
         <meta property="og:image" content="#property.defaultPhoto#">
         </cfoutput>
      </cfsavecontent>

      <cfreturn temp>

   </cffunction> <!--- end of setMetaData function --->



   <cffunction name="submitLeadToThirdParty" hint="Submits form information to Escapia; used on the property detail page contact form">

   	<cfargument name="form" required="true">

   	<cfset variables.timestamp = DateFormat(now(),'yyyy-mm-dd') & 'T' & TimeFormat(now(),'HH:mm:ss')>

   	<cfsavecontent variable="XMLvar">
		<cfoutput>
		<?xml version="1.0" encoding="UTF-8"?>
		<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
			<s:Header>
				<ActivityId CorrelationId="4f58be7c-ccfb-4afe-9937-65f36735683c" xmlns="http://schemas.microsoft.com/2004/09/ServiceModel/Diagnostics">2ecee460-6cb8-4175-b6a6-716782f54d18</ActivityId>
			</s:Header>
			<s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
				<EVRN_UnitInquiryRQ TimeStamp="#variables.timestamp#" EchoToken="request" Version="1.0" xmlns="http://www.escapia.com/EVRN/2007/02">
					<POS>
						<Source>
							<RequestorID ID="#variables.settings.booking.username#" MessagePassword="#variables.settings.booking.password#"/>
						</Source>
					</POS>
					<InquiryRequests>
					   <InquiryRequest>
					      <UnitRef UnitCode="#trim(form.property_id)#"/>
					      <Contact>
					         <Name>
					            <GivenName><cfoutput>#XMLFormat(form.firstname)#</cfoutput></GivenName>
					            <Surname><cfoutput>#XMLFormat(form.lastname)#</cfoutput></Surname>
					         </Name>
					         <Email DefaultInd="true"><cfoutput>#XMLFormat(form.email)#</cfoutput></Email>
					      </Contact>
					      <Message><cfoutput>#XMLFormat(form.comments)#</cfoutput></Message>
					      <cfif isdefined('form.hiddenstrcheckin') and len(form.hiddenstrcheckin) and isdefined('form.hiddenstrcheckout') and len(form.hiddenstrcheckout)>
		                  <cfoutput><StayDateRange Start="#form.hiddenstrcheckin#" End="#form.hiddenstrcheckout#"></StayDateRange></cfoutput>
		               </cfif>
					   </InquiryRequest>
					</InquiryRequests>
				</EVRN_UnitInquiryRQ>
			</s:Body>
		</s:Envelope>
		</cfoutput>
		</cfsavecontent>

		<cfhttp url="https://api.escapia.com/EVRNService.svc" timeout="10" method="post" result="apiResponse">
			<cfhttpparam type="header" name="Content-Type" value="text/xml;charset=utf-8"/>
			<cfhttpparam type="header" name="Content-Length" value="#len(XMLVar)#" />
			<cfhttpparam type="header" name="SOAPAction" value="UnitInquiry" />
			<cfhttpparam type="body" value="#trim(XMLVar)#" />
		</cfhttp>

		<cfif apiResponse.StatusCode eq '200 OK' and isXML(apiResponse.filecontent)>
				<cftry>
					<cfset xmlstring = xmlparse(trim(apiResponse.filecontent))>
					<cfif StructKeyExists(xmlstring.envelope.body.EVRN_UnitInquiryRS,'Success')>
						<!--- do nothing --->
					<cfelse>
						<cfif isdefined("ravenClient")>
							<cfset ravenClient.captureMessage('Escapia.cfc->submitLeadToThirdParty = ' & xmlstring)>
						</cfif>
					</cfif>
				<cfcatch>
					<cfif isdefined("ravenClient")>
						<cfset ravenClient.captureMessage('Escapia.cfc->submitLeadToThirdParty = ' & cfcatch.message)>
					</cfif>
				</cfcatch>
				</cftry>
		<cfelse>
				<cfif isdefined("ravenClient")>
					<cfset ravenClient.captureMessage('Escapia.cfc->submitLeadToThirdParty = ' & apiResponse)>
				</cfif>
		</cfif>

   </cffunction> <!--- end of submitLeadToThirdParty function --->



   <cffunction name="getDistinctTypes" returnType="string" hint="Gets distinct unit types for the refine search">

		<cfset var qryGetDistinctTypes = ''>

   	<cfquery name="qryGetDistinctTypes" dataSource="#variables.settings.booking.dsn#">
   		select distinct unitcategory from escapia_properties order by unitcategory
   	</cfquery>

   	<cfset typeList = ValueList(qryGetDistinctTypes.unitcategory)>

   	<cfreturn typelist>

   </cffunction>



   <!--- This might need to be adjusted per-client based on what they have in their table --->
   <cffunction name="getDistinctAreas" returnType="string" hint="Gets distinct areas for the refine search">

		<cfset var qryGetDistinctAreas = ''>

   	<cfquery name="qryGetDistinctAreas" dataSource="#variables.settings.booking.dsn#">
		SELECT distinct categoryvalue
		FROM surfsiderealty.escapia_amenities
		WHERE category = 'Location'
					AND categoryvalue <> 'N/A'
		ORDER BY categoryvalue
   	</cfquery>

   	<cfset areaList = ValueList(qryGetDistinctAreas.categoryvalue)>

   	<cfreturn areaList>

   </cffunction>


   <!--- This might need to be adjusted per-client based on what they have in their table --->
   <cffunction name="getDistinctLocations" returnType="string" hint="Gets distinct views for the refine search">

		<cfset var qryGetDistinctLocations = ''>

   	<cfquery name="qryGetDistinctLocations" dataSource="#variables.settings.booking.dsn#">
   		select distinct cityname from escapia_properties order by cityname
   	</cfquery>

   	<cfreturn ValueList(qryGetDistinctLocations.cityname)>


   </cffunction>



   <cffunction name="getAllProperties" returnType="query" hint="Returns a query of all properties">

		<cfset var qryGetAllProperties = ''>

   	<cfquery name="qryGetAllProperties" dataSource="#variables.settings.booking.dsn#">
   		select
   			distinct unitcode as propertyid,
   			unitshortname as name,
   			seopropertyname,
   			maxoccupancy as sleeps,
   			bedrooms,
   			bathrooms
   		from escapia_properties order by unitshortname
   	</cfquery>

   	<cfreturn qryGetAllProperties>

   </cffunction>



	<cffunction name="insertAPILogEntry" hint="Logs any API request to the apilogs table">

	   <cfargument name="page">
	   <cfargument name="req">
	   <cfargument name="res">

	   <cftry>

	      <cfquery datasource="#variables.settings.dsn#">
	         insert into apilogs
	         set
	            page = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.page#">,
	            req = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.req#">,
	            <cfif isdefined('arguments.res.filecontent')>
            		res = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.res.filecontent#">
            	<cfelse>
            		res = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.res#">
            	</cfif>
	      </cfquery>

	   <cfcatch>
	      <!--- Change to Jonathan and Randy after go live --->
	      <cfmail
	         subject="API Log Error from #cgi.http_host#"
	         to="jrichey@icoastalnet.com"
	         from="jrichey@icoastalnet.com"
	         server="#settings.cfmailServer#"
	         username="#settings.cfmailUsername#"
	         password="#settings.cfmailPassword#"
	         port="#settings.cfmailPort#"
	         useSSL="#settings.cfmailSSL#"
	         type="HTML"
	      >
	      	<h1>Arguments</h1>
	      	<cfdump var="#arguments#">
	      	<h1>cfcatch</h1>
	         <cfdump var="#cfcatch#">
	         <h1>cgi</h1>
	         <cfdump var="#cgi#">
	      </cfmail>


	   </cfcatch>

	   </cftry>

	</cffunction>

	<cffunction name="getRandomProperties" returnType="query">

		<cfset var qryGetRandomProperties = ''>

		<cfquery name="qryGetRandomProperties" datasource="#variables.settings.booking.dsn#">

		select
			unitcode as propertyid,
			unitshortname as name,
			seopropertyname,
			mapPhoto as defaultPhoto,
			bedrooms,
			maxoccupancy as sleeps,
			unitcategory as type,
			petsallowedcode as petsallowed,
			cityname as location,
			bathrooms,
			(select avg(rating) as average from be_reviews where unitcode = escapia_properties.unitcode) as avgRating

		from escapia_properties

		order by rand() limit 2

		</cfquery>

		<cfreturn qryGetRandomProperties>

	</cffunction>


	<cffunction name="getSearchFilterCount" returnType="string">

		<cfargument name="filter" required="true" type="string">
		<cfargument name="category" required="true" type="string">

		<cfset var qryGetSearchFilterCount = ''>

		<cfif arguments.category eq 'amenity'>
			<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
				select count(unitcode) as numRecords from escapia_amenities where categoryvalue = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.filter#">
			</cfquery>
			<cfreturn qryGetSearchFilterCount.numRecords>
		<cfelseif arguments.category eq 'type'>
			<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
				select count(unitcode) as numRecords from escapia_properties where unitcategory = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.filter#">
			</cfquery>
			<cfreturn qryGetSearchFilterCount.numRecords>
		<cfelseif arguments.category eq 'view'>
			<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
				select count(unitcode) as numRecords from escapia_amenities where category = 'LOCATION_TYPE' and categoryvalue = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.filter#">
			</cfquery>
			<cfreturn qryGetSearchFilterCount.numRecords>
		<cfelseif arguments.category eq 'other'>
			<cfif arguments.filter eq 'Pet Friendly'>
				<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
					select count(unitcode) as numRecords from escapia_properties where petsallowedcode = 'Pets Allowed'
				</cfquery>
				<cfreturn qryGetSearchFilterCount.numRecords>
			</cfif>
		<cfelse>
			<cfreturn 0> <!--- default case --->
		</cfif>

	</cffunction>

	<cffunction name="getRefineFilterCount" returnType="string">

		<cfargument name="filter" type="string">
		<cfargument name="category" type="string">
		<cfargument name="formStruct" type="struct">

		<cfset var qryGetSearchFilterCount = ''>

		<cfif arguments.category contains 'type' and arguments.category contains 'view'>
			<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
				SELECT count(escapia_properties.unitcode) as numRecords
				from escapia_properties
				JOIN escapia_amenities ON escapia_amenities.unitcode = escapia_properties.unitcode
				WHERE 1=1
				AND escapia_amenities.category = 'LOCATION_TYPE'
				<cfloop list="#arguments.formStruct.view#" index="unitview">
					and escapia_amenities.categoryvalue = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#unitview#">
				</cfloop>
				<cfloop list="#arguments.formStruct.type#" index="unittype">
					and escapia_properties.unitcategory = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#unittype#">
				</cfloop>
			</cfquery>
			<!--- <cfreturn qryGetSearchFilterCount> --->
			<cfreturn qryGetSearchFilterCount.numRecords>
		<cfelseif arguments.category eq 'amenity'>
			<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
				select count(unitcode) as numRecords from escapia_amenities where categoryvalue = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.filter#">
			</cfquery>
			<cfreturn qryGetSearchFilterCount.numRecords>
		<cfelseif arguments.category eq 'type'>
			<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
				select count(unitcode) as numRecords from escapia_properties where 1=1
				<cfloop list="#arguments.filter#" index="unittype">
					and unitcategory = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#unittype#">
				</cfloop>
			</cfquery>
			<cfreturn qryGetSearchFilterCount.numRecords>
		<cfelseif arguments.category eq 'view'>
			<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
				select count(unitcode) as numRecords from escapia_amenities where
				category = 'LOCATION_TYPE'
				<cfloop list="#arguments.filter#" index="unitview">
					and categoryvalue = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#unitview#">
				</cfloop>
			</cfquery>
			<cfreturn qryGetSearchFilterCount.numRecords>
		<cfelseif arguments.category eq 'other'>
			<cfif arguments.filter eq 'Pet Friendly'>
				<cfquery name="qryGetSearchFilterCount" dataSource="#variables.settings.booking.dsn#">
					select count(unitcode) as numRecords from escapia_properties where petsallowedcode = 'Pets Allowed'
				</cfquery>
				<cfreturn qryGetSearchFilterCount.numRecords>
			</cfif>
		<cfelse>
			<cfreturn 0> <!--- default case --->
		</cfif>

	</cffunction>


	<cffunction name="getPriceBasedOnDates" returnType="string" hint="Returns the rental rate for a given property based on the arrival date">

   	<cfargument name="unitcode" required="true" type="string">
   	<cfargument name="strcheckin" required="true" type="date">
   	<cfargument name="strcheckout" required="true" type="date">

   	<cfset var qryGetPriceBasedOnDates = ''>
   	<cfset var numNights = DateDiff('d',arguments.strcheckin,arguments.strcheckout)>
   	<cfset var rateType = 'Weekly'>

   	<cfif numNights gte 7> <!--- weekly rate --->

			<cfset var numNights = 7>

		<cfelseif numNights lt 7> <!--- nightly rate --->

   		<cfset var rateType = 'Nightly'>

		</cfif>

		<cfquery name="qryGetPriceBasedOnDates" dataSource="#variables.settings.booking.dsn#">
			select (maxRent*#numNights#) as baseRate
			from escapia_rates
			where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.unitcode#">
			and <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.strcheckin#"> between startdate and enddate
			and ratetype = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rateType#">
		</cfquery>

		<cfif qryGetPriceBasedOnDates.recordcount gt 0>
			<cfset tempReturn = DollarFormat(qryGetPriceBasedOnDates.baseRate) & ' <small>+Taxes and Fees</small>'>
		<cfelse>
		  <cfset tempReturn = ''>
		</cfif>

		<cfreturn tempReturn>

   </cffunction>



   <cfscript>
   function stripHTML(str) {
   	str = reReplaceNoCase(str, "<*style.*?>(.*?)</style>","","all");
   	str = reReplaceNoCase(str, "<*script.*?>(.*?)</script>","","all");

   	str = reReplaceNoCase(str, "<.*?>","","all");
   	//get partial html in front
   	str = reReplaceNoCase(str, "^.*?>","");
   	//get partial html at end
   	str = reReplaceNoCase(str, "<.*$","");
   	return trim(str);
   }
   </cfscript>

</cfcomponent>
