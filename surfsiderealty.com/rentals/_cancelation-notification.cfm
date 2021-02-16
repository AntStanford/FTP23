<!---START: REMIND ME TO BOOK LATER--->
<cfif isdefined('url.CancelationNotification')>
  <div class="alert alert-success" role="alert" style="margin-top:10px;">
    <strong>Success</strong>. You will receive a notification if this property becomes available for the time period you specified.  Thank you for signing up!
  </div>
<cfelse>
  <div class="text-center">
    <button type="button" class="btn remind-to-book-btn btn-success text-white cancelation-notification-btn" data-toggle="modal" data-target="#CancelationNotificationModal"><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Cancelation Notification</button><br>
  </div>
</cfif>
<cf_htmlfoot>
<div class="modal fade" id="CancelationNotificationModal" tabindex="-1" role="dialog" aria-labelledby="CancelationNotificationModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <form id="CancelationNotification-Form" action="_submit.cfm" method="post">
        <div class="modal-header site-color-1-bg text-white">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="CancelationNotificationModalLabel">Property Cancellation Notification</h4>
        </div>
        <div class="modal-body">
          <p>Put in the time period you would like to be notified about a cancellation for this property and we will send you a  notification.</p>
          <cfinclude template="/cfformprotect/cffp.cfm">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="CancelationNotification-FirstName"><strong>First Name</strong></label>
                <input class="form-control required" type="text" name="CancelationNotificationFirstName" id="CancelationNotification-FirstName" placeholder="Enter first name" required>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="CancelationNotification-Email"><strong>Email</strong></label>
                <input class="form-control required" type="email" name="CancelationNotificationEmail" id="CancelationNotification-Email" placeholder="Enter email address" required>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="CancelationNotification-StartDate"><strong>Start Date</strong></label>
                <span class="datepicker-wrap-modal">
                  <input name="CancelationNotificationStartDatet" id="CancelationNotification-StartDate" type="text" class="form-control datepicker required" placeholder="Start" required readonly>
                  <div id="CancelationNotification-StartDate-Datepicker-Container" class="datepicker-container"></div>
                </span>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="CancelationNotification-EndDate"><strong>End Date</strong></label>
                <span class="datepicker-wrap-modal">
                  <input name="CancelationNotificationEndDate" id="CancelationNotification-EndDate" type="text" class="form-control datepicker required" placeholder="End" required readonly>
                  <div id="CancelationNotification-EndDate-Datepicker-Container" class="datepicker-container"></div>
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="form-group">
                <p><strong>Flexible Dates?</strong></p>
                <label class="radio-inline" for="CancelationNotification-FlexibleDates-0">
                  <input type="radio" name="CancelationNotificationFlexibleDates" id="CancelationNotification-FlexibleDates-0" value="Flex" checked>
                  Yes
                </label>
                <label class="radio-inline" for="CancelationNotification-FlexibleDates-1">
                  <input type="radio" name="CancelationNotificationFlexibleDates" id="CancelationNotification-FlexibleDates-1" value="Strict">
                  No
                </label>
              </div>
            </div>
          </div>
          <cfoutput>
            <cfif isdefined('url.propertyid')>
              <input type="hidden" name="unitcode" value="#url.propertyid#">
              <input type="hidden" name="ReminderURL" value="<cfif https is 'off'>http<cfelse>https</cfif>://#http_host##cgi.script_name#&CancelationNotification=success">
            <cfelse>
              <input type="hidden" name="unitcode" value="#property.propertyid#">
              <input type="hidden" name="ReminderURL" value="<cfif https is 'off'>http<cfelse>https</cfif>://#http_host##script_name#?#query_string#&CancelationNotification=success">
            </cfif>
          </cfoutput>
        </div>
        <div class="modal-footer">
          <input class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" type="submit" value="Send Me Cancelation Notifications" name="SendCancelationNotifications">
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" defer>
$(document).ready(function(){
  $('#CancelationNotification-Form').validate();
});
</script>
</cf_htmlfoot>