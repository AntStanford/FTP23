<script type="text/javascript">
var onloadCallback = function() {
  if($('div#contactcaptcha').length){
    //Contact form on the Contact Us page
    var contactform = grecaptcha.render('contactcaptcha', {
      'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
    });
  }
  if($('div#newslettercaptcha').length){
    //Contact form on the Contact Us page
    var newsletterform = grecaptcha.render('newslettercaptcha', {
      'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>',
      'size' : 'compact'
    });
  }
  if($('div#newsletterformcaptcha').length){
    //Contact form on the Contact Us page
    var newsletterformcaptcha = grecaptcha.render('newsletterformcaptcha', {
      'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
    });
  }
  if($('div#propertymanagementformcaptcha').length){
    //Contact form on the Contact Us page
    var propertymanagementform = grecaptcha.render('propertymanagementformcaptcha', {
      'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
    });
  }
  if($('div#footercaptcha').length){
    //Footer contact form
    var footerform = grecaptcha.render('footercaptcha', {
      'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>',
    });
  }
  //ADA Compliance for Google Recaptcha
  if ( $('textarea[id^=g-recaptcha-response]').length ) {
    $('textarea[id^=g-recaptcha-response]').each(function(){
      var id = $(this).attr('id');
      $(this).before('<label for="'+id+'" class="hidden">'+id+'</label>');
    });
  }
};
</script>