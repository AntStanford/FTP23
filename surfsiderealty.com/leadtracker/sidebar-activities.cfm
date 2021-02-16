<!--- <cfquery datasource="#mls.dsn#" name="getActivities" cachedwithin="#CreateTimeSpan(0, 0, 10, 0)#">
  select cl_calendar.*,cl_agents.firstname,cl_agents.lastname
  from cl_calendar
  LEFT JOIN cl_agents
  On cl_calendar.agentid = cl_agents.id
  where 
		<cfif isdefined('cookie.LoggedInAgentID')>
			 cl_calendar.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#"> and 
		</cfif>
  date(cl_calendar.start_datetime) 
  <cfif isdefined('url.dates')>
	  <cfif url.dates eq 'open'> 
	  	>= <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(now(), 'yyyy-mm-dd')#">
	  <cfelseif url.dates eq 'missed'>
	  	< <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(now(), 'yyyy-mm-dd')#">
	  <cfelse> 
	  	= <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(url.dates, 'yyyy-mm-dd')#">
	  </cfif>
  </cfif>
  ORDER BY cl_calendar.start_datetime ASC
</cfquery> --->
<cfquery datasource="#mls.dsn#" name="getactivities">
  select id,start_datetime,activity
  from cl_calendar
  where 
      <cfif isdefined('cookie.LoggedInAgentID')>
      agentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.LOGGEDINAGENTID#"> and 
    </cfif>
  date(start_datetime) = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#dateformat(now(), 'yyyy-mm-dd')#">
</cfquery>

<h3>Activities</h3>

<ul>
	<cfif getactivities.recordcount eq 0>There are no activities scheduled.</cfif>
	<cfoutput query="getActivities">
		<li>#timeformat(start_datetime, 'h:mm t')# -  <a hreflang="en" href="##">#activity#</a></li>
	</cfoutput>
</ul>

