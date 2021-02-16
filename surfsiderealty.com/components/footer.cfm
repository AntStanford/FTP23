		<div class="footer">
				<img src="/mls/images/layout/realty-footer-bg.jpg">
				<div class="container">
					<div class="contact">
						<a class="logo" href="/realty/index.html"><img src="/mls/images/layout/footer-logo.png"></a>
						<div>
							<address>
								<span>Surfside Realty Company</span>
								213 South Ocean Boulevard<br>
								Surfside Beach, SC  29575
							</address>
							<p>Phone: <a hreflang="en" href="tel://800-833-8231">800-833-8231</a></p>
							<a hreflang="en" href="/contact-surfside-realty.cfm">Click Here to Email Us</a>
						</div>
					</div>
					<div class="contact-form">
						<img src="/mls/images/layout/contact-wave.jpg">
						<cfif cgi.script_name does not contain "vacation-rental-blog">
						<h3>Request More Information</h3>
						<form id="footerContactForm" role="form" method="post">
								<cfinclude template="/cfformprotect/cffp.cfm">
							<input type="hidden" name="whichform" value="footerContactForm">
							<input type="hidden" name="PAGEFROM" value="footerContactForm">
							<input type="text" name="firstname" placeholder="First Name*">
							<input type="text" name="lastname" placeholder="Last Name">
							<input type="text" name="email" placeholder="Email*">
							<input type="hidden" value="<cfoutput>#cgi.HTTP_REFERER#</cfoutput>" name="pagefrom">
							<div>
								<textarea name="comments" placeholder="Comments/Message*"></textarea>
							</div>
                            <div id="footerContactFormcaptcha"></div><br />
            				<div class="g-recaptcha-error"></div>
							<center>
							<input type="submit" value="Submit" name="" onClick="ga('nativeTracker.send', 'event', { eventCategory: 'quick-contact', eventAction: 'submitted', eventLabel: 'footer-quick-contact'});">
							</center>
							<div id="footerContactFormMSG"></div>
						</form>
						</cfif>
					</div>
					<div class="communities">
<cfif (isdefined('page.slug') and page.slug contains('sales')) or (cgi.script_name contains('sales') or cgi.script_name contains('mls'))>
						<h4>Communities</h4>
						<ul>
							<li><a hreflang="en" href="/sales/garden-city">GARDEN CITY REAL ESTATE</a></li>
							<li><a hreflang="en" href="/sales/litchfield-beaches">LITCHFIELD BEACHES REAL ESTATE</a></li>
							<li><a hreflang="en" href="/sales/murrells-inlet">MURRELLS INLET REAL ESTATE</a></li>
							<li><a hreflang="en" href="/sales/myrtle-beach">MYRTLE BEACH REAL ESTATE</a></li>
							<li><a hreflang="en" href="/sales/north-myrtle-beach">NORTH MYRTLE BEACH REAL ESTATE</a></li>
							<li><a hreflang="en" href="/sales/pawleys-island">PAWLEYS ISLAND REAL ESTATE</a></li>
							<li><a hreflang="en" href="/sales/surfside-beach">SURFSIDE BEACH REAL ESTATE</a></li>
						</ul>
<cfelse>
<!--- 						<a class="btn coral" href="https://secure.instantsoftwareonline.com/OwnerLink/(S(xqh14mufwnvn1m55fhyyx2nm))/Owners/PropertyOwnerLogin.aspx?coid=0260" target="_blank">Ownernet</a> --->
            <a class="btn coral" href="https://owner.escapia.com/2630" target="_blank">Ownernet</a>
						<h4>Local Info</h4>
						<ul>
              <li><a hreflang="en" href="https://www.magazooms.com/HTML5/Beach-Favorites-Magazine-Edition-2020" target="_blank">Beach Favorites Magazine</a></li>
							<li><a hreflang="en" href="/about-garden-city-beach-south-carolina">Garden City Beach</a></li>
							<li><a hreflang="en" href="/surfside-beach-sc-weather">Weather</a></li>
						</ul>
