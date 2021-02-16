<cfset thisPageTitle = "Contact Detail">

<cfinclude template="components/header.cfm">

<script type="text/javascript" src="js/validate-contact-details.js"></script>

<cfinclude template="components/navigation.cfm">

<cfinclude template="contact-details_.cfm">

<div class="container">

<cfif isdefined('getContact')>

	    <!--- Determine Phone Verification --->
    <cfparam name="phoneValidate" default="0">
    <cfparam name="phoneClass" default="phone-unknown">
    <cfif isdefined('getContact.phone') and LEN(getContact.phone)>
      <!--- Strip Phone Number of characters --->
      <cfset stripPhone = rereplace(getContact.phone,'\)|\(|\.| |-','','ALL')>
      <!--- Get Validation number --->
      <cfset phoneValidate = GetPhoneValidation(stripPhone)>
      <!--- Use Validation number to set CSS class to change icon --->
      <cfset phoneClass = getPhoneClass(phoneValidate)>
    </cfif>
    <!--- End: Phone Verification --->
</cfif>


<cfoutput>

		<form action="#cgi.script_name#<cfif isdefined('url.id') and LEN(url.id)>?id=#url.id#</cfif>" method="post" role="form" name="thisform" onsubmit="return validateForm()">
			<cfif isdefined('url.id') and LEN(url.id)><input type="hidden" name="id" value="#url.id#"></cfif>
			<section>
				<div class="panel">
					<div class="panel-heading">
						<h2><cfif isdefined('ContactExists')>LEAD TRACKER MESSAGING CENTER<cfelse>Add Contact</cfif></h2>
					</div>
					
					<div class="panel-body">
						<header>
								<span id="user-name"><cfif isdefined('ContactExists')>#capFirstTitle(getContact.firstname)# #capFirstTitle(getContact.lastname)#</cfif></span>
								<cfif isdefined('url.id') and LEN(url.id)>Last login: #dateTimeFormat(GetLastVisit(url.id), 'mm/dd/yyyy h:mm tt')#</cfif>
								<cfif isdefined('url.updated')>
									<span class="ProfileUpdated">Saved.</span>
								<cfelseif isdefined('url.emailsent')>
									<span class="ProfileUpdated">Email has been sent.</span>
								</cfif>

								<cfif isdefined('url.id') and LEN(url.id)>
									<div href="/admin/contacts/lightboxes/phonecall.cfm?clientid=#url.id#" class="fb_listing contact-detail-phonecall #phoneClass#"></div>
									<div><a hreflang="en" href="/admin/contacts/create-outlook-contact.cfm?id=#id#" target="_blank"><img src="/admin/images/vcard.gif" alt="Create Outlook Contact" border="0"></a></div>
								</cfif>
						</header>
						<div class="forms">
							<ul>
								<li>
								   <label>First Name</label>
								   <input name="firstname" type="text" <cfif isdefined('ContactExists')>value="#getContact.firstname#"</cfif> />    
								</li>
								<li>
								   <label>Last Name</label>
								   <input name="lastname" type="text"  <cfif isdefined('ContactExists')>value="#getContact.lastname#"</cfif>/>
								</li>

								<li>
								   <label>Salutation</label>
								   <input name="salutation" type="text"  <cfif isdefined('ContactExists')>value="#getContact.salutation#"</cfif>/>
								</li>

								<li>
								   <label>Address</label>
								   <input name="address" type="text"  <cfif isdefined('ContactExists')>value="#getContact.address#"</cfif>/>
								</li>

								<li>
								   <label>Company</label>
								   <input name="company" type="text"  <cfif isdefined('ContactExists')>value="#getContact.company#"</cfif>/>
								</li>

								<li>
								   <label>City</label>
								   <input name="city" type="text"   <cfif isdefined('ContactExists')>value="#getContact.city#"</cfif>/>
								</li>
								
								<li class="state">
								   <label>State</label>
								   <select class="selectpicker" name="state">
										<option value="0">-</option>
										<cfloop query="getStates">
											<option value="#state#" <cfif isdefined('ContactExists') and getStates.state eq getContact.state>selected</cfif>>#getStates.abbreviation#</option>
										</cfloop>
									</select>
								</li>
								<li class="zip">
								   <label>Zip</label>
								   <input name="zip" type="text"  <cfif isdefined('ContactExists')>value="#getContact.zip#"</cfif> />
								</li>
								<li class="country">
								   <label>Country</label>
								   <select class="selectpicker">
										<option value="0">-</option>
									   	<cfloop query="getCountries">
											<option value="#getCountries.Country#"  <cfif isdefined('ContactExists') and getCountries.Country eq getContact.country>selected</cfif>>#getCountries.Country#</option>
										</cfloop>
									</select>
								</li>
								<li>	
								   <label>Password</label>
								   <input name="password" type="text"  <cfif isdefined('ContactExists')>value="#getContact.password#"</cfif>/>
								</li>
								<li>
								   <label>Phone</label> 
								   <input name="phone" type="text" class="phone" <cfif isdefined('ContactExists')>value="#getContact.phone#"</cfif>/>
								</li>
								<li>
								   <label>Cell</label>
								   <input name="cellphone" type="text" class="phone"  <cfif isdefined('ContactExists')>value="#getContact.CellPhone#"</cfif>/>
								</li>
								<li>
								   <label>Work</label>
								   <input name="Officephone" type="text" class="phone"  <cfif isdefined('ContactExists')>value="#getContact.OfficePhone#"</cfif>/>
								</li>

							</ul>
							<ul>
								<li>
								   <label>Notify Msg</label>
						              <select class="selectpicker" name="NotifyOfLogin">
							              <option value="" <cfif isdefined('ContactExists') and getContact.NotifyOfLogin is ''>selected</cfif>>Default Global Settings</option>
							              <option value="emailtext" <cfif isdefined('ContactExists') and getContact.NotifyOfLogin is 'emailtext'>selected</cfif>>Receive Email and Text</option>
							              <option value="email" <cfif isdefined('ContactExists') and getContact.NotifyOfLogin is 'email'>selected</cfif> >Receive Email Only</option>
							              <option value="text" <cfif isdefined('ContactExists') and getContact.NotifyOfLogin is 'text'>selected</cfif>>Receive Text Only</option>
							              <option value="none" <cfif isdefined('ContactExists') and getContact.NotifyOfLogin is 'none'>selected</cfif>>No Notifications</option>
						              </select>
								</li>

								<li>
								   <label>Email</label>
								   <input name="email" type="text"  <cfif isdefined('ContactExists')>value="#getContact.email#"</cfif>/>
								</li>

								<li>
								   <label>Alt. Email</label>
								   <input name="email2" type="text"  <cfif isdefined('ContactExists')>value="#getContact.email2#"</cfif>/>
								</li>

								<li>
								   <label>Website</label>
								   <input name="website" type="text"  <cfif isdefined('ContactExists')>value="#getContact.website#"</cfif>/>
								</li>

								<li>
								   <label>Status</label>
								   	 <select class="selectpicker" name="rating">
										<option value="0">-</option>
								   	 	<cfloop query="getRatings">
											<option value="#getRatings.id#"  <cfif isdefined('ContactExists') and getRatings.id eq getContact.Rating>selected</cfif>>#getRatings.Rating#</option>
										</cfloop>
									</select>
								</li>

								<cfif isdefined('url.id') and LEN(url.id)>
									<li class="drip">
									   <label>Drip Campaign</label>
									   <ul>
									   	<cfif isdefined('CompaignExists')>
											<li class="save">
												<a hreflang="en" href="drip-campaign-lead.cfm?CampaignID=#checkCampaign.id#&clientid=#url.id#">View</a>
											</li>
										<cfif LEN(checkCampaign.DripStartDate) and LEN(checkCampaign.Status) and checkCampaign.Status neq 'Finished'>
											<li class="copy">
												<a hreflang="en" href="drip-campaign-lead-pause-resume.cfm?campaignid=#checkCampaign.id#&pause=" onclick="return confirm('Are you sure you wish to Pause this Campaign?')">Pause</a>
											</li>
										</cfif>
											<li class="delete">
												<a hreflang="en" href="drip-campaign-lead.cfm?clientid=#url.id#&campaignid=#checkCampaign.id#&delete=deletecampaign" onclick="return confirm('Are you sure you wish to Delete this Campaign?')">Delete</a>
											</li> 
										<cfelse>
											<li class="save">
												<a hreflang="en" href="drip-campaign-lead.cfm?clientid=#url.id#">Add</a>
											</li>
											<li class="copy" style="width:23% !important;">
												<a hreflang="en" href="drip-campaign-lead-autostart.cfm?clientid=#url.id#" onclick="return confirm('Are you sure you wish to automatically Create and Start a drip campaign?')">Auto Start</a>
											</li>
										</cfif>
			<!--- 							<li class="copy">
											<a hreflang="en" href="##">Copy</a>
										</li> --->
									   </ul>
									</li>
								</cfif>

								<li>
								   <label>Lead Source</label>
								   	 <select class="selectpicker" name="leadsource">
										<option value="0">-</option>
								   	 	<cfloop query="getSources">
											<option value="#getSources.id#"  <cfif isdefined('ContactExists') and getContact.leadsource eq getSources.id>selected</cfif>>#getSources.source#</option>
										</cfloop>
									</select>
								</li>
								<li>
								   <label>Referral</label>
								   <input name="leadreferral" type="text"  <cfif isdefined('ContactExists')>value="#getContact.leadreferral#"</cfif>/>
								</li>
