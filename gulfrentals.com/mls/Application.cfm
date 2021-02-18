<cfinclude template="/Application.cfm">
<!--- 
<cfset headers = getHttpRequestData().headers />
<cfif structKeyExists(headers, "X-Requested-With") and (headers["X-Requested-With"] eq "XMLHttpRequest")>
<cfelse>
	<cfif cgi.server_name contains "icnd.net"><div class="alert alert-danger" role="alert"><h3>Central MLS Development Environment</h3></div></cfif>
</cfif>
 --->