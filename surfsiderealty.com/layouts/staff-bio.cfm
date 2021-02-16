<cfinclude template="/components/header.cfm">
<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">

			<style>
				.staff-detail p {text-align: left !important;}
				.staff-detail .notfound {text-align: center !important; margin-top: 40%;}
			</style>

			<div class="staff-detail-int">
				<div>
					<cfif isdefined('url.id') and LEN(url.id)>
						<cfquery NAME="getBio" DATASOURCE="#settings.dsn#">
							SELECT name,description,photo
							FROM cms_staff
							Where id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
						</cfquery>

						<cfif getBio.recordcount eq 1>

							<cfoutput query="getBio">
								<cfif LEN(description)>
									<cfif LEN(photo)>
										<img border="0" src="/images/staff/#photo#">
									<cfelse>
										<img border="0" src="http://placehold.it/200x150&text=Placeholder">
									</cfif>
									<h4>#name#</h4>
									#description#
									<cfelse>
									<p class="notfound">There is no bio for #name# yet.</p>
								</cfif>
							</cfoutput>

						<cfelse>
							<p class="notfound">Sorry, information for this Staff member cannot be found.</p>
						</cfif>
					<cfelse>
						<p class="notfound">Sorry, information for this Staff member cannot be found.</p>
					</cfif>

				</div>
			</div>

		</div>
	</div>
</div>
<cfinclude template="/components/footer.cfm">