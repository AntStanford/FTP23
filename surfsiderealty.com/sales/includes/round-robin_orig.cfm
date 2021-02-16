<cfif agentid is "No">
  <cfquery name="GetNextRR" datasource="#mls.dsn#">
    select *
    from cl_agents
    where RoundRobinNow = 'Next' and roundrobin = 'Yes'
  </cfquery>
  <cfset AgentID = "#GetNextRR.id#">
  <cfset AgentEmailAddress = "#GetNextRR.email#">
  <cfset AgentName= "#GetNextRR.FirstName# #GetNextRR.LastName#">


  <!---START: ROUND ROBIN BRAINS--->

  <!---gets list of participating agents--->
      <cfquery name="qagents" datasource="#mls.dsn#">
        SELECT * FROM cl_agents
        where RoundRobin = 'Yes'
     </cfquery>

<!----If the application variable is not defined then define it--->
	<cfif not isdefined('application.roundrobin.agent')>
      <cfset application.roundrobin.agent = valuelist(qagents.id)>
    </cfif>


	<!---Gets the first ID out of the list--->
	<cfset temp=listgetat(application.roundrobin.agent,1,",")>
	<!---Deletes the first ID from the list--->
    <cfset temp2=ListDeleteAt(application.roundrobin.agent, "1")>
	<!---Takes the deleted id and appends it to the rear of the list that is left--->
    <cfset application.roundrobin.agent=ListAppend(temp2,temp)>

		<cfloop list="#application.roundrobin.agent#" index="i">

  		<cfquery name="UpdateRoundRobin" datasource="#mls.dsn#">
          update  cl_agents
          set
          RoundRobinNow = '' and roundrobin = 'Yes'
    	</cfquery>

        <cfquery name="UpdateRoundRobin" datasource="#mls.dsn#">
          update  cl_agents
          set
          RoundRobinNow = 'Next'
          where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#i#"> and roundrobin = 'Yes'
        </cfquery>

      <cfbreak>
      </cfloop>


  <!---END: ROUND ROBIN BRAINS--->


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