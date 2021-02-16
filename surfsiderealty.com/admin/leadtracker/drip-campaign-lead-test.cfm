<cfset thisPageTitle = "Drip Campaign">

<cfinclude template="drip-campaign-lead_.cfm">

<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">


	<div class="container drip-campaign-lead">

	<cfoutput>

		<form action="drip-campaign-lead.cfm" method="post" role="form" name="thisform" onsubmit="return validateForm();" enctype="multipart/form-data">
			
				<input type="hidden" name="Clientid" value="#url.clientid#">
			<!--- 	<cfif isdefined('cookie.LOGGEDINAGENTID')><input type="hidden" name="AgentID" value="#cookie.LOGGEDINAGENTID#"></cfif> --->


					<!--- If Drip Campaign is set up, hide agent ID, if admin is logged in, set agent id to their agent id, else use logged in agent id --->
					<cfif isdefined('url.campaignid') and isdefined('getCampaign.agentid')>
						<input type="hidden" name="AgentID" value="#getCampaign.agentid#">
					<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '1'>
						<input type="hidden" name="AgentID" value="50">
					<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '3'>
						<input type="hidden" name="AgentID" value="9">
					<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '4'>
						<input type="hidden" name="AgentID" value="9">
					<cfelseif isdefined('cookie.LoggedInAgentID')>
						<input type="hidden" name="AgentID" value="#cookie.LOGGEDINAGENTID#">
					</cfif>



				<cfif isdefined('url.campaignID')>
					<input type="hidden" name="campaignID" value="#url.campaignID#">
					<input type="hidden" name="status" value="#getCampaign.status#">
				</cfif>


				<!--- Determines whether we have to insert a new step into DB when saving or update the step --->