</cfif>
            <!--- TEMPORARY UNTIL APPROVED - DO NOT REMOVE --->
					  <!--- http://pt2.icnd.net/projects/view-task.cfm?projectID=592&taskid=69309 --->
					  <button class="btn turq" data-toggle="modal" data-target="#customNewsletterModal" style="white-space:normal;">Sign Up for Our Newsletter</button>

            <cf_htmlfoot>
            <!-- Modal -->
            <div class="modal fade" id="customNewsletterModal" tabindex="-1" role="dialog" aria-labelledby="customNewsletterModal">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Sign Up for Our Newsletter</h4>
                  </div>
                  <div class="modal-body">
                    <div id="customNewsletterModalFormMSG"></div>

                    <form name="customNewsletterModalForm" id="customNewsletterModalForm">
                      <cfinclude template="/cfformprotect/cffp.cfm">
                      <div class="modal-body">
                        <div class="form-group">
                          <label for="customNewsletterModalName">Name</label>
                          <input type="text" class="form-control required" name="customNewsletterModalName" id="customNewsletterModalName">
                        </div>
                        <div class="form-group">
                          <label for="customNewsletterModalEmailAddress">Email Address</label>
                          <input type="email" class="form-control required" name="customNewsletterModalEmailAddress" id="customNewsletterModalEmailAddress">
                        </div>
                        <div class="form-group">
                          <div id="customNewsletterModalcaptcha"></div><br />
                          <div class="g-recaptcha-error"></div>
                        </div>
                      </div>
                      <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Sign Up</button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
            </cf_htmlfoot>

					</div>
				</div>
				<div class="baseline">
					<div class="container">
						<p>&copy; <cfoutput>#DateFormat(now(), 'yyyy')#</cfoutput> Surfside Realty Company. All Rights Reserved. <span>Website Design by InterCoastal Net Designs</span></p>
					</div>
				</div><!-- END baseline -->
			</div><!-- END footer -->
		</div><!-- END wrapper -->

<!-- START: SeasideReferral Modal -->
<cfif isdefined('url.utm_campaign') and url.utm_campaign eq 'SeasideReferral'>
	<div id="seasideModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
          <img class="modal-logo" src="/images/surfside-seaside-logo.png" alt="Surfside Realty and Seaside Rentals">
          <!---
          <img src="/images/surfside-logo.png" alt="Surfside Realty">
          <img src="/images/seaside-rentals-logo.png" alt="Seaside Rentals">
          --->
	      </div>
	      <div class="modal-body">
	        <p>Seaside Rentals is now part of Surfside Realty! But don't worry, all the great properties and fun stays you have grown to love are still part of our rental program. Please let us know if we can be of any help to you!!</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Great, thanks!</button>
	      </div>
	    </div>
	  </div>
	</div>
