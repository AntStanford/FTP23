<cfset page.title ="Meta Viewer">

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Record updated!</strong>
  </div>
  
   <cfquery datasource="#settings.dsn#">
	update cms_pages set 
    h1 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.h1#">,
    metatitle = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metatitle#">,
    metadescription = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.metadescription#">
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery> 
  
</cfif>

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_pages order by sort
</cfquery>

<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>No.</th>
      <th>Page</th>     
	  <th>Slug</th>
	  <th>Title</th>
	  <th>Description</th>
	  <th>H1</th>
      <th></th> 
    </tr>        
    <cfoutput query="getinfo">
	  <form action="quick-view.cfm?success=" method="post" class="form-horizontal">
      <tr>
        <td width="45">#currentrow#.</td>
        <td>#name#</td>   
		<td><a href="/#slug#" target="_blank">#slug#</a></td>            
		<td><textarea cols="15" rows="8" name="metatitle" class="mceNoEditor">#metatitle#</textarea></td>
		<td><textarea cols="15" rows="8" name="metadescription" class="mceNoEditor">#metadescription#</textarea></td>
		<td><textarea cols="15" rows="8" name="h1" class="mceNoEditor">#h1#</textarea></td>
        <td width="50"><input type="submit" value="Submit" class="btn btn-primary btn-danger"></td>
      </tr>
	  <input type="hidden" name="id" value="#id#">
	  </form>
    </cfoutput>
    </table>
  </div>
</div>
</cfif>

<cfinclude template="/admin/components/footer.cfm">