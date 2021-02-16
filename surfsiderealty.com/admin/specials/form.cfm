<cfif isdefined('url.id')>
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_specials where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
  </cfquery>
</cfif>

<cfset page.title ="Specials">
<cfset module = 'special'>
<cfinclude template="/admin/components/header.cfm">

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
					<label class="control-label">Active</label>
					<div class="controls">
						<select name="active">
						   <option value="Yes" <cfif parameterexists(id) and getinfo.active is "Yes">selected="selected"</cfif>>Yes</option>
							<option value="No" <cfif parameterexists(id) and getinfo.active is "No">selected="selected"</cfif>>No</option>							
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
				<label class="control-label">Advertise Start Date</label>
				<div class="controls">
					<input maxlength="255" name="startdate" type="text" class="datepicker" <cfif parameterexists(id)>value="#DateFormat(getinfo.startdate,'mm/dd/yyyy')#"</cfif>>
				</div>
        </div>
        
        <div class="control-group">
				<label class="control-label">Advertise End Date</label>
				<div class="controls">
					<input maxlength="255" name="enddate" type="text" class="datepicker" <cfif parameterexists(id)>value="#DateFormat(getinfo.enddate,'mm/dd/yyyy')#"</cfif>>
				</div>
        </div>
        
        <div class="control-group">
				<label class="control-label">Allowed Booking Start Date</label>
				<div class="controls">
					<input maxlength="255" name="allowedBookingStartDate" type="text" class="datepicker" <cfif parameterexists(id)>value="#DateFormat(getinfo.allowedBookingStartDate,'mm/dd/yyyy')#"</cfif>>
				</div>
        </div>
        
        <div class="control-group">
				<label class="control-label">Allowed Booking End Date</label>
				<div class="controls">
					<input maxlength="255" name="allowedBookingEndDate" type="text" class="datepicker" <cfif parameterexists(id)>value="#DateFormat(getinfo.allowedBookingEndDate,'mm/dd/yyyy')#"</cfif>>
				</div>
        </div>
                
        <div class="control-group">
				<label class="control-label">Page Slug</label>
				<div class="controls">
					<input maxlength="255" name="slug" type="text" <cfif parameterexists(id)>value="#getinfo.slug#"</cfif>>
					<div class="help-block">
					(This will be the web address for the detail page)
					</div>
				</div>
        </div>        
        
        <div class="control-group">
				<label class="control-label">Description</label>
				<div class="controls">						
               <textarea id="txtContent" name="description" rows="4" cols="30">
                  <cfif parameterexists(id)>#getinfo.description#</cfif>
               </textarea>               
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

		      <div class="help-block">
		         (800px max width for optimal load times)
		      </div>

         <cfif parameterexists(id) and len(getinfo.photo)>
           <br /><img src="/images/specials/#getinfo.photo#" width="200"><br />
           <div class="help-block">(Image preview)</div>
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