<cfif settings.booking.pms eq 'Escapia' and isdefined('url.numAdults') and isdefined('url.numChildren') and isdefined('url.useraction') and isdefined('url.chargetemplateid')>
	
	<cfset apiresponse = application.bookingObject.booknow(unitcode=url.propertyid,strcheckin=url.strcheckin,strcheckout=url.strcheckout,useraction=url.useraction,promocode='',chargetemplateid=url.chargetemplateid,numAdults=url.numAdults,numChildren=url.numChildren)>

<cfelse>
	<cfset apiresponse = application.bookingObject.booknow(unitcode=url.propertyid,strcheckin=url.strcheckin,strcheckout=url.strcheckout)>
</cfif>

<cfoutput>#apiresponse#</cfoutput>