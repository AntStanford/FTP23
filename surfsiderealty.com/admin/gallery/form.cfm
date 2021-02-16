<cfset page.title ="Gallery">
<cfset module = 'photo'>
<cfinclude template="/admin/components/header.cfm">  
  
<cfif isdefined('url.id')>
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_assets where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
</cfif>

<cfoutput>

<cfif isdefined('url.success') and isdefined('url.id')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Update successful.</strong> Continue editing this #module# or <a href="index.cfm">go back.</a>
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
  			<i class="icon-picture"></i>
  		</span>
  		<h5>Add / Edit Form</h5>
  	</div>
  	
  	<div class="widget-content">
  	
      <form action="submit.cfm" method="post" enctype="multipart/form-data" class="form-horizontal">
  
        <div class="control-group">
  				<label class="control-label">Name</label>
  				<div class="controls">
  					<input maxlength="255" type="text" name="name" <cfif parameterexists(id)>value="#getinfo.name#"</cfif>>
  				</div>
  			</div>
  			
        <div class="control-group">
  				<label class="control-label">Image</label>
  				<div class="controls">
  					<input type="file" name="photo">
  					<span class="help-block">(Max width on photos is 800px - must be resized before uploaded)</span>
               <cfif parameterexists(id) and len(getinfo.thefile)>
                 <br />Preview:<br /><img src="/images/gallery/th_#getinfo.thefile#">
               </cfif>
  				</div>
  			</div>
  			
  			<div class="form-actions">
          <input type="submit" name="edit" value="Submit" class="btn btn-primary">
  				<cfif parameterexists(id)><input type="hidden" name="id" value="#url.id#"></cfif>
  			</div>
  			
      </form>
  
    </div>
    
  </div>

</cfoutput>

<cfinclude template="/admin/components/footer.cfm">