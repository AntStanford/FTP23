

<cfset newURL = replace(cgi.http_url,'admin','admin_old')>
<cflocation url="https://www.surfsiderealty.com#newURL#" addtoken="false">
<cfabort>