<!--- 				<cfif isdefined('HasOne')><input type="hidden" name="HasOne" value="yes"></cfif>
				<cfif isdefined('HasTwo')><input type="hidden" name="HasTwo" value="yes"></cfif>
				<cfif isdefined('HasThree')><input type="hidden" name="HasThree" value="yes"></cfif>
				<cfif isdefined('HasFour')><input type="hidden" name="HasFour" value="yes"></cfif>
				<cfif isdefined('HasFive')><input type="hidden" name="HasFive" value="yes"></cfif> --->
				<cfset dtHour = CreateTimeSpan(0,0,30,0) />
				<cfset dfHour = "6:30 AM">
						
			<header>
				<div class="panel">
					<div class="panel-heading">
						<cfoutput>
							<h4 style="float: right;"><cfif isdefined('url.campaignID') or isdefined('form.campaignID')>Edit<cfelse>Create</cfif> Drip Campaign</h4>
							<h2><a hreflang="en" href="contact-details.cfm?id=#url.clientid#">#getAcct.firstname# #getAcct.lastname#</a></h2>
							<cfif getAcct.donotsend eq "1"><span style="color:red;">NOTE: Lead has opted out of receiving emails.</span></cfif>	
						</cfoutput>
					</div>
					<div class="panel-body">

						<ul>
							<li>
								<label for="PlanName">Plan Name</label>
								<input id="PlanName" type="text" name="PlanName"  <cfif isdefined('url.campaignid')>value="#getCampaign.PlanName#"</cfif> />
							</li>
							<li>
								<label for="LeadScore">Score</label>
								<input id="LeadScore" type="text" name="LeadScore" readonly <cfif isdefined('url.campaignid')>value="#getCampaign.LeadScore#"<cfelse>value="0"</cfif> />
							</li>
							<li class="save">
								<input type="submit" value="Save"><!--- <a hreflang="en" href="#">Save</a> --->
							</li>
							<cfif isdefined('campaignid') and isdefined('clientid')>
								<li class="delete">
									<a hreflang="en" href="#cgi.script_name#?clientid=#clientid#&campaignid=#campaignid#&delete=deletecampaign" onclick="return confirm('Are you sure you wish to delete this Campaign?')">Delete</a> 
								</li>
							</cfif>

						<cfif isdefined('campaignid') and isdefined('clientid') and getCampaign.status eq 'Active'>
							<li class="copy">
								<a hreflang="en" href="drip-campaign-lead-pause-resume.cfm?campaignid=#url.campaignid#&clientid=#clientid#&pause=">Pause</a>
							</li>
						<cfelseif isdefined('campaignid') and isdefined('clientid') and getCampaign.status eq 'Paused'>
							<li class="copy">
								<a hreflang="en" href="drip-campaign-lead-pause-resume.cfm?campaignid=#url.campaignid#&clientid=#clientid#&resume=">Resume</a>
							</li>
						</cfif>

						<cfif isdefined('campaignid') and isdefined('clientid')>
							<li class="copy" style="width:12%;">
								<a hreflang="en" href="drip-campaign-lead-save-to-library.cfm?campaignid=#campaignid#&clientid=#clientid#">Save to Library</a>
							</li>
						</cfif>

						</ul>

						<ul>
							<li>
								<h3>Campaign  settings</h3>
							</li>
							<li>
								<h3>Event triggers</h3>
							</li>

							<li>
								<label for="PlanDescription">Description</label>
								<input class="" id="PlanDescription" name="PlanDescription" type="text" <cfif isdefined('url.campaignid')>value="#getCampaign.PlanDescription#"</cfif> />
							</li>
							<li>
								<label>
									<input type="checkbox" name="AutoPauseEmail" value="1" <cfif isdefined('url.campaignid') and getCampaign.AutoPauseEmail eq 1>checked</cfif>>Auto-Pause plan when prospect replies / sends email
								</label>
							</li>

							<li>
								<cfif NOT isdefined('campaignid') and isdefined('clientid')>

									<label for="plan-name">Drip Library</label>
									<select name="LibCampaign" class="driplibrary"  onchange="javascript:location.href = this.value;">
										<option value="">- My Plans  &not;</option>
										<cfif isdefined('myPlans')>
											<cfloop query="myPlans">
												<option value="/admin/leadtracker/drip-campaign-lead-create-from-library.cfm?planid=#Lib_PlanID#&clientid=#clientid#">#Lib_LeadScore# : #Lib_PlanName#</option>
											</cfloop>
										</cfif>
										<option value="">- Other Plans &not;</option>
											<cfloop query="otherPlans">
												<option value="/admin/leadtracker/drip-campaign-lead-create-from-library.cfm?planid=#Lib_PlanID#&clientid=#clientid#">[#Lib_LeadScore#] #Lib_PlanName#</option>
											</cfloop>
									</select>
									<br><b>NOTE:</b> Selecting a plan above will immediately set up this campaign.
									<br>View Plans in <a hreflang="en" href="/admin/leadtracker/drip-library.cfm" target="_blank">Drip Library</a>.
								</cfif>
							</li>

							<li>
								<label>
									<input name="AutoPauseTalk" id="auto-pause" value="1" type="checkbox"  <cfif isdefined('url.campaignid') and getCampaign.AutoPauseTalk eq 1>checked</cfif>>Auto-Pause when a call is logged "Talked to Prospect"
								</label>
							</li>
						</ul>
					</div>
				</div>
			</header>

			<section id="start">
				<div class="panel">
					<div class="panel-body">
						<h2><a hreflang="en" href="##">START</a>
						</h2>
						<div class="checkbox">
							<!--- <h4>AUTO START</h4> --->
							<cfif isdefined('url.campaignid') and LEN(getCampaign.dripstartdate) and getCampaign.status eq 'Active'>
								<h4>This Campaign Start<cfif getCampaign.dripstartdate gt now()>s<cfelse>ed</cfif> on #dateformat(getCampaign.dripstartdate, 'mm/dd/yy')#</h4>
							<cfelseif isdefined('url.campaignid') and LEN(getCampaign.dripstartdate) and getCampaign.status eq 'Paused' and LEN(getCampaign.PausedOn)>
								<h4>This Campaign was Paused on #dateformat(getCampaign.PausedOn, 'mm/dd/yy')#</h4>
							<cfelseif isdefined('url.campaignid') and LEN(getCampaign.dripstartdate) and getCampaign.status eq 'Finished'>
								<h4>This Campaign has Finished</h4>
								<cfelse>
								<label for="auto-start">
									<input name="StartNow" id="auto-start" type="checkbox" value="1"><span style="font-weight:bold;">Automatically start this campaign upon saving</span>
								</label>
							</cfif>
						</div>
					</div>
				</div>
			</section>

			<section id="drip-tracker">

				<!-- open -->
				<div class="tracker open">

					<aside>
						<div>1</div>
					</aside>

					<div class="tracker-panel">
						<div class="wait">
							<h3>WAIT</h3>
				
							<select name="StepOneWait" class="selectpicker">
								<cfif isdefined('HasOne') and LEN(step1.WaitDays)>
									<option value="#step1.WaitDays#">#step1.WaitDays# Day<cfif step1.WaitDays neq 1>s</cfif></option>
								<cfelse>
									<cfloop from="1" to="365" index="i">
										<option value="#i#" <cfif isdefined('HasOne') and step1.WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
									</cfloop>
								</cfif>
							</select>

							<cfif isdefined('HasOne') and LEN(step1.ScheduledDate)><p>#dateformat(step1.ScheduledDate, 'mm/dd/yyyy')#</p></cfif>
							<cfif isdefined('HasOne') and LEN(step1.LastSent)><p class="sent">#dateformat(step1.LastSent, 'mm/dd/yyyy')#</p></cfif>
						</div>

 
						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepOneTemplateID" name="StepOneTemplateID" onChange="getStepOneTemplate(this.value);UpdateSubjectOne();" class="selectpicker">
										<option value="0"><cfif isdefined('HasOne') and step1.OriginalTemplateID eq 0>Template deleted - Stored version still available<cfelse>...</cfif></option>
										<cfloop query="getTemplates"> 
											<option value="#id#" <cfif isdefined('HasOne') and step1.OriginalTemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif> <cfif getTemplates.defaultentry eq 1>(recommended)</cfif></option>
										</cfloop>
									</select>

										<div id="StepOneTime">
											<div class="glyphicon glyphicon-time" id="StepOneTimeSelect"></div>
											<select class="selectpicker" name="StepOneSendAt">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('HasOne') and LEN(step1.ScheduledTime)><cfset step1Time = CreateODBCTime(TimeFormat(step1.ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('HasOne') and LEN(step1.ScheduledTime) and step1Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
													</cfloop>
												</select>
										</div>

								<button class="collapse" type="button" data-toggle="collapse" href="##template-1">
									<span></span>Collapse
								</button>
							</header>

							<ul id="template-1" class="collapse">
								<li>
									
									<ul>
										<li>
											<label for="StepOneSubject">Subject</label>
											<input id="StepOneSubject" name="StepOneSubject" type="text" placeholder="..." <cfif isdefined('HasOne')>value="#step1.EmailSubject#"</cfif> />
										</li>
										<li>
											<cfif isdefined('HasOne') and LEN(step1.FileLinkText)>Attached: <a hreflang="en" href="#step1.attachedfileurl#" target="_blank">#step1.FileLinkText#</a><br></cfif>
											<input id="upload-file1" name="StepOneFile" value="Attach File" type="file"/><!--- <a hreflang="en" href="##">Attach File</a> --->
											<textarea class="input textarea" name="StepOneMessagebody" id="StepOneTemplateChanged"><cfif isdefined('HasOne')>#step1.ModifiedTemplate#</cfif></textarea>
										</li>
										<li>
											<!--- <a hreflang="en" href="#">Copy Email to Template</a> --->
										</li>
									</ul>

								</li>
							</ul>

						</div>
					</div>
				</div>

				<div class="tracker open">

					<aside>
						<div>2</div>
					</aside>

					<div class="tracker-panel">
						<div class="wait">
							<h3>WAIT</h3>
			
							<select name="StepTwoWait" class="selectpicker">
								<cfif isdefined('HasTwo') and LEN(step2.WaitDays)>
									<option value="#step2.WaitDays#">#step2.WaitDays# Day<cfif step2.WaitDays neq 1>s</cfif></option>
								<cfelse>
									<cfloop from="1" to="365" index="i">
										<option value="#i#" <cfif isdefined('HasTwo') and step2.WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
									</cfloop>
								</cfif>
							</select>

							<cfif isdefined('HasTwo')><p>#dateformat(step2.ScheduledDate, 'mm/dd/yyyy')#</p></cfif>
							<cfif isdefined('HasTwo') and LEN(step2.LastSent)><p class="sent">#dateformat(step2.LastSent, 'mm/dd/yyyy')#</p></cfif>
						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepTwoTemplateID" name="StepTwoTemplateID" onChange="getStepTwoTemplate(this.value);UpdateSubjectTwo();" class="selectpicker">
										<option value="0"><cfif isdefined('HasTwo') and step2.OriginalTemplateID eq 0>Template deleted - Stored version still available<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('HasTwo') and step2.OriginalTemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 2>(recommended)</cfif></option>
										</cfloop>
									</select>


										<div id="StepTwoTime">
											<div class="glyphicon glyphicon-time" id="StepTwoTimeSelect"></div>
											<select class="selectpicker" name="StepTwoSendAt">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('HasTwo') and LEN(step2.ScheduledTime)><cfset step2Time = CreateODBCTime(TimeFormat(step2.ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('HasTwo') and LEN(step2.ScheduledTime) and step2Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
													</cfloop>
												</select>
										</div>


								<button class="collapse" type="button" data-toggle="collapse" href="##template-2">
									<span></span>Collapse
								</button>
							</header>

							<ul id="template-2" class="collapse">
								<li>
									
									<ul>
										<li>
											<label for="StepTwoSubject">Subject</label>
											<input id="StepTwoSubject" name="StepTwoSubject" type="text" placeholder="..." <cfif isdefined('HasTwo')>value="#step2.EmailSubject#"</cfif> />
										</li>
										<li>
											<cfif isdefined('HasTwo') and LEN(step2.FileLinkText)>Attached: <a hreflang="en" href="#step2.attachedfileurl#" target="_blank">#step2.FileLinkText#</a><br></cfif>
											<input id="upload-file2" name="StepTwoFile" type="file"/><!--- <a hreflang="en" href="##">Attach File</a> --->
											<textarea class="input textarea" name="StepTwoMessagebody" id="StepTwoTemplateChanged"><cfif isdefined('HasTwo')>#step2.ModifiedTemplate#</cfif></textarea>
										</li>
										<li>
											<!--- <a hreflang="en" href="#">Copy Email to Template</a> --->
										</li>
									</ul>

								
								</li>
							</ul>

						</div>
					</div>
				</div>



			<div class="tracker open">

					<aside>
						<div>3</div>
					</aside>

					<div class="tracker-panel">
						<div class="wait">
							<h3>WAIT</h3>

							<select name="StepThreeWait" class="selectpicker">
								<cfif isdefined('HasThree') and LEN(step3.WaitDays)>
									<option value="#step3.WaitDays#">#step3.WaitDays# Day<cfif step3.WaitDays neq 1>s</cfif></option>
								<cfelse>
									<cfloop from="1" to="365" index="i">
										<option value="#i#" <cfif isdefined('HasThree') and step3.WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
									</cfloop>
								</cfif>
							</select>

							<cfif isdefined('HasThree')><p>#dateformat(step3.ScheduledDate, 'mm/dd/yyyy')#</p></cfif>
							<cfif isdefined('HasThree') and LEN(step3.LastSent)><p class="sent">#dateformat(step3.LastSent, 'mm/dd/yyyy')#</p></cfif>
						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepThreeTemplateID" name="StepThreeTemplateID" onChange="getStepThreeTemplate(this.value);UpdateSubjectThree();" class="selectpicker">
										<option value="0"><cfif isdefined('HasThree') and step3.OriginalTemplateID eq 0>Template deleted - Stored version still available<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('HasThree') and step3.OriginalTemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 3>(recommended)</cfif></option>>#subject#</option>
										</cfloop>
									</select>


										<div id="StepThreeTime">
											<div class="glyphicon glyphicon-time" id="StepThreeTimeSelect"></div>
											<select class="selectpicker" name="StepThreeSendAt">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('HasThree') and LEN(step3.ScheduledTime)><cfset step3Time = CreateODBCTime(TimeFormat(step3.ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('HasThree') and LEN(step3.ScheduledTime) and step3Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
													</cfloop>
												</select>
										</div>

								<button class="collapse" type="button" data-toggle="collapse" href="##template-3">
									<span></span>Collapse
								</button>
							</header>

							<ul id="template-3" class="collapse">
								<li>
									
									<ul>
										<li>
											<label for="">Subject</label>
											<input id="StepThreeSubject" name="StepThreeSubject" type="text" placeholder="..." <cfif isdefined('HasThree')>value="#step3.EmailSubject#"</cfif> />
										</li>
										<li>
											<cfif isdefined('HasThree') and LEN(step3.FileLinkText)>Attached: <a hreflang="en" href="#step3.attachedfileurl#" target="_blank">#step3.FileLinkText#</a><br></cfif>
											<input id="upload-file3" name="StepThreeFile" type="file"/>
											<!--- <a hreflang="en" href="##">Attach File</a> --->
											<textarea class="input textarea" name="StepThreeMessagebody" id="StepThreeTemplateChanged"><cfif isdefined('HasThree')>#step3.ModifiedTemplate#</cfif></textarea>
										</li>
										<li>
											<!--- <a hreflang="en" href="#">Copy Email to Template</a> --->
										</li>
									</ul>

								
								</li>
							</ul>

						</div>
					</div>
				</div>				
				


			<div class="tracker open">

					<aside>
						<div>4</div>
					</aside>

					<div class="tracker-panel">
						<div class="wait">
							<h3>WAIT</h3>
		
							<select name="StepFourWait" class="selectpicker">
								<cfif isdefined('HasFour') and LEN(step4.WaitDays)>
									<option value="#step4.WaitDays#">#step4.WaitDays# Day<cfif step4.WaitDays neq 1>s</cfif></option>
								<cfelse>
									<cfloop from="1" to="365" index="i">
										<option value="#i#" <cfif isdefined('HasFour') and step4.WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
									</cfloop>
								</cfif>
							</select>

							<cfif isdefined('HasFour')><p>#dateformat(step4.ScheduledDate, 'mm/dd/yyyy')#</p></cfif>
							<cfif isdefined('HasFour') and LEN(step4.LastSent)><p class="sent">#dateformat(step4.LastSent, 'mm/dd/yyyy')#</p></cfif>		
						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepFourTemplateID" name="StepFourTemplateID" onChange="getStepFourTemplate(this.value);UpdateSubjectFour();" class="selectpicker">
										<option value="0"><cfif isdefined('HasFour') and step4.OriginalTemplateID eq 0>Template deleted - Stored version still available<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('HasFour') and step4.OriginalTemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 4>(recommended)</cfif></option>>#subject#</option>
										</cfloop>
									</select>

										<div id="StepFourTime">
											<div class="glyphicon glyphicon-time" id="StepFourTimeSelect"></div>
											<select class="selectpicker" name="StepFourSendAt">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('HasFour') and LEN(step4.ScheduledTime)><cfset step4Time = CreateODBCTime(TimeFormat(step4.ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('HasFour') and LEN(step4.ScheduledTime) and step4Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
													</cfloop>
												</select>
										</div>


								<button class="collapse" type="button" data-toggle="collapse" href="##template-4">
									<span></span>Collapse
								</button>
							</header>

							<ul id="template-4" class="collapse">
								<li>
									
									<ul>
										<li>
											<label for="StepFourSubject">Subject</label>
											<input id="StepFourSubject" name="StepFourSubject" type="text" placeholder="..." <cfif isdefined('HasFour')>value="#step4.EmailSubject#"</cfif> />
										</li>
										<li>
											<!--- <a hreflang="en" href="##">Attach File</a> --->
											<cfif isdefined('HasFour') and LEN(step4.FileLinkText)>Attached: <a hreflang="en" href="#step4.attachedfileurl#" target="_blank">#step4.FileLinkText#</a><br></cfif>
											<input id="upload-file4" name="StepFourFile" type="file"/>
											<textarea class="input textarea" name="StepFourMessagebody" id="StepFourTemplateChanged"><cfif isdefined('HasFour')>#step4.ModifiedTemplate#</cfif></textarea>
										</li>
										<li>
											<!--- <a hreflang="en" href="#">Copy Email to Template</a> --->
										</li>
									</ul>

								
								</li>
							</ul>

						</div>
					</div>
				</div>				
				


			<div class="tracker open">

					<aside>
						<div>5</div>
					</aside>

					<div class="tracker-panel">
						<div class="wait">
							<h3>WAIT</h3>

							<select name="StepFiveWait" class="selectpicker">
								<cfif isdefined('HasFive') and LEN(step5.WaitDays)>
									<option value="#step5.WaitDays#">#step5.WaitDays# Day<cfif step5.WaitDays neq 1>s</cfif></option>
								<cfelse>
									<cfloop from="1" to="365" index="i">
										<option value="#i#" <cfif isdefined('HasFive') and step5.WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
									</cfloop>
								</cfif>
							</select>

							<cfif isdefined('HasFive')><p>#dateformat(step5.ScheduledDate, 'mm/dd/yyyy')#</p></cfif>
							<cfif isdefined('HasFive') and LEN(step5.LastSent)><p class="sent">#dateformat(step5.LastSent, 'mm/dd/yyyy')#</p></cfif>	
						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepFiveTemplateID" name="StepFiveTemplateID" onChange="getStepFiveTemplate(this.value);UpdateSubjectFive();" class="selectpicker">
										<option value="0"><cfif isdefined('HasFive') and step5.OriginalTemplateID eq 0>Template deleted - Stored version still available<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('HasFive') and step5.OriginalTemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 5>(recommended)</cfif></option>>#subject#</option>
										</cfloop>
									</select>

										<div id="StepFiveTime">
											<div class="glyphicon glyphicon-time" id="StepFiveTimeSelect"></div>
											<select class="selectpicker" name="StepFiveSendAt">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('HasFive') and LEN(step5.ScheduledTime)><cfset step5Time = CreateODBCTime(TimeFormat(step5.ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('HasFive') and LEN(step5.ScheduledTime) and step5Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
													</cfloop>
												</select>
										</div>


								<button class="collapse" type="button" data-toggle="collapse" href="##template-5">
									<span></span>Collapse
								</button>
							</header>

							<ul id="template-5" class="collapse">
								<li>
									
									<ul>
										<li>
											<label for="StepFiveSubject">Subject</label>
											<input id="StepFiveSubject" name="StepFiveSubject" type="text" placeholder="..." <cfif isdefined('HasFive')>value="#step5.EmailSubject#"</cfif> />
										</li>
										<li>
											<cfif isdefined('HasFive') and LEN(step5.FileLinkText)>Attached: <a hreflang="en" href="#step5.attachedfileurl#" target="_blank">#step5.FileLinkText#</a><br></cfif>
											<input id="upload-file5" name="StepFiveFile" type="file"/>
											<textarea class="input textarea" name="StepFiveMessagebody" id="StepFiveTemplateChanged"><cfif isdefined('HasFive')>#step5.ModifiedTemplate#</cfif></textarea>
										</li>
										<li>
											<!--- <a hreflang="en" href="#">Copy Email to Template</a> --->
										</li>
									</ul>

								
								</li>
							</ul>

						</div>
					</div>
				</div>				


			</section>




			<section id="repeat">
				<h2>REPEAT</h2>
				<div> 
				<select name="RepeatCampaign" class="selectpicker">
						<cfloop from="0" to="10" index="i">
							<option value="#i#" <cfif isdefined('url.campaignid') and getCampaign.RepeatCampaign eq i>selected</cfif>>#i# more time<cfif i neq 1>s</cfif></option>
						</cfloop>
				</select>
				</div>
				<div>
				<select name="RepeatAfter" class="selectpicker">
						<cfloop from="1" to="365" index="i">
							<option value="#i#" <cfif isdefined('url.campaignid') and getCampaign.RepeatAfter eq i>selected</cfif>>#i# day<cfif i neq 1>s</cfif></option>
						</cfloop>
				</select>
				</div>
			</section>

			<section id="finish">
				<div class="panel">
					<div class="panel-body">
						<h2><a hreflang="en" href="##">FINISH</a>
						</h2>
						<div class="checkbox">
							<h4>COLD</h4>
							<label for="cold">
								<input name="TurnToCold" id="cold" type="checkbox" value="1" <cfif isdefined('url.campaignid') and getCampaign.TurnToCold eq 1>checked<cfelseif isdefined('url.campaignid') and getCampaign.TurnToCold eq 0><cfelse>checked</cfif>>Uncheck option if you want to turn status off from COLD
							</label>
						</div>
					</div>
				</div>
			</section>

		</form>

	</cfoutput>




<cfif isdefined('url.campaignID') or isdefined('form.campaignID')>

			<header>
				<div class="panel">
					<div class="panel-heading">
						<cfoutput>
							<h4 style="float: right;"></h4>
							<h2>Campaign Email History</h2>
						
						</cfoutput>
					</div>
					<div class="panel-body">
						<ul>
							<li class="history-panel">
								<ul class="history-heading">
									<li><h4>Date Sent</h4></li>
									<li><h4>Email</h4></li>
									<li><h4>Opened</h4></li>
									<li><h4>Step</h4></li>
								</ul>
								<cfoutput query="getHistory">
									<ul class="history-results">
										<li>#DateFormat(getHistory.DateSent, 'm/d/yyyy')# #TimeFormat(getHistory.DateSent, 'h:mm')#</li>
										<li>#getHistory.EmailSubject#</li>
										<li><cfif LEN(getHistory.DateOpened)>#DateFormat(getHistory.DateOpened, 'm/d/yyyy')# #TimeFormat(getHistory.DateOpened, 'h:mm')#<cfelse>-</cfif></li>
										<li>#getHistory.StepNum#</li>  
									</ul>		
								</cfoutput>
							</li>
						</ul>

					</div>
				</div>
			</header>

	</cfif>



	</div>




	<!-- Grab Google CDN's jQuery, fall back to local if offline -->
	<!-- 2.0 for modern browsers, 1.10 for .oldie -->
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

	<!-- Bootstrap Core JavaScript -->
	<script src="js/_plugins/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.3/js/bootstrap-select.min.js"></script>
	<script>
		$('.selectpicker').selectpicker();
	</script>

<cfinclude template="components/footer.cfm">

