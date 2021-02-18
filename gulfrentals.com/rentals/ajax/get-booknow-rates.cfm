<cfif settings.booking.pms eq 'Escapia' and isdefined('url.numAdults') and isdefined('url.numChildren') and isdefined('url.useraction') and isdefined('url.chargetemplateid')>
	
	<cfset apiresponse = application.bookingObject.booknow(url.propertyid,url.strcheckin,url.strcheckout,url.useraction,'',url.chargetemplateid,url.numAdults,url.numChildren)>

<cfelseif settings.booking.pms eq 'Barefoot'>
	
	<cfif !isdefined('url.numAdults')>
		<cfset url.numAdults = 0>
	</cfif>
	
	<cfif !isdefined('url.numChildren')>
		<cfset url.numChildren = 0>
	</cfif>

	<cfif !isdefined('url.numPets')>
		<cfset url.numPets = 0>
	</cfif>
	
	<cfif !isdefined('url.maxoccupancy')>
		<cfset url.maxoccupancy = 10>
	</cfif>

	<cfif !isdefined('url.useraction')>
		<cfset url.useraction = "">
	</cfif>
	
	<cfset apiresponse = application.bookingObject.booknow(url.propertyid,url.strcheckin,url.strcheckout,url.numAdults,url.numChildren,url.maxoccupancy,url.useraction,url.numPets)>
<cfelse>
	<cfset apiresponse = application.bookingObject.booknow(url.propertyid,url.strcheckin,url.strcheckout)>
</cfif>

<cfoutput>#apiresponse#</cfoutput>