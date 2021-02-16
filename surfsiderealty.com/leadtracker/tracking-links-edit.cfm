<cfinclude template="tracking-links_.cfm">
<cfinclude template="components/functions.cfm">


<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2><cfif parameterexists(url.id)>Edit<cfelse>Add</cfif> Tracking Link</h2></li>
						<li class="headlinks"><a hreflang="en" href="tracking-links.cfm">Back to Links</a></li>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<form action="tracking-links.cfm" method="post">
					<cfoutput><input type="hidden" name="theid" value="#getInfo.id#"></cfoutput>
					<table class="table table-hover table-striped">
						<tbody>
							<cfoutput>

								<tr><td width="150">Subject</td><td><input type="text" name="subject" <cfif parameterexists(url.id)>value="#getInfo.subject#"</cfif>></td></tr>
								 <cfif parameterexists(url.id)>
								 	<cfset encryptedID = EncryptID(#id#)>
									  <tr>
									    <td>Tracking Link</td>
									    					    <td><a hreflang="en" href="http://#server_name#/mls/index.cfm?linktracker=#encryptedID#" target="_blank">http://#server_name#/mls/index.cfm?linktracker=#encryptedID#</a> - use this link in any media campaign to track.
										</td>
									  </tr>
								 </cfif>
								<tr><td>Body</td><td><textarea name="body" id="editor1"><cfif parameterexists(url.id)>#getInfo.body#</cfif></textarea></td></tr>
								<tr><td colspan="2"><cfif parameterexists(url.id)><input type="submit" name="submit" value="Update"><cfelse><input type="submit" name="submit" value="Add"></cfif></td></tr>
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