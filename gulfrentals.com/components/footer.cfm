	<div class="i-footer">
  	<button id="returnToTop" class="return-to-top site-color-5-bg" type="button">
    	<i class="fa fa-chevron-up"></i>
    	<span class="hidden">Return To Top</span>
  	</button>
		<div class="container">
  		<div class="row">
    		<div class="col-sm-12 col-md-6 col-lg-3">
      		<cfoutput><a href="/" class="i-footer-logo"></cfoutput>
      		  <img class="lazy" data-src="/images/layout/logo.png" src="/images/layout/1x1.png" width="100%" alt="Resort Vacation Properties Logo">
					</a>
					<!---
    			<div class="i-footer-search-wrap">
      			<form class="i-footer-search-form" method="post" action="/site-search">
        			<label for="fs-searchterm" class="hidden">Search</label>
        			<input type="search" placeholder="Search" class="i-footer-search" name="searchterm" id="fs-searchterm">
              <button type="submit" class="i-footer-search-submit" name="submit">
                <i class="fa fa-search"></i>
                <span class="hidden">Search</span>
              </button>
      			</form>
					</div>
				--->
				</div>
				
    		<div class="col-sm-12 col-md-6 col-lg-3">
          <p class="h4 text-white">Quick Links</p>
          <ul class="i-footer-links">

    				<cfquery name="getFooterLinks" dataSource="#settings.dsn#">
    					select * from cms_pages where showInFooter = 'Yes' order by sort
    				</cfquery>

    				<cfif getFooterLinks.recordcount gt 0>

    					<cfoutput query="getFooterLinks">
    						<cfif len(getFooterLinks.externalLink)>
    							<li><a href="#getFooterLinks.externalLink#" class="text-white site-color-2-hover" target="_blank">#getFooterLinks.name#</a></li>
    						<cfelse>
    							<li><a href="/#getFooterLinks.slug#" class="text-white site-color-2-hover">#getFooterLinks.name#</a></li>
    						</cfif>
    					</cfoutput>

    				</cfif>
          </ul>
				</div>
    		<div class="col-sm-12 col-md-6 col-lg-3">
          <p class="h4 text-white">Contact Us</p>
          <div class="footer-contact text-white">
            <cfoutput>
              #settings.company#
              <cfif len(settings.address)>
                <address class="footer-address">
                  #settings.address#<br>
                  #settings.city#, #settings.state# #settings.zip#<br>
                </address>
              </cfif>
      			  <cfif len(settings.tollFree)>
      			    <a href="tel:#settings.tollFree#" class="footer-phone text-white text-white-hover">#settings.tollFree#</a>
      			  </cfif>
      			  <cfif len(settings.phone)>
      			    <a href="tel:#settings.phone#" class="footer-phone text-white text-white-hover">#settings.phone#</a>
      			  </cfif>
              <a href="/contact" class="footer-email text-white text-white-hover box-link">Click Here to Email Us<span><i class="fa fa-chevron-right" aria-hidden="true"></i></span></a>
            </cfoutput>
          </div>
          <cfinclude template="/components/social.cfm">
				</div>
				<div class="col-sm-12 col-md-6 col-lg-3 footer-login">
					<a href="https://resortvacationproperties.ownernetworks.com" class="footer-email text-white text-white-hover box-link">OWNER LOGIN<span><i class="fa fa-chevron-right" aria-hidden="true"></i></span></a>
					<a href="https://resortvacationproperties.tenantnetworks.com" class="footer-email text-white text-white-hover box-link">GUEST LOGIN<span><i class="fa fa-chevron-right" aria-hidden="true"></i></span></a>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12 footer-logos">
					<img src="/images/layout/footer-logo-1.png">
					<img src="/images/layout/footer-logo-2.png">
					<img src="/images/layout/footer-logo-3.png">
					<img src="/images/layout/footer-logo-4.png">
					<img src="/images/layout/footer-logo-5.png">
					<img src="/images/layout/footer-logo-6.png">
				</div>
				<!---
    		<div class="col-sm-12 col-md-6 col-lg-3">
          <p class="h4 text-white">E-Newsletter</p>
    			<div id="footerformMSG" class="text-white"></div>
          <form class="i-footer-e-newsletter-form validate" id="footerform">
            <cfinclude template="/cfformprotect/cffp.cfm">
            <div class="row">
              <div class="col-sm-6 col-md-6 col-lg-6">
                <label for="fn-firstname" class="hidden">fn-firstname</label>
                <input type="text" placeholder="First Name" name="firstname" id="fn-firstname" class="required">
              </div>
              <div class="col-sm-6 col-md-6 col-lg-6">
                <label for="fn-lastname" class="hidden">fn-lastname</label>
                <input type="text" placeholder="Last Name" name="lastname" id="fn-lastname" class="required">
              </div>
              <div class="col-sm-12">
                <label for="fn-email" class="hidden">fn-email</label>
                <input type="email" placeholder="Email Address" name="email" id="fn-email" class="required">
              </div>
              <div class="col-sm-12">
                <div id="footercaptcha"></div>
                <div class="g-recaptcha-error"></div>
              </div>
              <div class="col-sm-12">
      					<div class="card input-well">
      						<input id="optinFooter" name="optin" type="checkbox" value="Yes"> <label for="optinFooter">
      						I agree to receive information about your rentals, services and specials via phone, email or SMS. <br>
      						You can unsubscribe at anytime. <a href="/privacy-policy.cfm" target="_blank">Privacy Policy</a></label>
      					</div>
    				  </div>
              <div class="col-sm-12 col-md-6 mt-2">
                <button type="button" class="btn reset-btn site-color-2-bg-hover text-white" name="newsletterform">Reset Form</button>
              </div>
              <div class="col-sm-12 col-md-6 mt-2">
                <input type="submit" value="Subscribe" class="btn site-color-2-bg site-color-2-lighten-bg-hover" name="newsletterform">
              </div>
            </div>
          </form>
				</div>
			--->
  		</div>
  		<div class="i-baseline">
    		<p>
      		Copyright &copy; <cfoutput>#dateformat(now(),'YYYY')# #settings.company#</cfoutput>. All Rights Reserved.
      		<span class="float-right">
            <cfif isdefined('page.slug') and page.slug eq 'index'>
        		  <a href="http://icoastalnet.com" target="_blank" class="site-color-2-hover">Website Design</a> by InterCoastal Net Designs
  					<cfelse>
					    Web Design by InterCoastal Net Designs
            </cfif>
      		</span>
    		</p>
  		</div>
		</div>
	</div><!-- END i-footer -->
</div><!-- END i-wrapper -->

<!--- Main Script Calls before all other script calls via <cf_htmlfoot> --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.4.1/jquery-migrate.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha256-CjSoeELFOcH0/uxWu6mC/Vlrc1AARqbm/jiiImDGV3s=" crossorigin="anonymous"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.10/js/bootstrap-select.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/jquery.lazy.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/plugins/jquery.lazy.iframe.min.js" type="text/javascript"></script>
<script defer src="https://cdn.jsdelivr.net/npm/css-vars-ponyfill@2"></script>
<script defer type="text/javascript">
$(document).ready(function(){
  cssVars({
    onlyLegacy: true
  });
});
</script>

<cf_htmlfoot output="true" />

<!--- <cfinclude template="/components/footer-javascripts.cfm"> --->

<!--- Global.js made last on Purpose --->
<script src="/javascripts/global.js" defer></script>

<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>

<cfif fileExists(ExpandPath('/components/cart-abandonment-footer.cfm'))>
	<cfinclude template="/components/cart-abandonment-footer.cfm">
</cfif>

</body>
</html>