<cfif isdefined('cookie.LoggedInAdminID') is "No" and isdefined('cookie.LoggedInAgentID') is "No">

  <cfif isdefined('url.emailreplay') and isdefined('url.id')>
    <cflocation url="/admin/login.cfm?msgreply=#url.id#" addtoken="No">
  <cfelse>
    <cflocation url="/admin/login.cfm" addtoken="No">
  </cfif>

<cfabort>
</cfif>


<!doctype html>
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if IE 9]>    <html class="no-js ie9" lang="en"> <![endif]-->
<!--[if gt IE 9]><!-->
<html class="no-js" lang="en" itemscope itemtype="http://schema.org/Product">
<!--<![endif]-->
<cfparam name="thisPageTitle" default="LeadTracker">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<title><cfoutput>#thisPageTitle#</cfoutput></title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1">

	<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
	<link href="css/base.css?v=1.3" rel="stylesheet">
	<link href="css/custom.css?v=1.11" rel="stylesheet">
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->

	<!-- START: for drip-campaign-lead -->
		<script src="js/validate-campaign-form.js?v=2.5" type="text/javascript" charset="utf-8"></script>
    <script src="js/validate-campaign-plan-form.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/drip-campaign-controls.js?v=2.1" type="text/javascript" charset="utf-8"></script>
	<!-- END: for drip-campaign-lead -->

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

<!--- Fancybox --->
<link rel="stylesheet" type="text/css" href="/mls/javascripts/_plugins/fancybox2/source/jquery.fancybox.css?v=2.3.3" media="screen" />
<script type="text/javascript" src="/mls/javascripts/_plugins/fancybox2/source/jquery.fancybox.js?v=2.1.4"></script>
<!--- 
<link rel="stylesheet" type="text/css" href="js/fancybox.js" media="screen" />
 --->
<script type="text/javascript" src="/admin/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/admin/ckeditor/ckfinder/ckfinder.js"></script>

<script type="text/javascript" src="js/jquery.slug.js"></script> 

<cfoutput>
  <script type="text/javascript">
	$(document).ready(function() {
		$(".fancybox").fancybox();

      $(".tooltip").fancybox({
          'autoSize': false,
          'autoDimensions': false,
          'width': 350,
          'height': 510,
          'fitToView': false,
          'transitionIn'    : 'none',
          'transitionOut'   : 'none',
          'showCloseButton'   : true,
          'overlayOpacity': 0.4,
          'type'        : 'iframe'
         });
      
        $(".fb_dynamic").fancybox({
        'autoScale'       : true,
        'autoSize' : true,
        'width': 350,
        'showCloseButton'   : true,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'type'        : 'iframe',
        'overlayOpacity': 0.4,
        'scrolling'   : 'no'
         });

      $(".fb_activity").fancybox({
      	'fitToView'   : false,
        'autoSize' : false,
        'autoScale': false,
         'width': 350,
         'height': 400,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'showCloseButton'   : true,
        'overlayOpacity': 0.4,
        'type'        : 'iframe',
        'scrolling'   : 'auto'
         });

       $(".fb_savedsearch").fancybox({
        'fitToView'   : false,
        'autoSize' : false,
        'autoScale': false,
         'width': 800,
         'height': 600,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'showCloseButton'   : true,
        'overlayOpacity': 0.4,
        'type'        : 'iframe',
        'scrolling'   : 'auto',
                'afterClose': function() {location.reload();return;}

         });

      $(".fb_listing").fancybox({
        'fitToView'   : false,
        'autoSize' : false,
        'autoScale': false,
         'width': 350,
         'height': 475,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'showCloseButton'   : true,
        'overlayOpacity': 0.4,
        'type'        : 'iframe',
        'scrolling'   : 'auto'
         });

      $(".fb_phoneadd").fancybox({
        'fitToView'   : false,
        'autoSize' : false,
        'autoScale': false,
         'width': 350,
         'height': 510,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'showCloseButton'   : true,
        'overlayOpacity': 0.4,
        'type'        : 'iframe',
        'scrolling'   : 'auto'
         });

      $(".fb_listing-add").fancybox({
        'fitToView'   : false,
        'autoSize' : false,
        'autoScale': false,
         'width': 350,
         'height': 475,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'showCloseButton'   : true,
        'overlayOpacity': 0.4,
        'type'        : 'iframe',
        'scrolling'   : 'auto',
    afterClose : function() {
        window.location = 'contact-details.cfm?action=Edit<cfif isdefined('url.id')>&id=#url.id#</cfif><cfif isdefined('url.id') and isdefined('url.display')>&display=#url.display#</cfif>##LOC';
        return;
            }
         });

      $(".fb_add-reload").fancybox({
        'fitToView'   : false,
        'autoSize' : false,
        'autoScale': false,
         'width': 350,
         'height': 475,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'showCloseButton'   : true,
        'overlayOpacity': 0.4,
        'type'        : 'iframe',
        'scrolling'   : 'auto',
        'afterClose': function() {location.reload();return;}
         });

    });
  </script>
  </cfoutput>

  <style type="text/css">
    .fancybox-custom .fancybox-skin {
      box-shadow: 0 0 50px #222;
    }
  </style>


<script type="text/javascript" src="/admin/tinymce/tinymce.min.js"></script>
  <script type="text/javascript">
   tinymce.init({
       selector: "#editor1,#editor2",
       menubar: false,
       toolbar: "filemanager undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | table | code",
       plugins: "filemanager link table code",
       height: 400,
       width: 800
    });
  </script>
  
</head>


<body 
	<cfif cgi.script_name contains 'contact-details.cfm'>
		class="contact-detail"
	<cfelseif cgi.script_name contains 'dashboard.cfm' or  cgi.script_name contains 'drip-campaigns.cfm' >
		class="leadtracker"
	</cfif>
	>