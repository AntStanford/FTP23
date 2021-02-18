<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0">
  <cfinclude template="/components/meta.cfm">
  <cfoutput>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Raleway:400,400i,700&display=swap" rel="stylesheet">
  <link href="/#application.settings.mls.dir#/stylesheets/styles.css?v=3" rel="stylesheet" type="text/css">
  <link href="/admin/pages/contentbuilder/assets/minimalist-basic/content-bootstrap-icnd.css" rel="stylesheet" type="text/css">
  <!--- UPDATE FA TO V5 --->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.css" rel="stylesheet">
  </cfoutput>

  <cf_htmlfoot>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" type="text/javascript"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.4.1/jquery-migrate.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="//maps.googleapis.com/maps/api/js?v=3&key=<cfoutput>#settings.googleMapsAPIKey#</cfoutput>"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OverlappingMarkerSpiderfier/1.0.3/oms.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/js-marker-clusterer/1.0.0/markerclusterer_compiled.js"></script>
  </cf_htmlfoot>

  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
  <cfinclude template="/components/analytics.cfm">
	<script type="text/javascript">
    var onloadCallback = function() {
    	if($('div#sendtofriendcaptcha').length){
	      //Send to Friend form on the PDP
	      var sendtofriend = grecaptcha.render('sendtofriendcaptcha', {
	        'sitekey' : '<cfoutput>#application.settings.google_recaptcha_sitekey#</cfoutput>'
	      });
      }
      if($('div#reviewscaptcha').length){
	      //Submit a Review form on the PDP
        var reviews = grecaptcha.render('reviewscaptcha', {
	        'sitekey' : '<cfoutput>#application.settings.google_recaptcha_sitekey#</cfoutput>'
	      });
      }
      if($('div#qandacaptcha').length){
	      //Submit a Question form on the PDP
        var qanda = grecaptcha.render('qandacaptcha', {
	        'sitekey' : '<cfoutput>#application.settings.google_recaptcha_sitekey#</cfoutput>'
	      });
      }
      if($('div#pdpmoreinfocaptcha').length){
	      //Request More Info form on the PDP
        var qanda = grecaptcha.render('pdpmoreinfocaptcha', {
	        'sitekey' : '<cfoutput>#application.settings.google_recaptcha_sitekey#</cfoutput>'
	      });
      }
      if($('div#sendtofriendcomparecaptcha').length){
	      //Send To Friend contact form
        var footerform = grecaptcha.render('sendtofriendcomparecaptcha', {
	        'sitekey' : '<cfoutput>#application.settings.google_recaptcha_sitekey#</cfoutput>'
	      });
      }
      if($('div#mlsCreateFormDiv').length){
        //Create account form
        var mlsCreateAccount = grecaptcha.render('mlsCreateAccountRecaptcha', {
          'sitekey' : '<cfoutput>#application.settings.google_recaptcha_sitekey#</cfoutput>'
        });
      }
      if($('div#propertyContactCaptcha').length){
        //Contact form on the Contact Us page
        var propertyContactForm = grecaptcha.render('propertyContactCaptcha', {
          'sitekey' : '<cfoutput>#settings.google_recaptcha_sitekey#</cfoutput>'
        });
      }
    };
	</script>
  <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5ac797b5adfdf8a5"></script>
</head>
<body<cfif cgi.script_name eq '/#application.settings.mls.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (isdefined('page.isCustomSearchPage') and page.isCustomSearchPage eq 'yes') OR (parameterexists(id) and (getinfo.layout contains 'full-mls.cfm')) or (isdefined('savedsearch') and savedsearch)> class="results-body"</cfif>>
  <div class="wrapper">
    <div class="mls-header-wrap<cfif cgi.script_name eq '/#application.settings.mls.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (isdefined('page.isCustomSearchPage') and page.isCustomSearchPage eq 'yes')> results-header-wrap</cfif> site-color-1-bg">
      <div class="header">
        <div class="header-logo">
          <a href="/"><img src="/mls/images/logo-mls.png" alt="The Shore Group - Chincoteague Real Estate"></a>
        </div>

        <!--- OTHER MLS PAGES --->
        <div class="header-nav">
          <a href="javascript:;" class="header-mobileToggle"><span><i class="fa fa-bars"></i></span></a>
          <cfinclude template="/components/navigation.cfm">
        </div>
        <!-- END header-nav -->

        <cfif isDefined("cookie.loggedIn") and cookie.loggedIn gt 0>
          <cfset clientid = cookie.loggedIn>
        <cfelse>
          <cfset clientid = 0>
        </cfif>

        <cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
        <cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER"><!--- just to make sure the cookie favorite list is up to date --->

        <div class="header-actions">

          <!-- RECENTLY VIEWED -->
          <a href="javascript:;" class="header-actions-action site-color-1-lighten-bg-hover" id="recentlyViewedToggle">
            <div rel="tooltip" data-placement="bottom" title="Properties you have Recently Viewed">
              <small>Recently Viewed</small>
              <i class="fa fa-eye text-white"></i>
              <span><em class="header-recently-viewed-count"><cfif StructKeyExists(cookie,'mlsrecent') and ListLen(cookie.mlsrecent)><cfoutput>#listlen(cookie.mlsrecent)#</cfoutput><cfelse>0</cfif></em></span>
            </div>
          </a>
          <cfinclude template="/#application.settings.mls.dir#/_recentlist.cfm">

          <!-- FAVORITES -->
          <a href="javascript:;" class="header-actions-action site-color-1-lighten-bg-hover" id="favoritesToggle">
            <div rel="tooltip" data-placement="bottom" title="Your Favorited Properties">
              <small>Favorites</small>
              <i class="fa fa-heart"></i>
              <span><em class="header-favorites-count"><cfif StructKeyExists(cookie,'mlsfavorites') and ListLen(cookie.mlsfavorites)><cfoutput>#listlen(cookie.mlsfavorites)#</cfoutput><cfelse>0</cfif></em></span>
            </div>
          </a>
          <cfinclude template="/#application.settings.mls.dir#/_favoriteslist.cfm">

          <!-- LOGIN/ACCOUNT -->
          <span id="mlsAccountLink">
            <cfif isdefined('cookie.loggedin') and len(cookie.loggedin)> <!-- IF LOGGED IN, DISPLAY NAME -->
              <a href="/mls/my-profile.cfm" class="header-actions-action header-action-create-account site-color-1-lighten-bg-hover">
                <div rel="tooltip" data-placement="bottom" title="View My Account">
                  <small><cfoutput>#cookie.userfirstname#</cfoutput></small>
            <cfelse>
              <a class="header-actions-action header-action-create-account site-color-1-lighten-bg-hover" data-toggle="modal" data-target="#loginModal">
                <div rel="tooltip" data-placement="bottom" title="Login / Create An Account">
                  <small>Login</small>
            </cfif>
                <i class="fa fa-user text-white"></i>
              </div>
            </a>
          <!--- <cfinclude template="/components/signup-account.cfm">  --->
          </span>
          <!-- PHONE NUMBER -->
          <a href="tel:<cfoutput>#settings.tollFree#</cfoutput>" class="header-actions-action header-action-phone text-white">
            <i class="fa fa-mobile text-white"></i>
            <small><cfoutput>#settings.tollFree#</cfoutput></small>
          </a>
        </div><!-- END header-actions -->

      </div><!-- END header -->
    </div><!-- END mls-header-wrap -->