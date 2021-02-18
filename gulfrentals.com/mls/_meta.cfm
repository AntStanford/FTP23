<cftry>
<cfoutput>
<meta property="og:title" content="#pagetitle#">
<meta property="og:description" content="#pagemetadescription#">
<meta property="og:url" content="http://#cgi.server_name#/mls/property.cfm?mlsid=#url.mlsid#&wsid=#url.wsid#&mlsnumber=#url.mlsnumber#" />
<meta property="og:image" content="<cfif len(property.photo_link) eq 0>http://placehold.it/100x100&text=No%20Image<cfelse>#listgetat(property.photo_link,1)#</cfif>">
</cfoutput>
<cfcatch></cfcatch>
</cftry>