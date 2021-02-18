<cfif agentid is "No">
  <cfquery name="GetNextRR" datasource="#application.settings.dsn#">
    SELECT  *
    FROM    cl_agents
    WHERE   RoundRobinNow = 'Next'
    AND     roundrobin = 'Yes'
  </cfquery>
  <cfset AgentID = "#GetNextRR.id#">
  <cfset AgentEmailAddress = "#GetNextRR.email#">
  <cfset AgentName= "#GetNextRR.FirstName# #GetNextRR.LastName#">

  <!--- is this a contactually client? --->
  <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes'>
    <cfif isdefined('GetNextRR.contactuallyid') and len(GetNextRR.contactuallyid)>
      <cfset AgentContactuallyID = GetNextRR.contactuallyid>
    <cfelseif isDefined('application.contactually.defaultUserId')>
      <cfset AgentContactuallyID = application.contactually.defaultUserId />
    <cfelse>
      <cfset AgentContactuallyID = '' />
    </cfif>
  </cfif>

  <!---START: ROUND ROBIN BRAINS--->

  <!---gets list of participating agents--->
  <cfquery name="qagents" datasource="#application.settings.dsn#">
    SELECT * FROM cl_agents
    WHERE  RoundRobin = 'Yes'
  </cfquery>

  <!--- Set Agent Id List --->
  <cfset application.roundrobin.agent = valuelist(qagents.id)>
  <!--- Find the List Position of this Agent --->
  <cfset thisrobin = listfind(application.roundrobin.agent,AgentID)>
  <!--- Define the next position in line --->
  <cfset nextrobin =  thisrobin + 1>
  <!--- If there is no next number,  then start over list at 1 --->
  <cfif nextrobin gt listlen(application.roundrobin.agent)><cfset nextrobin = 1></cfif>
   <!---  Get the next Agent ID  --->
  <cfset nextrobinid = listgetat(application.roundrobin.agent,nextrobin)>

  <cfquery name="UpdateRoundRobin" datasource="#application.settings.dsn#">
      UPDATE  cl_agents
      SET     RoundRobinNow = ''          
      WHERE   roundrobin = 'Yes'
  </cfquery>

  <cfquery name="UpdateRoundRobin" datasource="#application.settings.dsn#">
    UPDATE  cl_agents
    SET     RoundRobinNow = 'Next'
    WHERE   id = <cfqueryparam cfsqltype="cf_sql_integer" value="#nextrobinid#">
    AND     roundrobin = 'Yes'
  </cfquery>
  <!---END: ROUND ROBIN BRAINS--->

<cfelse>
  <cfquery name="GetNextRR" datasource="#application.settings.dsn#">
    SELECT  *
    FROM    cl_agents
    WHERE   id = <cfqueryparam cfsqltype="cf_sql_integer" value="#agentid#">
  </cfquery>
  <cfset AgentID = "#GetNextRR.id#">
  <cfset AgentEmailAddress = "#GetNextRR.email#">
  <cfset AgentName= "#GetNextRR.FirstName# #GetNextRR.LastName#">

  <!--- is this a contactually client? --->
  <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes'>
    <cfif isdefined('GetNextRR.contactuallyid') and len(GetNextRR.contactuallyid)>
      <cfset AgentContactuallyID = GetNextRR.contactuallyid>
    <cfelseif isDefined('application.contactually.defaultUserId')>
      <cfset AgentContactuallyID = application.contactually.defaultUserId />
    <cfelse>
      <cfset AgentContactuallyID = '' />
    </cfif>
  </cfif>
 
</cfif>