<!--- 								<li>
								   <label>Status</label>
								   	 <select class="selectpicker" name="LeadStatus">
										<option value="0">-</option>
								   	 	<cfloop query="getStatuses">
											<option value="#getStatuses.id#"  <cfif isdefined('ContactExists') and getStatuses.id eq getContact.LeadStatus>selected</cfif>>#getStatuses.status#</option>
										</cfloop>
									</select>
								</li> --->


								<li>
								   <label>Round Robin</label>
								   	<select class="selectpicker" name="agentid">
										<option value="0">Choose an Agent</option>
								   		<cfloop query="getAgents">
											<option value="#getAgents.id#" <cfif isdefined('ContactExists') and getAgents.id eq getContact.agentid>selected</cfif>>#getAgents.firstname# #getAgents.lastname#</option>
										</cfloop> 
									</select>
									<cfif isdefined('ContactExists')><input type="hidden" name="agentcheck" value="#getContact.agentid#"></cfif>
								</li>

								<li class="non-labeled">
								   <cfif isdefined('ContactExists')>
								   		Came From Website: #getContact.camefromwebsite#
								   	<cfelse>
								   		<input type="hidden" name="camefromwebsite" value="HHH">
								   </cfif>
								</li>
								<li class="non-labeled">
								   <span class="smallprint">Note: If reassigned or added, that agent will receive an email notification.</span>
								</li>
							</ul>
							<ul class="doubled">
								<cfif isdefined('ContactExists')>
								<li>
								   <label>Last Edited</label>
								   <input name="lastedit" type="text"  <cfif isdefined('ContactExists')>value="#DateFormat(getContact.lastedit, 'mm/dd/yy')#"</cfif>/>
								</li>
								<li>
								   <label>Edited By</label><cfif isdefined('ContactExists') and LEN(getContact.lasteditby)><cfset checkeditby = GetAgentName(getContact.lasteditby)></cfif>
								   <input name="lasteditby" type="text"  <cfif isdefined('ContactExists') and isdefined('checkeditby') and LEN(checkeditby)>value="#checkeditby#"<cfelseif LEN(getContact.lastedit)>value="Admin"</cfif>/>
								</li>
								
										<li>
										   <label>Last Reach</label>
										   <input name="lastreached" type="text"  <cfif isdefined('ContactExists')>value="#DateFormat(getContact.lastreached, 'mm/dd/yy')#"</cfif>/>
										</li>

										<li>
										   <label>Last Email</label>
										   <input  type="text"  name="lastemail" <cfif isdefined('ContactExists')>value="#DateFormat(getContact.lastemail, 'mm/dd/yy')#"</cfif>/>
										</li>

										<li>
										   <label>Last Meeting</label>
										   <input name="lastmeeting" type="text"  <cfif isdefined('ContactExists')>value="#DateFormat(getContact.lastmeeting, 'mm/dd/yy')#"</cfif>/>
										</li>

										<li>
										   <label>Last Letter</label>
										   <input name="lastletter" type="text"  <cfif isdefined('ContactExists')>value="#DateFormat(getContact.lastletter, 'mm/dd/yy')#"</cfif>/>
										</li>
										<li>
										   <label>Last Purchase</label>
										   <input type="text" name="lastPurchase" <cfif isdefined('lastPurchase.datesold')>value="#DateFormat(lastPurchase.datesold, 'mm/dd/yy')#"</cfif> disabled />
										</li>
										<li>
										   <label>1<sup>st</sup> Purchase</label>
										   <input type="text" name="firstPurchase" <cfif isdefined('firstPurchase.datesold')>value="#DateFormat(firstPurchase.datesold, 'mm/dd/yy')#"</cfif> disabled />
										</li>

										<cfif isdefined('ContactExists')>
											<li class="full notes">
												<label><b>Notes</b></label>
												<textarea name="followupnotes" type="text" rows="4">#GetLastNote(getContact.id)#</textarea>
											</li>
										</cfif>

										
										<li class="full reminder">
											<!--- <label>Set a Reminder with the above Note</label> --->
											<select class="selectpicker contact-type" name="followuptype">
												<option value="nofollowup">Note Only</option>
												<option value="Email">Follow Up Reminder: Email</option>
												<option value="Phone">Follow Up Reminder: Phone</option>
												<option value="Cell">Follow Up Reminder: Cell</option>
												<option value="Work Phone">Follow Up Reminder: Work Phone</option>
											</select>
											<select class="selectpicker time" name="followupDate">
												<cfloop index="i" from="0"  to="366">
													<option>#dateformat(DateAdd("d", i, now()), 'mm/dd/yyyy')#</option>
												</cfloop>
											</select>
											<select class="selectpicker time" name="followupTime">
												<cfloop index="t" from="6:00 AM" to="11:30 PM" step="#CreateTimeSpan(0,0,30,0)#">
													<option>#TimeFormat( t, "hh:mm:ss TT")#</option> 
												</cfloop>
											</select>
										</li>
								</cfif>
								<li class="full notes">
									<ul>
										<li class="save">
											<cfif isdefined('url.id') and LEN(url.id)><input type="submit" name="SaveProfile" value="Save Profile"><cfelse><input type="submit" name="AddContact" value="Add Contact"></cfif>
										</li>
										<cfif isdefined('url.id') and LEN(url.id)>
											<li class="copy">
												<a hreflang="en" href="/admin/contacts/lightboxes/saved-search.cfm?id=#url.id#" class="fb_savedsearch">Create Saved Search</a>
											</li>
											<li class="delete">
												<a hreflang="en" href="#cgi.script_name#?id=#url.id#&deleteacct=yes" onclick="return confirm('Are you sure you wish to Delete this Contact?')">Delete Contact</a> 
											</li>
										</cfif>
								   </ul>

								</li>
								

							</ul>

						</div>
						
					</div>
				</div>
			</section>
		</form>
		
