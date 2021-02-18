<cfset rates = application.bookingObject.getPropertyRates(property.propertyid)>
<cfset longrates = application.bookingObject.getPropertyLongTermRates(property.propertyid)>
<cfset beachgear_fee = application.bookingObject.GetBeachGearFee(property.propertyid)>

<div id="rates" name="rates" class="info-wrap rates-wrap">
  <div class="info-wrap-heading"><i class="fa fa-tags" aria-hidden="true"></i> Rates - Simplified pricing which includes all departure fees and taxes. Optional Travel Insurance is available.</div>
  <div class="info-wrap-body">
    <div class="table-wrap">
  		<table class="table rates-table">
  			<tr>
  				<th>Start Date</th>
  				<th>End Date</th>
  				<th>Weekly</th>
				<!---<th>Nightly</th>--->
           </tr>
  			<cfoutput query="rates">
  			<tr>
  				<td>
            <cfif isDate(start_date) and DateFormat(start_date,'mm/dd/yyyy') eq '12/31/3022'>Holiday
            <cfelseif isDate(start_date) and DateFormat(start_date,'mm/dd/yyyy') eq '12/31/3122'>Monthly
            <cfelse>#DateFormat(start_date,'mm/dd/yyyy')#
            </cfif>
          </td>
  				<td><cfif isDate(end_date)>#DateFormat(end_date,'mm/dd/yyyy')#</cfif></td>
  				<td><cfif isNumeric(weekly_rate) and weekly_rate gt 0>#DollarFormat(weekly_rate)#<cfelse>#weekly_rate#</cfif></td>
  				<!---<td><cfif weekly_rate gt 0>#DollarFormat(weekly_rate+beachgear_fee)#<cfelse>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-</cfif></td>
  				<td><cfif nightly_rate gt 0>#DollarFormat(nightly_rate)#<cfelse>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-</cfif></td>--->
  			</tr>
  			</cfoutput>
  		</table>
    </div><!-- END table-wrap -->
  
    <small class="scroll-indicator hide-mobile"><i class="fa fa-arrows-h" aria-hidden="true"></i><strong><span class="swipe">Swipe</span><span class="drag">Drag</span> for Rates</strong></small>
  </div><!-- END info-wrap-body -->
  <cfif longrates.recordcount gt 0>
  <div class="info-wrap-heading"><i class="fa fa-tags" aria-hidden="true"></i>Monthly Rates</div>
  <div class="info-wrap-body">
    <div class="table-wrap">
  		<table class="table rates-table">
  			<tr>
  				<th>Start Date</th>
  				<th>End Date</th>
  				<th>Monthly</th>
  				<th></th>				
           </tr>
  			<cfoutput query="longrates">
  			<tr>
  				<td>#DateFormat(start_date,'mm/dd/yyyy')#</td>
  				<td>#DateFormat(end_date,'mm/dd/yyyy')#</td>
  				<td><cfif weekly_rate gt 0>#DollarFormat(weekly_rate+beachgear_fee)#<cfelse>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-</cfif></td>
  				<td></td>
  			</tr>
  			</cfoutput>
  		</table>
    </div><!-- END table-wrap -->
  
    <small class="scroll-indicator hide-mobile"><i class="fa fa-arrows-h" aria-hidden="true"></i><strong><span class="swipe">Swipe</span><span class="drag">Drag</span> for Rates</strong></small>
  </div><!-- END info-wrap-body -->
</cfif>
</div><!-- END rates-wrap -->
