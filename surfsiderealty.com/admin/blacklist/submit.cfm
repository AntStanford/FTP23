<cftry>
	<cfset table = 'black_list' />

	<cfif structKeyExists( url, 'id' ) and structKeyExists( url, 'delete' )>
		<cfquery dataSource="#settings.dsn#">
		delete
		from #table#
		where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#val( url.id )#" />
		</cfquery>

		<cflocation url="index.cfm?successdelete" addtoken="false" />
	<cfelseif structKeyExists( form, 'id' )>
		<cfquery name="updateGuest" datasource="#settings.dsn#">
		update #table#
		set firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstname#" />,
			lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastname#" />,
			email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#" />
		where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#" />
		</cfquery>

		<cflocation url="index.cfm?success" addtoken="false" />
	<cfelse>
		<cfquery name="insertGuest" datasource="#settings.dsn#">
		insert into #table#( firstname, lastname, email )
		values(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstname#" />,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastname#" />,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#" />
		)
		</cfquery>

		<cflocation url="index.cfm?success" addtoken="false" />
	</cfif>

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>