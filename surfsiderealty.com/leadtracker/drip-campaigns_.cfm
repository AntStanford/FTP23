

<!--- Set Search Variables --->
<cfparam name="search.firstname" default="">
<cfparam name="search.lastname" default="">
<cfparam name="search.status" default="Active">
<cfparam name="search.sortby" default="drip_campaigns.DripStartDate DESC">
<cfparam name="search.querystring" default="">

<!--- Update Search Variables --->
<cfif isdefined('url.firstname') and LEN(url.firstname)><cfset search.firstname = url.firstname></cfif>
<cfif isdefined('url.lastname') and LEN(url.lastname)><cfset search.lastname = url.lastname></cfif>
<cfif isdefined('url.status') and LEN(url.status)><cfset search.status = url.status></cfif>
<cfif isdefined('url.sortby') and LEN(url.sortby)><cfset search.sortby = url.sortby></cfif>
<cfif isdefined('form.firstname') and LEN(form.firstname)><cfset search.firstname = form.firstname></cfif>
<cfif isdefined('form.lastname') and LEN(form.lastname)><cfset search.lastname = form.lastname></cfif>
<cfif isdefined('form.status') and LEN(form.status)><cfset search.status = form.status></cfif>
<cfif isdefined('form.sortby') and LEN(form.sortby)><cfset search.sortby = form.sortby></cfif>

<!--- Clear Search Variables --->
<cfif isdefined('form.clear')>
	<cfset search.firstname = "">
	<cfset search.lastname = "">
	<cfset search.status = "Active">
	<cfset search.sortby = "drip_campaigns.DripStartDate DESC">
	<cfset search.querystring = "">
</cfif>

<cfoutput><cfset search.querystring = "firstname=#search.firstname#&lastname=#search.lastname#&status=#search.status#&sortby=#search.sortby#"></cfoutput>


<cfquery datasource="#mls.dsn#" name="getInfo">
		Select drip_campaigns.id,drip_campaigns.clientid,drip_campaigns.planname,drip_campaigns.status,drip_campaigns.createdat,drip_campaigns.onrepeat,drip_campaigns.RepeatCampaign,
		drip_campaigns.DripStartDate,drip_campaigns.lastsent,cl_accounts.firstname,cl_accounts.lastname
		From drip_campaigns
		Left Join cl_accounts on cl_accounts.id = drip_campaigns.clientid
		Where 1 = 1 
			<cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
		        and drip_campaigns.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
		      </cfif>
		<cfif LEN(search.sortby)>and cl_accounts.firstname LIKE <cfqueryparam value="%#search.firstname#%" cfsqltype="cf_sql_varchar"></cfif>
		<cfif LEN(search.lastname)>and cl_accounts.lastname LIKE <cfqueryparam value="%#search.lastname#%" cfsqltype="cf_sql_varchar"></cfif>
		<cfif LEN(search.status) and search.status neq 'All'>and drip_campaigns.status LIKE <cfqueryparam value="%#search.status#%" cfsqltype="cf_sql_varchar"></cfif>
		<cfif LEN(search.sortby)>Order by <cfqueryparam value="#search.sortby#" cfsqltype="CF_SQL_VARCHAR"></cfif>
		
	</cfquery>

<!--- 	limit #act.perpage# Offset #act.start# --->