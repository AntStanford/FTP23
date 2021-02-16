<cfset page.title ="Vacation Package Categories">
<cfset module = 'Vacation Package Categories'>
<cfinclude template="/admin/components/header.cfm">  
  
<cfif isdefined('url.id')>
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_vacation_packages_categories where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
</cfif>

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
					<label class="control-label">Name</label>
					<div class="controls">
						<input type="text" name="name" <cfif parameterexists(id)>value="#getinfo.name#"</cfif>>
					</div>
				</div>
				
			<!--- 	<div class="control-group">
					<label class="control-label">Slug</label>
					<div class="controls">
						<input type="text" name="slug" <cfif parameterexists(id)>value="#getinfo.slug#"</cfif>>
					</div>
				</div>
			 --->
				
				
        <div class="control-group">
					<label class="control-label">Image</label>
			    <div class="controls">
			      <div class="uploader" id="uniform-undefined">
			        <input type="file" size="19" name="photo" style="opacity:0;">
			        <span class="filename">No file selected</span>
			        <span class="action">Choose File</span>
			      </div>				
            <cfif parameterexists(id) and len(getinfo.photo)>
              <a href="/images/vacation-packages/#getinfo.photo#" target="_blank" class="btn btn-mini"><i class="icon-eye-open"></i> View Image</a>
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