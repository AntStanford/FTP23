<cfinclude template="agents-edit_.cfm">
<cfinclude template="components/functions.cfm">


<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2><cfif parameterexists(url.id)>Edit<cfelse>Add</cfif> Agent</h2></li>
						<li class="headlinks"><a hreflang="en" href="agents.cfm">Back to Agents</a></li>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<cfoutput><form action="agents-edit.cfm<cfif parameterexists(url.id)>?id=#id#</cfif>" method="post" enctype="multipart/form-data"></cfoutput>
					<input type="hidden" name="notifications_acct" value="no">
					<input type="hidden" name="notifications_login" value="no">
					<table class="table table-hover table-striped">
						<tbody>
							<cfoutput>
								<tr><td width="150">First Name</td><td><input type="text" name="firstname" <cfif parameterexists(url.id)>value="#getInfo.firstname#"</cfif>></td></tr>
								<tr><td>Last Name</td><td><input type="text" name="lastname" <cfif parameterexists(url.id)>value="#getInfo.lastname#"</cfif>></td></tr>
								<tr><td>Email</td><td><input type="text" name="email" <cfif parameterexists(url.id)>value="#getInfo.email#"</cfif>></td></tr>
								<tr><td>Password</td><td><input type="text" name="password" <cfif parameterexists(url.id)>value="#getInfo.password#"</cfif>></td></tr>
								<tr><td>Phone</td><td><input type="text" name="phone" <cfif parameterexists(url.id)>value="#getInfo.phone#"</cfif>></td></tr>
								<tr><td>Cell Phone</td><td><input type="text" name="cellphone" <cfif parameterexists(url.id)>value="#getInfo.cellphone#"</cfif>></td></tr>
								<tr><td>Title</td><td><input type="text" name="title" <cfif parameterexists(url.id)>value="#getInfo.title#"</cfif>></td></tr>
								<tr><td>Agent MLS ID</td><td><input type="text" name="AgentMLSID" <cfif parameterexists(url.id)>value="#getInfo.AgentMLSID#"</cfif>></td></tr>
								<tr><td>Website</td><td><input type="text" name="website" <cfif parameterexists(url.id)>value="#getInfo.website#"</cfif>></td></tr>
								<!--- <tr><td>Primary Agent</td><td><select name="primary" style="width:100px;"><option <cfif parameterexists(url.id) and getInfo.primary eq 'No'>selected</cfif>>No<option <cfif parameterexists(url.id) and getInfo.primary eq 'Yes'>selected</cfif>>Yes</select></td></tr>  --->
								<cfif mls.EnableRoundRobin eq "Yes">
									<tr><td>Round Robin</td><td><select name="roundrobin" style="width:100px;"><option <cfif parameterexists(url.id) and getInfo.roundrobin eq 'No'>selected</cfif>>No<option <cfif parameterexists(url.id) and getInfo.roundrobin eq 'Yes'>selected</cfif>>Yes</select></td></tr> 
								<cfelse>
									<input type="hidden" name="roundrobin" value="no">
								</cfif>
								<tr><td>Biography</td><td><textarea name="biography" id="editor1"><cfif parameterexists(url.id)>#getInfo.biography#</cfif></textarea></td></tr>
								<tr><td>Email Signature</td><td><textarea name="AgentEmailSignature" id="editor2"><cfif parameterexists(url.id)>#getInfo.AgentEmailSignature#</cfif></textarea></td></tr>
								<tr><td>Photo</td><td><input type="file" name="AgentPhoto" size="35" <cfif parameterexists(url.id)>value="#getinfo.AgentPhoto#"</cfif> style="width: 230px;"><cfif parameterexists(url.id) and LEN(getinfo.agentphoto)><br><img src="/mls/images/agents/sm_#getinfo.agentphoto#" alt="" border="0"></cfif></td></tr>
								<tr><td colspan="2"><cfif parameterexists(url.id)><input type="submit" value="Update"><cfelse><input type="submit" value="Add"></cfif></td></tr>
							</cfoutput>
						</tbody>
					</table>

				</div>
			</div>
		</section>

			
<script type="text/javascript">
	CKEDITOR.replace('editor1', {
	filebrowserBrowseUrl: '/admin/core5/index.cfm' 
	});
	CKEDITOR.config.toolbar = 'Full';
	CKEDITOR.config.width="100%";
	CKEDITOR.config.height="250";
</script>
<script type="text/javascript">
	CKEDITOR.replace('editor2', {
	filebrowserBrowseUrl: '/admin/core5/index.cfm' 
	});
	CKEDITOR.config.toolbar = 'Full';
	CKEDITOR.config.width="100%";
	CKEDITOR.config.height="250";
</script>

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