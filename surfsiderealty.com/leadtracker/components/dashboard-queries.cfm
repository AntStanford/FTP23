<!--- Set Query Cache Time --->
<cfparam name="tracker.cacheTime" default="2" type="integer">
<cfif isdefined('url.cache')>
	<!--- Clear Query Cache Time --->
	<cfset tracker.cacheTime = 0>
</cfif>


<cfoutput>
	
<cfif session.tracker.mainqry eq "recentAct">

<!--- 	<h1>Recent Activity - #url.status#</h1> --->

	<!--- Get Recent Activity cachedwithin="#CreateTimeSpan(0, 0, tracker.cacheTime, 0)#" --->
		<!--- Added Group By ID  - 1/2/15  group by cl_accounts.id --->
	<cfquery datasource="#mls.dsn#" name="getInfo">  
		select cl_activity.clientId,cl_activity.action,cl_activity.createdAt,
		cl_accounts.firstname,cl_accounts.lastname,cl_accounts.phone,cl_accounts.camefromwebsite,cl_accounts.rating,
		cl_agents.firstname as agentFName,cl_agents.lastname as agentLName,cl_agents.id,cl_accounts.thedate
		from cl_activity
		Left Join cl_accounts on cl_activity.clientId = cl_accounts.id
		Left Join cl_agents on cl_accounts.agentid = cl_agents.id
		Where 1=1

		and cl_accounts.id <> ''

		<cfif isdefined('tracker.rating') and LEN(tracker.rating) and (tracker.rating neq 0 and tracker.rating neq 'Qualify' and tracker.rating neq 'New')>
			and cl_accounts.rating = <cfqueryparam value="#tracker.rating#" cfsqltype="cf_sql_varchar">
		<cfelseif isdefined('tracker.rating') and LEN(tracker.rating) and tracker.rating eq 'Qualify'>
		 	and (cl_accounts.rating is NUll or cl_accounts.rating = <cfqueryparam value="12" cfsqltype="cf_sql_integer">)
		<cfelseif isdefined('tracker.rating') and LEN(tracker.rating) and tracker.rating eq 'New'>
		 	and cl_accounts.thedate >= '#DateFormat(QualifyNewDate, "yyyy-mm-dd hh:mm:ss")#'
		</cfif>

	     <cfif isdefined('session.loggedInUserStruct.LoggedInAgentID')>
	        and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.loggedInUserStruct.LoggedInAgentID#">
	      </cfif>

		order by cl_activity.createdAt DESC
		limit 500
	</cfquery>

<cfelseif session.tracker.mainqry eq "searchAct">

	<!--- Get Recent Activity  cachedwithin="#CreateTimeSpan(0, 0, tracker.cacheTime, 0)#" --->
		<!--- Added Group By ID  - 1/2/15  group by cl_accounts.id --->
	<cfquery datasource="#mls.dsn#" name="getInfo">
		select cl_saved_searches.clientId,cl_saved_searches.createdAt,
		cl_accounts.firstname,cl_accounts.lastname,cl_accounts.phone,cl_accounts.camefromwebsite,cl_accounts.rating,
		cl_agents.firstname as agentFName,cl_agents.lastname as agentLName,cl_agents.id,cl_accounts.thedate
		from cl_saved_searches
		Left Join cl_accounts on cl_saved_searches.clientId = cl_accounts.id
		Left Join cl_agents on cl_accounts.agentid = cl_agents.id
		where cl_saved_searches.clientid <> <cfqueryparam value="" cfsqltype="cf_sql_varchar">

		<cfif isdefined('tracker.rating') and LEN(tracker.rating) and (tracker.rating neq 0 and tracker.rating neq 'Qualify' and tracker.rating neq 'New')>
			and cl_accounts.rating = <cfqueryparam value="#tracker.rating#" cfsqltype="cf_sql_varchar">
		<cfelseif isdefined('tracker.rating') and LEN(tracker.rating) and tracker.rating eq 'Qualify'>
		 	and (cl_accounts.rating is NUll or cl_accounts.rating = <cfqueryparam value="12" cfsqltype="cf_sql_integer">)
		<cfelseif isdefined('tracker.rating') and LEN(tracker.rating) and tracker.rating eq 'New'>
		 	and cl_accounts.thedate >= '#DateFormat(QualifyNewDate, "yyyy-mm-dd hh:mm:ss")#'
		</cfif>

	     <cfif isdefined('session.loggedInUserStruct.LoggedInAgentID')>
	        and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.loggedInUserStruct.LoggedInAgentID#">
	      </cfif>
	      

		order by cl_saved_searches.createdAt DESC
		limit 500
	</cfquery>

	<cfset action = 'Search'>

<cfelseif session.tracker.mainqry eq "AgentResp">
<!--- cachedwithin="#CreateTimeSpan(0, 0, 1, 0)#" --->
		<cfquery datasource="#mls.dsn#" name="getInfo" >
		  Select cl_leadtracker_response.clientid,cl_leadtracker_response.createdat,cl_leadtracker_response.id,cl_accounts.id as acctid,cl_accounts.agentid as acctagent
		  FROM cl_leadtracker_response
		  LEFT JOIN cl_accounts
		  ON cl_leadtracker_response.clientid = cl_accounts.id
		  WHERE cl_leadtracker_response.FromOrTo = "Waiting on Agent's Response"
	     	<cfif isdefined('session.loggedInUserStruct.LoggedInAgentID')>
		        and cl_leadtracker_response.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.loggedInUserStruct.LoggedInAgentID#">
		        and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.loggedInUserStruct.LoggedInAgentID#">
		      </cfif>
		  Order by id DESC
		  LIMIT 50  
		</cfquery>

 
