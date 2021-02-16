<!--- Update / Insert Scripts --->
<cfif cgi.request_method eq "post">
	<cfinclude template="contact-details-insert-update.cfm">
</cfif>


<!--- Delete Contact  --->
<cfif isdefined('url.id') and isdefined('url.deleteacct') and url.deleteacct eq 'Yes'>


	<cfquery datasource="#mls.dsn#" name="deleteContact">
		delete from cl_accounts
		where id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
		limit 1
	</cfquery>


	<div align="center">
		<p><b>Contact has been deleted.</b></p>
		<p><a hreflang="en" href="/admin/leadtracker/contact-details.cfm">Add</a> another contact.</p>
		<p><a hreflang="en" href="/admin/contacts/list-of-contacts2.cfm">Search</a> contacts.</p>
		<p><a hreflang="en" href="/admin/leadtracker/dashboard.cfm">Return</a> to dashboard.</p>
	</div>

<cfabort>

</cfif>


<cfif isdefined('url.id') and LEN(url.id)>

	<cfquery datasource="#mls.dsn#" name="getContact">
		select *
		from cl_accounts
		where id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
		limit 1
	</cfquery>



	<cfif getContact.recordcount eq 1>

		<cfset ContactExists = "yes">		

		
			<!---this was put here incase a lead made it in and was not assigned to a rep--->
			<cfif #getContact.agentid# is "">
			
				<cfquery datasource="#mls.dsn#" name="GetRRLocally">
					select *
					from cl_agents
					where roundrobin = 'Yes' and roundrobinnow = 'Next'
					limit 1
				</cfquery>				
			
				<CFQUERY NAME="UpdateQuery" DATASOURCE="#mls.dsn#">
					UPDATE cl_accounts
					SET 
					agentid = <cfqueryparam value="#GetRRLocally.id#" cfsqltype="cf_sql_integer">
					where id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfset getContact.agentid = "#GetRRLocally.id#">

			
			</cfif>

		<cfquery datasource="#mls.dsn#" name="getAgent">
			select *
			from cl_agents
			where id = <cfqueryparam value="#getContact.agentid#" cfsqltype="cf_sql_integer">
		</cfquery>

	</cfif>


	<cfquery datasource="#mls.dsn#" name="checkCampaign">
		select id,DripStartDate,status
		from drip_campaigns
		where clientid = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"> and status = <cfqueryparam value="active" cfsqltype="cf_sql_varchar">
		limit 1
	</cfquery>


	<cfif checkCampaign.recordcount eq 1>

		<cfset CompaignExists = "yes">

	</cfif>


  <cfquery datasource="#mls.dsn#" name="firstPurchase">
    SELECT datesold FROM cl_listings WHERE clientid = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"> and status='past' and datesold <> '' Order By datesold ASC limit 1
  </cfquery>

  <cfquery datasource="#mls.dsn#" name="lastPurchase">
    SELECT datesold FROM cl_listings WHERE clientid = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"> and status='past' and datesold <> '' Order By datesold DESC limit 1
  </cfquery>

</cfif>


<!--- Get Agents --->
	<cfquery datasource="#mls.dsn#" name="getAgents">
		select id,firstname,lastname
		from cl_agents
	</cfquery>



<!--- Get states --->
	<cfquery datasource="#mls.dsn#" name="getStates">
		select state,abbreviation
		from states
	</cfquery>


<!--- Get Counties --->
	<cfquery datasource="#mls.dsn#" name="getCountries">
		select id,country
		from countries
	</cfquery>

<!--- Get Ratings --->
	<cfquery datasource="#mls.dsn#" name="getRatings">
		select id,rating
		from cl_ratings
		order by rating asc
	</cfquery>


<!--- Get Statuses --->
	<cfquery datasource="#mls.dsn#" name="getStatuses">
		select id,status
		from cl_lead_statuses
	</cfquery>

<!--- Get Sources --->
	<cfquery datasource="#mls.dsn#" name="getSources">
		select id,source
		from cl_lead_sources
	</cfquery>


<cfinclude template="components/functions.cfm">