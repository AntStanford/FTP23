<cfset page.title ="Staff">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select cms_staff.*
  from cms_staff, cms_staff_categories
  where cms_staff_categories.category = cms_staff.category
  order by cms_staff_categories.sort, cms_staff.sort
</cfquery>

<cfinclude template="/admin/components/header.cfm">  

<cfif isdefined('url.successdelete')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>Record deleted!</strong>
  </div>
</cfif>

<cfif isdefined('url.successonduty')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>On Duty Changed!</strong>
  </div>
</cfif>

<cfif getinfo.recordcount gt 0>	
  <div class="alert alert-info">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Drag 'n drop the arrows to update sort order</strong> 
  </div>
</cfif>

<div class="alert alert-success" style="display:none" id="sortStatus">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Success!</strong> The sort order has been updated.
</div>

<p><a href="form.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>

<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    
    <table class="table">
       <tr>
         <th width="20">Sort</th>
         <th>Name</th>    
         <th width="170">Category</th>      
         <th width="50">Booking</th>
         <th width="50">Sales</th>                  
         <th width="50"></th>
         <th width="65"></th>
       </tr>
    </table>
    
    <ul id="sort-list">
    
    <cfoutput query="getinfo">
      
      <li id="listItem_#id#">
      
         <table class="table table-bordered table-striped">    
            <tr>
              <td width="30"><i class="icon-resize-vertical"></i></td>
              <td>#name#</td>   
              <td width="175">#category#</td>  
              <td width="55">
                <cfif onduty eq 'Booking'>
                  <a class="btn btn-mini btn-success">On Duty</a>
                <cfelse>
                  <a href="submit.cfm?id=#id#&onduty=booking" class="btn btn-mini btn-primary"><i class="icon-edit icon-white"></i> No</a>
                </cfif>
              </td>
              <td width="55">
                <cfif onduty eq 'Sales'>
                  <a class="btn btn-mini btn-success">On Duty</a>
                <cfelse>
                  <a href="submit.cfm?id=#id#&onduty=sales" class="btn btn-mini btn-primary"><i class="icon-edit icon-white"></i> No</a>
                </cfif>
              </td>
              <td width="50"><a href="form.cfm?id=#id#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Edit</a></td>
              <td width="65"><a href="submit.cfm?id=#id#&delete" class="btn btn-mini btn-danger" data-confirm="Are you sure you want to delete this staff member?"><i class="icon-remove icon-white"></i> Delete</a></td>         
            </tr>
         </table>
      
      </li>
         
    </cfoutput>
    
    </ul>
    
  </div>
</div>
</cfif>

<cfinclude template="/admin/components/footer.cfm">

<script type="text/javascript">
  $(document).ready(function() {
    $("#sort-list").sortable({
      update: function(event, ui) {
  			var sortOrder = $(this).sortable('toArray').toString();
  			$.get('sorter.cfm', {sortOrder:sortOrder});
  			$('#sortStatus').css('display','block');
  		}
    });
  });
</script>
