<cftry>
	<cfif structKeyExists( form, "reviewsub" )>
		<cfparam name="form.send_google_review" default="" />
		<cfparam name="form.send_property_review" default="" />
		<cfparam name="form.send_property_preres" default="" />

		<cfset quotearray = listtoarray( form.quotenum ) />
		<cfset success = false />

		<cfif len( form.send_google_review ) gt 0 or len( form.send_property_review ) gt 0 or len( form.send_property_preres ) gt 0>
			<cfloop from="1" to="#arraylen( quotearray )#" index="i">
				<cfif listfind( form.send_google_review, quotearray[i] ) or listfind( form.send_property_review, quotearray[i] ) or listfind( form.send_property_preres, quotearray[i] )>
					<cftry>
						<cftransaction action="begin" />

						<cfquery name="addQuotes" datasource="#settings.dsn#">
						insert into guest_reviews_send( 
							quotenumber
							<cfif len( form.send_google_review ) gt 0>,send_google_review</cfif>
							<cfif len( form.send_property_review ) gt 0>,send_property_review</cfif>
							<cfif len( form.send_property_preres ) gt 0>,send_property_preres</cfif>
						)
						values(
							<cfqueryparam cfsqltype="cf_sql_integer" value="#quotearray[i]#" />
							
							<cfif len( form.send_google_review ) gt 0>
								<cfif listfind( form.send_google_review, quotearray[i] )>
									,<cfqueryparam cfsqltype="cf_sql_integer" value="1" />
								<cfelse>
									,<cfqueryparam cfsqltype="cf_sql_integer" value="0" />
								</cfif>
							</cfif>

							<cfif len( form.send_property_review ) gt 0>
								<cfif listfind( form.send_property_review, quotearray[i] )>
									,<cfqueryparam cfsqltype="cf_sql_integer" value="1" />
								<cfelse>
									,<cfqueryparam cfsqltype="cf_sql_integer" value="0" />
								</cfif>
							</cfif>

							<cfif len( form.send_property_preres ) gt 0>
								<cfif listfind( form.send_property_preres, quotearray[i] )>
									,<cfqueryparam cfsqltype="cf_sql_integer" value="1" />
								<cfelse>
									,<cfqueryparam cfsqltype="cf_sql_integer" value="0" />
								</cfif>
							</cfif>
						)
						</cfquery>

						<cftransaction action="commit" />
						<cfset success = true />

						<cfcatch>
							<cftransaction action="rollback" />

							<cfset success = false />

							<cfdump var="#cfcatch#" abort="true" />
						</cfcatch>

					</cftry>
				</cfif>
			</cfloop>
		</cfif>

		<cfif success>
			<!---<cfhttp url="https://www.surfsiderealty.com/eblast/guest-review/send-schedule.cfm" />--->
			
			<cflocation url="index.cfm?success" addtoken="false" />
		</cfif>

	</cfif>

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>