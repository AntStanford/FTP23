<cfcookie name="surfsidenewsletterpopup" expires="2">

<cfquery name="qryGetPopUp" datasource="#settings.dsn#">
	SELECT title,photo,captureEmail,message,link,linkText,showCompanyBox
	FROM cms_popups
	WHERE isActive = <cfqueryparam cfsqltype="cf_sql_integer" value="1" />
	LIMIT 1
</cfquery>

<cfif qryGetPopUp.recordcount eq 1>
	<style>
		#modal1 .modal-content { border-radius:0; text-align:center; }
		#modal1 .modal-body { display:flex; padding:20px 15px; }
		#modal1 .modal-body .half-sec { width:50% }
		#modal1 button.close { position:absolute; top:10px; right:15px; font-size:27px; }
		#modal1 .half-sec.half-left { background-size:cover; background-repeat:no-repeat; background-position:center; display: flex; justify-content: center; align-items: center; }
		#modal1 .half-sec.half-left img { max-width: 100%; height: auto; }
		#modal1 img { margin-bottom:5px; max-height:150px; }
		#modal1 .btn { margin-top:5px; }
		#newsletter-modal-email { padding: 5px 10px; width: 90%; margin-bottom: 5px; }
		@media(max-width:536px){
			#modal1 .modal-body { display:block; }
			#modal1 .modal-body .half-sec { width:100%; }
			/* #modal1 .half-sec.half-left { padding-bottom:50%; } */
			#modal1 .half-sec.half-left img { margin: 20px 0; }
		}
	</style>
	
	<cfoutput>
		<div id="modal1" class="modal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-body">
						<button type="button" class="close" data-dismiss="modal">&times;</button>

						<cfif len( qryGetPopUp.photo ) gt 0>
							<!--- <div class="half-sec half-left" style="background-image:url('/images/layouts/COVID-19_travel-guarantee_popup.png');"></div> --->
							<!--- <div class="half-sec half-left" style="background-image:url('/images/popups/#qryGetPopUp.photo#');"></div> --->
							<div class="half-sec half-left">
								<img src="/images/popups/#qryGetPopUp.photo#">
							</div>
						</cfif>

						<div class="half-sec">
							<img src="/images/layout/logo.png" alt="#settings.company#">
							<!---
							<cfif qryGetPopUp.showCompanyBox eq 1>
								<img src="/images/layout/logo.png" alt="#settings.company#">
								<!---
								<div class="modal-heading">
									<h2>#settings.company#</h2>
									<p><small></small></p>
								</div>
								--->
							</cfif>
							--->
							<cfif len( qryGetPopUp.title ) gt 0>
								<h4>#qryGetPopUp.title#</h4>
							</cfif>

							<p>#qryGetPopUp.message#</p>

							<cfif len( qryGetPopUp.link ) gt 0>
								<p>
									<a href="#qryGetPopUp.link#" class="btn btn-blue">
										<cfif len( qryGetPopUp.linkText ) gt 0>
											#qryGetPopUp.linkText#
										<cfelse>
											Read More
										</cfif>
									</a>
								</p>
							</cfif>

							<p id="success-message" style="display:none;">Thanks! Your email has been sent! Close this window to continue browsing the website.</p>

							<cfif qryGetPopUp.captureEmail eq 1>
								<form id="newsletter-modal-form" name="newsletter-modal-form" method="post" action="/submit.cfm">
									<cfinclude template="/cfformprotect/cffp.cfm">
									<input type="hidden" name="newsletterModalForm" value="yes">
									<input type="text" id="newsletter-modal-email" name="email" placeholder="Email Address" required>
									<label class="hidden" for="newsletter-modal-email">Email Address</label>
									<input type="submit" class="btn btn-blue" value="Keep Me Informed">
								</form>
								<button type="button" class="btn btn-tan close-btn" data-dismiss="modal">No Thanks</button>
							</cfif>
						</div>
					</div>
				</div>
			</div>
		</div>

		
	</cfoutput>

  <script type="text/javascript">
  $( document ).ready(function() {

    $('#modal1').modal('show');

    $('#newsletter-modal-form').submit(function(e){
    	e.preventDefault();
      	var checkEmail = $('#newsletter-modal-email').val();

        if ($.trim(checkEmail) == '') {

        } else {
          $.post({
            url: $(this).attr('action'),
            data: $(this).serialize(),
            success: function(data){
              $('#newsletter-modal-form').hide();
              $('#success-message').show();
            }
          });
        }

     });

   });
  </script>
</cfif>
