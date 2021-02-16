<cftry>
	<cfset page.title = "Guest Review Emails" />
	<cfset sevendays = dateformat( now() - 7, 'yyyy-mm-dd' ) />
	<cfset thirtydays = dateformat( now() - 30, 'yyyy-mm-dd' ) />
	<cfset customdate = '2018-04-15' />

	<cfparam name="url.sb" default="dtcheckoutdate desc" />
	<cfparam name="form.filterprop" default="" />
	<cfparam name="form.checkin" default="" />
	<!---
		booking history query
	--->
	<cfquery name="getBooking" datasource="#settings.dsn#">
	select *
	from pp_guestreservationinfo
	where strstatus = 'B'
	and strstaytype = 'P'
	and stremail != ''
	and dtcheckoutdate between <cfqueryparam CFSQLType="cf_sql_date" value="#customdate#"> and <cfqueryparam CFSQLType="cf_sql_date" value="#dateformat( now(), 'yyyy-mm-dd' )#">

	<cfif len( form.filterprop ) gt 0>
		and strPropID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.filterprop#" />
	</cfif>

	<cfif len( form.checkin ) gt 0 and isdate( form.checkin )>
		and dtCheckinDate = <cfqueryparam cfsqltype="cf_sql_date" value="#form.checkin#" />
	</cfif>
	
	<cfif structKeyExists( url, "sb" )>
		order by <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.sb#">
	<cfelse>
		order by dtcheckoutdate desc
	</cfif>
	</cfquery>
	<!---
		all properties query for filter drop down
	--->
	<cfquery name="getAllProperties" datasource="#settings.dsn#">
	select *
	from pp_propertyinfo
	order by strpropid asc
	</cfquery>

	<cfinclude template="/admin/components/header.cfm" />

	<cfif structKeyExists( url, "success" )>
		<div class="alert alert-success">
			<button class="close" data-dismiss="alert">x</button>
			<strong>Emails have been sent for reviews!</strong>
		</div>
	</cfif>

	<label for="sortby">Sort By
		<select name="sortby" id="sortby" style="width:200px;">
			<option value="strFirstName asc" <cfif url.sb is 'strFirstName asc'>selected="selected"</cfif> >First name A-Z</option>
			<option value="strFirstName desc" <cfif url.sb is 'strFirstName desc'>selected="selected"</cfif>>First name Z-A</option>
			<option value="strLastName asc" <cfif url.sb is 'strLastName asc'>selected="selected"</cfif>>Last name A-Z</option>
			<option value="strLastName desc" <cfif url.sb is 'strLastName desc'>selected="selected"</cfif>>Last name Z-A</option>
			<option value="dtCheckinDate asc" <cfif url.sb is 'dtCheckinDate asc'>selected="selected"</cfif>>Check-in date (asc)</option>
			<option value="dtCheckinDate desc" <cfif url.sb is 'dtCheckinDate desc'>selected="selected"</cfif>>Check-in date (desc)</option>
			<option value="dtCheckoutDate asc" <cfif url.sb is 'dtCheckoutDate asc'>selected="selected"</cfif>>Check-out date (asc)</option>
			<option value="dtCheckoutDate desc" <cfif url.sb is 'dtCheckoutDate desc'>selected="selected"</cfif>>Check-out date (desc)</option>
			<option value="intQuoteNum asc" <cfif url.sb is 'intQuoteNum asc'>selected="selected"</cfif>>Reservation number (asc)</option>
			<option value="intQuoteNum desc" <cfif url.sb is 'intQuoteNum desc'>selected="selected"</cfif>>Reservation number (desc)</option>
			<option value="strPropID asc" <cfif url.sb is 'strPropID asc'>selected="selected"</cfif>>Property (asc)</option>
			<option value="strPropID desc" <cfif url.sb is 'strPropID desc'>selected="selected"</cfif>>Property (desc)</option>
		</select>
	</label>

	<form action="" name="filterby" id="filterby" method="post">
		<label for="filterby">Filter by
			<select name="filterprop" id="filterprop" placeholder="Property" style="width:200px;">
				<option value="0" <cfif val( form.filterprop ) eq 0>selected="selected"</cfif>>Property</option>

				<cfoutput query="getAllProperties">
					<option value="#strpropid#" <cfif form.filterprop is strpropid>selected="selected"</cfif>>#strname#</option>
				</cfoutput>
			</select>

			<cfoutput><input type="text" class="datepicker hasDatePicker" name="checkin" id="start-date" value="#form.checkin#" placeholder="Check in Date" /></cfoutput>
			<input type="submit" name="filterby" id="filterby" class="btn btn-info" value="Filter" />
			<button class="btn btn-success" id="clearfilter">Clear Filters</button>
		</label>
	</form>

	<div class="widget-box">
		<div class="widget-content nopadding">

			<form name="reviewform" id="reviewform" action="submit.cfm" method="post">

				<div style="margin:5px;float:right;">
					<input type="submit" id="reviewsub" name="reviewsub" value="Send" />
				</div>
			
			<table class="table table-bordered table-striped">
				<tr>
					<th width="30">No.</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Arrival</th>
					<th>Departure</th>
					<th>Reservation Number</th>
					<th>Property Name</th>
					<th>Send Google Review</th>
					<!---<th>Send Property Review ECI</th>
					<th>Send Property Review PreRes</th>--->
				</tr>

				<cfoutput query="getBooking">
					<!---
						booking history doesn't store property name (only address)
						so we query for it
					--->
					<cfquery name="getPropertyName" datasource="#settings.dsn#">
					select strAddress1 
					from pp_propertyinfo 
					<!---where strpropid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#strPropID#" /> --->
					where strpropid rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#strPropID#" />
					</cfquery>
					<!---
						if the quote number exists in the table
						that records emails sent (guest_reviews_send)
						disable the checkboxes where applicable
					--->
					<cfquery name="hasSent" datasource="#settings.dsn#">
					select *
					from guest_reviews_send
					where quotenumber = <cfqueryparam cfsqltype="cf_sql_integer" value="#intQuoteNum#" />
					</cfquery>

					<input type="hidden" name="quotenum" value="#intQuoteNum#" />

					<tr>
						<td>#currentrow#</td>
						<td>#strFirstName#</td>
						<td>#strLastName#</td>
						<td>#strEmail#</td>
						<td>#dateformat( dtCheckinDate, 'mm/dd/yyyy' )#</td>
						<td>#dateformat( dtCheckoutDate, 'mm/dd/yyyy' )#</td>
						<td>#intQuoteNum#</td>
						<td>
							<cfif len( getPropertyName.strAddress1 )>
								#getPropertyName.strAddress1#
							<cfelse>
								#strAddress1#
							</cfif>
						</td>
						<td>
							<input type="checkbox" name="send_google_review" value="#intQuoteNum#" <cfif hasSent.send_google_review eq 1>disabled</cfif> />
						</td>
						<!---<td>
							<input type="checkbox" name="send_property_review" value="#intQuoteNum#" <cfif hasSent.send_property_review eq 1>disabled</cfif> />
						</td>
						<td>
							<input type="checkbox" name="send_property_preres" value="#intQuoteNum#" <cfif hasSent.send_property_preres eq 1>disabled</cfif> />
						</td>--->
					</tr>
				</cfoutput>
			</table>

			<div style="margin:5px;float:right;">
				<input type="submit" id="reviewsub" name="reviewsub" value="Send" />
			</div>

			</form>
		</div>
	</div>

	<script type="text/javascript">
	$(document).ready(function(){
		$('#sortby').change(function(){
			var sb = $(this).val();

			window.location.href = '?sb='+sb;
		});

		$('#clearfilter').click(function(e){
			e.preventDefault();
			window.location.href = 'index.cfm';
		});
	});
	</script>

	<cfinclude template="/admin/components/footer.cfm" />

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>