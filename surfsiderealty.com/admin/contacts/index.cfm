<cfset page.title = 'Contacts'>

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_contacts order by CREATEDAT DESC,firstname
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>Record deleted!</strong>
  </div>
</cfif>

<p>
  <a href="form.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a>
  <cfif getinfo.recordcount gt 0>
    <a href="export.cfm" class="btn btn-primary"><i class="icon-file icon-white"></i> Download Contacts (XLS)</a>
  </cfif>
</p>

<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>No.</th>
      <th>Name</th>
      <th>Came From</th>         
      <th></th>
      <th></th>  
    </tr>      
    <cfoutput query="getinfo">
      <tr>
        <td>#currentrow#.</td>
        <td>#firstname# #lastname#</td> 
        <td>#camefrom#</td>                    
        <td width="50"><a href="form.cfm?id=#id#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Edit</a></td>
        <td width="65"><a href="submit.cfm?id=#id#&delete"  data-confirm="Are you sure you want to delete this contact?" class="btn btn-mini btn-danger"><i class="icon-remove icon-white"></i> Delete</a></td>         
      </tr>
    </cfoutput>
    </table>
  </div>
</div>
</cfif>

<cfinclude template="/admin/components/footer.cfm">