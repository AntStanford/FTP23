<!--- Set which query --->
<cfif isdefined('url.qry') and LEN(url.qry)>
	<cfset session.tracker.mainqry = url.qry>
<cfelse>
		<cfset session.tracker.mainqry = 'RecentLeads'>
</cfif>

<cfif session.tracker.mainqry eq "recentAct">
	<cfset thisPageTitle = "Recent Activity">
<cfelseif session.tracker.mainqry eq "searchAct">
	<cfset thisPageTitle = "Latest Search Activity">
<cfelseif session.tracker.mainqry eq "RecentLeads">
	<cfset thisPageTitle = "Latest Leads">
</cfif>


<!--- Set Lead Status / Rating --->
<cfparam name="url.status" default="All">
<cfparam name="tracker.rating" default="0">

<cfif url.status eq 'Cold'>
	<cfset tracker.rating = "4">
<cfelseif url.status eq 'Nurture'>
	<cfset tracker.rating = "10">
<cfelseif url.status eq 'Watch'>
	<cfset tracker.rating = "9">
<cfelseif url.status eq 'Hot'>
	<cfset tracker.rating = "2">
<cfelseif url.status eq 'Pending'>
	<cfset tracker.rating = "8">
<cfelseif url.status eq 'Trash'>
	<cfset tracker.rating = "7">
<cfelseif url.status eq 'Qualify'>
	<cfset tracker.rating = "Qualify">
<cfelseif url.status eq 'New'>
	<cfset tracker.rating = "New">
<cfelseif url.status eq 'Closed'>
	<cfset tracker.rating = "11">
<cfelse>
	<cfset tracker.rating = "0">
	<cfset url.status ="all">
</cfif>

<cfif session.tracker.mainqry eq "AgentResp">
	<cfset url.status ="Waiting on You">
<cfelseif session.tracker.mainqry eq "CustResp">
	<cfset url.status ="Waiting on Lead">
</cfif>


<!--- Set number of hours to be considered a New lead --->
<cfparam name="NewLeadHrs" default="2">
<cfset QualifyNewDate = DateAdd("h", -NewLeadHrs, now())>