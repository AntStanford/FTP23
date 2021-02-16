<div id="travelDatesAnchor"><!-- TRAVEL DATES STICKY ANCHOR FOR SCROLL --></div>
<div id="travelDates" class="property-dates">

  <cfset twentyFourHrs = Dateadd('h','-24',Now())>

  <cfquery datasource="#settings.dsn#" name="GetPropertyViews">
    SELECT DISTINCT TrackingEmail,UserTrackerValue
    FROM be_prop_view_stats WHERE createdAt >= <cfqueryparam value="#twentyFourHrs#" cfsqltype="CF_SQL_TIMESTAMP">
    and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#property.propertyid#">
    GROUP BY TrackingEmail,UserTrackerValue desc
  </cfquery>

  <cfif GetPropertyViews.recordcount gt 0>
    <strong class="alert-views">
      <i class="fa fa-fire" aria-hidden="true"></i>
      This Property has been looked at
      <cfif GetPropertyViews.recordcount eq 1>
        <strong>1</strong> time
      <cfelse>
        <strong><cfoutput>#GetPropertyViews.recordcount#</cfoutput></strong> times
      </cfif>
      in 24 hours
    </strong>
  </cfif>

  <form role="form" id="refineForm" class="refine-form">
    <input type="hidden" name="formtype" value="details-datepicker">
    <input type="hidden" name="page" value="0" />
    <cfoutput><input type="hidden" name="propertyid" value="#property.propertyid#"></cfoutput>
    <cfoutput><input type="hidden" name="unitshortname" value="#property.name#"></cfoutput>
    <cfif settings.travel_insurance_vendor eq 'Red Sky'>
      <input type="hidden" name="redskyclient" value="yes">
    <cfelse>
      <input type="hidden" name="redskyclient" value="no">
    </cfif>

    <fieldset>
      <div class="refine-dates">
        <cfoutput>
          <span class="datepicker-wrap">
            <label for="startDateDetail" class="hidden">startDateDetail</label>
            <input name="strcheckin" type="text" name="strCheckin" id="startDateDetail" class="pdp-start-date" value="<cfif isdefined('session.booking.strcheckin')>#session.booking.strcheckin#</cfif>" placeholder="Arrival" readonly>
            <label for="endDateDetail" class="hidden">endDateDetail</label>
            <input name="strcheckout" type="text" name="strCheckout" id="endDateDetail" class="pdp-end-date" value="<cfif isdefined('session.booking.strcheckout')>#session.booking.strcheckout#</cfif>" placeholder="Departure" readonly>
            <div id="detailDatepickerCheckin" class="detail-datepicker-checkin datepicker-container"></div>
            <div id="detailDatepickerCheckout" class="detail-datepicker-checkout datepicker-container"></div>
          </span>
        </cfoutput>
      </div><!-- END refine-dates -->
      <cfif !isdefined('session.booking.strcheckin') OR (isdefined('session.booking.strcheckin') and session.booking.strcheckin eq '')>
        <button id="selectDates" class="btn site-color-1-bg site-color-2-bg-hover text-white" type="button"><i class="fa fa-chevron-right" aria-hidden="true"></i> Get My Quote</button>
      </cfif>
    </fieldset>
  </form><!-- END refineForm -->

  <div id="APIresponse" class="property-cost">
    <cfif isdefined('APIresponse')><cfoutput>#APIresponse#</cfoutput></cfif>
  </div>

  <div class="hr">OR</div>

<!---
  <cfinclude template = "_remind-book-later.cfm">
  <cfinclude template="_price-alerts.cfm">
  <cfinclude template="_cancelation-notification.cfm">
	--->

  <!-- INQUIRE BUTTON -->
  <button id="requestInfoBtn" class="btn site-color-2-bg site-color-3-bg-hover text-white" type="button" ><i class="fa fa-question-circle" aria-hidden="true"></i> Request More Info</button>

  <div class="social-sharing-wrap">
    <h3 class="text-center">Share This Property!</h3>
   <div class="addthis_inline_share_toolbox"></div>
  </div>

  <button id="mobileClose" class="btn site-color-3-bg site-color-2-bg-hover">
    <i class="fa fa-close" aria-hidden="true"></i>
    <span class="hidden">Mobile Close</span>
  </button>
</div><!-- END travelDates -->
