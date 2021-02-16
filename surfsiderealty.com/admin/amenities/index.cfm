<cfset page.title ="Manage Your Amenities">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_amenities order by title
</cfquery>

<cfinclude template="/admin/components/header.cfm">  

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>The amenity has been updated.</strong>
  </div>
</cfif>

<cfif isdefined('url.delete')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>Review deleted</strong>
  </div>
</cfif>

<cfif settings.booking.pms eq 'Homeaway'>
   
   <cfif settings.booking.v12Client eq 'Yes'>
   	<p><a hreflang="en" href="form-homeaway-v12.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>
   <cfelse>
   	<p><a hreflang="en" href="form-homeaway.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>
   </cfif>   

<cfelseif settings.booking.pms eq 'Barefoot'>
   
   <p><a hreflang="en" href="form-barefoot.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>
   
<cfelseif settings.booking.pms eq 'Escapia'>
   
   <p><a hreflang="en" href="form-escapia.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>
      
</cfif>  

<div class="widget-box">
  <div class="widget-title">
    <span class="icon">
      <i class="icon-th"></i>
    </span>  
  	<h5><cfoutput>#page.title#</cfoutput></h5>
  </div>
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>No.</th>
      <th>Name</th>          
      <th></th>
    </tr>        
    <cfoutput query="getinfo">
      <tr>
        <td width="45">#currentrow#.</td>
        <td>#title#</td>           
        <td width="70"><a hreflang="en" href="submit.cfm?id=#id#&delete" class="btn btn-mini btn-danger" data-confirm="Are you sure you want to delete this amenity?"><i class="icon-trash icon-white"></i> Delete</a></td>      
      </tr>
    </cfoutput>
    </table>
  </div>
</div>

<cfinclude template="/admin/components/footer.cfm">