<!---
This file might need to be modified based on the PMS; for Escapia, use the same 'booknow' function, but passing in the promo code.

Options are: add_insurance or remove_insurance
--->


<cfif isdefined('url.propertyid') and isdefined('url.strcheckin') and isdefined('url.strcheckout') and isdefined('url.addInsurancePromoCode') and isdefined('url.promocode') and isdefined('url.chargetemplateid') and settings.booking.pms eq 'Escapia'>
		
	<!--- propertyID, arrival date, departure date, travel insurance (add_insurance,remove_insurance), promo code, charge template id --->
	<cfset apiresponse = application.bookingObject.booknow(unitcode=url.propertyid,strcheckin=url.strcheckin,strcheckout=url.strcheckout,useraction=url.addInsurancePromoCode,promocode=url.promocode,chargetemplateid=url.chargetemplateid)>
	
	<cfoutput>#apiresponse#</cfoutput>
	
	
</cfif>