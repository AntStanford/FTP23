<cfinclude template="drip-library_.cfm">
<cfinclude template="components/functions.cfm">

<cfinclude template="components/pagination.cfm">



<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2>Drip Library</h2></li>
						<li class="headlinks"><a hreflang="en" href="drip-campaign-plan.cfm">Create Plan</a></li>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<table class="table table-hover table-striped">

						<thead>

						<tr><td colspan="7">

							<form method="post">
								<table id="dripSearch">
									<tr>
										<th>Plan Name</th>
										<th>Description</th>
										<th>Author</th>
										<th>Order By</th>
										<th></th>
									</tr>

									<tr>
									<cfoutput>
										<td><input type="text" name="planname" <cfif LEN(search.planname)>value="#search.planname#"</cfif>></td>
										<td><input type="text" name="description" <cfif LEN(search.description)>value="#search.description#"</cfif>></td>
									</cfoutput>
									<td><select name="agent">
											<option <cfif LEN(search.agent) and search.agent eq 'Only Me'>selected</cfif>>Only Me
											<option value="All" <cfif LEN(search.agent) and search.agent eq 'All'>selected</cfif>>All
										</select>
									</td>
									<td><select name="sortby">
										<option value="drip_library.lib_planname ASC" <cfif LEN(search.sortby) and search.sortby eq 'drip_library.lib_planname ASC'>selected</cfif>>Plan Name A-Z
										<option value="drip_library.lib_planname DESC" <cfif LEN(search.sortby) and search.sortby eq 'drip_library.lib_planname DESC'>selected</cfif>>Plan Name Z-A
										<option value="drip_library.Lib_LeadScore ASC" <cfif LEN(search.sortby) and search.sortby eq 'drip_library.Lib_LeadScore ASC'>selected</cfif>>Score Low to High
										<option value="drip_library.Lib_LeadScore DESC" <cfif LEN(search.sortby) and search.sortby eq 'drip_library.Lib_LeadScore DESC'>selected</cfif>>Score High to Low

										
									</select>
									</td>
									<td><input type="submit" value="Search"><input type="submit" value="Clear" name="Clear"></td>
									</tr>

								</table>
							</form>

						</td></tr>

							<tr>
								<th style="width:50px;">Score</th>
								<th style="width:130px;">Plan Name</th>
								<th>Description</th>
								<th style="width:130px;">Author</th>
								<th style="width:75px;">Default</th>
								<th style="width:100px;">Created</th>
								<th style="width:100px;">Updated</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getInfo">

							<cfquery dbtype="query" name="Agent">
								select firstname,lastname
								from getAgents
								where id = <cfqueryparam value="#Lib_Agentid#" cfsqltype="cf_sql_integer">
							</cfquery>

							<tr>
								<td>#Lib_LeadScore#</td>
								<td><a hreflang="en" href="drip-campaign-plan.cfm?planid=#lib_planid#" class="edit">#Lib_PlanName#</a></td>
								<td>#Lib_PlanDescription#</td>
								<td>#Agent.firstname# #Agent.lastname#</td>
								<td><cfif Lib_Default eq 1>General<cfelseif Lib_Default eq 2>eAlert</cfif></td>
								<td>#dateformat(Lib_CreatedAt, 'm/dd/yyyy')#<!---  #timeformat(Lib_CreatedAt, 'h:mm')# ---></td>
								<td>#dateformat(Lib_UpdatedAt, 'm/dd/yyyy')#<!---  #timeformat(Lib_UpdatedAt, 'h:mm')# ---></td>
								<td><a hreflang="en" href="drip-campaign-plan.cfm?planid=#lib_planid#" class="edit">view</a></td>
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