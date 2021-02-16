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
        'scrolling'   : 'auto',

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
        window.location = 'contacts2.cfm?action=Edit&id=12398&display=history#LOC';
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
