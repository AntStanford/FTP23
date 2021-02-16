<cftry>



<!---START: Check ClientID and PlanID to continue --->
<cfif isdefined('url.clientid') is "No" or isdefined('url.clientid') and LEN(url.clientid) is '0'>
	A Client  must be selected.
	<cfabort>
</cfif>
<!--- END: Check ClientID and PlanID to continue --->


<!--- See if Lead has a eAlert set up - this will determine which plan they get --->
<cfquery datasource="#mls.dsn#" name="checkAlerts">
	Select Count(id) as thecount
	From cl_saved_searches
	Where clientid = <cfqueryparam value="#url.clientid#" cfsqltype="cf_sql_integer"> and howoften <> <cfqueryparam value="0" cfsqltype="cf_sql_integer"> and howoften <> ''
		 and NextNotificationDate <> '' and NextNotificationDate >= <cfqueryparam value="#dateformat(now())#" cfsqltype="cf_sql_date">
</cfquery>

<!--- 1 is General, 2 is for eAlerts --->
<cfparam name="planid" default="1">

<cfoutput>
<cfif checkAlerts.thecount eq 0>
	<cfset planid = 1>
<cfelse>
	<cfset planid = 2>
</cfif>

<!--- Get Default Plan --->
<cfquery datasource="#mls.dsn#" name="getDefaultPlan">
	Select Lib_PlanID
	From drip_library
	Where Lib_Default = <cfqueryparam value="#planid#" cfsqltype="cf_sql_integer">
	limit 1
</cfquery>



<cfif getDefaultPlan.recordcount gt 0 and NOT isdefined('url.noredirect')>
	<cflocation url="drip-campaign-lead-create-from-library.cfm?clientid=#url.clientid#&planid=#getDefaultPlan.Lib_PlanID#&AutoStart=1" addtoken="false">

<cfelseif getDefaultPlan.recordcount gt 0 and isdefined('url.noredirect')>

	<!--- Drip Campaign Initiated. <a hreflang="en" href='drip-campaign-lead-create-from-library.cfm?clientid=#url.clientid#&planid=#getDefaultPlan.Lib_PlanID#&AutoStart=1' target="_new">Click here</a> to Verify and Start the campaign. --->
clientid=#url.clientid#&planid=#getDefaultPlan.Lib_PlanID#&AutoStart=1
<cfelse>

There is no default campaign plan set up for the Auto Start feature to work.

</cfif>


</cfoutput>


<!--- <cfdump var="#checkAlerts#">
 --->


<cfcatch>

<cfmail to="matt.crouch@gmail.com" from="#cfmail.username#" subject="HHH- Autostart Drip Fail" type="html" username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#">
#cfcatch.message#
</cfmail>

</cfcatch>
</cftry>

<!--- 
<cfmail to="matt.crouch@gmail.com" from="#cfmail.username#" subject="HHH- Autostart Drip " type="html" username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#">
This ran<cfdump var="#url#">
</cfmail>

 --->