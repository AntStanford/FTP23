<!--- BEGIN reCaptcha CODE --->
<script type="text/javascript">
var sendtofriend,sendtofriendcompare,requestinfo,writereview,qanda,contactlong,footerContactForm,generalContactForm,customNewsletterModalForm;
var onloadCallback = function() {
	if($('div#sendtofriendcaptcha').length){
		sendtofriend = grecaptcha.render('sendtofriendcaptcha', {
      	'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
   	});
  }
	if($('div#sendtofriendcomparecaptcha').length){
		sendtofriendcompare = grecaptcha.render('sendtofriendcomparecaptcha', {
    	'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
   	});
  }
	if($('div#requestinfocaptcha').length){
		requestinfo = grecaptcha.render('requestinfocaptcha', {
    	'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
			,'size'	  : 'compact'
   	});
  }
	if($('div#writereviewcaptcha').length){
		writereview = grecaptcha.render('writereviewcaptcha', {
    	'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
   	});
  }
	if($('div#qandacaptcha').length){
		qanda = grecaptcha.render('qandacaptcha', {
    	'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
   	});
  }
	if($('div#contactlongcaptcha').length){
		contactlong = grecaptcha.render('contactlongcaptcha', {
    	'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
   	});
  }
	if($('div#footerContactFormcaptcha').length){
		footerContactForm = grecaptcha.render('footerContactFormcaptcha', {
    	'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
   	});
  }
  if($('div#generalContactFormcaptcha').length){
    generalContactForm = grecaptcha.render('generalContactFormcaptcha', {
      'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
    });
  }
  if($('div#customNewsletterModalcaptcha').length){
    customNewsletterModalForm = grecaptcha.render('customNewsletterModalcaptcha', {
      'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
    });
  }
};
</script>