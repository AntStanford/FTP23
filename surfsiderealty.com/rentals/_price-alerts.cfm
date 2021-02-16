<!---START: REMIND ME TO BOOK LATER--->
<cfif isdefined('url.pricealertsignup')>
  <div class="alert alert-success" role="alert">
    <strong>Success</strong>. You will receive price alert notifications for this property as rates increase and decrease.  Thank you for signing up!
  </div>
<cfelse>
  <button type="button" class="btn btn-block remind-to-book-btn btn-info text-white" data-toggle="modal" data-target="#PriceAlertSignUp"><i class="fa fa-bell" aria-hidden="true"></i> Sign Up For Price Alerts</button>
</cfif>

<cf_htmlfoot>
<div class="modal fade" id="PriceAlertSignUp" tabindex="-1" role="dialog" aria-labelledby="PriceAlertSignUpModalLabel">
  <div class="modal-dialog">
    <div class="modal-content">
      <form id="PriceAlert-Form" action="_submit.cfm" method="post">
        <div class="modal-header site-color-1-bg text-white">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="PriceAlertSignUpModalLabel">Sign up for Price Alert Notifications For This Property!</h4>
        </div>
        <div class="modal-body">
          <p>Set the time period you would like to received Price Alert notifications for this property and provide us your email.  We will send you emails as their are price increases and reductions.</p>
          <cfinclude template="/cfformprotect/cffp.cfm">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="PriceAlert-FirstName"><strong>First Name</strong></label>
                <input class="form-control required" type="text" name="FirstName" id="PriceAlert-FirstName" placeholder="Enter Your First Name" required>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="PriceAlert-LastName"><strong>Last Name</strong></label>
                <input class="form-control required" type="text" name="LastName" id="PriceAlert-LastName" placeholder="Enter Your Last Name" required>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-4">
              <div class="form-group">
                <label for="PriceAlert-StartAlerts"><strong>Start Alerts</strong></label>
                <span class="datepicker-wrap-modal">
                  <input name="PriceAlertStart" id="PriceAlert-StartAlerts" type="text" class="form-control datepicker required" placeholder="Start" required readonly>
                  <div id="PriceAlert-StartAlerts-Datepicker-Container" class="datepicker-container"></div>
                </span>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="PriceAlert-EndAlerts"><strong>End Alerts</strong></label>
                <span class="datepicker-wrap-modal">
                  <input name="PriceAlertEnd" id="PriceAlert-EndAlerts" type="text" class="form-control datepicker required" placeholder="End" required readonly>
                  <div id="PriceAlert-EndAlerts-Datepicker-Container" class="datepicker-container"></div>
                </span>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="PriceAlert-Email"><strong>My email address is</strong></label>
                <input class="form-control required" type="email" name="ReminderEmail" id="PriceAlert-Email" placeholder="Enter email address" required>
              </div>
            </div>
          </div>
          <cfoutput>
            <cfif isdefined('url.propertyid')>
              <input type="hidden" name="unitcode" value="#url.propertyid#">
              <input type="hidden" name="ReminderURL" value="<cfif https is 'off'>http<cfelse>https</cfif>://#http_host##cgi.script_name#&pricealertsignup=success">
            <cfelse>
              <input type="hidden" name="unitcode" value="#property.propertyid#">
              <input type="hidden" name="ReminderURL" value="<cfif https is 'off'>http<cfelse>https</cfif>://#http_host##script_name#?#query_string#&pricealertsignup=success">
            </cfif>
          </cfoutput>
        </div>
        <div class="modal-footer">
          <input class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" type="submit" value="Set Price Alert" name="SetPriceAlert">
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" defer>
  $(document).ready(function(){
    $('#PriceAlert-Form').validate();
  });
</script>
</cf_htmlfoot>