<cfset page.title = "Cart Abandonment - Detail Page">

<cfif isdefined('RunReport')>
	<cfset StartDate = "#form.startdate#">
	<cfset EndDate = "#form.enddate#">
<cfelse>
	<cfset StartDate = "#dateformat(now(),'mm')#/01/#dateformat(now(),'yyyy')#">
	<cfset EndDate = "#dateformat(now(),'mm/dd/yyyy')#">
</cfif>

<cfquery name="getinfo" dataSource="#settings.bcDSN#">
  select *
  from cart_abandonment_detail_page 
  where followUpEmailSent = 'Yes'
  and followUpEmailTimestamp between <cfqueryparam value="#StartDate#" cfsqltype="CF_SQL_TimeStamp"> and <cfqueryparam CFSQLType="CF_SQL_TimeStamp" value="#EndDate# 23:59:59">  
  and siteid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#"> 
  order by followUpEmailTimestamp desc
</cfquery>

<cfquery name="GetBookings" dataSource="#application.dsn#">
select strEmail as TenantEmail,dtChangeDate as UpdatedDate,strpropid
from pp_guestreservationinfo
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Record deleted!</strong>
  </div>
</cfif>

<form action="detail-page.cfm" method="post">
   <cfoutput>
   <table>
      <tr>
         <td>Start Date:</td>
         <td><input type="text" class="datepicker" name="StartDate" value="#startdate#"></td>
         <td>End Date:</td>
         <td><input type="text" class="datepicker" name="EndDate" value="#enddate#"></td>
         <td><input type="submit" class="btn btn-success" name="RunReport" value="Run Report"> <a href="detail-page.cfm" class="btn btn-warning">Reset</a></td>
      </tr>
   </table>
   </cfoutput>
</form>

<cfif isdefined('RunReport')>
   <div class="alert alert-success">
      You searched from <b><cfoutput>#form.startdate# to #form.enddate#</cfoutput></b>
   </div>
</cfif>

<cfif getinfo.recordcount gt 0>

<div class="widget-box">
  <div class="widget-content nopadding">
  
    <table class="table table-bordered table-striped">
      <tr>
         <th>No.</th>
         <th>First Name</th> 
         <th>Last Name</th>
         <th>Email</th> 
         <th>Sent On</th> 
         <th>Last Opened</th>
         <th>Returned and Booked</th>
         <th>Abandon Time</th>
      </tr>  
	 	 
    <cfoutput query="getinfo">
	
      <cfquery name="GetDetails" dataSource="#settings.bcDSN#">
        select *
        from cart_abandonment_opens 
        where email = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#"> 
        and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#unitcode#">
        and siteid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
      </cfquery>  
      
      <cfquery name="GetBooking" dbtype="query">
      	select * 
        from GetBookings
      	where TenantEmail = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#">  
      	and UpdatedDate > <cfqueryparam cfsqltype="CF_SQL_Date" value="#followUpEmailTimestamp#">  
      </cfquery>   
      
      <cfquery name="GetBookingLastUpdate" dbtype="query">
      	select * from GetBookings
      	where TenantEmail = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#"> 
      </cfquery> 

      <!---
        the client wants to have the total show if the guest came back and booked
        we have this field in the CA table on BC but it doesn't get populated
        so we have to go to the pp_guestreservationinfo table to get it
      --->
      <cfif GetBooking.recordcount gt 0>
        <cfquery name="getTotal" datasource="#application.dsn#">
        select dblAmountPaid
        from pp_guestreservationinfo
        where stremail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#email#" />
        and strpropid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#unitcode#" />
        and dtCheckInDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#startdate#" />
        and dtCheckOutDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#enddate#" />
        </cfquery>

        <cfset totalpaid = getTotal.dblAmountPaid />
      <cfelse>
        <cfset totalpaid = 0 />
      </cfif>

      <tr>
         <td width="45">#currentrow#. <a name="#currentrow#"></a></td>		
   		<td>#firstname#</td>
   		<td>#lastname#</td>
   		<td>#email#</td>
   		<td>#dateformat(followUpEmailTimestamp,'mm/dd/yyyy')# #timeformat(followUpEmailTimestamp,'h:mm tt')#</td>	
   		<td>#GetDetails.numtimesviewed# - #dateformat(GetDetails.lastopened,'mm/dd/yyyy')# #timeformat(GetDetails.lastopened,'h:mm tt')#</td>
   		<td>
        <cfif GetBooking.recordcount gt 0>
          Yes - <cfif val( totalpaid ) gt 0>#dollarformat( totalpaid )#</cfif>
            <br>
          <cfif isDefined("GetBooking.strpropid")>
            #GetBooking.strpropid#
          </cfif>
        <cfelse>
          No
        </cfif>
        <!---<cfif GetBooking.recordcount gt 0>Yes - <br>#GetBooking.strpropid#<cfelse>No</cfif>--->
      </td>
   		<td>#dateformat(getinfo.createdat,'mm/dd/yyyy')# #timeformat(getinfo.createdat,'h:mm tt')#</td>
	  </tr>
	  
    </cfoutput>
	
    </table>
	
  </div>
</div>

</cfif>

<cfinclude template="/admin/components/footer.cfm">