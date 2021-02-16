<cfset page.title ="Dashboard">

<cfquery name="GetNames" dataSource="#settings.dsn#">
  select * from phone_matcher_names order by firstname
</cfquery>

<cfinclude template="/admin/components/header.cfm">


  	
    <div class="alert alert-info">
      Welcome to your website's control panel. Use the navigation on the left to access each module.  Use the top right buttons to update your profile
      or manage your site's contact information.
      <a href="##" data-dismiss="alert" class="close">x</a>
    </div>
						 		
  	<div class="row-fluid">
  		<div class="span12">  			
  			<div class="widget-box">
  			   
  			  
						 
  				<div class="widget-title"><span class="icon"><i class="icon-signal"></i></span><h5>Site Statistics</h5><div class="buttons"><a href="javascript:;" onclick="window.location.reload();" class="btn btn-mini" id="fetchSeries"><i class="icon-refresh"></i> Update stats</a></div></div>
  				<div class="widget-content">
  					
					
					
					
					<div class="row-fluid">
  					<div class="span4">
					<form action="dashboard.cfm" method="post">
  						<select name="WhosePhone">
							<option value="-- Select A Phone To Track --" SELECTED>-- Select A Phone To Track --</option>
							<cfoutput query="GetNames">
							<option value="#id#">#firstname# #lastname#</option>
							</cfoutput>
						</select>
						<input type="submit" name="TrackGo" value="Track">		
					</form>		
  					</div>
					
  					<div class="span4">  						
  					<form action="dashboard.cfm" method="post">
  						<input type="text" class="form-control" placeholder="First Name" name="FirstName"> 
						<input type="text" class="form-control" placeholder="Last Name" name="LastName"> 
						<input type="text" class="form-control" placeholder="Alias" name="Alias">
						<input type="submit" name="TrackNameNumGo" value="Track">		
					</form>			  						
  					</div>	
					
					<div class="span4">  						
  					<form action="dashboard.cfm" method="post">
  						<input type="text" class="form-control" placeholder="Phone Number" name="PhoneNumber"> 
						<input type="submit" name="TrackNameNumGo" value="Track">		
					</form>			  						
  					</div>	
					
  					</div>
					
					
					<cfif isdefined('TrackGo')>
					
				
					
					<!--- <p>Get Numbers associated with Criminals phone</p> --->
					<cfquery name="GetNumbers" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers where phoneid = <cfqueryparam value="#WhosePhone#" cfsqltype="CF_SQL_VARCHAR"> order by phoneid					  
					</cfquery>
					
					<cfset ListOfNumbersToRun = "#valuelist(GetNumbers.tracknumber)#">					
					
					<!--- <p>Get a list of all the phones from the list</p> --->
					<cfquery name="GetUniquePhones" dataSource="#settings.dsn#">
					  select distinct(phoneid) as UniquePhoneIDs from phone_matcher_numbers where phoneid <> <cfqueryparam value="#WhosePhone#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
					
					<cfquery name="GetPhoneNames" dataSource="#settings.dsn#">
					  select firstname,lastname,id from phone_matcher_names
					</cfquery>
					
					<cfquery name="WhoWeTracking" dbtype="query">
						select * from GetPhoneNames where id = <cfqueryparam value="#WhosePhone#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
					
					
					<div class="widget-box">
						  <div class="widget-content nopadding">
						  <p>Tracking Numbers that <cfoutput>#WhoWeTracking.firstname# #WhoWeTracking.lastname#</cfoutput> has called.</p>
						    <table class="table table-bordered table-striped">
						    <tr>
						      <th>No.</th>
						      <th>First Name</th>
						      <th>Last Name</th> 
						      <th>Phone Number</th>  
						    </tr>  
							
							<cfloop index="i" list="#valuelist(GetUniquePhones.UniquePhoneIDs)#">
							<cfoutput>
							
							<cfquery name="GetPhoneName" dbtype="query">
								select * from GetPhoneNames where id = <cfqueryparam value="#i#" cfsqltype="CF_SQL_INTEGER">
							</cfquery>
							
							<cfquery name="GetMatches" dataSource="#settings.dsn#">
							  select * from phone_matcher_numbers 
							  where tracknumber in (<cfqueryparam value="#ListOfNumbersToRun#" cfsqltype="cf_sql_varchar" list="yes" />) and phoneid <> '#WhosePhone#' and phoneid = '#i#'
							</cfquery>
							
							<cfif GetMatches.recordcount gt 0>
							 <tr>
								 <td colspan="4">People on <strong>#GetPhoneName.firstname# #GetPhoneName.lastname#'s</strong> Call List that <strong>#WhoWeTracking.firstname# #WhoWeTracking.lastname#</strong> has spoken with.</td>
							</tr>
							
							<cfloop query="GetMatches">
							  <tr>
						        <td width="45">#currentrow#.</td>
						        <td width="50">#trackfirstname#</td>
						        <td width="50">#tracklastname#</td>
						        <td width="65"><a href="dashboard.cfm?TrackNameNumGo=&phonenumber=#tracknumber#">#tracknumber#</a></td>         
						      </tr>
							 </cfloop>
							 
							 </cfif>
							
							</cfoutput>
							</cfloop>
												
				
					</table>
			
					
				
					
					</cfif>
					
					
					
					
					<cfif isdefined('TrackNameNumGo')>
					
				
					
					<!--- <p>Get Numbers associated with Criminals phone</p> --->
					<cfquery name="GetNumbers" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers where 1=1
					  
					  <cfif isdefined('form.FirstName') and form.FirstName is not "">and trackfirstname like <cfqueryparam value="%#FirstName#%" cfsqltype="CF_SQL_VARCHAR"></cfif>
					  <cfif isdefined('form.LastName') and form.LastName is not "">and tracklastname like <cfqueryparam value="%#LastName#%" cfsqltype="CF_SQL_VARCHAR"></cfif>
					  <cfif isdefined('form.Alias') and form.Alias is not "">and trackalias like <cfqueryparam value="%#alias#%" cfsqltype="CF_SQL_VARCHAR"></cfif>
					  <cfif isdefined('PhoneNumber') and PhoneNumber is not "">and tracknumber = <cfqueryparam value="#PhoneNumber#" cfsqltype="CF_SQL_VARCHAR"></cfif>
					  
					  
					</cfquery>
														
					
					<div class="widget-box">
						  <div class="widget-content nopadding">
						  <p>
						  <cfoutput>
						  <cfif isdefined('PhoneNumber')>
						  Tracking phone number <strong>#phonenumber#</strong>
						  	<cfelse>
						  Tracking Numbers First Name is <cfif #form.firstname# is not ""><strong>#form.firstname#</strong><cfelse>N/A</cfif> and Last Name is <cfif #form.lastname# is not ""><strong>#form.lastname#</strong><cfelse>N/A</cfif> and alias is <cfif #form.alias# is not ""><strong>#form.alias#</strong><cfelse>N/A</cfif>.
						  </cfif>
						  
						</cfoutput>
						</p>
						    <table class="table table-bordered table-striped">
						    <tr>
						      <th>No.</th>
						      <th>First Name</th>
						      <th>Last Name</th> 
							  <th>Alias</th> 
						      <th>Phone Number</th> 
							  <th>Found on this person's phone</th> 
						    </tr>  
							
							
							
							<cfif GetNumbers.recordcount gt 0>
														
							<cfoutput query="GetNumbers">
							  <tr>
						        <td width="45">#currentrow#.</td>
						        <td width="50">#trackfirstname#</td>
						        <td width="50">#tracklastname#</td>
								<td width="50">#trackalias#</td>
						        <td width="65">#tracknumber#</td>         
								<td width="65"><a href="dashboard.cfm?trackgo=&WhosePhone=#phoneid#">#phonefirstname# #phonelastname#</a></td>   
						      </tr>
							 </cfoutput>
							 
							 </cfif>
							
						
												
				
					</table>
			
					
				
					
					</cfif>
					
					
					
										
  				</div>
  			</div>					
  		</div>
  	</div>

  	

  
