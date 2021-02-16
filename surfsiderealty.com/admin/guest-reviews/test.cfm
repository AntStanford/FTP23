<cftry>
	<!--- call the email sender https://www.outerbanksrentals.com/eblast/guest-review/send-schedule.cfm --->
	<cfhttp url="https://www.outerbanksrentals.com/eblast/guest-review/send-schedule.cfm" />

	<cfdump var="#cfhttp#" />

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>