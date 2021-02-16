    $(document).ready(function() {
      $('.fancybox').fancybox();
     
         $(".fb2_login").fancybox({
        'width'       : 725,
        'height'      : 450,
        'autoScale'       : false,
        'showCloseButton'   : false,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'type'        : 'iframe',
        'scrolling'   : 'no',
        'afterClose'    : function() {location.reload();return;}
         });


      $(".fb_dynamic").fancybox({
        'width'       : 650,
        'height'      : 484,
        'autoScale'       : false,
        'showCloseButton'   : false,
        'transitionIn'    : 'none',
        'transitionOut'   : 'none',
        'scrolling'   : 'no',
        'type'        : 'iframe'
         });
    });