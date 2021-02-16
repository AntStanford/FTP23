<!--- Set Pagination Variables  --->

<!--- Set Defaults --->
<cfparam name="url.pg" default="1" type="integer">
<cfparam name="tracker.startRow" default="1" type="integer">
<cfparam name="tracker.endRow" default="10" type="integer">
<cfparam name="tracker.maxRows" default="10" type="integer">
<cfparam name="tracker.resultCnt" default="1" type="integer">
<cfparam name="tracker.totalResults" default="1" type="integer">
<cfparam name="tracker.resultPages" default="1" type="integer">
<cfparam name="tracker.navShowPageLinks" default="6" type="integer">
<cfparam name="tracker.navLoopTo" default="6" type="integer">
<cfparam name="tracker.navPrevLink" default="1" type="integer">
<cfparam name="tracker.navLoopFrom" default="1" type="integer">
<cfparam name="tracker.navNextLink" default="1" type="integer">
<cfif url.pg gte 3><cfset tracker.navLoopFrom = url.pg></cfif>
<cfset tracker.navNextLink = url.pg + 1>



<!--- After page 1, adjust pagination values --->
<cfif url.pg gt 1>
	<cfset tracker.startRow = (url.pg * tracker.maxRows) - (tracker.maxRows - 1)>
	<cfset tracker.endRow = (tracker.startRow + tracker.maxRows) - 1>
	<cfset tracker.resultCnt = tracker.startRow>
	<cfset tracker.navShowPageLinks = (url.pg + tracker.navShowPageLinks)>
	<cfset tracker.navPrevLink = url.pg - 1>
</cfif>
 


<!--- Set Number of Results / Pages --->
<cfif isdefined('RecentLeadCounter') and LEN(RecentLeadCounter)>
	<cfset tracker.totalResults = RecentLeadCounter>
	<cfset tracker.resultPages = Ceiling(RecentLeadCounter / tracker.maxRows)>

<cfelseif isdefined('url.qry') and url.qry eq "AgentResp">
	<cfset tracker.totalResults = agentcounter>
	<cfset tracker.resultPages = Ceiling(agentcounter / tracker.maxRows)>

<cfelseif isdefined('url.qry') and  url.qry eq "CustResp">
	<cfset tracker.totalResults = contactcounter>
	<cfset tracker.resultPages = Ceiling(contactcounter / tracker.maxRows)>

<cfelseif isdefined('url.qry') and  url.qry eq "RecentLeads">
	<cfset tracker.totalResults = RecentLeadCounter>
	<cfset tracker.resultPages = Ceiling(RecentLeadCounter / tracker.maxRows)>

<cfelseif isdefined('getInfo.recordCount') and getInfo.recordCount gt 1>
	<cfset tracker.totalResults = getInfo.recordCount>
	<cfset tracker.resultPages = Ceiling(getInfo.recordCount / tracker.maxRows)>
</cfif>

<cfif tracker.resultPages lt tracker.navShowPageLinks>
	<cfset tracker.navLoopTo = tracker.resultPages>
</cfif>

<cfif tracker.navShowPageLinks gt tracker.resultPages>
	<cfset tracker.navShowPageLinks = tracker.resultPages>
</cfif>


<!--- Adjust Last Page Row Count --->
<cfif tracker.endRow gte tracker.totalResults>
	<cfset tracker.endRow = tracker.totalResults>
</cfif>



<!--- Adjust Navigation Counts --->
<!--- If the page is gt 6, want to there to be a buffer so the page you are on is not the first link in nav --->
<cfif tracker.resultPages gt 6 and url.pg gt 2>

	<cfset tracker.navLoopFrom = url.pg - 2>

	<cfif url.pg lt (tracker.resultPages - 3)>
		<cfset tracker.navLoopto = tracker.navShowPageLinks - 3>
	<cfelse>
		<cfset tracker.navLoopto = tracker.resultPages>	
	</cfif>

	<cfset tracker.navShowPageLinks = tracker.navLoopto>

<cfelseif tracker.resultPages lte 6>

	<cfset tracker.navLoopFrom = 1>

<cfelseif tracker.resultPages lt tracker.navShowPageLinks>

	<cfset tracker.navShowPageLinks = tracker.resultPages>
	<cfset tracker.navLoopFrom = 1>
	<cfset navLoopTo.navLoopFrom = tracker.resultPages>

<cfelseif tracker.resultPages eq tracker.navShowPageLinks>

	<cfset tracker.navLoopFrom = tracker.navShowPageLinks>
	<cfset tracker.navLoopto = tracker.navShowPageLinks>

</cfif>


