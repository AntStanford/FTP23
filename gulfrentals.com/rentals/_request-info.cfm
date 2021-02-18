<div id="inquire" name="inquire" class="info-wrap inquire-wrap">
  <div class="info-wrap-heading"><i class="fa fa-question-circle" aria-hidden="true"></i> Request More Info</div>
  <div class="info-wrap-body">
    <em>Want to know specifics? Ask anything in reference to vacationing at this property that you would like to know...<br/>Example: <strong>&ldquo;Are fresh linens provided?&rdquo;</strong></em>
    <div id="propertyContactFormMSG"></div>
    <form role="form" id="propertyContactForm" class="contact-form validate" method="post">
      <cfinclude template="/cfformprotect/cffp.cfm">
  		<cfoutput>
  		<input type="hidden" name="property_name" value="#property.name#">
  		<input type="hidden" name="property_id" value="#property.propertyid#">
  		<input type="hidden" name="property_photo" value="#property.defaultPhoto#">
  		<input type="hidden" name="key" value="#cfid##cftoken#">
  		<input type="hidden" name="hiddenstrcheckin" value="" id="hiddenstrcheckin">
  		<input type="hidden" name="hiddenstrcheckout" value="" id="hiddenstrcheckout">
  		<input type="hidden" name="requestMoreInfoForm">
  		</cfoutput>
      <fieldset class="row">
        <div class="form-group col-xs-12 col-sm-6">
          <label for="ri-firstName">First Name</label>
          <input type="text" id="ri-firstName" name="firstName" placeholder="First" class="required ca-send-data">
        </div>
        <div class="form-group col-xs-12 col-sm-6">
          <label for="ri-lastName">Last Name</label>
          <input type="text" id="ri-lastName" name="lastName" placeholder="Last" class="required ca-send-data">
        </div>
        <div class="form-group col-xs-12">
          <label for="ri-email">Email Address</label>
          <input type="email" id="ri-email" name="email" placeholder="Email" class="required ca-send-data">
        </div>
        <div class="form-group col-xs-12">
          <label for="ri-comments">Comments/Questions</label>
          <textarea id="ri-comments" name="comments" placeholder="Comments..."></textarea>
        </div>
        <div class="form-group col-xs-12">
          <div id="pdpmoreinfocaptcha"></div>
          <div class="g-recaptcha-error"></div>
        </div>
        <div class="form-group col-xs-12">
          <div class="well input-well">
            <input id="optinRequestInfo" name="optin" type="checkbox" value="Yes"> <label for="optinRequestInfo">I agree to receive information about your rentals, services and specials via phone, email or SMS.<br >
            You can unsubscribe at anytime. <!---<a href="/privacy-policy.cfm" target="_blank">Privacy Policy</a>---></label>
          </div>
        </div>
        <div class="form-group col-xs-12">
          <input type="submit" id="" name="" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" value="Request Info" onClick="ga('send','event','Contact Form','Submit','Location - Property Contact Form','1');">
        </div>
      </fieldset>
    </form>
  </div><!-- END info-wrap-body -->
</div><!-- END inquire-wrap -->
