<cfif isdefined('url.id')>
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_specials where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
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
  
      <form action="submit.cfm" method="post" class="form-horizontal">
        
        <div class="control-group">
				<label class="control-label">Title</label>
				<div class="controls">
					<input maxlength="255" name="title" type="text" <cfif parameterexists(id)>value="#getinfo.title#"</cfif>>
				</div>
        </div>
        
        <div class="control-group">
				<label class="control-label">Start Date</label>
				<div class="controls">
					<input maxlength="255" name="startdate" type="text" class="datepicker" <cfif parameterexists(id)>value="#DateFormat(getinfo.startdate,'mm/dd/yyyy')#"</cfif>>
				</div>
        </div>
        
        <div class="control-group">
				<label class="control-label">End Date</label>
				<div class="controls">
					<input maxlength="255" name="enddate" type="text" class="datepicker" <cfif parameterexists(id)>value="#DateFormat(getinfo.enddate,'mm/dd/yyyy')#"</cfif>>
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
				<div class="form-actions">
					<input type="submit" value="Submit" class="btn btn-primary">
          <cfif parameterexists(id)><input type="hidden" name="id" value="#url.id#"></cfif>
				</div>
      </form>
    
    </div>
  </div>
  
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">