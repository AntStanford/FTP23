<cfset page.title ="Property Reviews">
<cfset module = 'review'>
<cfinclude template="/admin/components/header.cfm">

<cfif settings.booking.pms eq 'Homeaway'>
   
   <cfquery name="getProperties" dataSource="#settings.dsn#">
      select strpropid,strname from pp_propertyinfo order by strname
   </cfquery>

<cfelseif settings.booking.pms eq 'Barefoot'>
   
   <cfquery name="getProperties" dataSource="#settings.dsn#">
      select propertyid,name from bf_properties order by name
   </cfquery>

<cfelseif settings.booking.pms eq 'Escapia'>
   
   <cfquery name="getProperties" dataSource="#settings.dsn#">
      select unitcode,unitshortname from escapia_properties order by unitshortname
   </cfquery>

</cfif>


<cfoutput>

  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Update successful!</strong> Continue editing this #module# or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Success!</strong> Add another #module# or <a href="index.cfm">go back.</a>
    </div>
  </cfif>
  
  <div class="widget-box">
    <div class="widget-title">
      <span class="icon">
        <i class="icon-th"></i>
      </span>
      <h5>Add / Edit Form</h5>
    </div>
    <div class="widget-content nopadding">
  
      <form action="submit.cfm" method="post" class="form-horizontal">
            
            <div class="control-group">
					<label class="control-label">Property</label>
					<div class="controls">
						<select name="propertyid" style="width:300px">
						   <option value=" ">- Select One -</option>
						   <cfif settings.booking.pms eq 'Homeaway'>
   						   <cfloop query="getProperties">
   						      <option value="#strpropid#">#strname#</option>
   						   </cfloop>
   						<cfelseif settings.booking.pms eq 'Barefoot'>
   						   <cfloop query="getProperties">
   						      <option value="#propertyid#">#name#</option>
   						   </cfloop>
   						<cfelseif settings.booking.pms eq 'Escapia'>
   						   <cfloop query="getProperties">
   						      <option value="#unitcode#">#unitshortname#</option>
   						   </cfloop>
   						</cfif>
						</select>
					</div>
				</div>
								
            <div class="control-group">
					<label class="control-label">First Name</label>
					<div class="controls">
						<input maxlength="255" name="firstname" type="text" <cfif parameterexists(id)>value="#getinfo.firstname#"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Last Name</label>
					<div class="controls">
						<input maxlength="255" name="lastname" type="text" <cfif parameterexists(id)>value="#getinfo.lastname#"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Home Town</label>
					<div class="controls">
						<input maxlength="255" name="hometown" type="text" <cfif parameterexists(id)>value="#getinfo.hometown#"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Email</label>
					<div class="controls">
						<input maxlength="255" name="email" type="text" <cfif parameterexists(id)>value="#getinfo.email#"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Check-In Date</label>
					<div class="controls">
						<input maxlength="255" readonly="readonly" class="datepicker" name="checkInDate" type="text" <cfif parameterexists(id)>value="#getinfo.checkInDate#"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Check-Out Date</label>
					<div class="controls">
						<input maxlength="255" readonly="readonly" class="datepicker" name="checkOutDate" type="text" <cfif parameterexists(id)>value="#getinfo.checkOutDate#"</cfif>>
					</div>
				</div>
				
            <div class="control-group">
              <label class="control-label" for="rating">Rating</label>
              <div class="controls">
                <select id="rating" name="rating" class="input-xlarge">
                  <option value="1">1 star</option>
                  <option value="2">2 stars</option>
                  <option value="3">3 stars</option>
                  <option value="4">4 stars</option>
                  <option value="5">5 stars</option>
                </select>
              </div>
            </div>
				
				<div class="control-group">
					<label class="control-label">Title</label>
					<div class="controls">
						<input maxlength="255" name="title" type="text" <cfif parameterexists(id)>value="#getinfo.title#"</cfif>>
					</div>
				</div>
				
            <div class="control-group">
					<label class="control-label">Review</label>
					<div class="controls">
						
            <textarea name="review" id="txtContent" rows="4" cols="30">
               <cfif parameterexists(id)>#getinfo.review#</cfif>
            </textarea>
            
                   
            
					</div>
				</div>
				<div class="form-actions">
					<input type="submit" value="Submit" class="btn btn-primary">
          <cfif parameterexists(id)><input type="hidden" name="id" value="#url.id#"></cfif>
				</div>
      </form>
    
    </div>
  </div>
  
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">