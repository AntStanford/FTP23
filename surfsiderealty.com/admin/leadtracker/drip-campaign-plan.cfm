<cfset thisPageTitle = "Drip Plan">

<cfinclude template="drip-campaign-plan_.cfm">

<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">


	<div class="container drip-campaign-lead">

	<cfoutput>

		<form action="drip-campaign-plan.cfm" method="post" role="form" name="thisform" onsubmit="return validatePlanForm();" enctype="multipart/form-data">
			<!--- 	
				<input type="hidden" name="Lib_PlanID" value="#url.planid#">
			<cfif isdefined('cookie.LOGGEDINAGENTID')><input type="hidden" name="Lib_AgentID" value="#cookie.LOGGEDINAGENTID#"></cfif> --->


					<!--- If Drip Campaign is set up, hide agent ID, if admin is logged in, set agent id to their agent id, else use logged in agent id --->
					<cfif isdefined('url.planid') and isdefined('getCampaign.agentid')>
						<input type="hidden" name="Lib_AgentID" value="#getCampaign.agentid#">
					<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '1'>
						<input type="hidden" name="Lib_AgentID" value="50">
					<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '3'>
						<input type="hidden" name="Lib_AgentID" value="9">
					<cfelseif isdefined('cookie.LoggedInAdminID') and cookie.LoggedInAdminID eq '4'>
						<input type="hidden" name="Lib_AgentID" value="9">
					<cfelseif isdefined('cookie.LoggedInAgentID')>
						<input type="hidden" name="Lib_AgentID" value="#cookie.LOGGEDINAGENTID#">
					</cfif>



				<cfif isdefined('url.planid')>
					<input type="hidden" name="Lib_PlanID" value="#url.planid#">
					<input type="hidden" name="Lib_UpdatedAt" value="#dateformat(now(), 'yyyy-mm-dd hh:mm:ss')#">
				<cfelse>
					<input type="hidden" name="Lib_CreatedAt" value="#dateformat(now(), 'yyyy-mm-dd hh:mm:ss')#">
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
							<h4 style="float: right;"><cfif isdefined('url.planid') or isdefined('form.planid')>Edit<cfelse>Create</cfif> Drip Plan</h4>
							<h2><a hreflang="en" href="drip-library.cfm">Library</a> - Drip Plan</h2>
						<!--- 						<cfif getAcct.donotsend eq "1"><span style="color:red;">NOTE: Lead has opted out of receiving emails.</span></cfif>	 --->
						</cfoutput>
					</div>
					<div class="panel-body">

						<ul>
							<li>
								<label for="Lib_PlanName">Plan Name</label>
								<input id="Lib_PlanName" type="text" name="Lib_PlanName"  <cfif isdefined('url.planid')>value="#getCampaign.Lib_PlanName#"</cfif> />
							</li>
							<li>
								<label for="LeadScore">Score</label>
								<input id="LeadScore" type="text" name="Lib_LeadScore" readonly  <cfif isdefined('url.planid') and LEN(getCampaign.Lib_LeadScore)>value="#getCampaign.Lib_LeadScore#"<cfelse>value="0"</cfif> />
							</li>

							
							<!--- Only Admins or Authors can edit Plans --->
							<cfif isdefined('url.planid') and isdefined('LoggedInAgentID') and getCampaign.Lib_AgentID eq cookie.LoggedInAgentID or isdefined('cookie.LoggedInAdminID')>
								<li class="save">
									<input type="submit" value="Save">
								</li>
								<cfif isdefined('url.planid')>
									<li class="delete">
										<a hreflang="en" href="#cgi.script_name#?planid=#url.planid#&deleteplan=yes" onclick="return confirm('Are you sure you wish to delete this Plan?')">Delete</a> 
									</li>
								</cfif>
							<cfelse>
								<li class="save">
									<input type="submit" value="Save">
								</li>	
							</cfif>

						</ul>

						<ul>
							<li>
								<h3>Plan Settings</h3>
							</li>
							<li>
								<h3>Event triggers</h3>
							</li>

							<li>
								<label for="Lib_PlanDescription">Description</label>
								<input class="" id="Lib_PlanDescription" name="Lib_PlanDescription" type="text" <cfif isdefined('url.planid')>value="#getCampaign.Lib_PlanDescription#"</cfif> />
							</li>
							<li>
								<label>
									<input type="checkbox" name="Lib_AutoPauseEmail" value="1" <cfif isdefined('url.planid') and getCampaign.Lib_AutoPauseEmail eq 1>checked</cfif>>Auto-Pause plan when prospect replies / sends email
								</label>
							</li>

							<li>
								
									<label for="Lib_Default">Set as Default</label> 
									<select name="Lib_Default" class="driplibrary" <cfif isdefined('cookie.LoggedInAdminID') is "0">disabled</cfif>>
										<option value="0" <cfif isdefined('url.planid') and getCampaign.Lib_Default eq 0>selected</cfif>>- Select type  &not;</option>
										<option value="1" <cfif isdefined('url.planid') and getCampaign.Lib_Default eq 1>selected</cfif>>Default - General</option>
										<option value="2" <cfif isdefined('url.planid') and getCampaign.Lib_Default eq 2>selected</cfif>>Default - eAlerts</option>
									</select>
									<br><b>NOTE:</b> There can only one Plan per Default type.<br>Any previously selected Plan for the type will be unselected.
								
							</li>

							<li>
								<label>
									<input name="Lib_AutoPauseTalk" id="auto-pause" value="1" type="checkbox"  <cfif isdefined('url.planid') and getCampaign.Lib_AutoPauseTalk eq 1>checked</cfif>>Auto-Pause when a call is logged "Talked to Prospect"
								</label>
							</li>
						</ul>
					</div>
				</div>
			</header>


			<section id="drip-tracker">

				<!-- open -->
				<div class="tracker open">

					<aside>
						<div>1</div>
					</aside>

					<div class="tracker-panel">
						<div class="wait">
							<h3>WAIT</h3>
				
							<select name="Lib_1_WaitDays" class="selectpicker">

									<cfloop from="1" to="365" index="i">
										<option value="#i#" <cfif isdefined('url.planid') and getCampaign.Lib_1_WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
									</cfloop>
				
							</select>

						</div>

 
						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepOneTemplateID" name="Lib_1_TemplateID" onChange="getStepOneTemplate(this.value);UpdateSubjectOne();" class="selectpicker">
										<option value="0"><cfif isdefined('url.planid') and getCampaign.Lib_1_TemplateID eq 0>N/A<cfelse>...</cfif></option>
										<cfloop query="getTemplates"> 
											<option value="#id#" <cfif isdefined('url.planid') and getCampaign.Lib_1_TemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif> <cfif getTemplates.defaultentry eq 1>(recommended)</cfif></option>
										</cfloop>
									</select>

										<div id="StepOneTime">
											<div class="glyphicon glyphicon-time" id="StepOneTimeSelect"></div>
											<select class="selectpicker" name="Lib_1_ScheduledTime">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('url.planid') and LEN(getCampaign.Lib_1_ScheduledTime)><cfset step1Time = CreateODBCTime(TimeFormat(getCampaign.Lib_1_ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('url.planid') and LEN(getCampaign.Lib_1_ScheduledTime) and step1Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
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
											<label for="Lib_1_Subject">Subject</label>
											<input id="StepOneSubject" name="Lib_1_Subject" type="text" placeholder="..." <cfif isdefined('url.planid')>value="#getCampaign.Lib_1_Subject#"</cfif> />
										</li>
										<li>
											<!--- 
											<cfif isdefined('url.planid') and LEN(step1.FileLinkText)>Attached: <a hreflang="en" href="#step1.attachedfileurl#" target="_blank">#step1.FileLinkText#</a><br></cfif>
											<input id="upload-file1" name="StepOneFile" value="Attach File" type="file"/><!--- <a hreflang="en" href="##">Attach File</a> --->
											 --->
											<textarea class="input textarea" name="Lib_1_ModifiedTemplate" id="StepOneTemplateChanged"><cfif isdefined('url.planid')>#getCampaign.Lib_1_ModifiedTemplate#</cfif></textarea>
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
			
							<select name="Lib_2_WaitDays" class="selectpicker">
								<cfloop from="1" to="365" index="i">
									<option value="#i#" <cfif isdefined('url.planid') and getCampaign.Lib_2_WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
								</cfloop>
							</select>

						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepTwoTemplateID" name="Lib_2_TemplateID" onChange="getStepTwoTemplate(this.value);UpdateSubjectTwo();" class="selectpicker">
										<option value="0"><cfif isdefined('url.planid') and getCampaign.Lib_2_TemplateID eq 0>N/A<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('url.planid') and getCampaign.Lib_2_TemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 2>(recommended)</cfif></option>
										</cfloop>
									</select>


										<div id="StepTwoTime">
											<div class="glyphicon glyphicon-time" id="StepTwoTimeSelect"></div>
											<select class="selectpicker" name="Lib_2_ScheduledTime">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('url.planid') and LEN(getCampaign.Lib_2_ScheduledTime)><cfset step2Time = CreateODBCTime(TimeFormat(getCampaign.Lib_2_ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('url.planid') and LEN(getCampaign.Lib_2_ScheduledTime) and step2Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
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
											<label for="Lib_2_Subject">Subject</label>
											<input id="StepTwoSubject" name="Lib_2_Subject" type="text" placeholder="..." <cfif isdefined('url.planid')>value="#getCampaign.Lib_2_Subject#"</cfif> />
										</li>
										<li>
											<!---
											 <cfif isdefined('url.planid') and LEN(step2.FileLinkText)>Attached: <a hreflang="en" href="#step2.attachedfileurl#" target="_blank">#step2.FileLinkText#</a><br></cfif>
											<input id="upload-file2" name="StepTwoFile" type="file"/><!--- <a hreflang="en" href="##">Attach File</a> ---> 
										--->
											<textarea class="input textarea" name="Lib_2_ModifiedTemplate" id="StepTwoTemplateChanged"><cfif isdefined('url.planid')>#getCampaign.Lib_2_ModifiedTemplate#</cfif></textarea>
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

							<select name="Lib_3_WaitDays" class="selectpicker">
								<cfloop from="1" to="365" index="i">
									<option value="#i#" <cfif isdefined('url.planid') and getCampaign.Lib_3_WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
								</cfloop>
							</select>

						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepThreeTemplateID" name="Lib_3_TemplateID" onChange="getStepThreeTemplate(this.value);UpdateSubjectThree();" class="selectpicker">
										<option value="0"><cfif isdefined('url.planid') and getCampaign.Lib_3_TemplateID eq 0>N/A<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('url.planid') and getCampaign.Lib_3_TemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 3>(recommended)</cfif></option>>#subject#</option>
										</cfloop>
									</select>


										<div id="StepThreeTime">
											<div class="glyphicon glyphicon-time" id="StepThreeTimeSelect"></div>
											<select class="selectpicker" name="Lib_3_ScheduledTime">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('url.planid') and LEN(getCampaign.Lib_3_ScheduledTime)><cfset step3Time = CreateODBCTime(TimeFormat(getCampaign.Lib_3_ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('url.planid') and LEN(getCampaign.Lib_3_ScheduledTime) and step3Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
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
											<input id="StepThreeSubject" name="Lib_3_Subject" type="text" placeholder="..." <cfif isdefined('url.planid')>value="#getCampaign.Lib_3_Subject#"</cfif> />
										</li>
										<li><!--- 
											<cfif isdefined('url.planid') and LEN(step3.FileLinkText)>Attached: <a hreflang="en" href="#step3.attachedfileurl#" target="_blank">#step3.FileLinkText#</a><br></cfif>
											<input id="upload-file3" name="StepThreeFile" type="file"/> --->
											<!--- <a hreflang="en" href="##">Attach File</a> --->
											<textarea class="input textarea" name="Lib_3_ModifiedTemplate" id="StepThreeTemplateChanged"><cfif isdefined('url.planid')>#getCampaign.Lib_3_ModifiedTemplate#</cfif></textarea>
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
		
							<select name="Lib_4_WaitDays" class="selectpicker">
								<cfloop from="1" to="365" index="i">
									<option value="#i#" <cfif isdefined('url.planid') and getCampaign.Lib_4_WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
								</cfloop>
							</select>
	
						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepFourTemplateID" name="Lib_4_TemplateID" onChange="getStepFourTemplate(this.value);UpdateSubjectFour();" class="selectpicker">
										<option value="0"><cfif isdefined('url.planid') and getCampaign.Lib_4_TemplateID eq 0>N/A<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('url.planid') and getCampaign.Lib_4_TemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 4>(recommended)</cfif></option>>#subject#</option>
										</cfloop>
									</select>

										<div id="StepFourTime">
											<div class="glyphicon glyphicon-time" id="StepFourTimeSelect"></div>
											<select class="selectpicker" name="Lib_4_ScheduledTime">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('url.planid') and LEN(getCampaign.Lib_4_ScheduledTime)><cfset step4Time = CreateODBCTime(TimeFormat(getCampaign.Lib_4_ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('url.planid') and LEN(getCampaign.Lib_4_ScheduledTime) and step4Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
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
											<input id="StepFourSubject" name="Lib_4_Subject" type="text" placeholder="..." <cfif isdefined('url.planid')>value="#getCampaign.Lib_4_Subject#"</cfif> />
										</li>
										<li>
											<!--- <a hreflang="en" href="##">Attach File</a> ---><!--- 
											<cfif isdefined('url.planid') and LEN(step4.FileLinkText)>Attached: <a hreflang="en" href="#step4.attachedfileurl#" target="_blank">#step4.FileLinkText#</a><br></cfif>
											<input id="upload-file4" name="StepFourFile" type="file"/> --->
											<textarea class="input textarea" name="Lib_4_ModifiedTemplate" id="StepFourTemplateChanged"><cfif isdefined('url.planid')>#getCampaign.Lib_4_ModifiedTemplate#</cfif></textarea>
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

							<select name="Lib_5_WaitDays" class="selectpicker">
								<cfloop from="1" to="365" index="i">
									<option value="#i#" <cfif isdefined('url.planid') and getCampaign.Lib_5_WaitDays eq i>selected</cfif>>#i# Day<cfif i neq 1>s</cfif></option>
								</cfloop>
							</select>

						</div>

						<div class="controls open">

							<header>
								<div class="icon-search"></div>
									<select id="StepFiveTemplateID" name="Lib_5_TemplateID" onChange="getStepFiveTemplate(this.value);UpdateSubjectFive();" class="selectpicker">
										<option value="0"><cfif isdefined('url.planid') and getCampaign.Lib_5_TemplateID eq 0>N/A<cfelse>...</cfif></option>
										<cfloop query="getTemplates">
										<option value="#id#" <cfif isdefined('url.planid') and getCampaign.Lib_5_TemplateID eq getTemplates.ID>selected</cfif> <cfif getTemplates.status eq 0>disabled</cfif>>#subject# <cfif getTemplates.status eq 0>(inactive)</cfif>  <cfif getTemplates.defaultentry eq 5>(recommended)</cfif></option>>#subject#</option>
										</cfloop>
									</select>

										<div id="StepFiveTime">
											<div class="glyphicon glyphicon-time" id="StepFiveTimeSelect"></div>
											<select class="selectpicker" name="Lib_5_ScheduledTime">
													<cfloop index="dtTime" from="1:00 AM" to="11:30 PM" step="#dtHour#">
														<cfset compareTime =  #CreateODBCTime(dtTime)#>
														<cfif isdefined('url.planid') and LEN(getCampaign.Lib_5_ScheduledTime)><cfset step5Time = CreateODBCTime(TimeFormat(getCampaign.Lib_5_ScheduledTime, 'hh:mm:ss tt'))></cfif>
														<option value="#TimeFormat( dtTime, "hh:mm:ss TT")#" <cfif isdefined('url.planid') and LEN(getCampaign.Lib_5_ScheduledTime) and step5Time eq compareTime>selected<cfelseif TimeFormat( dtTime, "hh:mm TT") eq dfHour>selected</cfif>>#TimeFormat( dtTime, "hh:mm TT" )#</option> 
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
											<input id="StepFiveSubject" name="Lib_5_Subject" type="text" placeholder="..." <cfif isdefined('url.planid')>value="#getCampaign.Lib_5_Subject#"</cfif> />
										</li>
										<li>
											<!--- <cfif isdefined('url.planid') and LEN(step5.FileLinkText)>Attached: <a hreflang="en" href="#step5.attachedfileurl#" target="_blank">#step5.FileLinkText#</a><br></cfif>
											<input id="upload-file5" name="StepFiveFile" type="file"/> --->
											<textarea class="input textarea" name="Lib_5_ModifiedTemplate" id="StepFiveTemplateChanged"><cfif isdefined('url.planid')>#getCampaign.Lib_5_ModifiedTemplate#</cfif></textarea>
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
				<select name="Lib_RepeatCampaign" class="selectpicker">
						<cfloop from="0" to="10" index="i">
							<option value="#i#" <cfif isdefined('url.planid') and getCampaign.Lib_RepeatCampaign eq i>selected</cfif>>#i# more time<cfif i neq 1>s</cfif></option>
						</cfloop>
				</select>
				</div>
				<div>
				<select name="Lib_RepeatAfter" class="selectpicker">
						<cfloop from="1" to="365" index="i">
							<option value="#i#" <cfif isdefined('url.planid') and getCampaign.Lib_RepeatAfter eq i>selected</cfif>>#i# day<cfif i neq 1>s</cfif></option>
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
								<input name="Lib_TurnToCold" id="cold" type="checkbox" value="1" <cfif isdefined('url.planid') and getCampaign.Lib_TurnToCold eq 1>checked<cfelseif isdefined('url.planid') and getCampaign.TurnToCold eq 0><cfelse>checked</cfif>>Uncheck option if you want to turn status off from COLD
							</label>
						</div>
					</div>
				</div>
			</section>

		</form>

	</cfoutput>



<!--- 
<cfif isdefined('url.planid') or isdefined('form.planid')>

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
 --->


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

