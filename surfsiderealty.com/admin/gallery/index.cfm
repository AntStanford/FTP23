<cfset page.title ="Gallery">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_assets where section = 'Gallery'
  order by sort
</cfquery>

<cfinclude template="/admin/components/header.cfm">  

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Photo deleted!</strong>
  </div>
</cfif>



<p><a href="form.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add New</a></p>

<cfif getinfo.recordcount gt 0>
<div class="alert alert-info">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Drag 'n drop photos to update sort order</strong> 
</div>
</cfif>

<div class="alert alert-success" style="display:none" id="sortStatus">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Success!</strong> The sort order has been updated.
</div>

<cfif getinfo.recordcount gt 0>
<div class="widget-box">
	<div class="widget-content">
		
		<ul id="sort-list">
		 
		 <cfoutput query="getinfo">
		 <li id="listItem_#id#">
		  <table class="table table-bordered table-striped">
		    <tr>
                <td width="25"><i class="icon-resize-vertical"></i></td>
                <td width="200">#name#</td>
                <td width="200"><img src="/images/gallery/th_#thefile#"></td>
                <td width="20"><a href="form.cfm?id=#id#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Edit</a></td>
                <td width="20"><a href="submit.cfm?id=#id#&delete" class="btn btn-mini btn-danger" data-confirm="Are you sure you want to delete this photo?"><i class="icon-remove icon-white"></i> Delete</a></td>         
            </tr>
         </table>
		 </cfoutput>
		
		</ul>
		
	</div>
</div>
</cfif>



<cfinclude template="/admin/components/footer.cfm">


<script type="text/javascript">
  
  $(document).ready(function() {
    
    //this handles the image sorting
    $("#sort-list").sortable({
      update: function(event, ui) {
  			var sortOrder = $(this).sortable('toArray').toString();
  			$.get('sorter.cfm', {sortOrder:sortOrder});
  			$('#sortStatus').css('display','block');
  		}
    });
    
  });
    
</script>

