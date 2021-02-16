<cfset page.title ="MLS Area Coordinates">

<cfinclude template="/admin/components/header.cfm">  

<cfparam name="message" default="">

<cfif isdefined('form.submit')>
  
  <cfset lat = #trim(listgetat(mapresults,'1'))#>
  <cfset long = #trim(listgetat(mapresults,'2'))#>

	<CFQUERY NAME="PropertyQuery" DATASOURCE="mlsv30master">
		update masterareas_cleaned
		set longitude = '#long#',
		latitude = '#lat#'
		where id = '#hiddencityid#'
	</CFQUERY>
	
	<cfset message = 'Coordinates have been updated'>

</cfif>

<cfquery name="getinfo" dataSource="mlsv30master">
   select masterareas_cleaned.id,masterareas_cleaned.city,mlsfeeds.state
   from masterareas_cleaned 
   left join mlsfeeds on
   masterareas_cleaned.mlsid = mlsfeeds.id
   where latitude is null and masterareas_cleaned.city != '' and state != ''
   order by state
</cfquery>


<cfif len(message)>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">x</button>
    <strong><cfoutput>#message#</cfoutput></strong>
  </div>
</cfif>

<p><a href="http://itouchmap.com/latlong.html" class="btn btn-info" target="_blank"><i class="icon-plane icon-white"></i> Launch Mapper</a></p>

<div class="widget-box">
  <div class="widget-title">
    <span class="icon">
      <i class="icon-th"></i>
    </span>  
  	<h5>Users</h5>
  </div>
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped table-hover">
    <tr>
      <th>No.</th>
      <th>City, State</th>           
      <th></th>     
    </tr>      
    <cfoutput query="getinfo">
      <form method="post">
        <tr>
          <td>#currentrow#.</td>
          <td>#city#, #state#</td>             
          <td width="300">
            <input type="text" name="mapresults">
            <input type="submit" name="submit" value="Submit" class="btn btn-success" style="float:right"></td>        
        </tr>
        <input type="hidden" name="hiddencityid" value="#id#">
      </form>  
    </cfoutput>
  
</table>

<cfinclude template="/admin/components/footer.cfm">