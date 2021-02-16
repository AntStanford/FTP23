<cfset page.title ="Homepage Slideshow">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_assets 
  where section = 'Homepage Slideshow'
  order by sort
</cfquery>

<cfinclude template="/admin/components/header.cfm"> 

<style type="text/css">
  #sort-list li td i.icon-resize-vertical{cursor:pointer}
</style>

<cfif IsDefined('url.success')>
	<div class="alert alert-success">
    	<button class="close" data-dismiss="alert">&times;</button>
    	<strong>Record deleted!</strong>
	</div>
</cfif>

<cfif getinfo.recordcount gt 0>	
  <div class="alert alert-info">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Drag 'n drop the arrows to update sort order</strong> 
  </div>
</cfif>

<cfif getinfo.recordcount lte 6>
   <p><a href="form.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>
<cfelse>
   <p>You have reached your 6 image limit; to add more photos, you can must delete one.  This restriction will optimize your page load times.</p>
</cfif>

<div class="alert alert-success" style="display:none" id="sortStatus">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Success!</strong> The sort order has been updated.
</div>

<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    
    <table class="table">
       <tr>
         <th width="20">Sort</th>
         <th>Name</th>
         <th width="55"></th>                 
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
              <td width="55"><a href="/images/homeslideshow/#thefile#" target="_blank" class="btn btn-mini btn-info"><i class="icon-search icon-white"></i> View</a></td>     
              <td width="50"><a href="form.cfm?id=#id#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Edit</a></td>
              <td width="65"><a href="submit.cfm?id=#id#&delete" class="btn btn-mini btn-danger" data-confirm="Are you sure you want to delete this image?"><i class="icon-remove icon-white"></i> Delete</a></td>         
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