<cfset page.title ="Forms & Documents">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_assets where section = 'Documents' 
   order by createdAt desc
</cfquery>

<cfinclude template="/admin/components/header.cfm">  

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">�</button>
    <strong>Record deleted!</strong>
  </div>
</cfif>

<p><a href="form.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>

<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>No.</th>
      <th>Date</th>
      <th>Name</th>
      <th></th>       
    </tr>        
    <cfoutput query="getinfo">
      <tr>
        <td width="45">#currentrow#.</td>
        <td width="100">#DateFormat(createdAt,'mm/dd/yyyy')#</td>
        <td>#name#</td>
        <td width="180">
          <a href="/files/#thefile#" target="_blank" class="btn btn-mini btn-info"><i class="icon-eye-open icon-white"></i>View</a>
          <a href="form.cfm?id=#id#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Edit</a>
          <a href="submit.cfm?id=#id#&delete" class="btn btn-mini btn-danger"  data-confirm="Are you sure you want to delete this file?"><i class="icon-remove icon-white"></i> Delete</a>
        </td>         
      </tr>
    </cfoutput>
    </table>
  </div>
</div>
</cfif>

<cfinclude template="/admin/components/footer.cfm">