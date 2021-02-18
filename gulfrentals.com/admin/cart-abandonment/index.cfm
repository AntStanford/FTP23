<cftry>

  <cfset page.title ="Cart Abandonment">

  <cfif isdefined('RunReport')>
    <cfset StartDate = "#form.startdate#">
    <cfset EndDate = "#form.enddate#">
    <cfset PostedPropertyID = "#form.PropertyID#">
  <cfelse>
    <cfset StartDate = "#dateformat(now(),'mm')#/01/#dateformat(now(),'yyyy')#">
    <cfset EndDate = "#dateformat(now(),'mm/dd/yyyy')#">
    <cfset PostedPropertyID = "">
  </cfif>

  <cfquery name="getinfoproperties" datasource="#settings.dsn#">
  SELECT PropertyID,name,name AS PropertyTitle FROM bf_properties
  </cfquery>

  <cfquery name="getinfo" dataSource="booking_clients">
  select *
  from cart_abandonment
  where followupemailsent = 'Yes'
  and followupemailtimestamp between <cfqueryparam value="#StartDate#" cfsqltype="CF_SQL_TimeStamp"> and  <cfqueryparam CFSQLType="CF_SQL_TimeStamp" value="#EndDate# 23:59:59">

  <cfif trim(PostedPropertyID) neq "">
    AND unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#PostedPropertyID#">
  </cfif>

  and siteid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#settings.id#">
  order by followupemailtimestamp desc
  </cfquery>

  <cfinclude template="/admin/components/header.cfm">


  <cfif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">&times;</button>
      <strong>Record deleted!</strong>
    </div>
  </cfif>

  <form action="index.cfm" method="post">
  <cfoutput>
  <table>
  <tr>
  <td>Start Date:</td><td><input type="text" class="datepicker" name="StartDate" value="#startdate#"></td>
  <td>End Date:</td><td><input type="text" class="datepicker" name="EndDate" value="#EndDate#"></td>
  <td>Property:</td>
  	<td>
    	<select name="PropertyID">
        	<option value=" ">Select Property</option>
        	<cfloop query="getinfoproperties">
				<option value="#getinfoproperties.PropertyID#" <cfif getinfoproperties.PropertyID eq PostedPropertyID>selected="selected"</cfif>>#name#</option>
			</cfloop>
        </select>
  </td>
  <td><input type="submit" class="btn btn-success" name="RunReport" value="Run Report"> <a href="index.cfm" class="btn btn-warning">Reset</a></td>
  </tr>
  </table>
  </cfoutput>
  </form>

  <cfif getinfo.recordcount gt 0>

  <div class="widget-box">
    <div class="widget-content nopadding">

      <table class="table table-bordered table-striped">
      <tr>
        <th>No.</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Email</th>
      <th>Phone</th>
      <th>Sent On</th>
      <th>Property Name</th>
      <th>Arrival Date</th>
      <th>Departure Date</th>
      <th>Returned and Booked</th>
     <!--- <th>Escapia Record Updated</th>--->
      <!--- <th>Scripts Ran</th> --->
      <th>Abandon Time</th>
      </tr>

     <cfset TotalRevenueAmount = "0">
     <cfset TotalLostRevenue = "0">
     <cfset YesCount = 0>
     <cfset NoCount = 0>
      <cfoutput query="getinfo">
      <!---<cfquery name="GetDetails" dataSource="booking_clients">
        select *
        from cart_abandonment_opens
        where email = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#"> and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#unitcode#">
      </cfquery>--->

      <cfquery name="getPropinfo" datasource="#application.dsn#">
      SELECT name
      FROM bf_properties
      WHERE PropertyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#unitcode#" />
      </cfquery>

      <cfquery name="GetBooking" datasource="#application.dsn#">
      select *
      from guestweb_bookings
      where tenantemail = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#">
      and updatedDate > <cfqueryparam cfsqltype="CF_SQL_Date" value="#followupemailtimestamp#">
      and PropertyID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getinfo.unitcode#">
      <!---and dtBookDate > <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getinfo.followupemailtimestamp#">--->
      </cfquery>

      <cfquery name="GetEscapiaLastUpdate" dbtype="query">
      select *
      from GetBooking
      where tenantemail = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#">
      </cfquery>

        <tr>
          <td width="45">#currentrow#. <a name="#currentrow#"></a></td>
        <td>#firstname#</td>
        <td>#lastname#</td>
        <td>#email#<cfif LEN(ipaddress)><br>#ipaddress#</cfif></td>
        <td>#phone#</td>
        <td>#dateformat(followUpEmailTimeStamp,'mm/dd/yyyy')# #timeformat(followUpEmailTimeStamp,'h:mm tt')#</td>
        <td>
          #getPropInfo.name#
          <!---#GetDetails.numtimesviewed# - #dateformat(GetDetails.lastopened,'mm/dd/yyyy')# #timeformat(GetDetails.lastopened,'h:mm tt')#--->
        </td>

        <td>
            #DateFormat(startdate, "MM/DD/YYYY")#
        </td>

        <td>
            #DateFormat(enddate, "MM/DD/YYYY")#
        </td>

        <td>
          <cfif GetBooking.recordcount gt 0>
            Yes - <br>
            <!--- #GetBooking.propertyname#<br> --->
            #dollarformat(GetBooking.totalcharges)#

            <cfset TotalRevenueAmount = TotalRevenueAmount + GetBooking.totalcharges>
            <cfset YesCount = YesCount + 1>
          <cfelse>
            No - <br/>
            #dollarformat(totalamount)#
            <cfset TotalLostRevenue = TotalLostRevenue + val(totalamount)><!--- Added val() - TT 100085 2018-07-15 A.DOUTE --->
            <cfset NoCount = NoCount + 1>
          </cfif>
        </td>

        <!---<td>#dateformat(GetEscapiaLastUpdate.dtchangedate,'mm/dd/yyyy')# #timeformat(GetEscapiaLastUpdate.dtchangedate,'h:mm tt')# <cfif GetEscapiaLastUpdate.recordcount gt 0><br>Previous Guest</cfif></td>--->
        <td>#dateformat(getinfo.createdat,'mm/dd/yyyy')# #timeformat(getinfo.createdat,'h:mm tt')#</td>
      </tr>

    <!--- <tr>
    <td colspan="9"><cfdump var="#GetBooking#"></td>
    </tr> --->

      </cfoutput>

    <cfset PercentageReturned = (YesCount / getinfo.recordcount) * 100>
    <cfset PercentageNotReturned = (NoCount / getinfo.recordcount) * 100>
    <cfoutput>
      <tr>
        <td colspan="6" style="text-align:right;">Not booked:</td>
        <td colspan="2">#NumberFormat(PercentageNotReturned, '__.__')#% - #dollarformat(TotalLostRevenue)#</td>
      </tr>
      <tr>
        <td colspan="6" style="text-align:right;">Returned and booked:</td>
        <td colspan="2">#NumberFormat(PercentageReturned,'___.__')#% - #dollarformat(TotalRevenueAmount)#</td>
      </tr>
    </cfoutput>
      </table>

    </div>
  </div>

  </cfif>

  <cfinclude template="/admin/components/footer.cfm">

  <cfcatch>
    <cfdump var="#cfcatch#" abort="true" />
  </cfcatch>

</cftry>
