<!--- <cfif CGI.REMOTE_ADDR eq "75.182.88.35"><cfset agentid = "No"></cfif> --->


<cfif agentid is "No">
<!---
See TT - 82160
<cfquery name="GetNextRR" datasource="#mls.dsn#">
    select *
    from cl_agents
    where RoundRobinNow = 'Next' and roundrobin = 'Yes'
  </cfquery> --->


<cfset timenow = "#now()#">
<cfset Time9am = "#dateformat(now(),'mm/dd/yyyy')# 09:00:00">
<cfset Time1pm = "#dateformat(now(),'mm/dd/yyyy')# 13:00:00">


<cfif timenow gt "#Time9am#" and timenow lt "#Time1pm#">
		<cfset dutytime = "9am - 1pm">
	<cfelse>
		<cfset dutytime = "1pm - 9am">
</cfif>


 <cfquery datasource="#mls.dsn#" name="GetAgentOnCall">
	select *
	from cl_agent_on_duty
	where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#timenow#"> and DutyTime = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dutytime#">
</cfquery>

<cfquery name="GetNextRR" datasource="#mls.dsn#">
    select *
    from cl_agents
    where id = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetAgentOnCall.agentid#">
  </cfquery>


  <cfset AgentID = "#GetNextRR.id#">
  <cfset AgentEmailAddress = "#GetNextRR.email#">
  <cfset AgentName= "#GetNextRR.FirstName# #GetNextRR.LastName#">


  <!---START: ROUND ROBIN BRAINS
  <!---
See TT - 82160--->

  <!---gets list of participating agents--->
      <cfquery name="qagents" datasource="#mls.dsn#">
        SELECT * FROM cl_agents
        where RoundRobin = 'Yes'
     </cfquery>

   <!---  <Cfdump var="#qagents#"><br> --->

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

      <cfquery name="UpdateRoundRobin" datasource="#mls.dsn#">
          update  cl_agents
          set
          RoundRobinNow = '' and roundrobin = 'Yes'
      </cfquery>

      <cfquery name="UpdateRoundRobin" datasource="#mls.dsn#">
          update  cl_agents
          set
          RoundRobinNow = 'Next'
          where id = #nextrobinid# and roundrobin = 'Yes'
        </cfquery>
  END: ROUND ROBIN BRAINS--->

<cfelse>
  <cfquery name="GetNextRR" datasource="#mls.dsn#">
    select *
    from cl_agents
    where id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#agentid#">
  </cfquery>
  <cfset AgentID = "#GetNextRR.id#">
  <cfset AgentEmailAddress = "#GetNextRR.email#">
  <cfset AgentName= "#GetNextRR.FirstName# #GetNextRR.LastName#">
</cfif>