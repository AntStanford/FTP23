<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
  <cfinclude template="/components/meta.cfm">
  <cfoutput>
  <link rel="dns-prefetch" href="//cdnjs.cloudflare.com">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="/#settings.booking.dir#/stylesheets/styles.css?v=3.1" rel="stylesheet" type="text/css">
  <!--- <link href="/admin/pages/contentbuilder/assets/minimalist-blocks/content.min.css" rel="stylesheet" type="text/css"> --->
  <link href="/admin/pages/contentbuilder/assets/minimalist-basic/content-bootstrap-icnd.css" rel="stylesheet" type="text/css">

  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css" rel="stylesheet" type="text/css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css2?family=Lato&family=Risque&display=swap" rel="stylesheet">
  </cfoutput>

  <cf_htmlfoot>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" type="text/javascript" defer></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.4.1/jquery-migrate.min.js" type="text/javascript" defer></script>
  <script type="text/javascript" src="//maps.googleapis.com/maps/api/js?v=3&key=<cfoutput>#settings.googleMapsAPIKey#</cfoutput>"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OverlappingMarkerSpiderfier/1.0.3/oms.min.js" defer></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/js-marker-clusterer/1.0.0/markerclusterer_compiled.js" defer></script>
  </cf_htmlfoot>

  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
  <!--- ANALYTICS --->
	<cfinclude template="/components/analytics.cfm">
  <!--- RECAPTCHA --->
	<cfinclude template="recaptcha.cfm">

  <cfif cgi.script_name eq '/#settings.booking.dir#/property.cfm'>
  	<!-- Go to www.addthis.com/dashboard to customize your tools -->
  	<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5a6a23638591c1d8" async></script>
  </cfif>
</head>
<body<cfif cgi.script_name eq '/#settings.booking.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (StructKeyExists(request,'resortContent')) OR (isdefined('page') and page.isCustomSearchPage eq 'Yes') OR (cgi.script_name eq '/layouts/special.cfm')> class="results-body"</cfif>>
  <div class="wrapper">
    <div class="booking-header-wrap<cfif cgi.script_name eq '/#settings.booking.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (StructKeyExists(request,'resortContent')) OR (isdefined('page') and page.isCustomSearchPage eq 'Yes') OR (cgi.script_name eq '/layouts/special.cfm')> results-header-wrap<cfelseif cgi.script_name eq '/#settings.booking.dir#/book-now.cfm'> booknow-header-wrap</cfif>">
      <div class="header">
        <div class="header-logo">
          <a href="/"><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/logo-gulfrentals.png" alt="Gulf Shores &amp; Ft.Morgan  Alabama Vacation Rentals"></a>
        </div>

        <!--- BOOK NOW PAGE ONLY --->
        <cfif cgi.script_name eq '/#settings.booking.dir#/book-now.cfm'>
          <cfoutput>
            <div class="header-actions">
    					<cfif cgi.http_referer does not contain 'results.cfm'>
    						<!--- Only show the 'Back' button if the user came from the PDP --->
    						<cfoutput><a href="javascript:history.go(-1)" class="header-actions-action site-color-4-bg site-color-4-lighten-bg-hover text-black"><i class="fa fa-chevron-left"></i> Back</a></cfoutput>
    					</cfif>
    					<cfif len(settings.tollFree)>
          			<a class="header-actions-action" href="tel:#settings.tollFree#"> <i class="fa fa-phone"></i> <span>#settings.tollFree#</span></a>
          		</cfif>
            </div>
          </cfoutput>
        <cfelse>

          <!--- OTHER BOOKING PAGES --->
          <div class="header-nav">
            <a href="javascript:;" class="header-mobileToggle"><span><i class="fa fa-bars"></i></span><span class="hidden">header-mobileToggle</span></a>
            <!---<cfinclude template="/components/navigation.cfm">--->
            <cfoutput>#session.wpNav#</cfoutput>
          </div>
          <!-- END header-nav -->

          <div class="header-actions">
            <!-- RECENTLY VIEWED -->
            <a href="javascript:;" class="header-actions-action site-color-1-lighten-bg-hover" id="recentlyViewedToggle">
              <div rel="tooltip" data-placement="bottom" title="Properties you have Recently Viewed">
                <small>Recently Viewed</small>
                <i class="fa fa-eye"></i>
                <span><em class="header-recently-viewed-count"><cfif StructKeyExists(cookie,'recent') and ListLen(cookie.recent)><cfoutput>#listlen(cookie.recent)#</cfoutput><cfelse>0</cfif></em></span>
              </div>
            </a>
            <cfinclude template="/#settings.booking.dir#/_recentlist.cfm">

            <!-- FAVORITES -->
            <a href="javascript:;" class="header-actions-action site-color-1-lighten-bg-hover" id="favoritesToggle">
              <div rel="tooltip" data-placement="bottom" title="Your Favorited Properties">
                <small>Favorites</small>
                <i class="fa fa-heart"></i>
                <span><em class="header-favorites-count"><cfif StructKeyExists(cookie,'favorites') and ListLen(cookie.favorites)><cfoutput>#listlen(cookie.favorites)#</cfoutput><cfelse>0</cfif></em></span>
              </div>
            </a>
            <cfinclude template="/#settings.booking.dir#/_favoriteslist.cfm">

            <!-- LOGIN/ACCOUNT -->
            <!---
            <cfif isdefined('cookie.GuestFocusLoggedInID')>
              <a target="_blank" href="/guest-focus/dashboard.cfm" class="header-actions-action header-action-create-account site-color-1-lighten-bg-hover">
                <div rel="tooltip" data-placement="bottom" title="View My Account">
                	<cfquery name="getGuestLoyaltyUser" dataSource="#settings.dsn#">
        						select * from guest_focus_users where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#cookie.GuestFocusLoggedInID#">
        					</cfquery>
                	<small><cfoutput>#getGuestLoyaltyUser.firstname#</cfoutput></small>
            <cfelse>
              <a target="_blank" href="/guest-focus/" class="header-actions-action header-action-create-account site-color-1-lighten-bg-hover">
              	<div rel="tooltip" data-placement="bottom" title="Login / Create An Account">
                	<small>Login</small>
            </cfif>
                <i class="fa fa-user"></i>
              </div>
            </a>
          --->
            <!-- PHONE NUMBER -->
            <a href="tel:<cfoutput>#settings.tollFree#</cfoutput>" class="header-actions-action header-action-phone">
              <i class="fa fa-mobile"></i>
              <small><cfoutput>#settings.tollFree#</cfoutput></small>
            </a>
          </div><!-- END header-actions -->
        </cfif>

      </div><!-- END header -->
    </div><!-- END booking-header-wrap -->