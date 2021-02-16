			<div class="footer">
				<img src="/sales/images/layout/realty-footer-bg.jpg">
				<div class="container">
					<div class="contact">
						<a class="logo" href="/realty/index.html"><img src="/sales/images/layout/footer-logo.png"></a>
						<div>
							<address>
								<span>Surfside Realty Company</span>
								213 South Ocean Boulevard<br>
								Surfside Beach, SC  29575
							</address>
							<p>Phone: <a hreflang="en" href="tel://866-896-4440">866-896-4440</a></p>
							<cfoutput><a hreflang="en" href="mailto:#cfmail.clientEmail#">Click Here to Email Us</a></cfoutput>
						</div>
					</div>
					<div class="contact-form">
						<img src="/sales/images/layout/contact-wave.jpg">

						<h3>Request More Information</h3>
						<form id="footerContactForm" role="form" method="post">
							<cfinclude template="/cfformprotect/cffp.cfm">
							<input type="hidden" name="whichform" value="footerContactForm">
							<input type="hidden" name="PAGEFROM" value="footerContactForm">
							<input type="text" name="firstname" placeholder="First Name*">
							<input type="text" name="lastname" placeholder="Last Name">
							<input type="email" name="email" placeholder="Email*">
							<div>
								<textarea name="comments" placeholder="Comments/Message*"></textarea>
                                <div id="footerContactFormcaptcha"></div><br />
            				<div class="g-recaptcha-error"></div>
								<input type="submit" value="Submit" name="">
							</div>
						</form>
						<div id="footerContactFormMSG"></div>
					</div>
					<div class="communities">
						<h4>Communities</h4>
						<ul>
							<li><a hreflang="en" href="/sales/garden-city">Garden City Real Estate</a></li>
							<li><a hreflang="en" href="/sales/litchfield-beaches">Litchfield Beaches Real Estate</a></li>
							<li><a hreflang="en" href="/sales/murrells-inlet">Murrells Inlet Real Estate</a></li>
							<li><a hreflang="en" href="/sales/myrtle-beach">Myrtle Beach Real Estate</a></li>
							<li><a hreflang="en" href="/sales/north-myrtle-beach">North Myrtle Beach Real Estate</a></li>
							<li><a hreflang="en" href="/sales/pawleys-island">Pawleys Island Real Estate</a></li>
							<li><a hreflang="en" href="/sales/surfside-beach">Surfside Beach Real Estate</a></li>
						</ul>
					</div>
				</div>
				<div class="baseline">
					<div class="container">
						<p>&copy; 2016 Surfside Realty Company. All Rights Reserved. <span>Website Design by InterCoastal Net Designs</span></p>
					</div>
				</div><!-- END baseline -->
			</div><!-- END footer -->

		</div><!-- END wrapper -->

    <cf_htmlfoot>
<!--- 	   <script src="/bootstrap/js/bootstrap.min.js"></script> --->
	   <script src="/sales/javascripts/cycle/jquery.cycle2.min.js"></script>
	   <script src="/sales/javascripts/cycle/jquery.cycle2.carousel.min.js"></script>
	   <script src="/sales/javascripts/cycle/jquery.cycle2.swipe.min.js"></script>
	   <script src="/sales/javascripts/chosen/chosen.jquery.min.js"></script>

	   		<!--- Form submit --->
			<script type="text/javascript">
					    var frm = $('#footerContactForm');
					    frm.submit(function (ev) {
					        $.ajax({
					            type: frm.attr('method'),
								url:'/submit.cfm',
					            data: frm.serialize(),
					            success: function (response) {
									response = $.trim(response);
									console.log("response: '" + response + "'");
									// if(response) {
									// 	$('#footerContactFormMSG').html(response);
									// }
									// else {
									// 	$("div.g-recaptcha-error").html("<font color='red'>You must complete the reCAPTCHA</font>");
									// }
									if(response === "success") {
            $('form#footerContactForm').hide();
            $('#footerContactFormMSG').html('Thanks! Your request has been sent!');
          }
          else {
            $("div.g-recaptcha-error").html("<font color='red'>You must complete the reCAPTCHA</font>");
          }


					            }
					        });

					        ev.preventDefault();
					    });
					</script>
				<style>#footerMSG{color:black;}</style>

    </cf_htmlfoot>


<cf_htmlfoot>
<cfinclude template="/sales/includes/mls-modals.cfm">
</cf_htmlfoot>

<!--- Main Script Calls before all other script calls via <cf_htmlfoot> --->
<script src="/javascripts/jquery-3.1.1.min.js"></script>
<script src="/javascripts/jquery-migrate-1.4.1.min.js"></script>
<script src="/bootstrap/js/bootstrap.min.js"></script>
<script src="/javascripts/jquery-ui/jquery-ui.min.js"></script> <!--- Datepicker functionality Only (saves 250kb) --->
<script src="/javascripts/jquery-validate/jquery.validate.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
<!--- Output all Javascript Files --->
<cf_htmlfoot output="true" />

   <script src="/sales/javascripts/global.min.js?v=3"></script>

	</body>
</html>