</cfoutput>

	<cfif isdefined('url.id') and LEN(url.id)>
		<section id="subpanel">
			<div class="panel">
				<div class="panel-body">
					<a name="LOC"></a>
					<cfinclude template="contact-details-submenu.cfm">
					
					<div id="content-area">
						<!--- Content Area of Each Section Linked --->
						<cfif isdefined('url.display')><cfinclude template="contact-details-results.cfm"></cfif>
					</div>
			
				</div><!-- panel-body -->
			</div><!-- panel -->

		</section>
	</cfif>
	

	</div>




	<!-- Grab Google CDN's jQuery, fall back to local if offline -->
	<!-- 2.0 for modern browsers, 1.10 for .oldie -->
	<!--- 
	<script>
	var oldieCheck = Boolean(document.getElementsByTagName('html')[0].className.match(/\soldie\s/g));
	if (!oldieCheck) {
		document.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"><\/script>');
	} else {
		document.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"><\/script>');
	}
	</script>
	<script>
	if (!window.jQuery) {
		if (!oldieCheck) {
			document.write('<script src="/js/_plugins/jquery.min.js"><\/script>');
		} else {
			document.write('<script src="/js/_plugins/jquery-1.10.1.min.js"><\/script>');
		}
	}
	</script>
 --->
	<!-- Bootstrap Core JavaScript -->
	<script src="js/_plugins/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.3/js/bootstrap-select.min.js"></script>
	<script>
		$('.selectpicker').selectpicker();
	</script>


	<cfinclude template="components/footer.cfm">

