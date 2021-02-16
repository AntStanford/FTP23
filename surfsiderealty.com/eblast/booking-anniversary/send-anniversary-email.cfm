<cftry>
	<cfquery name="getClientSettings" dataSource="booking_clients">
	select *
	from settings
	where dsn = 'surfsiderealty2018'
	</cfquery>

	<cfdump var="#getClientSettings#" />

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>