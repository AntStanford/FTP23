<cfif 
	isdefined('form.strcheckin') and 
	IsValid('date',form.strcheckin) and
	isdefined('form.strcheckout') and
	IsValid('date',form.strcheckout) and
	isdefined('form.propertyid') and
	len(form.propertyid)
	>

	<cfparam name="form.promocode" default="">
	
	<cfset apiresponse = application.bookingObject.getDetailRates(form.propertyid,form.strcheckin,form.strcheckout,form.promocode)>

<cfelse>
	<cfset apiresponse = 'One or more required parameters is missing. Please try again.'>
</cfif>

<cfoutput>#apiresponse#</cfoutput>