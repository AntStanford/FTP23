<cfset variables.similar = application.oMLS.getSimilarProps(wsid = 1, price = 220000) /><!--- , companyOnly = true, beds = 3, baths = 3 --->

<cfdump var="#variables.similar#">