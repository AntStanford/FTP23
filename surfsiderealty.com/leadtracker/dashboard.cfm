<cfinclude template="dashboard_.cfm">
<cfinclude template="components/functions.cfm">
<!--- <cfif CGI.REMOTE_ADDR eq "76.182.53.8">
	<cfinclude template="components/dashboard-queries-matt.cfm">
<cfelse> --->
	<cfinclude template="components/dashboard-queries.cfm">
<!--- </cfif> --->

<cfinclude template="components/dashboard-counter.cfm">
<cfinclude template="components/pagination.cfm">

<cfinclude template="components/header.cfm">
<script src="js/action-selector.js" type="text/javascript" charset="utf-8"></script>

<cfinclude template="components/navigation.cfm">


	<div class="container">
	
			<cfquery datasource="#mls.dsn#" name="getRating">
				select *
				from cl_ratings
				where rating <> 'None'
				order by rating
			</cfquery>

		<div class="filters row">
			<option value="#clientid#~none">Change Status</option>
			<cfoutput query="getRating">
				<button class="#rating#" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=#rating#'">#rating#</button><!--- 
				<button class="new" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=New'">New</button>
				<button class="qualify" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Qualify'">Qualify</button>
				<button class="nurture" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Nurture'">Nurture</button>
				<button class="watch" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Watch'">Watch</button>
				<button class="hot" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Hot'">Hot</button>
				<button class="cold" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Cold'">Cold</button>
				<button class="closed" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Closed'">Closed</button>
				<button class="pending" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Pending'">Pending</button>
				<button class="trash" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=Trash'">Trash</button>
				<button class="all" onclick="window.location.href='dashboard.cfm?qry=#session.tracker.mainqry#&status=0'">All</button> --->
			</cfoutput>
		</div>
		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
					  <cfoutput>
						<li><h2>#url.status#</h2></li>
						<li>Page <input id="" type="text" name="currentpage" placeholder="#url.pg#" /> of <cfif session.tracker.mainqry eq 'CustResp'>1<cfelse>#tracker.resultPages#</cfif></li>
						<!--- <li><cfif session.tracker.mainqry eq "RecentLeads"><a hreflang="en" href="dashboard.cfm?qry=searchAct&status=#status#">Latest Search Activity</a><cfelse><a hreflang="en" href="dashboard.cfm?qry=RecentLeads&status=#status#">Recent Activity</a></cfif></li> --->
						<li><a hreflang="en" href="dashboard.cfm?qry=AgentResp&status=#status#">Waiting On Your Response</a> <input id="" type="text" <cfif isdefined('agentcounter') and agentcounter GT '0'>placeholder="#agentcounter#"</cfif> /> </li>
						<li><a hreflang="en" href="dashboard.cfm?qry=CustResp&status=#status#">Waiting On Customer Response</a></li>	
					  </cfoutput>
					</ul>           
                                                          							
				</div>
				
				
				
				<div class="panel-body">
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<th>Status</th>
								<th>Agent Name</th>
								<th>Contact Info</th>
								<th>Action</th>
								<th>Calls</th>
								<th>Emails</th>
								<th>Drip</th>
								<th>Follow Up</th>
								<th>E-Alert</th>
								<th>Price Range</th>
								<th>Last Visit</th>
								<th>Visits</th>
								<th>Views</th>
								<th>Favs</th>
								<th>Site</th>
								<th>Created</th>
							</tr>
						</thead>

						 <cfif session.tracker.mainqry eq "AgentResp">

						 		<cfinclude template="components/dashboard-results-agent.cfm">

						 <cfelseif session.tracker.mainqry eq "CustResp">

						 		<cfinclude template="components/dashboard-results-contacts.cfm">

						 <cfelseif session.tracker.mainqry eq "RecentLeads">

						 		<cfinclude template="components/dashboard-recent-leads.cfm">

						<cfelse>

								<tbody>
			
									<!--- To display message to user after action select box changed --->
									<tr><td colspan="16" id="searchresultsActionChange" style="display: none;" Onclick="javascript:hidemessage(document.getElementById('searchresultsActionChange'))" title="Click to close message."></td></tr>

									<cfoutput query="getInfo" startrow="#tracker.startRow#" maxrows="#tracker.maxRows#">

										<!--- start: Determine class for rating --->
											<cfset ratingClass = 'new'>
										<cfif rating eq '4'>
											<cfset ratingClass = "cold">
										<cfelseif rating eq '10'>
											<cfset ratingClass = "nurture">
										<cfelseif rating eq '9'>
											<cfset ratingClass = "watch">
										<cfelseif rating eq '2'>
											<cfset ratingClass = "hot">
										<cfelseif rating eq '8'>
											<cfset ratingClass = "pending">
										<cfelseif rating eq '7'>
											<cfset ratingClass = "trash">
										<cfelseif rating eq ''>
											<cfset ratingClass = "qualify">
										</cfif>
										<!--- end: Determine class for rating --->


									    <!--- Determine Phone Verification --->
									    <cfparam name="phoneValidate" default="0">
									    <cfparam name="phoneClass" default="phone-unknown">
									    <cfif isdefined('phone') and LEN(phone)>
									      <!--- Strip Phone Number of characters --->
									      <cfset stripPhone = rereplace(phone,'\)|\(|\.| |-','','ALL')>
									      <!--- Get Validation number --->
									      <cfset phoneValidate = GetPhoneValidation(stripPhone)>
									      <!--- Use Validation number to set CSS class to change icon --->
									      <cfset phoneClass = getPhoneClass(phoneValidate)>
									    </cfif>
									    <!--- End: Phone Verification --->
	

										<cfif LEN(clientid)><cfset theLastLogin = GetLastLogin(clientId)></cfif>
										<tr>
											<td class="status #ratingClass#"><cfif LEN(rating)>#GetLeadRating(rating)#<cfelse>Qualify</cfif></td>
											<td class="agent">#capFirstTitle(agentFName)# #capFirstTitle(agentLName)#</td>
											<td class="contact"><a hreflang="en" href="contact-details.cfm?id=#clientid#"><cfif LEN(firstname) and LEN(lastname)>#capFirstTitle(firstname)# #capFirstTitle(lastname)#<cfelse>Name Unavailable</cfif></a><br>#phone#</td>
											<td class="action">
												<select class="selectpicker" onChange="ActionSelector(this.value);javascript:hideshow(document.getElementById('searchresultsActionChange'))">
													
													<cfloop query="getRating">
														<option value="#getInfo.clientid#~#rating#">#rating#</option>
													</cfloop>
														<!--- <option value="#clientid#~none">Change Status</option>
														<option value="#clientid#~hot">- to Hot</option>
														<option value="#clientid#~nurture">- to Nurture</option>
														<option value="#clientid#~watch">- to Watch</option>
														<option value="#clientid#~cold">- to Cold</option>
														<option value="#clientid#~pending">- to Pending</option>
														<option value="#clientid#~closed">- to Closed</option>
														 <option value="#clientid#~startdrip">Start Drip Campaign</option> --->
												
														<!--- <option value="##" disabled selected>#action#</option> --->
												</select>
											<cfif session.tracker.mainqry eq 'recentAct'><br>#GetLastActivity(clientid)#<br>#dateformat(createdAt, 'm/dd/yy')# #timeformat(createdAt, 'h:mm t')#</cfif>
											</td>
											<td class="calls talking">
												 <i href="/admin/contacts/lightboxes/phonecall.cfm?clientid=#clientid#" class="fb_phoneadd #phoneClass#"></i><!--- <i href="/admin/contacts/lightboxes/phoneupdate.cfm?phonenumber=#rereplace(phone,'\)|\(|\.|-|\##','','ALL')#" class="fb_listing #phoneClass#"></i> ---> <cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Phone##LOC" target="_blank">#GetCalls(clientid)#</a></cfif>
											</td>
											<td class="emails one-way"><i class="fb_listing" href="/admin/contacts/lightboxes/messages.cfm?id=#clientid#&reply=&dash=agent"></i> <cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=History##LOC" target="_blank">#GetEmails(clientid)#</a></cfif></td>
											<td class="drip ok">
												#gotDripCampaign(clientid)#
											</td>
											<td class="date"> 
												<cfset fdate = GetFollowUps(clientid)>
												<cfset ftime = timeformat(fdate, 'h:mm tt')>
												<cfset fdate = dateformat(fdate, 'yyyy-mm-dd')>
												<cfif LEN(fdate)>#fdate# #ftime#<div>#DateDiff("d", fdate, now())# day<cfif DateDiff("d", fdate, now()) gt 1 or DateDiff("d", fdate, now()) eq 0>s</cfif> ago</div></cfif>
											</td>
											<td class="agent">
												#GetEAlerts(clientid)#
												<!--- <div>Agent</div> --->
											</td>
											<td class="price">
												<!--- <select class="selectpicker">
													<option>#GetSSMinMax(clientid)#</option>
												</select> --->#GetSSMinMax(clientid)#
											</td>
											<td class="last-visit">
												<cfif LEN(clientid)>#GetLastVisit(clientid)#</cfif>
												<!--- <cfif LEN(clientid)>#dateformat(theLastLogin, 'm/d/yyyy')# <br>#timeformat(theLastLogin, 'hh:mmtt')#</cfif> --->
											</td>
											<td class="visits"><cfif LEN(clientid)>#GetVisits(clientId)#</cfif></td>
											<td class="views"><cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Views##LOC" target="_blank">#GetAllProperties(clientid)#</a></cfif></td>
											<td class="favs"><cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Favorites##LOC" target="_blank">#GetFavs(clientId)#</a></cfif></td>
											<td class="site">#camefromwebsite#</td>
											<td class="created">
												#dateformat(thedate, 'm/d/yyyy')#<br>#timeformat(thedate, 'hh:mmtt')#
											</td>
										</tr>
										<cfset tracker.resultCnt = tracker.resultCnt + 1>
									</cfoutput>
								</tbody>

						</cfif>  

					</table>

					<cfinclude template="components/pagination-links.cfm">



				</div>
			</div>
		</section>

			

		<section id="key">
			<ul>
				<li><span class="new">New:</span>  Stays coded as NEW for <cfoutput>#NewLeadHrs#</cfoutput> hours</li>
				<li><span class="qualify">Qualify:</span>  Not contacted - need to Qualify</li>
				<li><span class="nurture">Nurture:</span>  Contacted - buy 3-6 months</li>
				<li><span class="watch">Watch:</span>  Contacted - buy 6-12 Months</li>
				<li><span class="hot">Hot:</span>  Ready To Buy</li>
			</ul>

			<ul>
				<li><span class="cold">Cold:</span> Archive</li>
				<li><span class="closed">Closed</span></li>
				<li><span class="pending">Pending</span></li>
				<li><span class="trash">Trash:</span> Bogus</li>
				<li><span class="all">All:</span>  Active</li>
			</ul>

			<ul>
				<li class="calls talking"><i></i> Talking to Prospect</li>
				<li class="calls valid"><i></i> Valid Phone Number</li>
				<li class="calls unknown"><i></i> Unknown Phone Status</li>
				<li class="calls do-not-call"><i></i> Do Not Call</li>
				<li class="calls wrong"><i></i> Wrong Number</li>
			</ul>
			<ul>
				<li class="emails one-way"><i></i> 1 Way Emailing to Prospect</li>
				<li class="emails valid"><i></i> Valid Email Addess</li>
				<li class="emails unknown"><i></i> Unknown Email Address</li>
				<li class="emails opted"><i></i> Opted Out of Email Contact</li>
				<li class="emails invalid"><i></i> Invalid Email Address</li>
				<li class="emails two-way"><i></i> 2 Way Emailing</li>
			</ul>
		</section>
	</div>


	<div id="slide-panel">
		<a hreflang="en" href="#" class="btn" id="opener"><i class="glyphicon glyphicon-align-justify"></i>To-Do Items</a>
		<div id="activities"><cfinclude template="sidebar-activities.cfm"></div>
		<div id="actions"><cfinclude template="sidebar-actions.cfm"></div>
		<div id="reminders"><cfinclude template="sidebar-reminders.cfm"></div>
	</div>

<!--- 
<script src="js/_plugins/jquery.min.js"></script>
 --->
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
