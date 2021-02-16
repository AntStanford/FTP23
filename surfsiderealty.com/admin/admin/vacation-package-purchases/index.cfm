<cfset page.title ="Vacation Packages">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from vacation_package_additions 
  where Converted = 'Yes'  <cfif isdefined('showallprocessed')>and processed = 'Yes'<cfelse>and processed = 'No'</cfif>
  group by ConfirmationCode
  order by createdat desc
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Record deleted!</strong>
  </div>
</cfif>

<cfif isdefined('showallprocessed')>
	  <p><a href="index.cfm?" class="btn btn-success"><i class="icon-plus icon-white"></i> Show All Unprocessed</a></p>
	 <cfelse>
	  <p><a href="index.cfm?showallprocessed=" class="btn btn-success"><i class="icon-plus icon-white"></i> Show All Processed</a></p>
</cfif>




<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>No.</th>       
	  <th>First Name</th>   
	  <th>Last Name</th> 
	  <th>Reservation Number</th>
	  <th>Submitted</th>
	  <th>Processed</th>
      <th></th> 
    </tr>        
    <cfoutput query="getinfo">
      <tr>
        <td width="45">#currentrow#.</td>
		<td>#ReservationFirstName#</td>
        <td>#ReservationLastName#</td>               
		<td>#ConfirmationCode#</td> 
		<td>#dateformat(createdat,'mm/dd/yyyy')#</td>
		<td>#processed#</td>
        <td width="75"><a href="form.cfm?id=#ConfirmationCode#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Review</a></td>
      </tr>
    </cfoutput>
    </table>
  </div>
</div>
</cfif>

<cfinclude template="/admin/components/footer.cfm">