<cfelseif session.tracker.mainqry eq "CustResp">

	<!--- in components/dashboard-counter.cfm --->

	
<!--- 	<cfquery datasource="#mls.dsn#" name="getInfo" cachedwithin="#CreateTimeSpan(0, 0, 3, 0)#">
	  SELECT DISTINCT clientid,cl_leadtracker_response.FromOrTo,cl_accounts.thedate as thedate,cl_accounts.firstname,cl_accounts.lastname,cl_accounts.email,cl_accounts.CAMEFROMWEBSITE as site,cl_accounts.address,cl_accounts.address2,cl_accounts.city,cl_accounts.state,cl_accounts.zip,cl_accounts.phone,cl_accounts.agentid,cl_accounts.id as theid,cl_accounts.leadstatus as leadstatus, cl_leadtracker_response.createdat as responsedate,cl_accounts.PPCsignup as PPCsignup,cl_accounts.thedate as acctcreated
	  FROM cl_leadtracker_response
	  INNER JOIN cl_accounts 
	  ON cl_leadtracker_response.clientid=cl_accounts.id
	  WHERE cl_leadtracker_response.FromOrTo = "Waiting on Customer's Response"
	     <cfif isdefined('session.loggedInUserStruct.LoggedInAgentID') and (session.loggedInUserStruct.LoggedInAgentID neq "9" or  session.loggedInUserStruct.LoggedInAgentID neq "50")>
	        and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.loggedInUserStruct.LoggedInAgentID#">
	      </cfif>
	  Order by cl_leadtracker_response.createdat DESC
	</cfquery>  --->


<cfelseif session.tracker.mainqry eq "RecentLeads">

	<cfquery datasource="#mls.dsn#" name="getInfo">  
		select cl_activity.clientId,cl_activity.action,cl_activity.createdAt,
		cl_accounts.firstname,cl_accounts.lastname,cl_accounts.phone,cl_accounts.camefromwebsite,cl_accounts.rating,
		cl_agents.firstname as agentFName,cl_agents.lastname as agentLName,cl_agents.id,cl_accounts.thedate
		from cl_activity
		Left Join cl_accounts on cl_activity.clientId = cl_accounts.id
		Left Join cl_agents on cl_accounts.agentid = cl_agents.id
		Where 1=1

		and cl_accounts.id <> ''

		<cfif isdefined('tracker.rating') and LEN(tracker.rating) and (tracker.rating neq 0 and tracker.rating neq 'Qualify' and tracker.rating neq 'New')>
			and cl_accounts.rating = <cfqueryparam value="#tracker.rating#" cfsqltype="cf_sql_varchar">
		<cfelseif isdefined('tracker.rating') and LEN(tracker.rating) and tracker.rating eq 'Qualify'>
		 	and (cl_accounts.rating is NUll or cl_accounts.rating = <cfqueryparam value="12" cfsqltype="cf_sql_integer">)
		<cfelseif isdefined('tracker.rating') and LEN(tracker.rating) and tracker.rating eq 'New'>
		 	and cl_accounts.thedate >= '#DateFormat(QualifyNewDate, "yyyy-mm-dd hh:mm:ss")#'
		</cfif>

	     <cfif isdefined('session.loggedInUserStruct.LoggedInAgentID')>
	        and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.loggedInUserStruct.LoggedInAgentID#">
	      </cfif>

		order by cl_activity.createdAt DESC
		limit 500
	</cfquery>



<!--- Create a list with duplicate values. --->
<cfset strList = ValueList(getInfo.clientid)>
<!---
    Create an look up index. This is a struct whose only
    purpose is to provide a fast key-lookup for existing values.
--->
<cfset objExistingKeys = {} />
<!---
    We are going to create a new array to hold our "new" list
    values. This will be our ordered copy of the list with only
    unique values.
--->
<cfset arrNewList = [] />
<!---
    Now, let's loop over the existing list and build our new
    list IN ORDER with only unique values.
--->
<cfloop index="strItem"  list="#strList#"  delimiters=",">
    <!--- Check to see if this item has been used already. --->
    <cfif NOT StructKeyExists( objExistingKeys, strItem )>
        <!---
            This list item is not a key in our look up index
            which means that it has NOT been used in our new
            list yet. Let's add it to our new list array.
        --->
        <cfset ArrayAppend( arrNewList, strItem ) />
        <!---
            Add the item to our look up index so that we don't
            use it again on further loop iterations.
        --->
        <cfset objExistingKeys[ strItem ] = true />
    </cfif>
</cfloop>
<!---
    Now that we have copied over all the unique values in
    order to our new list, let's collaps the array down into
    a string list.
--->
<cfset strNewList = ArrayToList( arrNewList ) />
<!--- Create the count for pagination --->
<cfset RecentLeadCounter = ListLen(strNewList)>


</cfif>

</cfoutput>

