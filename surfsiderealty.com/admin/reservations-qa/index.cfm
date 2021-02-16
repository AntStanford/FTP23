<cftry>
	<cfset page.title = "Reservation Q&A">

	<cfquery name="getinfo" dataSource="#settings.dsn#">
	select * from cms_reservation_qa
	</cfquery>

	<cfinclude template="/admin/components/header.cfm">  

	<cfif isdefined('url.success')>
	  <div class="alert alert-success">
	    <button class="close" data-dismiss="alert">×</button>
	    <strong>Record deleted!</strong>
	  </div>
	</cfif>

	<div class="widget-box">		
		<div class="widget-content nopadding">
		  
		  <table class="table table-bordered table-striped">
		  <tr>
	      <th width="30">No.</th>
	      <th>Reservation Number</th>
	      <th>How did you hear about us?</th>
	      <th>How did you find us?</th>
	    </tr>  
	      
	    <cfoutput query="getinfo">
	      <tr>
	        <td>#currentrow#.</td>
	        <td>#reservationid#</td>
	        <td>#hearabout#</td>
	        <td>#findus#</td>
	      </tr>
	    </cfoutput>
	  
	    </table>
	    
		</div>

	</div>

	<cfinclude template="/admin/components/footer.cfm">

	<script src="/admin/javascripts/_plugins/blog/jquery.blog.js"></script>

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>