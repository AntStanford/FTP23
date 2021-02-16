<!---
This file might need to be modified based on the PMS; for Escapia, use the same 'booknow' function, but passing in the url.useraction value.

Options are: add_insurance or remove_insurance
--->


<cfif isdefined('url.propertyid') and isdefined('url.strcheckin') and isdefined('url.strcheckout') and isdefined('url.useraction') and isdefined('url.chargetemplateid') and settings.booking.pms eq 'Escapia'>
	
	<cfif isdefined('url.promocode')>
		<cfset thePromoCode = url.promocode>
	<cfelseif isdefined('url.hiddenPromoCode')>
		<cfset thePromoCode = url.hiddenPromoCode>
	<cfelse>
		<cfset thePromoCode = ''>		
	</cfif>

	<cfset variables.addons = "">  
  <cfloop collection="#url#" item="i">
  	<cfif left(i,5) EQ "addon" AND url[i] GT 0>
    	<cfset variables.addons = ListAppend(variables.addons,"#ReplaceNoCase(i,"addon","")#-#url[i]#")>
    </cfif>
  </cfloop>
	
	<!--- propertyID, arrival date, departure date, travel insurance (add_insurance,remove_insurance), promo code, charge template id --->
	<cfset apiresponse = application.bookingObject.booknow(unitcode=url.propertyid,strcheckin=url.strcheckin,strcheckout=url.strcheckout,useraction=url.useraction,promocode=thePromoCode,chargetemplateid=url.chargetemplateid,addons=variables.addons)>
	
	<cfoutput>#apiresponse#</cfoutput>

</cfif>