</cfif>
<!-- END: SeasideReferral  Modal -->
<cf_htmlfoot>
  <script src="/sales/javascripts/chosen/chosen.jquery.js"></script>
  <script src="/sales/javascripts/global.min.js"></script>
	<!--- Footer Form submit --->
	<script type="text/javascript">
		$(document).ready(function () {

	    $(window).on('load',function(){
        $('#seasideModal').modal('show');
	    });

	    $('#footerContactForm').validate({
        rules: {
          firstname: {
            required: true
          },
          email: {
            required: true,
            email: true
          },
          comments: {
            required: true
          },
        },
        highlight: function (element) {
          $(element).closest('.control-group').removeClass('success').addClass('error');
        },
        success: function (element) {
          element.text('OK!').addClass('valid')
            .closest('.control-group').removeClass('error').addClass('success');
        },
        submitHandler: function (form) {
          // form validates so do the ajax
          $.ajax({
            type: $(form).attr('method'),
						url:'/submit.cfm',
            data: $(form).serialize(),
            success: function (response, status) {
						response = $.trim(response);
						console.log("response: '" + response + "'");
						if(response === "success") {
						// ajax done
              $("#footerContactFormMSG").html('Thank you for contacting us!')
            }
      				else {
							  $("div.g-recaptcha-error").html("<font color='red'>You must complete the reCAPTCHA</font>");
						  }
            }
          });
          return false; // ajax used, block the normal submit
        }
	    });

      $('#customNewsletterModalForm').validate({
        submitHandler: function (form) {
          // form validates so do the ajax
          $.ajax({
            type: 'POST',
            url:'/submit.cfm',
            data: $('#customNewsletterModalForm').serialize(),
            success: function (response, status) {
              response = $.trim(response);

              if(status === "success") {
              // ajax done
                $('#customNewsletterModalForm').hide();
                $("#customNewsletterModalFormMSG").html('Thank you for contacting us!')
              } else {
                $("div.g-recaptcha-error").html("<font color='red'>You must complete the reCAPTCHA</font>");
              }
            }
          });

          return false; // ajax used, block the normal submit
        }
      });
		});
	</script>
	<style>#footerMSG{color:black;}</style>

  <script type="text/javascript">
    $(document).ready(function ($) {
			// /south-myrtle-beach-vacation-rental-specials.cfm
			$( "#strCheckin" ).datepicker({
				minDate: '+2d',
				onSelect: function( selectedDate ) {
					var newDate = $(this).datepicker('getDate');
					newDate.setDate(newDate.getDate()+7);
					$('#strCheckin1').datepicker('setDate',newDate);
					$('#strCheckin1').datepicker('option','minDate',selectedDate);
					setTimeout(function(){
						$( "#strCheckin1" ).datepicker('show');
					}, 16);
				}
			});

			$( "#strCheckin1" ).datepicker({
			 minDate: '+2d'
			});
      // $( "#strCheckin" ).datepicker();

      $('#quickTabs').tab();
    });
  </script>

	<cfif cgi.script_name eq '/rentals/property.cfm'>

    <!--- All the JS below is for the datepicker on the property detail page --->
    <!---
      ***************************************************************************
      THE ACTUAL CODE FOR PDP IS IN _travel-dates.cfm
      ***************************************************************************
    --->
    <script type="text/javascript">
      $(document).ready(function() {
        $(document).on("hidden.bs.modal", function (e) {
          $(e.target).removeData("bs.modal").find("#familycalculator").empty();
        });

        $( "#start-date-detail" ).datepicker({
          minDate: '+2d',
					beforeShowDay: checkAvailability,
      		onSelect: function( selectedDate ) {
      			var newDate = $(this).datepicker('getDate');
      			newDate.setDate(newDate.getDate()+7);
      			$("#end-date-detail").prop('disabled', false);
      			$('#end-date-detail').datepicker('setDate',newDate);
      			$('#end-date-detail').datepicker('option','minDate',selectedDate);
      			setTimeout(function(){
    			  	$( "#end-date-detail" ).datepicker('show');
      			}, 16);
          } //end onSelect
        });

        // show date picker on start date when button "btn_selectDates" is clicked
        $( "#btn_selectDates" ).click( function(){
          $( "#start-date-detail" ).datepicker('show');
        }
        );

        $( "#end-date-detail" ).datepicker({
          minDate: '+2d',
          beforeShowDay: checkAvailability,
          onSelect: function(selectedDate){
  					var tStartDate = $("#start-date-detail").datepicker('getDate');
  					var tEndDate = $(this).datepicker('getDate');

  					if ( tStartDate != '' && tEndDate!= '' ) {
  						$( "#btn_selectDates" ).hide();
  					}

		      	submitForm();
          }
        });

        var myBadDates = [];
        var counter = 0;

        //nonAvailList is defined in _calendar-tab.cfm
        <cfloop list="#nonAvailListForDatepicker#" index="i">
          <cfoutput>
            myBadDates[counter] = '#DateFormat(i,"yyyy-mm-dd")#';
          </cfoutput>
          counter = counter + 1;
        </cfloop>

        function checkAvailability(mydate){
          var $return=true;
          var $returnclass ="available";
          $checkdate = $.datepicker.formatDate('yy-mm-dd', mydate);

          for(var i = 0; i < myBadDates.length; i++)
          {
            if(myBadDates[i] == $checkdate){
              $return = false;
              $returnclass= "unavailable";
            }
          }
          return [$return,$returnclass];
        }
      });
    </script>
	</cfif>
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "LocalBusiness",
  "name": "Surfside Realty",
  "telephone": "(843) 238-3435",
  "email": "info@surfsiderealty.com",
  "address":
{
  "@type": "PostalAddress",
  "streetAddress": "213 S Ocean Blvd",
  "addressLocality": "Surfside Realty",
  "addressRegion": "SC",
  "addressCountry": "USA",
  "postalCode": "29575"
},
  "url": "http://www.surfsiderealty.com/",
  "logo": "http://www.surfsiderealty.com/images/layout/logo.png",
  "hasMap": "https://www.google.com/maps/place/Surfside+Realty+Company/@33.6036912,-78.9763899,17z/data=!3m1!4b1!4m2!3m1!1s0x890040fd54d4e73f:0x1bfa31f021d78420",
  "geo":
{
  "@type": "GeoCoordinates",
  "latitude": "33.6036912",
  "longitude": "-78.9763899"
},
  "sameAs" : [
  "https://www.facebook.com/SurfsideRealty/",
  "https://twitter.com/surfsiderealty",
  "https://www.linkedin.com/company/surfside-realty"
  ]
}
</script>

