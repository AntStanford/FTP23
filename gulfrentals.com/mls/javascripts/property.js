// MASTER VARIABLE FOR MLS DIRECTORY
var mlsFolder = '/mls';

//   ****     ****    ****  **  **   ***  ***   ******  **   **  ******       *****   ******   ****   ****    **  **
//   **  **  **  **  **     **  **  ** **** **  **      ***  **    **         **  **  **      **  **  **  **  **  **
//   **  **  **  **  **     **  **  **  **  **  *****   ** ** *    **         ** **   *****   ******  **  **   ****
//   **  **  **  **  **     **  **  **  **  **  **      **  ***    **         *** *   **      **  **  **  **    **
//   ****     ****    ****   ****   **      **  ******  **   **    **         **  **  ******  **  **  ****      **
$(document).ready(function(){
////////////////////////////////////////
///////////   LEFT COLUMN   ////////////
////////////////////////////////////////

  // PROPERTY BANNER CONTAINER VARIABLES
  var pdpBanner = $('#propertyImage');
  var pdpMap = $('#propertyMap');
  var pdp3DTour = $('#property3DTour');
  var pdpVideoTour = $('#propertyVideoTour');

  // PROPERTY IMAGE
  if ($('#propertyImage').length) {
    $('#propertyImage > img').delay(500).fadeIn(800);

    // LOAD GALLERY IF PROPERTY IMAGE IS CLICKED - IF CHANGED, UPDATE THE CLICK EVENT FOR GALLERY BUTTON BELOW
    $('#propertyImage > img').on('click', function() {
      pdpGallery.eq(0).click();// STARTING AT 0 - CORRELATES TO NUMBER OF IMAGE IN GALLERY TO LOAD
    });
  }

  // PROPERTY GALLERY LOAD
  if ($('.hidden-gallery').length) {
    var pdpGallery = $('#hiddenGallery').find('a');

    // LOAD GALLERY IF BUTTON IS CLICKED - IF CHANGED, UPDATE THE CLICK EVENT FOR PROPERTY IMAGE ABOVE
    $('#propertyGalleryBtn').on('click', function() {
      pdpGallery.eq(0).click();// STARTING AT 0 - CORRELATES TO NUMBER OF IMAGE IN GALLERY TO LOAD
    });
  }

  // PROPERTY MAP LOAD
  if ($('#propertyMapBtn').length) {
    $('#propertyMapBtn').on('click', function(){
      // ADD ACTIVE CLASS TO MAP CONTAINER - ACTIVE CLASS ADDS HIGHER Z-INDEX - ADJUST IN STYLESHEET
      pdpMap.toggleClass('active');
      pdp3DTour.removeClass('active');
      pdpVideoTour.removeClass('active');

      // BUTTON TEXT SWITCH - PROPERTY MAP BUTTON
      var $this = $(this).toggleClass('inactive');
      $(this).toggleClass('active');
      if($(this).hasClass('inactive')){
        $(this).html('<i class="fa fa-map-marker"></i> <span>View Map</span>');
      } else {
        $(this).html('<i class="fa fa-close"></i> <span>Hide Map</span>');

        // PAUSE THE 3D VIDEO TOUR IF PROPERTY MAP BUTTON IS CLICKED
        $('#property3DTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');

        // PAUSE THE VIDEO TOUR IF PROPERTY MAP BUTTON IS CLICKED
        $('#propertyVideoTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
      }

      // IF SIBLING BUTTON IS ACTIVE, RETURN TO NORMAL STATE - PROPERTY TOUR BUTTON
      if($('#property3DTourBtn').hasClass('active')){
        $('#property3DTourBtn').removeClass('active').addClass('inactive').html('<i class="fa fa-video-camera"></i> <span>View 3D Tour</span>');
      }
      // IF SIBLING BUTTON IS ACTIVE, RETURN TO NORMAL STATE - PROPERTY TOUR BUTTON
      if($('#propertyVideoTourBtn').hasClass('active')){
        $('#propertyVideoTourBtn').removeClass('active').addClass('inactive').html('<i class="fa fa-video-camera"></i> <span>View Video Tour</span>');
      }
    });
  }

  // PROPERTY TOUR LOAD
  if ($('#property3DTourBtn').length) {
    $('#property3DTourBtn').on('click', function(){
      // ADD ACTIVE CLASS TO TOUR CONTAINER - ACTIVE CLASS ADDS HIGHER Z-INDEX - ADJUST IN STYLESHEET
      pdp3DTour.toggleClass('active');
      pdpVideoTour.removeClass('active');
      pdpMap.removeClass('active');

      // BUTTON TEXT SWITCH - PROPERTY TOUR BUTTON
      var $this = $(this).toggleClass('inactive');
      $(this).toggleClass('active');
      if($(this).hasClass('inactive')){
        $(this).html('<i class="fa fa-video-camera"></i> <span>View 3D Tour</span>');

        // PAUSE THE VIDEO IF CLASS IS REMOVED
        $('#property3DTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
      } else {
        $(this).html('<i class="fa fa-close"></i> <span>Hide 3D Tour</span>');

        // PLAY THE VIDEO IF CLASS IS ADDED
        $('#property3DTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
      }

      // IF SIBLING BUTTON IS ACTIVE, RETURN TO NORMAL STATE - PROPERTY MAP BUTTON
      if($('#propertyMapBtn').hasClass('active')){
        $('#propertyMapBtn').removeClass('active').addClass('inactive').html('<i class="fa fa-map-marker"></i> <span>View Map</span>');
      }
      // IF SIBLING BUTTON IS ACTIVE, RETURN TO NORMAL STATE - PROPERTY TOUR BUTTON
      if($('#propertyVideoTourBtn').hasClass('active')){
        $('#propertyVideoTourBtn').removeClass('active').addClass('inactive').html('<i class="fa fa-video-camera"></i> <span>View Video Tour</span>');
      }

      // PAUSE THE VIDEO IF CLASS IS REMOVED
      $('#propertyVideoTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');

    });
  }

  // PROPERTY TOUR LOAD
  if ($('#propertyVideoTourBtn').length) {
    $('#propertyVideoTourBtn').on('click', function(){
      // ADD ACTIVE CLASS TO TOUR CONTAINER - ACTIVE CLASS ADDS HIGHER Z-INDEX - ADJUST IN STYLESHEET
      pdpVideoTour.toggleClass('active');
      pdp3DTour.removeClass('active');
      pdpMap.removeClass('active');

      // BUTTON TEXT SWITCH - PROPERTY TOUR BUTTON
      var $this = $(this).toggleClass('inactive');
      $(this).toggleClass('active');
      if($(this).hasClass('inactive')){
        $(this).html('<i class="fa fa-video-camera"></i> <span>View Video Tour</span>');

        // PAUSE THE VIDEO IF CLASS IS REMOVED
        $('#propertyVideoTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
      } else {
        $(this).html('<i class="fa fa-close"></i> <span>Hide Video Tour</span>');

        // PLAY THE VIDEO IF CLASS IS ADDED
        $('#propertyVideoTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
      }

      // IF SIBLING BUTTON IS ACTIVE, RETURN TO NORMAL STATE - PROPERTY MAP BUTTON
      if($('#propertyMapBtn').hasClass('active')){
        $('#propertyMapBtn').removeClass('active').addClass('inactive').html('<i class="fa fa-map-marker"></i> <span>View Map</span>');
      }
      // IF SIBLING BUTTON IS ACTIVE, RETURN TO NORMAL STATE - PROPERTY TOUR BUTTON
      if($('#property3DTourBtn').hasClass('active')){
        $('#property3DTourBtn').removeClass('active').addClass('inactive').html('<i class="fa fa-video-camera"></i> <span>View 3D Tour</span>');
      }

      // PAUSE THE VIDEO IF CLASS IS REMOVED
      $('#property3DTour iframe')[0].contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
    });
  }


  // STICKY FUNCTION - FIXED TABS
  function stickyTabs() {
    var window_top = $(window).scrollTop();
    var tab_anchor = $('#propertyTabsAnchor').offset().top;
    if (window_top > tab_anchor) {
      $('#propertyTabs').addClass('fixed');
      $('#propertyTabsAnchor').height($('#propertyTabs').outerHeight());
      $('#returnToTop').fadeIn(250);
    } else {
      $('#propertyTabs').removeClass('fixed');
      $('#propertyTabsAnchor').height(0);
      $('#returnToTop').fadeOut(250);
    }
  }

  $(function() {
    $(window).scroll(stickyTabs);
    stickyTabs();
  });

  // VARIABLES FOR FIXED TABS
  var sections = $('.info-wrap');
  var tabs = $('#propertyTabs');
  var tabs_height = tabs.outerHeight();

  // CLICK TAB - SMOOTH SCROLL INSTEAD OF HARD JUMP
  tabs.find('a').on('click', function() {
    var $tab = $(this);
    var id = $tab.attr('href');

    $('html, body').animate({
      scrollTop: $(id).offset().top - tabs_height + 2
    }, 800);

    return false;
  });

  // FIND EACH SECTION on SCROLL or CLICK for JUMP LINKS
  $(window).on('scroll', function() {
    var cur_pos = $(this).scrollTop();

    sections.each(function() {
      var tab_top = $(this).offset().top - tabs_height;
      var tab_bottom = tab_top + $(this).outerHeight();
      // ADD/REMOVE ACTIVE CLASS ON TABS
      if (cur_pos >= tab_top && cur_pos <= tab_bottom) {
        tabs.find('a').removeClass('active');
        sections.removeClass('active');
        $(this).addClass('active');
        tabs.find('a[href="#'+$(this).attr('id')+'"]').addClass('active');

      // ADD/REMOVE ACTIVE CLASS ON LAST TAB ITEM - WHEN LAST TAB HAS REACHED BOTTOM
      } else if ($(window).scrollTop() + $(window).height() == $(document).height()) {
        tabs.find('a').removeClass('active');
        sections.removeClass('active');
        $(this).addClass('active');
        tabs.find('a[href="#'+$(this).attr('id')+'"]').addClass('active');
      }
    });
  });


////////////  FORM VALIDATION   ////////////
  if ($('#sendToFriendForm').length) {

  		$('form#sendToFriendForm').validate({
			submitHandler: function(form){
				$.ajax({
					type: "POST",
					url: mlsFolder + "/_submit.cfm",
					data: $('form#sendToFriendForm').serialize(),
					dataType: "text",
					success: function (response) {
						response = $.trim(response);
						console.log(response);
						if(response === "success") {
							$('form#sendToFriendForm').hide();
							$('#sendToFriendFormMSG').html("<font color='green'>Thanks! Your email has been sent!</font>");
						}
						else {
							$("form#sendToFriendForm div.g-recaptcha-error").html("<font color='red'>You must complete the reCAPTCHA</font>");
						}
					}
				});
				return false;
			}
		});

	}

	// VALIDATES AND SUBMITS THE 'Ask A Question' FORM ON THE PROPERTY DETAIL PAGE
  if ($('#propertyQandAForm').length) {

  	$('form#propertyQandAForm').validate({
  		submitHandler: function(form){
  			$.ajax({
  				type: "POST",
					url: mlsFolder + "/_submit.cfm",
  				data: $('form#propertyQandAForm').serialize(),
  				dataType: "text",
  				success: function (response) {
  					response = $.trim(response);
  					console.log(response);
  					if(response === "success") {
  						$('form#propertyQandAForm').hide();
  						$('#propertyQandAFormMSG').html('Thanks! Your email has been sent! Close this window to continue browsing the website.');
  					}
  					else {
  						$("form#propertyQandAForm div.g-recaptcha-error").html("<font color='red'>You must complete the reCAPTCHA</font>");
  					}
  				}
  			});
  			return false;
  		}
  	});

  }

  // VALIDATES AND SUBMITS THE 'Contact' FORM ON THE PROPERTY DETAIL PAGE
  if ($('#propertyContactForm').length) {

	  $('form#propertyContactForm').validate({
			submitHandler: function(form){
				$.ajax({
					type: "POST",
					url: mlsFolder + "/_submit.cfm",
					data: $('form#propertyContactForm').serialize(),
					dataType: "text",
					success: function (response) {
						response = $.trim(response);
						console.log(response);
						if(response === "success") {
							$('form#propertyContactForm').hide();
							$('#propertyContactFormMSG').html("<font color='green'>Thanks! Your email has been sent!</font>");
						}
						else {
							$("form#propertyContactForm div.g-recaptcha-error").html("<font color='red'>You must complete the reCAPTCHA</font>");
						}
					}
				});
				return false;
			}
		});

  }


/////////////////////////////////////////
////////////  RIGHT COLUMN   ////////////
/////////////////////////////////////////

  // STICKY FUNCTION - FIXED PROPERTY SIDEBAR
  function sticky_sidebar() {
    var window_top = $(window).scrollTop();
    var sticky_anchor = $('#propertySidebarAnchor').offset().top;
    var sticky = $('#propertySidebar');
    if (window_top > sticky_anchor) {
      $('#propertySidebar').addClass('fixed');
      // USE THIS IF HEIGHT IS NOT DEFINED - FLASHES IS NOT
      $('#propertySidebarAnchor').height($('#propertySidebar').outerHeight());
    } else {
      $('#propertySidebar').removeClass('fixed');
      // USE THIS IF HEIGHT IS NOT DEFINED - FLASHES IS NOT
      $('#propertySidebarAnchor').height(0);
    }
  }
  $(function() {
    $(window).scroll(sticky_sidebar);
    sticky_sidebar();
  });

  // SIDEBAR SECTION
  ///////////////////////

  // BUTTON TRIGGER FOR SMOOTH SCROLL TO INQURE FORM
  $('#requestInfoBtn').on('click', function(){
    // SCROLL TO SECTION, SUBTRACT HEIGHT FOR HEADING FOR ALIGNMENT
  	$('html, body').animate({scrollTop: $('#inquire').offset().top - 45},1600);
  	return false;
  });

  // MOBILE TOGGLE - LOAD SIDEBAR POP-UP WINDOW
  if ($('#propertySidebar').length) {
    $('#mobileSidebarToggle').on('click', function() {
      $('body').addClass('no-scroll sidebar-active')
      $('#propertySidebar').fadeToggle().addClass('active');
    });
    $('#mobileClose').on('click', function() {
      $('body').removeClass('no-scroll sidebar-active')
      $('#propertySidebar').fadeToggle().removeClass('active');
    });
  }

  $(window).on('resize',function(){
  	if( $(window).width() < 1024) {
      $('.property-sidebar-wrap').insertAfter('.property-agent-comments');
    } else if ( $(window).width() > 1025) {
      $('.property-sidebar-wrap').insertAfter('.property-details-wrap');
    }
  });

  // CLICK EVENT TO SCROLL UP - FADE FUNCTION WITH STICKY TABS FUNCTION
  $('#returnToTop').on('click', function(){
  	$('html, body').animate({scrollTop : 0},800);
  	return false;
  });

});