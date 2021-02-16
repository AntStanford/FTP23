<cfset page.title ="Vacation Package Categories">
<cfset module = 'Vacation Package Categories'>
<cfinclude template="/admin/components/header.cfm">  
  
<cfif isdefined('url.id')>
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_vacation_packages where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
</cfif>

 <cfquery name="GetCategories" dataSource="#settings.dsn#">
    select * from cms_vacation_packages_categories order by name
  </cfquery>

<cfoutput>

  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">×</button>
      <strong>Update successful!</strong> Continue editing this #module# or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">×</button>
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
					<label class="control-label">Category</label>
					<div class="controls">
						<select name="category" style="width: 250px;">
							<option value=""> - Select A Category - </option>
							<cfloop query="GetCategories">
							  <option value="#name#" <cfif isdefined('url.id') and getinfo.category is "#name#">selected</cfif>>#name#</option>
							</cfloop>
						</select>
					</div>
				</div>
	  
	  			<div class="control-group">
					<label class="control-label">Active</label>
					<div class="controls">
						<select name="active" style="width: 250px;">
							<option value="Yes" selected>Yes</option>
							<option value="No" <cfif isdefined('url.id') and getinfo.active is "No">selected</cfif>>No</option>
						</select>
					</div>
				</div>

        		<div class="control-group">
					<label class="control-label">Name</label>
					<div class="controls">
						<input type="text" name="name" <cfif parameterexists(id)>value="#getinfo.name#"</cfif>>
					</div>
				</div>

        		<div class="control-group">
					<label class="control-label">Safe Name</label>
					<div class="controls">
						<input type="text" name="safename" <cfif parameterexists(id)>value="#getinfo.safename#"</cfif>><br>
						Letters and numbers only, no & " ), etc.
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Cost</label>
					<div class="controls">
						<input type="text" name="cost" <cfif parameterexists(id)>value="#getinfo.cost#"<cfelse>value="0.00"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Description</label>
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
              <a href="/images/vacationpackages/#getinfo.photo#" target="_blank" class="btn btn-mini"><i class="icon-eye-open"></i> View Image</a>
            </cfif>   
            <span class="help-block">Image must be resized to 800px wide (max) before uploaded.</span>
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