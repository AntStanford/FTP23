<!--- Set Search Variables --->
<cfparam name="search.planname" default="">
<cfparam name="search.description" default="">
<cfparam name="search.agent" default="All">
<cfparam name="search.sortby" default="drip_library.Lib_LeadScore DESC">

<!--- Update Search Variables --->
<cfif isdefined('form.planname') and LEN(form.planname)><cfset search.planname = form.planname></cfif>
<cfif isdefined('form.description') and LEN(form.description)><cfset search.description = form.description></cfif>
<cfif isdefined('form.agent') and LEN(form.agent)><cfset search.agent = form.agent></cfif>
<cfif isdefined('form.sortby') and LEN(form.sortby)><cfset search.sortby = form.sortby></cfif>


<!--- Clear Search Variables --->
<cfif isdefined('form.clear')>
	<cfset search.planname = "">
	<cfset search.description = "">
	<cfset search.agent = "All">
	<cfset search.sortby = "drip_library.Lib_LeadScore DESC">
</cfif>


<cfquery datasource="#mls.dsn#" name="getInfo">
	select Lib_PlanName,Lib_PlanDescription,Lib_LeadScore,Lib_Agentid,Lib_CreatedAt,Lib_UpdatedAt,Lib_PlanID,Lib_Default
	from drip_library
	where 1=1
	<cfif isdefined('search.planname') and LEN(search.planname)>and Lib_PlanName LIKE <cfqueryparam value="%#search.planname#%" cfsqltype="cf_sql_varchar"></cfif>
	<cfif isdefined('search.description') and LEN(search.description)>and Lib_PlanDescription LIKE <cfqueryparam value="%#search.description#%" cfsqltype="cf_sql_varchar"> </cfif>
	<cfif isdefined('search.agent') and LEN(search.agent) and search.agent eq 'Only Me' and isdefined('cookie.LOGGEDINAGENTID')>and Lib_AgentID = <cfqueryparam value="#cookie.LOGGEDINAGENTID#" cfsqltype="cf_sql_integer"></cfif>
	order by <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#search.sortby#">
</cfquery>

<cfquery datasource="#mls.dsn#" name="getAgents">
	select firstname,lastname,id 
	from cl_agents
</cfquery>