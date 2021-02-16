<cfif isdefined('url.id')>
<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from vacation_package_additions 
  where confirmationcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">
</cfquery>
</cfif>

<cfset page.title ="Vacation Packages">
<cfset module = 'Vacation Packages'>
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
  
      <form action="submit.cfm" method="post" class="form-horizontal">
	  
	  <cfloop query="getinfo">
	  
	  
	  		  <div class="control-group">
	            <label class="control-label"><strong>Package Category:</strong></label>
	            <div class="controls">
	             #packagecategory#
	            </div>
	          </div>
			  
			  <div class="control-group">
	            <label class="control-label"><strong>Package Name:</strong></label>
	            <div class="controls">
	             #packagename#
	            </div>
	          </div>
			  
			  <div class="control-group">
	            <label class="control-label"><strong>Package Cost:</strong></label>
	            <div class="controls">
	             #dollarformat(packagecost)#
	            </div>
	          </div>
			  
			  <hr>
			  
			  </cfloop>
	  
	  
        <div class="control-group">
					<label class="control-label">Mark as processed</label>
					<div class="controls">
						<input type="checkbox" name="processed" value="Yes" <cfif parameterexists(id) and getinfo.processed is "Yes">checked</cfif>>
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