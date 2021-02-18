<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
  <cfinclude template="/components/meta.cfm">
  <link rel="dns-prefetch" href="//cdnjs.cloudflare.com">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
  <link href="/stylesheets/styles.css?v=3" rel="stylesheet" type="text/css" media="screen, projection">
  <cf_htmlfoot>
  <link href="/admin/pages/contentbuilder/assets/minimalist-blocks/content.min.css" rel="stylesheet" type="text/css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.10/css/bootstrap-select.min.css" rel="stylesheet" type="text/css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  </cf_htmlfoot>
  <!--- THIS LOADS THE FONTS - DO NOT REMOVE --->
  <link rel="preconnect" href="https://fonts.googleapis.com/css" crossorigin>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/webfont/1.6.28/webfontloader.js"></script>
  <script>
    WebFont.load({
      google: {
        families: ['Open+Sans:300,400,400i,600,700&display=swap']
      }
    });
  </script>
  <cfif isdefined('page') and len(page.canonicalLink)>
    <cfoutput><link rel="canonical" href="#page.canonicalLink#"></cfoutput>
  </cfif>
	<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
  <!--- ANALYTICS --->
	<cfinclude template="/components/analytics.cfm">
  <!--- RECAPTCHA --->
	<cfinclude template="/components/recaptcha.cfm">
  <!--- RENDER BLOCKING - SO PLACING LAST IN HEAD --->
  <link href="/favicon.ico" rel="icon" type="image/x-icon">
  <cfinclude template = "/components/pixel-codes.cfm">
</head>
<body <cfif isdefined('page.bodyClass') and LEN(page.bodyClass)>class="<cfoutput>#page.bodyClass#</cfoutput>"</cfif>>
	<div class="i-wrapper">
		<div class="i-header">
			<div class="container">
  			<div class="i-header-logo-wrap">
    			<a href="/" class="i-header-logo"><cfoutput>#settings.company#</cfoutput></a>
  			</div>
  			<div class="i-header-info">
          <!-- RECENTLY VIEWED -->
          <div class="i-header-viewed i-header-actions text-white">
            <span class="header-action" id="recentlyViewedToggle">Recently Viewed <i class="fa fa-eye site-color-3" data-toggle="tooltip" data-placement="bottom" title="Recently Viewed"></i> <em class="header-recently-viewed-count"><cfif StructKeyExists(cookie,'recent') and ListLen(cookie.recent)><cfoutput>#listlen(cookie.recent)#</cfoutput><cfelse>0</cfif></em></span>
            <cfinclude template="/#settings.booking.dir#/_recentlist.cfm">
          </div>
          <!-- FAVORITES -->
          <div class="i-header-favorites i-header-actions text-white">
            <span class="header-action" id="favoritesToggle">Favorites <i class="fa fa-heart" data-toggle="tooltip" data-placement="bottom" title="Favorites"></i> <em class="header-favorites-count"><cfif StructKeyExists(cookie,'favorites') and ListLen(cookie.favorites)><cfoutput>#listlen(cookie.favorites)#</cfoutput><cfelse>0</cfif></em></span>
            <cfinclude template="/#settings.booking.dir#/_favoriteslist.cfm">
          </div>
          <!-- LOGIN/ACCOUNT -->
          <div class="i-header-login text-white">
            <cfif isdefined('cookie.GuestFocusLoggedInID')>
             <a target="_blank" href="/guest-focus/dashboard.cfm" class="text-white">
            	<cfquery name="getGuestLoyaltyUser" dataSource="#settings.dsn#">
    						select * from guest_focus_users where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#cookie.GuestFocusLoggedInID#">
    					</cfquery>
            	<cfoutput>#getGuestLoyaltyUser.firstname#</cfoutput>
            <cfelse>
             <a target="_blank" href="/guest-focus/" class="text-white">
            	Login
            </cfif>
              <i class="fa fa-user text-white" data-toggle="tooltip" data-placement="bottom" title="Create An Account"></i>
            </a>
          </div>

    			<div class="i-header-phone">
    			  <cfif len(settings.tollFree)>
    			    <cfoutput><a href="tel:#settings.tollFree#" class="text-white text-white-hover"><i class="fa fa-mobile"></i> #settings.tollFree#</a></cfoutput>
    			  </cfif>
    			  <cfif len(settings.phone)>
    			    <cfoutput><a href="tel:#settings.phone#" class="text-white text-white-hover"><i class="fa fa-mobile"></i> #settings.phone#</a></cfoutput>
    			  </cfif>
    			</div>
  			</div><!-- END i-header-info -->
			</div>
			<div class="i-header-navigation">
				<div class="container">
    			<a href="javascript:;" class="i-header-qs-scroller"><span class="text-white"><i class="fa fa-sliders"></i></span></a>
    			<a href="javascript:;" class="i-header-mobileToggle"><span class="site-color-1-bg text-white"><i class="fa fa-bars"></i></span></a>
					<cfinclude template="/components/navigation.cfm">
				</div>
			</div>
		</div><!-- END i-header -->
		<cfinclude template="/components/header-banner.cfm">