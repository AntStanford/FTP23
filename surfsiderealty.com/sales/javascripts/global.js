$(document).ready(function(){

  //Toggles Mobile .navigation
  $('#mobileToggle').click(function(event){
    $('body').toggleClass('menu-active');
    $(this).next().slideToggle(200);
    event.stopPropagation();
  });

  if( $(window).width() <= 992) {
    $('body').click(function(){
      $('.header-nav').slideUp(200);
    });
    $('.header-nav li:has(ul)').append("<span class='dropnav arrow-down'></span>");
    $('.header-nav li .dropnav').click(function(event) {
      $(this).toggleClass('arrow-up');
      $(this).prev().slideToggle(200);
      event.stopPropagation();
    });
  }
  //Add Class to subnav
  $('.header-nav li:has(ul)').addClass('sub');

	$(".chosen-select").chosen({disable_search_threshold: 100});

  //MLS Actions

    //Toggle Favorites
  	// $('a.toggle-favorite, a.toggle-search-alert').on('click', function(e) {
  	// 	toggleButtonAction(this, e);
  	// });

    //Mortgage Calculator Slider - Property-details.cfm
    $('#mortgage').click(function(){
      $('#mortgage-output').slideToggle(200);
    });

  //Search Results Map View - Width
  $('#map_canvas').css({'width':'100%'});

  //Plugin Calls

  	//Chosen Plugin

  	  //Activates all Select boxes in MLS to be Chosen
      $('#mls-wrapper select').chosen();

    	//Show or Hide Specific Data
    	$('select#wsid').chosen().change( function() {
    		var wsid = $(this).chosen().val();
    		$(this).closest('form').find('[data-wsid]').each( function(i, el) {
    			$this = $(el);
    			if ( $this.attr('data-wsid') == wsid )
    				$this.parent().show();
    			else
    				$this.parent().hide();
    		});
    	});


      //Property Detail Page - Hides all but first
      $('.property-images-slideshowX a').hide();
      $('.property-images-slideshowX a:first').show();



  //Scroll to fixed number in header
  if( $(window).width() <= 480) {
    $(window).scroll(function() {
      var height = $(window).scrollTop();
      if(height > 300) {
        $('.phone-num').addClass('fixed');
      } else {
        $('.phone-num').removeClass('fixed');
      }
    });
  } else {
    $(window).scroll(function() {
      var height = $(window).scrollTop();
      if(height > 50) {
        $('.phone-num').addClass('fixed');
      } else {
        $('.phone-num').removeClass('fixed');
      }
    });
  }

});

//Toggle Function
function toggleButtonAction( el, event ) {
	var $this = $(el);
	$.ajax({
		url: $this.attr('href'),
		success: function(data) {
			data = jQuery.parseJSON(data);
			if (data.hasOwnProperty('SUCCESS')) {
				$this.toggleClass('enabled');
				$this.text(data['LABEL']);
			} else if (data.hasOwnProperty('REDIRECT'))
				window.location = data['REDIRECT'];
			else
				alert(data['ERROR']);
		}
	});
	event.preventDefault();
}