<cfinclude template="/admin/components/footer.cfm">

<script src="/admin/bootstrap/js/excanvas.min.js"></script>
<script src="/admin/bootstrap/js/jquery.min.js"></script>
<script src="/admin/bootstrap/js/jquery.ui.custom.js"></script>
<script src="/admin/bootstrap/js/bootstrap.min.js"></script>
<script src="/admin/bootstrap/js/jquery.flot.min.js"></script>
<script src="/admin/bootstrap/js/jquery.flot.resize.min.js"></script>
<script src="/admin/bootstrap/js/jquery.peity.min.js"></script>
<script src="/admin/bootstrap/js/fullcalendar.min.js"></script>
<script src="/admin/bootstrap/js/unicorn.js"></script>






<!--- 	<p>Get Numbers associated with Brian's phone</p>
					
					
					<cfquery name="GetNumbers" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers where phoneid = '#WhosePhone#' order by phoneid
					</cfquery>
					
					<cfset ListOfNumbersToRun = "#valuelist(GetNumbers.tracknumber)#">
					
					<p>Get everyone's else to check and see if we have any matches.</p>
					
					<cfquery name="GetUniquePhones" dataSource="#settings.dsn#">
					  select distinct(phoneid) as UniquePhoneIDs from phone_matcher_numbers where phoneid <> '#WhosePhone#'
					</cfquery>
					
					
					<cfloop query="GetUniquePhones">
					<cfoutput><p>#UniquePhoneIDs#</p></cfoutput>
					
					<cfquery name="TestMatchesForThisUser" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers where phoneid = '#UniquePhoneIDs#'
					</cfquery>
					
						<cfloop query="#TestMatchesForThisUser#">
							<cfloop index="i" list="#valuelist(GetNumbers.tracknumber)#">
								<cfif i is "#tracknumber#"><cfoutput>#tracknumber# #trackfirstname# #tracklastname#<br></cfoutput></cfif>					
							</cfloop>
						</cfloop>
					
					</cfloop> --->
					
					<!--- THIS WORKS ALMOST
					
					<p>Get Numbers associated with Brian's phone</p>
					
					
					<cfquery name="GetNumbers" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers where phoneid = '#WhosePhone#' order by phoneid
					</cfquery>
					
					<cfset ListOfNumbersToRun = "#valuelist(GetNumbers.tracknumber)#">
					
					<cfdump var="#GetNumbers#">
					
					<p>Get everyone's else to check and see if we have any matches.</p>
					
					<cfquery name="GetUniquePhones" dataSource="#settings.dsn#">
					  select distinct(phoneid) as UniquePhoneIDs from phone_matcher_numbers where phoneid <> '#WhosePhone#'
					</cfquery>
					
					<cfdump var="#GetUniquePhones#">
					
					<p>Now Get all of Brian's numbers into a list and start search each profile returned.</p>
					<cfoutput>#valuelist(GetNumbers.tracknumber)#</cfoutput>
					
					
					<cfloop query="GetNumbers">
					
						<cfquery name="GetMatches" dataSource="#settings.dsn#">
						  select * from phone_matcher_numbers where tracknumber = '#tracknumber#' and phoneid <> '#WhosePhone#'
						</cfquery>
					<cfif getmatches.recordcount gt 0>
						
					<strong><cfoutput>#UniquePhoneIDs#</cfoutput></strong><Br>
					<cfdump var="#GetMatches#">
					
					</cfif>
					
					</cfloop> --->
					
					
					
					
					
					
					
					
					
					<!--- 	<cfloop query="GetNumbers">
					
					<cfquery name="GetMatches" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers where tracknumber = '#tracknumber#' and phoneid <> '#phoneid#'
					</cfquery>
					
					<cfoutput query="GetMatches">
					<cfif getmatches.recordcount gt 0>#phonefirstname# #phonelastname# has called #trackfirstname# #tracklastname#</cfif><br>
					</cfoutput>
					
					</cfloop> --->
					
					
					<!--- <cfquery name="GetNumbers" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers where phoneid = '#WhosePhone#'
					</cfquery>
					
					
					<cfquery name="WhoWeTracking" dataSource="#settings.dsn#">
					  select * from phone_matcher_names order by firstname
					</cfquery>
										
					
					<cfif GetNumbers.recordcount gt 0>
						<div class="widget-box">
						  <div class="widget-content nopadding">
						  <p>Tracking Numbers that <cfoutput>#WhoWeTracking.firstname# #WhoWeTracking.lastname#</cfoutput> has called.</p>
						    <table class="table table-bordered table-striped">
						    <tr>
						      <th>No.</th>
						      <th>First Name</th>
						      <th>Last Name</th> 
						      <th>Phone Number</th>  
						    </tr>  
							
							<cfloop query="GetNames">     
							
								<cfquery name="GetNumbersTheyHaveCalled" dataSource="#settings.dsn#">
								  select * from phone_matcher_numbers where tracknumber = '#tracknumber#'
								</cfquery>
								
								<cfdump var="#GetNumbersTheyHaveCalled#">
							 
						    <cfoutput query="GetNumbersTheyHaveCalled">
								<tr>
								 <td>##</td>
								</tr>
						      <tr>
						        <td width="45">#currentrow#.</td>
						        <td>#trackfirstname#</td>
						        <td width="50">#tracklastname#</td>
						        <td width="65">#tracknumber#</td>         
						      </tr>
						    </cfoutput>
							</cfloop>
						    </table>
						  </div>
						</div>
						</cfif> --->
						
						
						
						
						
						 	<!--- <cfoutput query="GetUniquePhones">
					
					<cfquery name="GetMatches" dataSource="#settings.dsn#">
					  select * from phone_matcher_numbers 
					  where tracknumber in (<cfqueryparam value="#ListOfNumbersToRun#" cfsqltype="cf_sql_varchar" list="yes" />) and phoneid <> '#WhosePhone#' and phoneid = '#UniquePhoneIDs#'
					</cfquery>
					
					<cfif getmatches.recordcount gt 0>
					
					<cfquery name="GetPhoneName" dbtype="query">
						select * from GetPhoneNames where id = <cfqueryparam value="#UniquePhoneIDs#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
					
								<!--- <cfdump var="#GetMatches#"> --->
					
						
							<cfoutput>
							 <tr>
								 <td colspan="4">#GetPhoneName.firstname# #GetPhoneName.lastname#</td>
								</tr> 
							<cfloop query="GetMatches">
						       <tr>
						        <td width="45">#currentrow#.</td>
						        <td>#GetMatches.trackfirstname#</td>
						        <td width="50">#GetMatches.tracklastname#</td>
						        <td width="65">#GetMatches.tracknumber#</td>         
						      </tr> 
							</cfloop>  
							
							</cfoutput>
					
					
					</cfif>
					</cfoutput> --->