<!-- Hotjar Tracking Code for http://www.surfsiderealty.com/ -->
<script>
  (function(h,o,t,j,a,r){
    h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
    h._hjSettings={hjid:143540,hjsv:5};
    a=o.getElementsByTagName('head')[0];
    r=o.createElement('script');r.async=1;
    r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
    a.appendChild(r);
  })(window,document,'//static.hotjar.com/c/hotjar-','.js?sv=');
</script>

<!-- This site is converting visitors into subscribers and customers with OptinMonster - http://optinmonster.com --><div id="om-fyow2ekmuwghczrx-holder"></div><script>var fyow2ekmuwghczrx,fyow2ekmuwghczrx_poll=function(){var r=0;return function(n,l){clearInterval(r),r=setInterval(n,l)}}();!function(e,t,n){if(e.getElementById(n)){fyow2ekmuwghczrx_poll(function(){if(window['om_loaded']){if(!fyow2ekmuwghczrx){fyow2ekmuwghczrx=new OptinMonsterApp();return fyow2ekmuwghczrx.init({u:"11630.277282",staging:0,dev:0});}}},25);return;}var d=false,o=e.createElement(t);o.id=n,o.src="//a.optnmnstr.com/app/js/api.min.js",o.onload=o.onreadystatechange=function(){if(!d){if(!this.readyState||this.readyState==="loaded"||this.readyState==="complete"){try{d=om_loaded=true;fyow2ekmuwghczrx=new OptinMonsterApp();fyow2ekmuwghczrx.init({u:"11630.277282",staging:0,dev:0});o.onload=o.onreadystatechange=null;}catch(t){}}}};(document.getElementsByTagName("head")[0]||document.documentElement).appendChild(o)}(document,"script","omapi-script");</script><!-- / OptinMonster -->

<cfinclude template="/components/facebook-pixel.cfm">

<!---<cfif isdefined('page.id') and LEN(page.id)>
  <cfquery name="qryEmailPopup" dataSource="#settings.dsn#">
    SELECT title,message,link,linkText,photo,captureEmail
    FROM cms_popup
    where isActive = <cfqueryparam value="1" cfsqltype="tinyint">
    and id in (select popupid from cms_popup_pages where pageid = <cfqueryparam value="#page.id#" cfsqltype="integer">)
    Limit 1
  </cfquery>
</cfif>
<cfif !isDefined("cookie.popupform") and isdefined('qryEmailPopup.recordcount') and qryEmailPopup.recordcount eq 1 and isdefined('page.id')>
--->

