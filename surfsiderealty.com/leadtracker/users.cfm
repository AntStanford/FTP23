<cfinclude template="users_.cfm">
<cfinclude template="components/functions.cfm">

<cfinclude template="components/pagination.cfm">



<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2>Users</h2></li>
						<cfif isdefined('url.id') and LEN(url.id)><li class="headlinks"><a hreflang="en" href="users.cfm">View All</a></li></cfif>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<table class="table table-hover table-striped">

						<thead>

						<tr><td colspan="7">

							<form method="post" action="users.cfm">
								<cfif isdefined('url.id') and LEN(url.id)><cfoutput><input type="hidden" name="theid" value="#url.id#"></cfoutput></cfif>
								<table id="dripSearch">
									<tr>
										<th>Name</th>
										<th>Email</th>
										<th>Password</th>
										<th></th>
									</tr>
									<tr>
										<td><cfoutput><input type="text" name="thename" <cfif isdefined('url.id') and LEN(url.id)>value="#getInfo.name#" <cfelse>value=""</cfif>></cfoutput></td>
										<td><cfoutput><input type="text" name="theemail" <cfif isdefined('url.id') and LEN(url.id)>value="#getInfo.email#" <cfelse>value=""</cfif>></cfoutput></td>
										<td><cfoutput><input type="password" name="thepassword" <cfif isdefined('url.id') and LEN(url.id)>value="#getInfo.password#" <cfelse>value=""</cfif>></cfoutput></td>
										<td><cfif isdefined('url.id') and LEN(url.id)><input type="submit" name="submit" value="Edit"><cfelse><input type="submit" name="submit" value="Add"></cfif></td>
									</tr>
								</table>
							</form>

						</td></tr>

							<tr>
								<th style="width:50px;"></th>
								<th>Name</th>
								<th>Email</th>
								<th style="width:75px;"></th>
								<th style="width:75px;"></th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getInfo" startrow="#tracker.startRow#" maxrows="#tracker.maxRows#">
							<tr>
								<td>#currentrow#.</td>
								<td>#name#</td>
								<td>#email#</td>
								<td><a hreflang="en" href="users.cfm?id=#id#" class="edit">Edit</a></td>
								<td><a hreflang="en" href="users.cfm?id=#id#&delete=yes" class="delete" onclick="return confirm('Are you sure you wish to delete this User?')">Delete</a></td>
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