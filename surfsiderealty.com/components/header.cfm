<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!--- META --->
  <cfinclude template="/components/meta.cfm">
  <meta name="google-site-verification" content="ge3P2Z8uMD7fEvxXa0PcGpgUCPRM02Pfr704-SSOQUY">
  <!--- ANALYTICS --->
  <cfinclude template="/components/analytics.cfm">
  <!--- FONTS --->
  <cfinclude template="/components/fonts.cfm">

  <link rel="dns-prefetch" href="//cdnjs.cloudflare.com">
  <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" hreflang="en">
  <link href="/sales/stylesheets/styles.min.css?v=3.2" rel="stylesheet" hreflang="en">
  <link href="/sales/stylesheets/mls.min.css?v=3" rel="stylesheet" type="text/css" hreflang="en">

  <cfif cgi.script_name does not contain '/sales/'>
    <link href="/stylesheets/styles.min.css?v=3" rel="stylesheet" hreflang="en">
  </cfif>

  <link href="/sales/javascripts/chosen/chosen.css" rel="stylesheet" hreflang="en">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css" hreflang="en">

  <cf_htmlfoot>
  <script src="/jwplayer/jwplayer.min.js" type="text/javascript"></script>
  <script src="/sales/javascripts/cycle/jquery.cycle2.min.js"></script>
  <script src="/sales/javascripts/cycle/jquery.cycle2.carousel.min.js"></script>
  <script src="/sales/javascripts/cycle/jquery.cycle2.swipe.min.js"></script>
  </cf_htmlfoot>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" rel="stylesheet" media="all">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" rel="stylesheet" media="all">

  <cfif cgi.script_name eq '/rentals/property.cfm' and cgi.script_name eq '/long-term/details.cfm'>
    <link rel="stylesheet" href="/javascripts/fancybox/jquery.fancybox.min.css" type="text/css" media="screen" hreflang="en">
    <link rel="stylesheet" href="/javascripts/fancybox/helpers/jquery.fancybox-buttons.css" type="text/css" media="screen" hreflang="en">
    <cf_htmlfoot>
    <script src="/javascripts/fancybox/jquery.fancybox.pack.js"></script>
    <script src="/javascripts/fancybox/helpers/jquery.fancybox-buttons.js"></script>
    <script src="/javascripts/fancybox/helpers/jquery.fancybox-media.js"></script>
    </cf_htmlfoot>
  <cfelse>
    <link rel="stylesheet" type="text/css" href="/sales/javascripts/_plugins/fancybox2/source/jquery.fancybox.css" media="screen" hreflang="en">
    <cf_htmlfoot>
    <script type="text/javascript" src="/sales/javascripts/_plugins/fancybox2/source/jquery.fancybox.js"></script>
    <script type="text/javascript" src="/sales/javascripts/_plugins/fancybox2/source/fancybox_mls.js"></script>
    <!--Callrail Phone Number Tracking Added 1-9-2017 PH -->
  	<script type="text/javascript" src="//cdn.callrail.com/companies/835456052/00ea6fd3167e83869ba4/12/swap.js"></script>
    </cf_htmlfoot>
  </cfif>
  <!--- RECAPTCHA --->
  <cfinclude template="/components/recaptcha.cfm">

  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init()>
  <!-- Flip.to - Website Integration -->
  <cfif !cgi.script_name contains '/rentals'>
    <script async src="https://integration.flip.to/P6S4CND"></script>
  </cfif>
  <!-- Go to www.addthis.com/dashboard to customize your tools -->
  <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5a68e980a35e55da"></script>

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  <link href="/favicon.ico" rel="icon" type="image/x-icon">
</head>
<body <cfif isdefined('page.slug') and page.slug eq 'index'>class="homepage"</cfif>>
	<cfif isDefined('slug') and slug eq 'index'>
		<cfinclude template="/components/home-page-announcements.cfm">
	</cfif>
  <div class="wrapper">
    <div class="header">
      <div class="header-top">
        <div class="container">
          <a hreflang="en" href="/" class="mobile-logo">Surfside Realty</a>
          <cfif cgi.script_name does not contain "book-now.cfm">
            <a hreflang="en" href="javascript:;" id="mobileToggle">MENU</a>
          </cfif>
          <cfif cgi.script_name contains "book-now.cfm">
            <a hreflang="en" href="/" class="booking-logo"></a>
          <cfelse>
            <cfinclude template="/components/navigation.cfm">
          </cfif>
          <cfif cgi.script_name contains "book-now.cfm">
            <ul class="social"><li style="color:white"><h4> Call us at at 1-800-833-8231 for help.</h4></li></ul>
          <cfelse>
            <ul class="social">
              <li><a hreflang="en" href="https://www.facebook.com/SurfsideRealty" class="facebook" target="_blank"></a></li>
              <li><a hreflang="en" href="https://twitter.com/surfsiderealty" class="twitter" target="_blank"></a></li>
              <li><a hreflang="en" href="https://www.instagram.com/surfsiderealty/" class="instagram" target="_blank"></a></li>
              <!--- <li><a hreflang="en" href="https://plus.google.com/109811451216565628152" class="google" target="_blank"></a></li> --->
              <!--- <li><a hreflang="en" href="" class="pinterest" target="_blank"></a></li> --->
              <li><a hreflang="en" href="http://www.youtube.com/surfsiderealty" class="youtube" target="_blank"></a></li>
              <li class="phone-num"><span><a hreflang="en" href="tel:18008338231">1-800-833-8231</a><em>Call Us</em></span></li>
            </ul><!-- END social -->
          </cfif>
        </div>
      </div><!-- END header-top -->
      <cfinclude template="/components/header-banner.cfm">
      <!---
      <cfif (isdefined('page.slug') and page.slug eq 'sales') or (cgi.script_name contains 'mls' OR cgi.script_name contains 'sales')>
        <cfinclude template="/sales/components/login.cfm">
      </cfif>
       --->
      <cfquery name="getmlscoinfo" datasource="mlsmaster30">
        SELECT *
        FROM mlsfeeds
        where id = '2'
      </cfquery>
      <cfif (isdefined('page.slug') and page.slug eq 'sales') or (cgi.script_name contains 'mls' OR cgi.script_name contains 'sales')>
        <cfinclude template="/components/_quick-search-mls.cfm">
      <cfelseif (isdefined('page.slug') and page.slug eq 'propertymanagement') or cgi.script_name contains('rentals') or (isdefined('page.slug') and page.slug eq 'association-management')>
        <!--- No Quick Search --->
      <cfelse>
        <cfinclude template="/components/_quick-search.cfm">
      </cfif>
    </div><!-- END header -->
