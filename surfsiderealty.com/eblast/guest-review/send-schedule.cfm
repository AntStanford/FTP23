<cftry>
	<cfparam name="quotenumberlist" default="" />
	<!--- this is for our unsubscribed folks --->
	<cfset emaillist = application.unsubobj.getUnsubscribeList( settings.id ) />
	<!---
		Get the guests that are supposed to receive the Google review email
	--->
	<cfquery name="getSendData2" datasource="#application.dsn#">
	select *
	from guest_reviews_send
	where send_google_review = 1
	and send_date is null
	</cfquery>

	<cfdump var="#getSendData2#" />

	<cfset quotenumberlist = valueList( getSendData2.quotenumber ) />

	<cfdump var="#quotenumberlist#" />
	<!---
		if we have send data, get the guests' email, name, property information
	--->
	<cfif getSendData2.recordcount gt 0>
		<cfquery name="getGuestData2" datasource="#application.dsn#">
		select stremail,strfirstname,intQuoteNum
		from pp_guestreservationinfo
		where intQuoteNum in( <cfqueryparam cfsqltype="cf_sql_integer" value="#quotenumberlist#" list="true" /> )
		</cfquery>

		<cfdump var="#getGuestData2#" />

		<!--- reviews@surfsiderealty.com --->
		<cfoutput query="getGuestData2">
			<cfif !listFindNoCase( emaillist, stremail )>
				<cfmail to="#stremail#" from="#cfmail.company# <#cfmail.username#>" subject="Review Your Experience with Surfside Realty" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML">
					<cfinclude template="5-star-stay.cfm" />
				</cfmail>
			</cfif>
		</cfoutput>
	</cfif>
	<!---
		Here we need to update the guest_reviews_send table's send_date to time of sent email
	
	<cfif listlen( quotenumberlist ) gt 0>
		<cfquery name="updateSent" datasource="#application.dsn#">
		update guest_reviews_send
		set send_date = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#" />
		where quotenumber in( <cfqueryparam cfsqltype="cf_sql_integer" value="#quotenumberlist#" /> )
		</cfquery>
	</cfif>
	--->

	<cfcatch>
		<cfmail to="cbarksdale@icoastalnet.com" from="#cfmail.company# <#cfmail.username#>" subject="Error @ Surfside Guest Review" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML">
			<cfdump var="#cfcatch#" />
		</cfmail>
	</cfcatch>
</cftry>