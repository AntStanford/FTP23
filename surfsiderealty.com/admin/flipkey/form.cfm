<cfif isdefined('url.propertyid')>
  <cfquery name="getinfo" dataSource="#settings.bcdsn#">
      select flipkeyid from flipkey_property_ids where propertyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">	
      and siteID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
  </cfquery>
</cfif>


<cfset page.title ="FlipKey Property IDs">
<cfset module = 'flipkey ID'>
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
      <h5>Edit Flipkey ID for <cfoutput>#url.name#</cfoutput></h5>
    </div>
    <div class="widget-content nopadding">
  
      <form action="submit.cfm" method="post" class="form-horizontal">
        <div class="control-group">
					<label class="control-label">Flipkey ID</label>
					<div class="controls">
						<input maxlength="255" name="flipkeyid" type="text" <cfif parameterexists(propertyid)>value="#getinfo.flipkeyid#"</cfif>>
					</div>
				</div>
				
					
        
				<div class="form-actions">
					<input type="submit" value="Submit" class="btn btn-primary">
          			<cfif isdefined('url.propertyid')>
					<input type="hidden" name="propertyid" value="#url.propertyid#">
					</cfif>
				</div>
      </form>
    
    </div>
  </div>
  
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">