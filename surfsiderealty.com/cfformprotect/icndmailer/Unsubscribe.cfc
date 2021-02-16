<cfcomponent displayname="Unsubscribe">
	<!---
		Any changes to this file must also be made on the production server cfformprotect/icndmailer/Unsubscribe.cfc
	--->
	<cffunction name="isUnsubscribed" returntype="boolean">
		<cfargument name="guestemail" required="true" type="string" default="" />
		<cfargument name="siteid" required="true" type="numeric" default="0" />

		<cftry>
			<!---
				this method checks if a guest has already unsubbed from this client (siteid)
				if so, return true
			--->
			<cfset var hasunsubbed = false />

			<cfquery name="unsubCheck" datasource="booking_clients">
			select *
			from unsubscribe
			where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.guestemail#" />
			and siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.siteid#" />
			</cfquery>

			<cfif unsubCheck.recordcount gt 0>
				<cfset hasunsubbed = true />
			</cfif>

			<cfcatch>

			</cfcatch>
		</cftry>

		<cfreturn hasunsubbed />
	</cffunction>

	<cffunction name="setUnsubscribe" returntype="boolean">
		<cfargument name="guestemail" required="true" type="string" default="" />
		<cfargument name="siteid" required="true" type="numeric" default="0" />

		<cftry>
			<cfset var isadded = false />

			<cftransaction action="begin" />

			<cfquery name="addUnusb" datasource="booking_clients">
			insert into unsubscribe( siteid, email )
			values(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.siteid#" />,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.guestemail#" />
			)
			</cfquery>

			<cftransaction action="commit" />

			<cfset isadded = true />

			<cfcatch>
				<cftransaction action="rollback" />

				<cfset isadded = false />
			</cfcatch>
		</cftry>

		<cfreturn isadded />
	</cffunction>

	<cffunction name="getUnsubscribeList" returntype="any">
		<cfargument name="siteid" required="true" type="numeric" default="0" />

		<cftry>
			<!--- get a list of email addresses from the unsubscribe table for this siteid --->
			<cfset var emaillist = "" />

			<cfquery name="getEmailList" datasource="booking_clients">
			select *
			from unsubscribe
			where siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.siteid#" />
			</cfquery>

			<cfset emaillist = valuelist( getEmailList.email ) />

			<cfcatch>
			</cfcatch>
		</cftry>

		<cfreturn emaillist />
	</cffunction>
</cfcomponent>