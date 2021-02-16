<cftry>

	<cfset page.title = "Reservation Addons" />

	<cfquery name="getinfo" dataSource="#settings.dsn#">
	select cra.*,cca.*
	from cms_reservation_addons cra
	join cms_checkout_addons cca on cca.id = cra.addonid
	order by cra.createdate desc
	</cfquery>

	<cfinclude template="/admin/components/header.cfm" />

	<p>
		<a href="/admin/addons" class="btn btn-success">Back to Add-ons</a>
	</p>

	<cfif getinfo.recordcount gt 0>
		<div class="widget-box">
			<div class="widget-content nopadding">
				<table class="table table-bordered table-striped">
					<tr>
						<th width="30">No.</th>
						<th>Reservation Number</th>
						<th>Date</th>
						<th>Add-on (count)</th>
						<th>Add-on Total</th>
					</tr>

					<cfoutput query="getinfo">
						<tr>
							<td>#currentrow#.</td>
							<td>#reservationid#</td>
							<td>#dateformat( createdate,'mm/dd/yyyy' )#</td>
							<td>#title# (#addoncount#)</td>
							<td>#dollarFormat( totalamount )#</td>
						</tr>
					</cfoutput>
				</table>
			</div>
		</div>
	</cfif>

	<cfinclude template="/admin/components/footer.cfm" />

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>