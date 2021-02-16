<cfinclude template="drip-campaign-template_.cfm">
<cfinclude template="components/functions.cfm">


<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2><cfif parameterexists(url.id)>Edit<cfelse>Add</cfif> Drip Template</h2></li>
						<li class="headlinks"><a hreflang="en" href="drip-campaign-templates.cfm">Back to Templates</a></li>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<form action="drip-campaign-templates.cfm" method="post">
					<cfoutput>
						<cfif isdefined('url.id') and LEN(url.id)>
							<!--- For Editing a Template --->
							<input type="hidden" name="id" value="#url.id#">
							<input type="hidden" name="lastModified" value="#CreateODBCDateTime(now())#">
						<cfelse>
							<!--- For Adding a Template --->
							<input type="hidden" name="createdAt" value="#CreateODBCDateTime(now())#">
							<input type="hidden" name="lastModified" value="#CreateODBCDateTime(now())#">
						</cfif>
						<input type="hidden" name="theid" value="#getInfo.id#">
					</cfoutput>
					<table class="table table-hover table-striped">
						<tbody>
							<cfoutput>

								<tr><td width="150">Subject</td><td><input type="text" name="subject" <cfif parameterexists(url.id)>value="#getInfo.subject#"</cfif>></td></tr>
								
									<tr>
										<td>Status</td>
										<td>
											<select name="status" style="width:150px;">
												<option value="1">Active</option>
												<option value="0" <cfif isdefined('url.id') and LEN(url.id) and getInfo.status eq '0'>selected</cfif>>Not Active</option>
											</select>
										</td>
									</tr>

									<tr>
										<td>Default </td>
										<td>
											<select name="defaultentry" style="width:150px;">
												<option value="0"> not selected</option>
												<option value="1" <cfif isdefined('url.id') and LEN(url.id) and getInfo.defaultentry eq '1'>selected</cfif>>Step One</option>
												<option value="2" <cfif isdefined('url.id') and LEN(url.id) and getInfo.defaultentry eq '2'>selected</cfif>>Step Two</option>
												<option value="3" <cfif isdefined('url.id') and LEN(url.id) and getInfo.defaultentry eq '3'>selected</cfif>>Step Three</option>
												<option value="4" <cfif isdefined('url.id') and LEN(url.id) and getInfo.defaultentry eq '4'>selected</cfif>>Step Four</option>
												<option value="5" <cfif isdefined('url.id') and LEN(url.id) and getInfo.defaultentry eq '5'>selected</cfif>>Step Five</option>
											</select>
										</td> 
									</tr>
								<tr><td>Body</td><td><textarea name="body" style="width:100%;height:200px;"><cfif parameterexists(url.id)>#getInfo.body#</cfif></textarea><br>You Can Dynamically Input Client Information By Using The Following Syntax:<br>
									First Name = {{Firstname}}<br>
									Last Name = {{Lastname}}<br>
									Email = {{Email}}<br>
									Password = {{Password}}<br>
									Site Web Address = {{Fulllink}}<br>
									Agent Signature = {{Agentsignature}}
								</td></tr>
								


								<tr><td colspan="2"><cfif parameterexists(url.id)><input type="submit" name="submit" value="Update"><cfelse><input type="submit" name="submit" value="Add"></cfif></td></tr>
							</cfoutput>
						</tbody>
					</table>

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