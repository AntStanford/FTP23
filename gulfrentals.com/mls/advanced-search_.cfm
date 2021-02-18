<!--- This gonna be a new search, so lets clear the search session --->
<cfset structDelete(SESSION,"mlssearch")>

<!--- END: SET SESSIONS TO USE THROUGH REMAINDER OF SEARCH --->

<!--- TODO: move this to its own CFC, when working on the login feature --->
<!--- if user logs out, we kill all users session info --->
<cfif isdefined('logout')>
	<cfset structdelete(session,"USERFirstName",true)>
	<cfset structdelete(cookie,"USERFirstName",true)>
	<cfset structdelete(session,"USERLastName",true)>
	<cfset structdelete(cookie,"USERLastName",true)>
	<cfset structdelete(session,"USEREmail",true)>
	<cfset structdelete(cookie,"USEREmail",true)>
	<cfset structdelete(session,"USERPhone",true)>
	<cfset structdelete(cookie,"USERPhone",true)>
	<cfset structdelete(session,"LoggedIn",true)>
	<cfset structdelete(cookie,"LoggedIn",true)>
	<cfset structdelete(cookie,"MLSfavorites",true)>

	<cflocation url="/mls/index.cfm" addtoken="No">
</cfif>

<!--- START: USED TO CLOSE LIGHTBOX AND RELOAD PAGE --->
<cfset session.RememberMePage = "#script_name#?#query_string#">
<!--- END: USED TO CLOSE LIGHTBOX AND RELOAD PAGE --->