<!--- NOT IN USE AT THE MOMENT - COMMENTING OUT 12/22/20
<cfif cgi.remote_host eq '75.87.66.209' or cgi.remote_host eq '99.1.177.220' or cgi.remote_host eq '68.44.158.31' or cgi.remote_host eq '216.99.119.254'>
  <script>
  $(document).ready(function(){
        setTimeout(function() {
            $('#signupModal').fadeIn(1000).modal();
        }, 3000);
        $.ajax({
            type: "POST",
            url: "/components/popup-cookie.cfm"
          });
        $("#popupdealsform").submit(function(){
          var formCheck = $('#popupdealsform').validate();
          if (formCheck.invalid.signupemail === undefined){
              console.log('valid');

              var str = $('#popupdealsform').serialize();
              $.ajax({
                type: "POST",
                url: "/submit.cfm",
                data: str,
                success: function(msg){
                  $("#dealsMessage").html('Thank you for signing up!');
                  $("#popupdealsform").hide();
                }
              }); //end success
          }
          return false;
        }); //end submit
  });
  </script>
  <!--- <cfset session.modalViewed = 1> --->
  <style>
  /* Sign up modal */
  #signupModal .close { position: absolute; top: 7px; right: 11px; float: none; z-index: 9999999; }
  #signupModal .modal-content { border-radius: 0; }
  #signupModal .modal-body { padding: 0; }
  #signupModal h4 { font-size:25px; }
  #signupModal h5 { font-size:18px; }
  #signupModal .signup-btn { margin: 0; }
  #signupModal .logo { display: block; margin: 0 auto 25px; position: relative; }
  #signupModal h4 { font-family: 'Barlow', sans-serif; font-size: 30px; line-height: 1.25; }
  #signupModal small { display: table; margin: 0 auto 25px; padding-bottom: 20px; border-bottom: 1px solid #fff; font-family: 'Quicksand', sans-serif; }
  #signupModal input[type=email] { display: block; width: 100%; margin: 0 auto 15px; padding: 12px 15px; border: 1px hsl(181, 100%, 37%) solid; line-height: 1; border-radius: 2px; text-overflow: ellipsis; letter-spacing: normal; }
  #signupModal input[type=submit] { display: block; margin: 0 auto; padding: 10px 45px; }
  .signup-modal-wrap { position: relative; display: flex; }
  .signup-modal-left { width: 50%; flex-grow: 1; background-size: cover !important; background-repeat: no-repeat !important; background-position: center center !important; }
  .signup-modal-right { width: 50%; padding: 15px; }
  @media (max-width: 600px) {
    .signup-modal-wrap { flex-direction: column; }
    .signup-modal-left { width: 100%; padding-bottom: 50%; background-size: contain !important; }
    .signup-modal-right { width: 100%; }
  }
  </style>

  <div class="modal" id="signupModal">
    <div class="modal-dialog" role="document">
      <div class="modal-content text-center">
        <div class="modal-body">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <div class="signup-modal-wrap">
            <cfoutput>
            <!--- <div class="signup-modal-left" style="background:url('https://placehold.it/300x400&text=placeholder');"></div> --->
            <div class="signup-modal-left" <cfif isdefined('qryEmailPopup.photo') and LEN(qryEmailPopup.photo)>style="background:url('/images/popups/#qryEmailPopup.photo#');"</cfif>></div>
            <div class="signup-modal-right">
              <img class="logo" src="/images/layout/logo.png" alt="Outer Beaches Realty">
              <cfif isdefined('qryEmailPopup.title') and LEN(qryEmailPopup.title)><h4>#qryEmailPopup.title#</h4></cfif>
              <cfif isdefined('qryEmailPopup.message') and LEN(qryEmailPopup.message)><p>#qryEmailPopup.message#</p></cfif>
              </cfoutput>
              <cfif isdefined('qryEmailPopup.link') and LEN(qryEmailPopup.link)>
                <cfoutput><p><a href="#qryEmailPopup.link#" class="btn btn-mini btn-block site-color-2-bg site-color-2-lighten-bg-hover text-white signup-btn" id="popupModalLink"><cfif isdefined('qryEmailPopup.linkText') and LEN(qryEmailPopup.linkText)>#qryEmailPopup.linkText#<cfelse>Read More</cfif></a></p></cfoutput>
              </cfif>
              <p><em id="dealsMessage"></em></p>
              <form id="popupdealsform" class="validate">
                <cfif isdefined('qryEmailPopup.captureEmail') and qryEmailPopup.captureEmail eq 1>
                <cfinclude template="/cfformprotect/cffp.cfm">
                <fieldset>
                  <input type="hidden" name="popupdealsform">
                  <input type="email" name="signupemail" class="required" placeholder="Enter your email address here...">
                  <input type="submit" name="signup" value="Sign Up" class="btn btn-block site-color-1-bg site-color-1-lighten-bg-hover text-white signup-btn">
                </fieldset>
                </cfif>
              </form>
            </div>
          </div>
        </div>
        </div>
      </div>
    </div>
  </div><!-- END modal -->
</cfif>
--->

</cf_htmlfoot>

<!--- Main Script Calls before all other script calls via <cf_htmlfoot> --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.4.1/jquery-migrate.min.js"></script>
<script src="/bootstrap/js/bootstrap.min.js"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/jquery.lazy.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/plugins/jquery.lazy.iframe.min.js" type="text/javascript"></script>
<script defer src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" type="text/javascript"></script>
<script defer src="/javascripts/jquery-validate/jquery.validate.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
<!--- Output all Javascript Files --->
<cf_htmlfoot output="true" />
<!--- Global.js made last on Purpose --->
<script defer src="/javascripts/global.min.js?v=3.2"></script>
<!--- <script src="https://www.google.com/recaptcha/api.js"></script> --->
<cfinclude template="/components/cart-abandonment-footer.cfm">

<cfif NOT IsDefined("Cookie.surfsidenewsletterpopup")>
  <cfinclude template="/components/newsletter-modal.cfm">
</cfif>
</body>
</html>



<!--- <cfif cgi.remote_addr eq '45.42.5.230'>
   PSSSSSSSSSSSSSSSSST

  <cfoutput>
    #isDefined('session.booking.getResults')#<br> #isDefined('session.blahblah.blah')#
  </cfoutput>
</cfif> --->