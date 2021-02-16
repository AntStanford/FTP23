<!--- COUNT FOR WAITING ON AGENT  cachedwithin="#CreateTimeSpan(0, 0, 1, 0)#" --->

<!---  <cfquery datasource="#mls.dsn#" name="WaitingAgent">
  Select clientid,createdat,id
  FROM cl_leadtracker_response
  WHERE cl_leadtracker_response.FromOrTo = "Waiting on Agent's Response"
    <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
        and cl_leadtracker_response.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
      </cfif>
  Order by id DESC
  LIMIT 50
</cfquery> --->
 <cfquery datasource="#mls.dsn#" name="WaitingAgent">
      Select cl_leadtracker_response.clientid,cl_leadtracker_response.createdat,cl_leadtracker_response.id,cl_accounts.id as acctid,cl_accounts.agentid as acctagent
      FROM cl_leadtracker_response
      LEFT JOIN cl_accounts
      ON cl_leadtracker_response.clientid = cl_accounts.id
      WHERE cl_leadtracker_response.FromOrTo = "Waiting on Agent's Response"
           <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
            and cl_leadtracker_response.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
            and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
          </cfif>
      Order by id DESC
      LIMIT 50  
</cfquery>

<cfset clientlist = '~'>
<cfset agentcounter = '0'>

<cfoutput query="WaitingAgent">

  <cfif ListFind(clientlist, clientid) eq 0>
    <cfset clientlist = clientlist & "," & clientid>

    <CFQUERY DATASOURCE="#mls.dsn#" NAME="GetLastContact">
      SELECT FromOrTo
      FROM cl_leadtracker_response
      where clientid = '#clientid#'
    <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
        and cl_leadtracker_response.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
      </cfif>
      order by createdat desc
      limit 1
    </CFQUERY>



    <CFQUERY DATASOURCE="#mls.dsn#" NAME="CheckAcct">
      SELECT id
      FROM cl_accounts
      where id = '#clientid#'
    </CFQUERY>

    <cfif GetLastContact.FromOrTo eq "Waiting on Agent's Response" and CheckAcct.recordcount gt 0>

      <cfset agentcounter = agentcounter + 1>
    </cfif>

  </cfif>

</cfoutput>



<!--- COUNT FOR WAITING ON Customer cachedwithin="#CreateTimeSpan(0, 0, 3, 0)#" --->

<cfquery datasource="#mls.dsn#" name="WaitingCust" >
  SELECT DISTINCT clientid,cl_leadtracker_response.FromOrTo,cl_accounts.thedate as thedate,cl_accounts.firstname,cl_accounts.lastname,cl_accounts.email,cl_accounts.CAMEFROMWEBSITE as site,cl_accounts.address,cl_accounts.address2,cl_accounts.city,cl_accounts.state,cl_accounts.zip,cl_accounts.phone,cl_accounts.agentid,cl_accounts.id as theid,cl_accounts.leadstatus as leadstatus, cl_leadtracker_response.createdat as responsedate,cl_accounts.PPCsignup as PPCsignup,cl_accounts.thedate as acctcreated, cl_accounts.rating as rating
  FROM cl_leadtracker_response
  INNER JOIN cl_accounts 
  ON cl_leadtracker_response.clientid=cl_accounts.id
  WHERE cl_leadtracker_response.FromOrTo = "Waiting on Customer's Response"
       <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
        and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
      </cfif>
  Order by cl_leadtracker_response.createdat DESC
  LIMIT 50
</cfquery> 

<!--- GET THE ACTUAL COUNT OF WAITING ON RESPONSE --->
<cfset contactcounter  = 0>
<cfoutput query="WaitingCust">

<CFQUERY DATASOURCE="#mls.dsn#" NAME="GetLastContact">
  SELECT FromOrTo
  FROM cl_leadtracker_response
  where clientid = '#clientid#'
     <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
        and cl_leadtracker_response.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
      </cfif>
  order by createdat desc
  limit 1
</CFQUERY>

<cfif GetLastContact.FromOrTo is "Waiting on Customer's Response">
  <cfset contactcounter  = 1 + contactcounter>
</cfif>

</cfoutput>

