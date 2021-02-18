<!--- THE AGENT SELECTION CODE WAS TAKEN FROM THE LIVE CBSLOANE SITE & MODIFIED FOR USE HERE --->
<!---START: NEXT AGENT ON ROTATION--->
<cfif settings.mls.EnableRoundRobin is "Yes">
  <cfif isdefined('cookie.LoggedIn')>

    <cfquery name="GetAgent" datasource="#settings.dsn#">
      select *
      from cl_agents
      where id = <cfqueryparam value="#GetAccountInfo.agentid#" cfsqltype="CF_SQL_VARCHAR">
    </cfquery>

  <cfelse>

    <cfquery name="GetAgent" datasource="#settings.dsn#" >
      SELECT * FROM cl_agents
      WHERE AgentPhoto <> ""
      AND 
          (
            firstname = <cfqueryparam value="#property.LISTING_AGENT_FIRST_NAME#" cfsqltype="CF_SQL_VARCHAR">
            AND
              (
                lastname = <cfqueryparam value="#property.LISTING_AGENT_LAST_NAME#" cfsqltype="CF_SQL_VARCHAR">
                <!--- HACK for TT-97865 --->
                OR
                lastname = substring_index(<cfqueryparam value="#property.LISTING_AGENT_LAST_NAME#" cfsqltype="CF_SQL_VARCHAR">,'-',1)
              )
          )
          OR AGENTmlsid = <cfqueryparam value="#property.LISTING_AGENT_ID#" cfsqltype="CF_SQL_VARCHAR">

      LIMIT 1
    </cfquery>

    <cfif GetAgent.Recordcount eq 0>
      <!--- See if the listing belongs to a company agent if it does, assign to them. --->
      <cfquery name="GetAgent" datasource="#settings.dsn#">
        select *
        from cl_agents
        where AgentMLSID = <cfqueryparam value="#property.LISTING_AGENT_ID#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>

      <!---if not then round robin--->
      <cfif GetAgent.Recordcount eq 0>
        <cfquery name="GetAgent" datasource="#settings.dsn#">
          select *
          from cl_agents
          where RoundRobinNow = 'Next'
          AND roundrobin = 'Yes'
        </cfquery>

        <!---Ticket 94087--->
        <!---START: ROUND ROBIN BRAINS--->
        <!---gets list of participating agents--->
        <cfquery name="qagents" datasource="#settings.dsn#">
          SELECT * FROM cl_agents
          where RoundRobin = 'Yes'
        </cfquery>

        <cfquery name="GetNextRR" datasource="#settings.dsn#">
          select *
          from cl_agents
          where RoundRobinNow = 'Next' and roundrobin = 'Yes'
        </cfquery>
        <cfset AgentID = "#GetNextRR.id#">

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

        <cfquery name="UpdateRoundRobin" datasource="#settings.dsn#">
          update  cl_agents
          set
          RoundRobinNow = ''
          where roundrobin = 'Yes'
        </cfquery>

        <cfquery name="UpdateRoundRobin" datasource="#settings.dsn#">
          update  cl_agents
          set
          RoundRobinNow = 'Next'
          where id = #nextrobinid# and roundrobin = 'Yes'
        </cfquery>
        <!---END: ROUND ROBIN BRAINS--->
        <!---Ticket 94087--->
      </cfif>
    </cfif>

  </cfif>

  <cfoutput>
  <div class="area-specialist">
    <h3>Area Specialist</h3>
    <cfif len(GetAgent.AgentPhoto)>
      <img src="/images/staff-sales/#GetAgent.AgentPhoto#">
    </cfif>

    <p>
      <strong>#GetAgent.FirstName# #GetAgent.Lastname#</strong> <cfif isdefined('cookie.LoggedIn')>is your area specialist!</cfif><br>
      <cfif len(GetAgent.title)><strong>#GetAgent.title#</strong><br></cfif>
      <cfif len(GetAgent.email)>Email: #GetAgent.email#<br></cfif>
      <cfif len(GetAgent.phone)>Office Phone: #GetAgent.phone#<br></cfif>
      <cfif len(GetAgent.cellphone)>Cell Phone: #GetAgent.cellphone#<br></cfif>
      <!--- <cfif len(GetAgent.home_phone)>Home Phone: #GetAgent.home_phone#<br></cfif> --->
      <cfif len(GetAgent.fax_number)>Fax: #GetAgent.fax_number#<br></cfif>
      <cfif len(GetAgent.website)><a href="#GetAgent.website#" target="_blank">View Website</a></cfif>
    </p>
  </div>
  </cfoutput>
  
</cfif>