	<cfoutput>
					<tbody>

									<!--- To display message to user after action select box changed --->
									<tr><td colspan="16" id="searchresultsActionChange" style="display: none;" Onclick="javascript:hidemessage(document.getElementById('searchresultsActionChange'))" title="Click to close message."></td></tr>

			

									<cfloop from="#tracker.startrow#" to="#tracker.endrow#" index="i">
										<!--- set clientid variable from list --->
										<cfset clientid = ListGetAt(strNewList, i)>


												<!--- Go back and get basic info --->
												<cfquery datasource="#mls.dsn#" name="genInfo">  
													select cl_activity.clientId,cl_activity.action,cl_activity.createdAt,cl_activity.createdAt as thisDate,
													cl_accounts.firstname,cl_accounts.lastname,cl_accounts.phone,cl_accounts.camefromwebsite,cl_accounts.rating,
													cl_agents.firstname as agentFName,cl_agents.lastname as agentLName,cl_agents.id,cl_accounts.thedate
													from cl_activity
													Left Join cl_accounts on cl_activity.clientId = cl_accounts.id
													Left Join cl_agents on cl_accounts.agentid = cl_agents.id
													Where cl_activity.clientId = <cfqueryparam value="#clientid#" cfsqltype="cf_sql_integer">
													Order by cl_activity.createdAt DESC
													limit 1
												</cfquery>

<cfif CGI.REMOTE_ADDR eq "1.38.164.88"><cfdump var="#getInfo#"></cfif>

											<!--- start: Determine class for rating --->
											<cfset ratingClass = 'new'>
											<cfif genInfo.rating eq '4'>
                                                <cfset ratingClass = "cold">
                                            <cfelseif genInfo.rating eq '10'>
                                                <cfset ratingClass = "nurture">
                                            <cfelseif genInfo.rating eq '9'>
                                                <cfset ratingClass = "watch">
                                            <cfelseif genInfo.rating eq '2'>
                                                <cfset ratingClass = "hot">
                                            <cfelseif genInfo.rating eq '8'>
                                                <cfset ratingClass = "pending">
                                            <cfelseif genInfo.rating eq '7'>
                                                <cfset ratingClass = "trash">
                                            <cfelseif genInfo.rating eq ''>
                                                <cfset ratingClass = "qualify">
                                            </cfif>
											<!--- end: Determine class for rating --->


									    <!--- Determine Phone Verification --->
									    <cfparam name="phoneValidate" default="0">
									    <cfparam name="phoneClass" default="phone-unknown">
									    <cfif isdefined('genInfo.phone') and LEN(genInfo.phone)>
									      <!--- Strip Phone Number of characters --->
									      <cfset stripPhone = rereplace(genInfo.phone,'\)|\(|\.| |-','','ALL')>
									      <!--- Get Validation number --->
									      <cfset phoneValidate = GetPhoneValidation(stripPhone)>
									      <!--- Use Validation number to set CSS class to change icon --->
									      <cfset phoneClass = getPhoneClass(phoneValidate)>
									    </cfif>
									    <!--- End: Phone Verification --->
	

										<cfif LEN(genInfo.clientId)><cfset theLastLogin = GetLastLogin(genInfo.clientId)></cfif>
										<tr>
											<td class="status #ratingClass#"><cfif LEN(genInfo.rating)>#GetLeadRating(genInfo.rating)#<cfelse>Qualify</cfif></td>
											<td class="agent">#capFirstTitle(genInfo.agentFName)# #capFirstTitle(genInfo.agentLName)#</td>
											<td class="contact"><a hreflang="en" href="contact-details.cfm?id=#clientid#"><cfif LEN(genInfo.firstname) and LEN(genInfo.lastname)>#capFirstTitle(genInfo.firstname)# #capFirstTitle(genInfo.lastname)#<cfelse>Name Unavailable</cfif></a><br>#genInfo.phone#</td>
											<td class="action">
												<select class="selectpicker" onChange="ActionSelector(this.value);javascript:hideshow(document.getElementById('searchresultsActionChange'))">
														<option value="#clientid#~none">Change Status</option>
														<cfloop query="getRating">
														<option value="#clientid#~#rating#">#rating#</option>
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
											<br>#GetLastActivity(genInfo.clientId)#<br>#dateformat(genInfo.createdAt, 'm/dd/yy')# #timeformat(genInfo.createdAt, 'h:mm t')#
											</td>
											<td class="calls talking">
												<i href="/admin/contacts/lightboxes/phonecall.cfm?clientid=#clientid#" class="fb_phoneadd #phoneClass#"></i><!--- <i href="/admin/contacts/lightboxes/phoneupdate.cfm?phonenumber=#rereplace(genInfo.phone,'\)|\(|\.|-|\##','','ALL')#" class="fb_listing #phoneClass#"></i>  ---><cfif LEN(genInfo.clientId)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Phone##LOC" target="_blank">#GetCalls(genInfo.clientId)#</a></cfif>
											</td>
											<td class="emails one-way"><i class="fb_listing" href="/admin/contacts/lightboxes/messages.cfm?id=#clientid#&reply=&dash=agent"></i> <cfif LEN(genInfo.clientId)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=History##LOC" target="_blank">#GetEmails(genInfo.clientId)#</a></cfif></td>
											<td class="drip ok">
												#gotDripCampaign(genInfo.clientId)#<!--- <cfif gotDripCampaign(genInfo.clientId) eq "Yes"><i></i><cfelse>0</cfif> --->
											</td>
											<td class="date"> 
												<cfset fdate = GetFollowUps(genInfo.clientId)>
												<cfset ftime = timeformat(fdate, 'h:mm tt')>
												<cfset fdate = dateformat(fdate, 'yyyy-mm-dd')>
												<cfif LEN(fdate)>#fdate# #ftime#<div>#DateDiff("d", fdate, now())# day<cfif DateDiff("d", fdate, now()) gt 1 or DateDiff("d", fdate, now()) eq 0>s</cfif> ago</div></cfif>
											</td>
											<td class="agent">
												#GetEAlerts(genInfo.clientId)#
												<!--- <div>Agent</div> --->
											</td>
											<td class="price">
												<!--- <select class="selectpicker">
													<option>#GetSSMinMax(genInfo.clientId)#</option>
												</select> --->#GetSSMinMax(genInfo.clientId)#
											</td>
											<td class="last-visit">
												<cfif LEN(genInfo.clientId)>#GetLastVisit(genInfo.clientId)#</cfif>
												<!--- <cfif LEN(genInfo.clientId)>#dateformat(theLastLogin, 'm/d/yyyy')# <br>#timeformat(theLastLogin, 'hh:mmtt')#</cfif> --->
											</td>
											<td class="visits"><cfif LEN(genInfo.clientId)>#GetVisits(genInfo.clientId)#</cfif></td>
											<td class="views"><cfif LEN(genInfo.clientId)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Views##LOC" target="_blank">#GetAllProperties(genInfo.clientId)#</a></cfif></td>
											<td class="favs"><cfif LEN(genInfo.clientId)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Favorites##LOC" target="_blank">#GetFavs(genInfo.clientId)#</a></cfif></td>
											<td class="site">#genInfo.camefromwebsite#</td>
											<td class="created">
												#dateformat(genInfo.thedate, 'm/d/yyyy')#<br>#timeformat(genInfo.thedate, 'hh:mmtt')#
											</td>
										</tr>
										<cfset tracker.resultCnt = tracker.resultCnt + 1>
									</cfloop>
								</tbody>

</cfoutput>