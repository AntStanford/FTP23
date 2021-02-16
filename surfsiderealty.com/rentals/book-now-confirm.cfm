<cfif isdefined('form.numAdults') and isdefined('form.numChildren') and isdefined('form.maxOccupancy')>

	<cfset totalGuests = form.numAdults + form.numChildren>

	<cfif totalGuests gt form.maxOccupancy>

		<cfinclude template="components/header.cfm">
			<div class="booking booking-confirm container">

			  <div class="row clearfix">
			    <div class="col-md-12">
			      <div class="page-header">
			        <p class="h3">Booking Issue</p>
			      </div>
			    </div>
			  </div>

				<div class="row clearfix">
					<div class="col-md-12">
						<p>The total number of guests exceeds the max occupancy of this unit, which is <cfoutput>#form.maxOccupancy#</cfoutput>.</p>
						<p>Please <a href="javascript: window.history.go(-1)">go back</a> and update the number of guests and re-submit your reservation request.</p>
					</div>
				</div>

			</div>
		<cfinclude template="components/footer.cfm">

		<cfabort>

	</cfif>

</cfif>


<cfif NOT isdefined('form.strCheckin')>Check-In not defined<cfabort></cfif>
<cfif NOT isdefined('form.strCheckout')>Check-Out not defined<cfabort></cfif>
<cfif NOT isdefined('form.propertyid')><!---you are a bot--->Propertyid is required.<cfabort></cfif>
<cfif isdefined('form.strcheckin') and !isValid('date',form.strcheckin)>Check-In date not valid.<cfabort></cfif>
<cfif isdefined('form.strcheckout') and !isValid('date',form.strcheckout)>Check-Out date not valid.<cfabort></cfif>

<!--- query to check availability and get pricing info --->
<cfset request.reservationCode = application.bookingObject.checkout(form)>

<cfif !isDefined('request.reservationCode') OR (isDefined('request.reservationCode') AND !LEN(request.reservationCode))>
	<cfset session.errorMessage = 'RES is undefined.'>
	<cflocation addToken="no" url="/#settings.booking.dir#/booking-error.cfm">
<cfelse>
	<cfinclude template="/#settings.booking.dir#/_confirm-email.cfm">
</cfif>

<cfinclude template="components/header.cfm">

<!---START: give cart abandonment email credit--->
<cfif isdefined('cookie.CartAbandonEmail') and isdefined('cookie.CartAbandonmentKey')>

	<cfquery NAME="UpdateQuery" DATASOURCE="#application.bcDSN#">
		UPDATE cart_abandonment SET
		CookieAbandomentUnitCodeBooked = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.unitcode#">,
		CookieAbandonmentBooked = 'Yes'
		where TheKey = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cookie.CartAbandonmentKey#">
		and siteID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
	</cfquery>

	<cfcookie name="CartAbandonEmail" expires="NOW">
	<cfcookie name="CartAbandonmentKey" expires="NOW">

</cfif>
<!---END: give cart abandonment email credit--->

<!---START: give the return and book feature credit--->
<cfif isdefined('Cookie.ReturnAndBookedID')>

	<CFQUERY NAME="UpdateQuery" DATASOURCE="#settings.dsn#">
    	UPDATE cms_remindtobook
    	SET
    	ReturnedAndBooked = 'Yes',
		FinalPropertyID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyID#">,
		FinalBookingValue = <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#form.Total#">,
		FinalPropertyName = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyName#">
    	where id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.ReturnAndBookedID#">
 	</cfquery>

</cfif>

<!---END: give the return and book feature credit--->

<!--- User has chosen to enroll in the Guest Loyalty Program --->
<cfif isdefined('form.enroll_user_glp') and form.enroll_user_gp eq 'yes'>
	<cfinclude template="_enroll_user_glp.cfm">
</cfif>

<div class="booking booking-confirm container">

  <div class="row clearfix">
    <div class="col-md-12">
      <div class="page-header">
        <p class="h3">Booking Confirmation</p>
      </div>
    </div>
  </div>

  <div class="row clearfix">
    <div class="col-md-12">
      <cfoutput>
				<p>Thank you <b>#form.firstname# #form.lastname#</b> for selecting your accommodations with <b>#cgi.http_host#</b>.</p>
				<p><strong>Your reservation code is: #request.reservationCode#</strong></p>
			</cfoutput>
    </div>

		<div class="col-md-6 col-sm-6 col-xs-12">
			<div class="panel panel-default">
				<div class="panel-body booking-panel">
					<p class="h3">User Information</p>
					<div>
						<cfoutput>
						<p>Name: #form.firstname# #form.lastname#</p>
						<p>Address: #form.address1# <cfif isdefined('form.address2') and len(form.address2)>#form.address2#</cfif></p>
						<p>#form.city#, #form.state# #form.zip#</p>
						<p>Adults: #form.numAdults#</p>
						<p>Children: #form.numChildren#</p>
						</cfoutput>
					</div>
				</div>
			</div>
		</div>

		<div class="col-md-6 col-sm-6 col-xs-12">
			<div class="panel panel-default">
				<div class="panel-body booking-panel">
					<p class="h3">Unit Information</p>
					<div>
						<cfoutput>
						<p>Name: #form.propertyName# - Unitcode: #form.propertyID#</p>
						<p>Check In: #form.strCheckin#</p>
						<p>Check Out: #form.strCheckout#</p>
						<p>Location: #form.propertyCity#, #form.propertyState#</p>
						</cfoutput>
					</div>
				</div>
			</div>
		</div>

		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="panel panel-default">
				<div class="panel-body booking-panel">
					<p class="h3">Summary of Charges</p>
					<div>
						<cfoutput>
							<p>Total Amount for Reservation: #DollarFormat(form.Total)#</p>
							<cfif isdefined('form.addInsurance') and form.addInsurance is "true" and isdefined('form.tripinsuranceamount') and form.tripinsuranceamount neq '' and form.tripinsuranceamount gt 0>
								<p>You purchased travel insurance for #DollarFormat(form.tripinsuranceamount)#</p>
							</cfif>
              <cfif IsDefined('form.selectedAddOns') AND listLen(form.selectedAddOns) GT 0>
              	<p>You selected the following add-ons to be billed separately:</p>
                <cfquery name="variables.qryAddOns" dataSource="#settings.booking.dsn#">
                SELECT id, title, amount, tax
                FROM cms_checkout_addons
                WHERE 1 = 0
                      <cfloop list="#form.selectedAddOns#" index="i">
                        OR id = <cfqueryparam value="#ListFirst(i,'-')#" cfsqltype="cf_sql_integer">
                      </cfloop>
                </cfquery>
                <cfloop query="variables.qryAddOns">
                  <cfset variables.addonAmount = 0 >
                  <cfloop list="#form.selectedAddOns#" index="i">
                    <cfif variables.qryAddOns.id EQ ListFirst(i,'-')>
                      <p>&nbsp;&bull;&nbsp;#variables.qryAddOns.title# <cfif ListLast(i,'-') GT 1>(#ListLast(i,'-')#)</cfif>
                      <cfset variables.addonAmount = variables.qryAddOns.amount * ListLast(i,'-')>
                      #DollarFormat(variables.addonAmount)#</p>
                    </cfif>
                  </cfloop>
                </cfloop>
              </cfif>
						</cfoutput>
					</div>
				</div>
			</div>
		</div>

	</div>

</div><!-- END booking container -->

<cfinclude template="components/footer.cfm">
