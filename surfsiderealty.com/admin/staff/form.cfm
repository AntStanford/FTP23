<cfset page.title ="Staff Members">
<cfset module = 'staff member'>
<cfinclude template="/admin/components/header.cfm">  
  
<cfif isdefined('url.id')>
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_staff where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
</cfif>

<cfoutput>

  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">&times;</button>
      <strong>Update successful!</strong> Continue editing this #module# or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">&times;</button>
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
  
      <form action="submit.cfm" method="post" class="form-horizontal" enctype="multipart/form-data">
        <div class="control-group">
					<label class="control-label">Name</label>
					<div class="controls">
						<input type="text" name="name" <cfif parameterexists(id)>value="#getinfo.name#"</cfif>>
					</div>
				</div>
        		<div class="control-group">
					<label class="control-label">Title</label>
					<div class="controls">
						<input type="text" name="title" <cfif parameterexists(id)>value="#getinfo.title#"</cfif>>
					</div>
				</div>
        		<div class="control-group">
					<label class="control-label">Category</label>
					<div class="controls">
						<cfquery name="GetCategories" datasource="#settings.dsn#">
							Select * from cms_staff_categories order by sort
						</cfquery>
						<select name="category" style="width:250px">
							<cfloop query="GetCategories">
								<option value="#GetCategories.category#" <cfif isdefined('url.id') and getinfo.category eq GetCategories.category>selected</cfif>>#GetCategories.category#</option>
							</cfloop>
						</select>
					</div>
				</div>
        		<div class="control-group">
					<label class="control-label">On Duty</label>
					<div class="controls">
						<select name="OnDuty" style="width:250px">
								<option value="0" selected>No</option>
								<option value="Booking" <cfif parameterexists(id) and getinfo.onduty eq 'Booking'>selected</cfif>>Booking</option>
								<option value="Sales" <cfif parameterexists(id) and getinfo.onduty eq 'Sales'>selected</cfif>>Sales</option>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">Phone</label>
					<div class="controls">
						<input type="text" name="phone" <cfif parameterexists(id)>value="#getinfo.phone#"</cfif>>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">Email</label>
					<div class="controls">
						<input type="text" name="email" <cfif parameterexists(id)>value="#getinfo.email#"</cfif>>
					</div>
				</div>
        		<div class="control-group">
					<label class="control-label">Bio</label>
					<div class="controls">
						<textarea name="description" style="height:100px"><cfif parameterexists(id)>#getinfo.description#</cfif></textarea>
					</div>
				</div>
        		<div class="control-group">
					<label class="control-label">Image</label>
			    <div class="controls">
			      <div class="uploader" id="uniform-undefined">
			        <input type="file" size="19" name="photo" style="opacity:0;">
			        <span class="filename">No file selected</span>
			        <span class="action">Choose File</span>
			      </div>				
            <cfif parameterexists(id) and len(getinfo.photo)>
              <a href="/images/staff/#getinfo.photo#" target="_blank" class="btn btn-mini"><i class="icon-eye-open"></i> View Image</a>
            </cfif>              
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