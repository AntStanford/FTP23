<cfparam name="url.clientaction" default="none">
<cfparam name="clientid" default="0">
<cfparam name="action" default="none">
<cfset errormsg = "An error has occurred.">

<cfoutput>

	<!--- The select option value should be passing the Client ID and action chosen --->
	<cfif ListLen(url.clientaction, '~') eq 2>

		<!--- Set Client and Action from URL PARAM --->
		<cfset clientid = ListGetAt(url.clientaction, 1, '~')>
		<cfset action = ListGetAt(url.clientaction, 2, '~')>

		<!--- If action is not none or start drip, update its rating --->
		<cfif LEN(action) and action neq 'none' and action neq 'startdrip'>

			<!--- Get matching rating --->
			<cfquery datasource="#mls.dsn#" name="getRating">
				select id 
				from cl_ratings
				where rating LIKE <cfqueryparam value="%#action#%" cfsqltype="cf_sql_varchar">
			</cfquery>

					<cfif getRating.recordcount gt 0 and clientid neq 0>

					<!--- Get matching rating --->
					<cfquery datasource="#mls.dsn#" name="getClient">
						select firstname,lastname 
						from cl_accounts
						Where id = <cfqueryparam value="#clientid#" cfsqltype="cf_sql_integer">
						limit 1
					</cfquery>

					<!--- update client rating --->
					<cfquery datasource="#mls.dsn#" name="updateRating">
						Update cl_accounts
						Set Rating = <cfqueryparam value="#getRating.id#" cfsqltype="cf_sql_varchar">
						Where id = <cfqueryparam value="#clientid#" cfsqltype="cf_sql_integer">
						limit 1
					</cfquery>
					
					<!--- Display action to user --->
				#capFirstTitle(getClient.firstname)# #capFirstTitle(getClient.lastname)# rating has been changed to #capFirstTitle(action)#. 

				<cfelse>
					#errormsg#
				</cfif>
				


				

		<cfelseif action eq 'startdrip'>

			<!--- Start Drip not functional. --->

			<cfhttp url = "http://www.hiltonheadhomes.com/admin/leadtracker/drip-campaign-lead-autostart.cfm" method="post" throwonerror="true">
		      <cfhttpparam type="url" name="clientid" value="#clientid#"></cfhttpparam>
		       <cfhttpparam type="url" name="noredirect" value="yes"></cfhttpparam>
		    </cfhttp>

		   <!---  <cfdump var="#cfhttp#"> --->
			<cfif cfhttp.statuscode contains '200' and cfhttp.text eq 'yes'>
				Drip Campaign Initiated. <a hreflang="en" href='drip-campaign-lead-create-from-library.cfm?#Trim(cfhttp.filecontent)#' target="_blank" style="color:white;text-decoration:underline;">Click here</a> to Verify and Start the campaign.
			</cfif>


		<cfelse>
			#errormsg#
		</cfif>

	<cfelse>
		#errormsg#
	</cfif>

</cfoutput>




<!--- 
<cfquery datasource="#mls.dsn#" name="getInfo"> --->