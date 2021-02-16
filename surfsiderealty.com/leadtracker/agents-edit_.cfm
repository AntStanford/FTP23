<!--- UPDATE --->
<cfif isdefined('url.id') and LEN(url.id) and cgi.request_method eq 'Post'>

<!--- <cfif form.primary is "No">

	<cfquery datasource="#mls.dsn#" name="AnyPrimaries">
		select *
		from cl_agents
		where `primary` = 'Yes'
	</cfquery>
	
	<cfif AnyPrimaries.recordcount lte 1>
		<cfinclude template="components/header.cfm">
		<cfinclude template="components/navigation.cfm">
		<p>You must have at least one primary agent!</p>
		<p>This agent is responsible for receiving all leads and distributing them.</p>	
		<p>Please <a hreflang="en" href="javascript: window.history.go(-1)">GO BACK </a>and leave this lead as the primary or go select another agent as the primary.</p>
		<cfinclude template="components/footer.cfm">
	<Cfabort>
	</cfif>

</cfif> --->

	<!--- <cfif form.primary is "Yes">
		<CFQUERY DATASOURCE="#mls.dsn#" NAME="CheckPrimary">
			UPDATE cl_agents
			set
			`primary` = 'No'
		</CFQUERY>
	</cfif> --->

		<cfinclude template = "agents_upload.cfm">

	<cfquery datasource="#mls.dsn#">
		UPDATE cl_agents
		SET 
		firstname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#firstname#">,
		lastname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lastname#">,
		email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#email#">,
		Phone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Phone#">,
		cellphone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cellphone#">,
		AgentMLSID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AgentMLSID#">,
		website = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#website#">,
		biography = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#biography#">,
			roundrobin = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#roundrobin#">,
			<!--- `primary` = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#primary#">, --->
		password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#password#">,
		notifications_acct = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#notifications_acct#">,
		notifications_login = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#notifications_login#">
		<cfif #Len(form.AgentPhoto)#>,AgentPhoto = '#myfile#'</cfif>
		,AgentEmailSignature = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#AgentEmailSignature#">
		,title = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#title#">
		where id = '#id#'
	</cfquery>


<cfelseif cgi.request_method eq 'post' and NOT parameterexists(url.id)>


	<!--- <cfif form.primary is "Yes">
		<CFQUERY DATASOURCE="#mls.dsn#" NAME="CheckPrimary">
			UPDATE cl_agents
			set
			`primary` = 'No'
		</CFQUERY>
	</cfif> --->
	
	<cfinclude template = "agents_upload.cfm">

	<cfquery datasource="#mls.dsn#">
		INSERT INTO cl_agents (firstname, lastname, email, Phone, cellphone, AgentMLSID, website, biography,roundrobin,<!--- `primary`, --->password,AgentPhoto,AgentEmailSignature,title,notifications_acct,notifications_login) 
		VALUES(
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#firstname#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lastname#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#email#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Phone#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cellphone#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AgentMLSID#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#website#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#biography#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#roundrobin#">,
		<!--- <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#primary#">, --->
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#password#">,
		'#myfile#',
		<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#AgentEmailSignature#">,
		<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#title#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#notifications_acct#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#notifications_login#">
		)
	</cfquery>

	<cfquery datasource="#mls.dsn#" name="getMax">
		select Max(id) as lastAgent
		from cl_agents
		limit 1
	</cfquery>

	<cfoutput><cflocation addtoken="false" url="agents-edit.cfm?id=#getMax.lastAgent#"></cfoutput>

</cfif>


 <!--- Get Agent --->
 <cfif isdefined('url.id') and LEN(url.id)>
	<cfquery datasource="#mls.dsn#" name="getInfo">
		select *
		from cl_agents
		Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
		Limit 1
	</cfquery>
</cfif>