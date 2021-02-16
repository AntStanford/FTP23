<cfif len(settings.address) and len(settings.city) and len(settings.state) and len(settings.zip)>
  <p class="h2">Map</p>
  <div class="embed-responsive embed-responsive-16by9">
	<cfoutput><iframe src="https://maps.google.com/maps?q=#settings.address#%2C+#settings.city#%2C+#settings.state#+#settings.zip#&ie=UTF8&output=embed" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe></cfoutput>
  </div><br>
</cfif>
<div class="row">
  <div class="col-lg-6 col-md-6 col-sm-6">
    <p class="h2">Address</p>
    <div class="well">
      <p class="nomargin">
        <cfoutput>
          #settings.company#<br>
          #settings.address#<br>
          #settings.city#, #settings.state# #settings.zip#<br>
        </cfoutput>
      </p>
    </div>
  </div>
  <div class="col-lg-6 col-md-6 col-sm-6">
    <p class="h2">Email & Phone</p>
    <div class="well">
      <p class="nomargin">
        <cfoutput>
          <b>Email:</b> <a hreflang="en" href="mailto:#settings.clientEmail#">#settings.clientEmail#</a><br>
      	  <cfif len(settings.tollFree)>
      	    <cfoutput><b>Phone (toll free):</b> <a hreflang="en" href="tel:#settings.tollFree#"><i class="fa fa-mobile"></i> #settings.tollFree#</a></cfoutput>
      	  <cfelseif len(settings.phone)>
      	    <cfoutput><b>Phone:</b> <a hreflang="en" href="tel:#settings.phone#"><i class="fa fa-mobile"></i> #settings.phone#</a></cfoutput>
      	  </cfif>
        </cfoutput>
      </p>
    </div>
  </div>
</div>
<p class="h2">Contact Form</p>
<p>Fill out the form below and we will contact you shortly.</p>
<div class="well">
  <form class="row validate" id="contactform" method="post" action="/submit.cfm">
    <cfinclude template="/cfformprotect/cffp.cfm">
    <div class="form-group col-md-6">
      <label for="firstname">First Name *</label>
    <input id="firstname" name="firstname" type="text" class="form-control required">
    </div>
    <div class="form-group col-md-6">
      <label for="lastname">Last Name *</label>
      <input id="lastname" name="lastname" type="text" class="form-control required">
    </div>
    <div class="form-group col-md-6">
      <label for="phone">Phone</label>
      <input id="phone" name="phone" type="text" class="form-control">
    </div>
    <div class="form-group col-md-6">
      <label for="email">Email *</label>
      <input id="email" name="email" type="text" class="form-control required">
    </div>
    <div class="form-group col-md-12">
      <label for="comments">Comments</label>
      <textarea class="form-control" id="comments" name="comments"></textarea>
    </div>
    <div class="form-group">
        <div id="contactcaptcha"></div><br /> 
        <div class="g-recaptcha-error"></div>
	</div>
    <div class="form-group col-md-12 nomargin">
      <input type="submit" value="Submit" id="contactform" name="contactform" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white text-white-hover" onClick="ga('nativeTracker.send','event','Contact Form','Submit','Location - Contact Page','1');">
    </div>
  </form>
</div>