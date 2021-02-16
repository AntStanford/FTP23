
<cfset page.title ="Multi-Upload image Gallery">
<cfset module = 'image'>
<cfset uppicture = '/images/#url.strpropid#/'>
<!---<cfset uppicture_resized = '/images/#url.strpropid#/resized'>--->
<cfset uppicture_resized = '/uploaded'>


<cfquery name="getimages" dataSource="#settings.dsn#">
  select id, strpropid, image from prop_images where strpropid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.strpropid#"> order by sort
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfoutput>

  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Update successful!</strong> Continue editing this #module# or <a href="index.cfm?unitcode=#url.strpropid#">go back.</a>
    </div>
  <cfelseif isdefined('url.deleteimage') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>image deleted!</strong> Continue editing this #module# or <a href="index.cfm?unitcode=#url.strpropid#">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Insert successful!</strong> Add another #module# or <a href="index.cfm?unitcode=#url.strpropid#">go back.</a>
    </div>
  </cfif>

  <div class="alert alert-success" style="display:none" id="sortStatus">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Success!</strong> The sort order has been updated.
</div>

<a href="/admin/property-photos/index.cfm?strpropid=#url.strpropid#" class="btn btn-success"><i class="icon-chevron-left icon-white"></i> Go Back</a>

<cfif getimages.recordcount gt 0>

  <div class="widget-box">
  	<div class="widget-title">
  		<span class="icon">
  			<i class="icon-picture"></i>
  		</span>
  		<h5>Drag images to change the order, this will save automatically.</h5>
  	</div>
  	<div class="widget-content">
		<ul id="sort-list" class="thumbnails">
  		  <cfloop query="getimages">
    			<li class="span2" id="#id#" style="border:none">
    			 <a href="javascript:;" role="button" class="thumbnail" data-toggle="modal"><img src="#uppicture_resized#/#image#" title="#image#" style="height:135px;"></a>
    		  </li>
    		</cfloop>
  		</ul>

  	</div>
  </div>


</cfif>





</cfoutput>

<cfinclude template="/admin/components/footer.cfm">


	<script type="text/javascript">

		$(document).ready(function() {

		//this handles the image sorting
		$("#sort-list").sortable({
		update: function(event, ui) {
		var sortOrder = $(this).sortable('toArray').toString();
		//alert(sortOrder);
		$.get('sorter.cfm', {sortOrder:sortOrder});
		$('#sortStatus').css('display','block');
		}
		});

		});

	</script>
