<cfset page.title ="FlipKey Property IDs">

<p>Delete this comment: This module currently built for Barefoot clients; change property query below as
needed for your PMS </p>

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select propertyid,name from bf_properties order by name
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">x</button>
    <strong>Flipkey ID updated!</strong>
  </div>
</cfif>

<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>No.</th>
      <th>Property</th>  
      <th>Flipkey ID</th>
      <th></th> 
    </tr>        
    <cfoutput query="getinfo">
       
       <cfquery name="getFlipKeyID" dataSource="#settings.bcdsn#">
         select flipkeyid from flipkey_property_ids where propertyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getinfo.propertyid#">
         and siteID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
       </cfquery>
       
	    <tr>
        <td width="45">#currentrow#.</td>
        <td>#name#</td> 
        <td>#getFlipKeyID.flipkeyid#</td>              
        <td width="50"><a href="form.cfm?propertyid=#propertyid#&name=#name#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Edit</a></td>
       </tr>
    </cfoutput>
    </table>
  </div>
</div>
</cfif>

<cfinclude template="/admin/components/footer.cfm">