<cfinclude template="components/header.cfm">
<cfinclude template="components/navigation.cfm">

<cfif isdefined('longshift')>

<!---1pm to 9am check--->
	<cfquery datasource="#mls.dsn#" name="TimeExists">
		select thedate
		from cl_agent_on_duty
		where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#"> and DutyTime = '1pm - 9am' 
	</cfquery>
	
	<cfif TimeExists.recordcount eq 0>
	
			
			<cfquery datasource="#mls.dsn#">
			    INSERT INTO cl_agent_on_duty (agentid, DutyTime, thedate) 
			    VALUES(
			    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#agentid#">,
			    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#DutyTime#">,
				<cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#">)
			</cfquery>

	
	
	<cfelse>
	
			<CFQUERY NAME="UpdateQuery" DATASOURCE="#mls.dsn#">
				UPDATE cl_agent_on_duty
				SET 
				agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#agentid#">,
				DutyTime = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#DutyTime#">,
				thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#">
				where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#"> and DutyTime = '1pm - 9am' 
			</cfquery>
	
	  </cfif>
	</cfif>
	
	
	<cfif isdefined('shortshift')>
	<!---9am to 1pm check--->
	<cfquery datasource="#mls.dsn#" name="TimeExists">
		select thedate
		from cl_agent_on_duty
		where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#"> and DutyTime = '9am - 1pm' 
	</cfquery>
	
	<cfif TimeExists.recordcount eq 0>
	
			
			<cfquery datasource="#mls.dsn#">
			    INSERT INTO cl_agent_on_duty (agentid, DutyTime, thedate) 
			    VALUES(
			    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#agentid#">,
			    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#DutyTime#">,
				<cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#">)
			</cfquery>

	
	
	<cfelse>
	
			<CFQUERY NAME="UpdateQuery" DATASOURCE="#mls.dsn#">
				UPDATE cl_agent_on_duty
				SET 
				agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#agentid#">,
				DutyTime = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#DutyTime#">,
				thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#">
				where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#form.thedate#"> and DutyTime = '9am - 1pm'
			</cfquery>
	
	</cfif>
</cfif>


	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">
					<ul>
						<li class="headlinks"><h2>Agents</h2></li>
					</ul>                                      							
				</div>
				
				
				<cfset today = "#now()#">
				
				<cfquery datasource="#mls.dsn#" name="GetAgents">
					select *
					from cl_agents
					order by firstname
				</cfquery>
				
				<cfquery datasource="#mls.dsn#" name="GetAllAssignments">
					select *
					from cl_agent_on_duty
				</cfquery>
	
				
				
				
				<div class="panel-body">
					<table class="table table-hover table-striped">

						<thead>

							<tr>
								<th>Date</th>
								<th>Agent 9am - 1pm</th>
								<th>Agent 1pm - 9am</th>
								<th style="width:75px;"></th>
								<th style="width:75px;"></th>
							</tr>
						</thead>
						<tbody>
							<cfloop index="i" from="0" to="60" step="1">
							<cfoutput>
								<cfset CalendarDate = "#dateadd('d',i,now())#">
											
							
								
							<tr>
								<td>#dateformat(CalendarDate,'mm/dd/yyyy')#</td>
								
								<td>
								
								<cfquery datasource="#mls.dsn#" name="GetAllAssignment">
									select *
									from cl_agent_on_duty
									where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#CalendarDate#"> and DutyTime = '9am - 1pm'
								</cfquery>
								
								<form action="agent-on-duty.cfm" method="post">
										<input type="hidden" name="TheDate" value="#dateformat(CalendarDate,'mm/dd/yyyy')#">
										<input type="hidden" name="DutyTime" value="9am - 1pm">
										<select name="agentid">
											<option> - Select Agent - </option>
											<cfloop query="GetAgents">
												<option value="#id#" <cfif GetAllAssignment.agentid is #id#>selected</cfif>>#firstname# #lastname#</option>
											</cfloop>
										</select>
										<input type="submit" name="Submit" value="Submit">
										<input type="hidden" name="shortshift" value="">
									</form>
								
								</td>
								
								<td>
								
								<cfquery datasource="#mls.dsn#" name="GetAllAssignment">
									select *
									from cl_agent_on_duty
									where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#CalendarDate#"> and DutyTime = '1pm - 9am'
								</cfquery>
								
									<form action="agent-on-duty.cfm" method="post">
										<input type="hidden" name="TheDate" value="#dateformat(CalendarDate,'mm/dd/yyyy')#">
										<input type="hidden" name="DutyTime" value="1pm - 9am">
										<select name="agentid">
											<option> - Select Agent - </option>
											<cfloop query="GetAgents">
												<option value="#id#" <cfif GetAllAssignment.agentid is #id#>selected</cfif>>#firstname# #lastname#</option>
											</cfloop>
										</select>
										<input type="submit" name="Submit" value="Submit">
										<input type="hidden" name="longshift" value="">
									</form>
								
								</td>
								<td></td>
								<td></td>
							</tr>
							</cfoutput>
							</cfloop>
						</tbody>
					</table>



				</div>
			</div>
		</section>

			



<cfinclude template="components/footer.cfm">