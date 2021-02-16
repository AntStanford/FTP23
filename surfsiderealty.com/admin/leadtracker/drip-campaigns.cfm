<cfinclude template="drip-campaigns_.cfm">
<cfinclude template="components/functions.cfm">

<cfinclude template="components/pagination.cfm">



<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li><h2>Drip Campaigns</h2></li>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<table class="table table-hover table-striped">

						<thead>

						<tr><td colspan="9">

							<form method="post">
								<table id="dripSearch">
									<tr>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Status</th>
										<th>Order By</th>
										<th></th>
									</tr>

									<tr>
									<cfoutput>
										<td><input type="text" name="firstname" <cfif LEN(search.firstname)>value="#search.firstname#"</cfif>></td>
										<td><input type="text" name="lastname" <cfif LEN(search.lastname)>value="#search.lastname#"</cfif>></td>
									</cfoutput>
									<td><select name="status">
											<option value="All">All
											<option <cfif LEN(search.status) and search.status eq 'Active'>selected</cfif>>Active
											<option <cfif LEN(search.status) and search.status eq 'Paused'>selected</cfif>>Paused
											<option <cfif LEN(search.status) and search.status eq 'Finished'>selected</cfif>>Finished
										</select>
									</td>
									<td><select name="sortby">
										<option value="cl_accounts.firstname ASC" <cfif LEN(search.sortby) and search.sortby eq 'cl_accounts.firstname ASC'>selected</cfif>>First Name A-Z
										<option value="cl_accounts.lastname ASC"  <cfif LEN(search.sortby) and search.sortby eq 'cl_accounts.lastname ASC'>selected</cfif>>Last Name A-Z
										<option value="drip_campaigns.DripStartDate ASC"  <cfif LEN(search.sortby) and search.sortby eq 'drip_campaigns.DripStartDate ASC'>selected</cfif>>Start Date ASC
										<option value="cl_accounts.firstname DESC"  <cfif LEN(search.sortby) and search.sortby eq 'cl_accounts.firstname DESC'>selected</cfif>>First Name Z-A
										<option value="cl_accounts.lastname DESC"  <cfif LEN(search.sortby) and search.sortby eq 'cl_accounts.lastname DESC'>selected</cfif>>Last Name Z-A
										<option value="drip_campaigns.DripStartDate DESC"  <cfif LEN(search.sortby) and search.sortby eq 'drip_campaigns.DripStartDate DESC'>selected</cfif>>Start Date DESC
									</select>
									</td>
									<td><input type="submit" value="Search"><input type="submit" value="Clear" name="Clear"></td>
									</tr>

								</table>
							</form>

						</td></tr>

							<tr>
								<th>Contact</th>
								<th>Campaign Name</th>
								<th style="width:130px;">Pause / Resume</th>
								<th style="width:130px;">Status</th>
								<th style="width:130px;">Repeat</th>
								<th style="width:130px;">Started</th>
								<th style="width:130px;">Created</th>
								<th style="width:130px;">Last Sent</th>
								<th style="width:130px;"></th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getInfo">
							<tr>
								<td><a hreflang="en" href="contact-details.cfm?id=#clientid#">#firstname# #lastname#</a></td>
								<td><a hreflang="en" href="drip-campaign-lead.cfm?campaignid=#id#&clientid=#clientid#">#planname#</a></td>
								<td><cfif LEN(DripStartDate) and LEN(Status) and Status neq 'Finished'><cfif status eq 'Active'><a hreflang="en" href="drip-campaign-lead-pause-resume.cfm?campaignid=#id#&pause=" onclick="return confirm('Are you sure you wish to pause this Campaign?')">Click to Pause</a><cfelse><a hreflang="en" href="drip-campaign-lead-pause-resume.cfm?campaignid=#id#&resume=" onclick="return confirm('Are you sure you wish to resume this Campaign?')">Click to Resume</a></cfif><cfelse>-</cfif></td>
								<td <cfif status eq 'active'>class="green"</cfif>>#status#</td> 
								<td><cfif LEN(DripStartDate)><cfif onrepeat eq '0'>Initial<cfelse>#onrepeat# of #RepeatCampaign#</cfif><cfelse>Campaign Not Started</cfif></td>
								<td><cfif LEN(DripStartDate)>#dateformat(DripStartDate, 'mmm')# #dateformat(DripStartDate, 'd')#, #dateformat(DripStartDate, 'yyyy')#<cfelse>-</cfif></td>
								<td><cfif LEN(createdat)>#dateformat(createdat, 'mmm')# #dateformat(createdat, 'd')#, #dateformat(createdat, 'yyyy')#</cfif></td>
								<td><cfif LEN(lastsent)>#dateformat(lastsent, 'mmm')# #dateformat(lastsent, 'd')#, #dateformat(lastsent, 'yyyy')#</cfif></td>
								<td><a hreflang="en" href="drip-campaign-lead.cfm?campaignid=#id#&clientid=#clientid#" class="edit">view</a></td>
							</tr>
							</cfoutput>
						</tbody>
					</table>

					<div align="center">
						<cfinclude template="components/pagination-links.cfm">
					</div>


				</div>
			</div>
		</section>

			


<script src="js/_plugins/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="js/_plugins/bootstrap.min.js"></script>
<script src="js/_plugins/bootstrap-select.js"></script>
<script>
	

$(document).ready(function(){
	$('.selectpicker').selectpicker();
	
	$('#opener').on('click', function() {  
		var panel = $('#slide-panel');
		if (panel.hasClass("visible")) {
			panel.removeClass('visible').animate({'margin-right':'-300px'});
		$('#content').css({'margin-right':'0px'});
		} else {panel.addClass('visible').animate({'margin-right':'0px'});
		$('#content').css({'margin-right':'-300px'});
	}  
	
	return false;
	});

});

</script>


<cfinclude template="components/footer.cfm">