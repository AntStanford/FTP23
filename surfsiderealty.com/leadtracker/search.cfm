<cfinclude template="search_.cfm">
<cfinclude template="components/functions.cfm">
<cfinclude template="components/pagination.cfm">
<cfinclude template="components/header.cfm">
<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2>Contact Search</h2></li>
						<li class="headlinks"><a hreflang="en" href="contact-details.cfm">Add New Contact</a></li>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<table class="table table-hover table-striped">

						<thead>

						<tr><td colspan="4">
							<cfoutput>
							<form method="post" action="search.cfm">
								<table id="dripSearch">



									<tr>
										<th>Date Type</th>
										<th>Start Date</th>
										<th>End Date</th>
										<th></th>
										<th></th>
									</tr>
									<tr>
										<td>
											<select name="datesearch">
												<option value="profile" <cfif session.datesearch eq 'profile'>selected</cfif>>Acct Created
												<option value="search" <cfif session.datesearch eq 'search'>selected</cfif>>Date of Lead Search
												<option value="email" <cfif session.datesearch eq 'email'>selected</cfif>>Email Search
											</select>
										</td>
										<td><input type="text" name="startdate" <cfif LEN(session.startdate)>value="#session.startdate#"</cfif>></td>
										<td><input type="text" name="enddate" <cfif LEN(session.enddate)>value="#session.enddate#"</cfif>></td>
										<td></td>
										<td></td>
									</tr>

								<tr><td colspan="5"><hr></td></tr>

									<tr>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Email</th>
										<th>Agent</th>
										<th>Rating</th>
									</tr>
									<tr>
										<td><input type="text" name="firstname" <cfif LEN(session.firstname)>value="#session.firstname#"</cfif>></td>
										<td><input type="text" name="lastname" <cfif LEN(session.lastname)>value="#session.lastname#"</cfif>></td>
										<td><input type="text" name="email" <cfif LEN(session.email)>value="#session.email#"</cfif>></td>
										<td><select name="agentid"><option>All<cfloop query="getAgents"><option value="#id#" <cfif session.agentid is id>selected</cfif>>#firstname# #lastname#</cfloop></select></td>
										<td><select name="rating"><option>All<cfloop query="getRatings"><option value="#id#" <cfif session.rating eq id>selected</cfif>>#rating#</cfloop></select></select></td>
									</tr>



									<tr><td colspan="5"><hr></td></tr>
									<tr>
										<th>Property Type</th>
										<th>Area</th>
										<th>Price Min</th>
										<th>Price Max</th>
										<th>View</th>
									</tr>
									<tr>
										<td>
											<select name="wsid">
												<option>Any
												<cfloop index="i" list="#getmlscoinfo.wsid#">
												<option value="#listgetat(i,'1','~')#" <cfif session.wsid is "#listgetat(i,'1','~')#">selected</cfif>>#listgetat(i,'2','~')#</option>
												</cfloop>
											</select>
  										</td>
										<td>
											<select name="area">
											<option>All
											<cfloop query="getareas">
											<option value="#areashidden#" <cfif isdefined('session.area')><cfloop index="A" list="#session.area#"> <cfif #a# is "#areashidden#">selected</cfif></cfloop></cfif>>#city#</option>
											</cfloop>
											</select>
  										</td>
										<td>
											<select name="pmin">
												<cfif LEN(session.pmin)><option value="#session.pmin#" selected>$#trim(numberformat(session.pmin,'__,___,___'))#</option><cfelse><option value="">No Preference</cfif>
												<cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
													<option value="#i#" <cfif session.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
													<cfif #i# eq "1000000">
													<cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
													<option value="#i#" <cfif session.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
													</cfloop>
													<cfbreak>
													</cfif>
												</cfloop>
											</select>
  										</td>
										<td>
										<select name="pmax">
											<cfif LEN(session.pmax)><option value="#session.pmax#" selected>$#trim(numberformat(session.pmax,'__,___,___'))#</option><cfelse><option value="">No Preference</cfif>
											<cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
												<option value="#i#" <cfif session.pmax is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
												<cfif #i# eq "1000000">
												<cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
												<option value="#i#" <cfif session.pmax is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
												</cfloop>
												<cfbreak>
												</cfif>
											</cfloop>
										</select>
  									</td>
  									<td>
										<select name="WaterType">
											<option selected="selected" value="">All</option>
											<cfloop index="i" list="#TheWaterTypes#"> 
											<option value="#i#" <cfif session.WaterType eq i>selected</cfif>>#i#</option>
											</cfloop>
										</select>	
  									</td>
									</tr>
									<tr>
										<th>Bedrooms Min</th>
										<th>Bedrooms Max</th>
										<th>Bathrooms Min</th>
										<th>Bathrooms Max</th>
										<th></th>
									</tr>
									<tr>
										<td>
											<select name="bedmin">
												<option selected="selected" value="">No Preference</option>
												<option value="1" <cfif session.bedmin is "1">selected</cfif>>1 Bedroom(s)</option>
												<option value="2" <cfif session.bedmin is "2">selected</cfif>>2 Bedroom(s)</option>
												<option value="3" <cfif session.bedmin is "3">selected</cfif>>3 Bedroom(s)</option>
												<option value="4" <cfif session.bedmin is "4">selected</cfif>>4 Bedroom(s)</option>
												<option value="5" <cfif session.bedmin is "5">selected</cfif>>5 Bedroom(s)</option>
												<option value="6" <cfif session.bedmin is "6">selected</cfif>>6 Bedroom(s)</option>
											</select>
										</td>
										<td>
											<select name="bedmax">
												<option selected="selected" value="">No Preference</option>
												<option value="1" <cfif session.bedmax is "1">selected</cfif>>1 Bedroom(s)</option>
												<option value="2" <cfif session.bedmax is "2">selected</cfif>>2 Bedroom(s)</option>
												<option value="3" <cfif session.bedmax is "3">selected</cfif>>3 Bedroom(s)</option>
												<option value="4" <cfif session.bedmax is "4">selected</cfif>>4 Bedroom(s)</option>
												<option value="5" <cfif session.bedmax is "5">selected</cfif>>5 Bedroom(s)</option>
												<option value="6" <cfif session.bedmax is "6">selected</cfif>>6 Bedroom(s)</option>
											</select>
										</td>
										<td>
											<select name="bathmin">
												<option selected="selected" value="">No Preference</option>
												<option value="1" <cfif session.bathmin is "1">selected</cfif>>1 Bedroom(s)</option>
												<option value="2" <cfif session.bathmin is "2">selected</cfif>>2 Bedroom(s)</option>
												<option value="3" <cfif session.bathmin is "3">selected</cfif>>3 Bedroom(s)</option>
												<option value="4" <cfif session.bathmin is "4">selected</cfif>>4 Bedroom(s)</option>
												<option value="5" <cfif session.bathmin is "5">selected</cfif>>5 Bedroom(s)</option>
											</select>
										</td>
										<td>
											<select name="bathmax">
												<option selected="selected" value="">No Preference</option>
												<option value="1" <cfif session.bathmax is "1">selected</cfif>>1 Bedroom(s)</option>
												<option value="2" <cfif session.bathmax is "2">selected</cfif>>2 Bedroom(s)</option>
												<option value="3" <cfif session.bathmax is "3">selected</cfif>>3 Bedroom(s)</option>
												<option value="4" <cfif session.bathmax is "4">selected</cfif>>4 Bedroom(s)</option>
												<option value="5" <cfif session.bathmax is "5">selected</cfif>>5 Bedroom(s)</option>
											</select>
										</td>
										<td></td>
									</tr>

									<tr><td colspan="5"><hr></td></tr>

									<tr>
										<th>Email / Notes</th>
										<!--- <th>Search Saved Searches</th> --->
										<th>Purchases</th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
									<tr>
										<td><input type="text" name="agentkeyword" <cfif LEN(session.agentkeyword)>value="#session.agentkeyword#"</cfif>></td>
										<!--- <td><input type="text" name="savedsearch" <cfif LEN(session.savedsearch)>value="#session.savedsearch#"</cfif>></td> --->
										<td><input type="text" name="purchases" <cfif LEN(session.purchases)>value="#session.purchases#"</cfif>></td>
										<td></td>
					  				<td></td>
					  				<td></td>
									</tr>

									<tr>
										<td colspan="1"  style="padding-top:10px;"><input type="submit" value="Search"><input type="submit" name="clear" value="Clear"></td>
										<td colspan="3" style="padding-top:10px;"></td>
										<td colspan="1" style="padding-top:10px;"><input type="button" onclick="window.location='search-export.cfm?export=';" value="Export" class="bluebutton exportbutton"></td>
									</tr>
								</table>
							</form>
							</cfoutput>
						</td></tr>

							<tr>
								<th style="width:50px;"></th>
								<th>Name</th>
								<th>Contact Info</th>
								<th>Rating</th>
								<cfif isdefined('cookie.LoggedInAdminID')><th>Agent</th></cfif>
								<cfif session.joinsearch eq 1><th>Search Date</th></cfif>
								<th>Created</th>
								<th style="width:75px;"></th>
								<!--- <th style="width:75px;"></th> --->
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getInfo" startrow="#tracker.startRow#" maxrows="#tracker.maxRows#">
							<tr>
								<td>#currentrow#.</td>
								<td><a hreflang="en" href="/leadtracker/contact-details.cfm?id=#id#&display=history" class="edit">#capFirstTitle(firstname)# #capFirstTitle(lastname)#</a></td>
								<td>#email#<br>#phone#</td>
								<td><cfif LEN(rating)>#GetLeadRating(rating)#<cfelse>Qualify</cfif></td>
								<cfif isdefined('cookie.LoggedInAdminID')><td>#GetAgentName(agentid)#</td></cfif>
								<cfif session.joinsearch eq 1><td>#dateformat(ssdate, 'mm/dd/yyyy')#<br>#timeformat(ssdate, 'hh:mm TT')#</td></cfif>
								<td>#dateformat(thedate, 'mm/dd/yyyy')#</td>
								<td><a hreflang="en" href="/leadtracker/contact-details.cfm?id=#id#&display=history" class="edit">View</a></td>
								<!--- <td><a hreflang="en" href="lead-ratings.cfm?id=#id#&delete=yes" class="delete" onclick="return confirm('Are you sure you wish to delete this Rating?')">Delete</a></td> --->
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