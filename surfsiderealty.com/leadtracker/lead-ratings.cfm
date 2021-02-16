<cfinclude template="lead-ratings_.cfm">
<cfinclude template="components/functions.cfm">

<cfinclude template="components/pagination.cfm">



<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2>Lead Ratings</h2></li>
						<cfif isdefined('url.id') and LEN(url.id)><li class="headlinks"><a hreflang="en" href="lead-ratings.cfm">View All</a></li></cfif>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<table class="table table-hover table-striped">

						<thead>

						<tr><td colspan="4">

							<form method="post" action="lead-ratings.cfm">
								<cfif isdefined('url.id') and LEN(url.id)><cfoutput><input type="hidden" name="theid" value="#url.id#"></cfoutput></cfif>
								<table id="dripSearch">
									<tr>
										<th>Rating Name</th>
										<th></th>
									</tr>
									<tr>
										<td><cfoutput><input type="text" name="ratingname" <cfif isdefined('url.id') and LEN(url.id)>value="#getInfo.rating#"</cfif>></cfoutput></td>
										<td><cfif isdefined('url.id') and LEN(url.id)><input type="submit" name="submit" value="Edit"><cfelse><input type="submit" name="submit" value="Add"></cfif></td>
									</tr>
								</table>
							</form>

						</td></tr>

							<tr>
								<th style="width:50px;"></th>
								<th>Rating</th>
								<th style="width:75px;"></th>
								<th style="width:75px;"></th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getInfo" startrow="#tracker.startRow#" maxrows="#tracker.maxRows#">
							<tr>
								<td>#currentrow#.</td>
								<td>#rating#</td>
								<td><a hreflang="en" href="lead-ratings.cfm?id=#id#" class="edit">Edit</a></td>
								<td><a hreflang="en" href="lead-ratings.cfm?id=#id#&delete=yes" class="delete" onclick="return confirm('Are you sure you wish to delete this Rating?')">Delete</a></td>
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