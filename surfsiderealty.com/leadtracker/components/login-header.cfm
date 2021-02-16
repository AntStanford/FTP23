<!DOCTYPE html>
<html lang="en">
<head>
	<title>Lead Tracker</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!---<link href="/admin/stylesheets/template.css?v=2" rel="stylesheet" type="text/css">
    <link href="/admin/stylesheets/datepicker.css" rel="stylesheet" type="text/css">--->
    <link href="/leadtracker/stylesheets/template.css?v=2" rel="stylesheet" type="text/css">
    <!---<link href="/leadtracker/stylesheets/datepicker.css" rel="stylesheet" type="text/css">--->
    <link href="/admin/bootstrap/css/datepicker.css" rel="stylesheet" type="text/css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js" type="text/javascript" charset="utf-8"></script>
    <!---<script src="/admin/javascripts/global.js" type="text/javascript" charset="utf-8"></script>--->
    <script src="/leadtracker/javascripts/global.js" type="text/javascript" charset="utf-8"></script>
    <!---<script type="text/javascript" src="/admin/ckeditor/ckeditor.js"></script>--->
    <script type="text/javascript" src="/admin/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="/leadtracker/javascripts/CalendarPopup.js"></SCRIPT>

	<script src="/admin/bootstrap/js/bootstrap-datepicker.js"></script>
    
	<!---FANCY BODY SCRIPTS AND CSS--->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<!---<script type="text/javascript" src="/mls/javascripts/jquery.fancybox-1.3.4.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="/mls/stylesheets/jquery.fancybox-1.3.4.css" media="screen" />
	<script type="text/javascript" src="/mls/javascripts/fancybox-global.js"></script>--->

  	<script type="text/javascript" src="/mls/javascripts/_plugins/fancybox2/source/jquery.fancybox.js?v=2.1.3"></script>
  	<link rel="stylesheet" type="text/css" href="/mls/javascripts/_plugins/fancybox2/source/jquery.fancybox.css?v=2.1.2" media="screen" />

	<script type="text/javascript">
    $(document).ready(function() {
      $('.fancybox').fancybox();

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
			'scrolling'   : 'no',
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
			'scrolling'   : 'auto',

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
			'scrolling'   : 'auto',

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

<script language="javascript">
<!--
function NoteConfirm() {

	var answer = confirm ("Are you sure you want to delete this entry?");
	if (answer){
		
		return true;
		
	}else{
		return false;

	}
}
function ArchiveConfirm() {

	var answer = confirm ("Are you sure you want to archive this reminder?");
	if (answer){
		
		return true;
		
	}else{
		return false;

	}
}
// -->
</script>



</head>

<body>
