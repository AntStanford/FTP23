<cfinclude template="pages_.cfm">
<cfinclude template="components/functions.cfm">

<cfinclude template="components/header.cfm">

<cfinclude template="components/navigation.cfm">

	<div class="container">


		<section>
			<div class="panel">
				<div class="panel-heading">

					<ul>
						<li class="headlinks"><h2><cfif parameterexists(url.id)>Edit<cfelse>Add</cfif> Page</h2></li>
						<li class="headlinks"><a hreflang="en" href="pages.cfm">Back to Pages</a></li>
					</ul>           
                                                              							
				</div>
				<div class="panel-body">
					<form action="pages.cfm" method="post">
					<cfif isdefined('CreateSearchPage')>
						<input type="hidden" name="CreateSearchPage" value="">
					</cfif>
					<cfoutput><input type="hidden" name="theid" value="#getInfo.id#"></cfoutput>
					<table class="table table-hover table-striped">
						<tbody>
							<cfoutput>
								<tr>
									<td width="150">Status</td>
									<td>
										<select name="Status" style="width:150px;">
											<option value="active" <cfif parameterexists(url.id) and getinfo.TypeOfPage is "active">selected</cfif>>Active</option>
											<option value="inactive" <cfif parameterexists(url.id) and getinfo.TypeOfPage is "inactive">selected</cfif>>Inactive</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>Type of Page</td>
									<td>
										<select name="TypeOfPage" style="width:150px;">
											<option value="Standard" <cfif parameterexists(url.id) and getinfo.TypeOfPage is "Standard">selected</cfif>>Standard</option>
											<option value="Results" <cfif parameterexists(url.id) and getinfo.TypeOfPage is "Results">selected</cfif>>Search Results</option>
										</select>
									</td>
								</tr>
								  <tr>
								    <td>Page Title</td>
								    <td><input id="name" maxlength="255" name="name" size="40" type="text" <cfif parameterexists(url.id)>value="#getinfo.name#"</cfif> /></td>
								  </tr>
								  <tr>
								    <td>Page Slug</td> <!--- Creates dynamic slug only when adding new page not editing --->
								    <td><input type="text" name="slug" <cfif NOT parameterexists(url.id)>id="slug" class="slug"</cfif> <cfif parameterexists(url.id)>value="#getinfo.slug#"</cfif>> Use dashes "-" instead of spaces.  Ex: About-Us.  <br>NOTE: if you edit this, you will need to change any links that reference this slug.</td>
								  </tr>  
								  
								  <tr>
								    <td>H1 Tag</td>
								    <td><input maxlength="255" name="H1Tag" size="40" type="text" <cfif parameterexists(url.id)>value="#getinfo.H1Tag#"</cfif> /></td>
								  </tr>
								  
								   <tr>
								    <td>Meta Title</td>
								    <td><input maxlength="255" name="metatitle" size="70" type="text" <cfif parameterexists(url.id)>value="#getinfo.metatitle#"</cfif> /> <input type="button" value="Calculate Characters" onClick="countit3(this)" style="width:160px;float:left;"> <input type="text" name="displaycount3" size="3" style="width:160px;"></td>
								  </tr>
								    
								  <tr>
								    <td>Meta Keywords</td>
								    <td><textarea name="metakeywords" style="width:50%;height:100px;"><cfif parameterexists(url.id)>#getinfo.metakeywords#</cfif></textarea><br><input type="button" value="Calculate Characters"   onClick="countit(this)" style="width:160px;float:left;"> <input type="text" name="displaycount" size="3" style="width:160px;"></td>
								  </tr>
								  
								  <tr>
								    <td>Meta Description</td>
								    <td><textarea name="metadesc" style="width:50%;height:100px;"><cfif parameterexists(url.id)>#getinfo.metadesc#</cfif></textarea><br><input type="button" value="Calculate Characters" onClick="countit2(this)" style="width:160px;float:left;"> <input type="text" name="displaycount2" size="3" style="width:160px;"></td>
								  </tr>

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

<script language="JavaScript">
	function countit(what){

	formcontent=what.form.metakeywords.value
	what.form.displaycount.value=formcontent.length
	}

	function countit2(what){

	formcontent=what.form.metadesc.value
	what.form.displaycount2.value=formcontent.length
	}

	function countit3(what){

	formcontent=what.form.metatitle.value
	what.form.displaycount3.value=formcontent.length
	}
</script>


<cfinclude template="components/footer.cfm">