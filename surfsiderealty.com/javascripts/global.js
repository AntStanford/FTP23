$(document).ready(function(){

  //Mobile Move Fixed Navigation Bar to Top Most for z-index reasons
  $(window).on('resize',function(){
    if ($(window).width() <= 992) {
      $('.i-header-navigation').prependTo('body');
    } else {
      $('.i-header-navigation').appendTo('.i-header');
    }
  }).resize();

  //Open and Close Mobile Menu
  $('.i-header-mobileToggle').click(function(){
    $(this).find('.fa').toggleClass('fa-bars').toggleClass('fa-times');
    $('.i-wrapper').toggleClass('open');
    $(this).next().toggleClass('open');
  });

  //Selectpicker
  if ($('.selectpicker').length) {
    $.getScript('/bootstrap/js/bootstrap-select.min.js',function(){
      $('head').append($('<link rel="stylesheet" type="text/css" />').attr('href','/bootstrap/css/bootstrap-select.min.css'));
      $('.selectpicker').selectpicker();
    });
  }

  // LAZY LOAD
  if ($('.lazy').length) {
    $('.lazy').lazy({
      effect: 'fadeIn',
      effectTime: 1000,
      threshold: 0,
      afterLoad: function(element) {
        var lazyElement = element.get(0);
        // Add a Class to set the placeholder background to transparent
        $(lazyElement).addClass('loaded');
      }
    });
  }

  //Owl Carousel
  if ($('.owl-carousel').length) {
    $.getScript('/javascripts/owl-carousel/owl.carousel.min.js',function(){
      $('head')
        .append($('<link rel="stylesheet" type="text/css" />').attr('href','/javascripts/owl-carousel/assets/owl.carousel.min.css'))
        .append($('<link rel="stylesheet" type="text/css" />').attr('href','/javascripts/owl-carousel/assets/owl.theme.default.min.css'));
      //HP Banner Rotation (hero)
      if ($('.owl-carousel.hp').length) {
        $('.owl-carousel.hp').owlCarousel({
          items: 1, autoplay: true, autoplayTimeout: 5000, smartSpeed: 1000, lazyLoad: true, loop: true,
          onInitialized: removePlaceholder
        });
        function removePlaceholder() {
          $('.i-header-carousel-wrap').removeClass('placeholder');
        }
      }
      // FEATURED PROPERTIES SLIDER
      if ($('.owl-carousel.featured-props-carousel').length) {
        $('.owl-carousel.featured-props-carousel').owlCarousel({
          responsive: {0:{items: 1, dots: false}, 481:{items: 2, dots: false}, 768:{items: 3, dots: false}, 1014:{items: 3, dots: false}, 1200:{items: 4, dots: true}, 1700:{items: 5, dots: true}}, margin: 10, autoplay: false, smartSpeed: 1000, lazyLoad: true, loop: false, nav: true, navText: ["<img src='/images/layout/arrow-left-sm.png' alt='Chevron Left'>","<img src='/images/layout/arrow-right-sm.png' alt='Chevron Right'>"],
          onInitialized: removePlaceholder
        });
        function removePlaceholder() {
          // LOADER FOR CAROUSEL
          $('.cssload-container').addClass('hidden');
          $('.featured-props .featured-container').removeClass('placeholder');
        }
      }
      //Featured Slider
      if ($('.owl-carousel.i-featured-slider').length) {
        $('.owl-carousel.i-featured-slider').owlCarousel({
          lazyLoad: true, loop: true, nav: true, navText: [], margin: 15,
          responsive: { 0: { items: 1 }, 481: { items: 2 }, 993: { items: 3 } },
          onInitialized: removePlaceholder
        });
        function removePlaceholder() {
          // LOADER FOR CAROUSEL
          $('.cssload-container').addClass('hidden');
          $('.i-featured .featured-container').removeClass('placeholder');
        }
      }
      //Long Term Rentals
      if ($('.owl-carousel.long-term-carousel').length) {
        $('.owl-carousel.long-term-carousel').owlCarousel({
          items: 1, autoplay: true, autoplayTimeout: 5000, smartSpeed: 1000, lazyLoad: true, loop: true,
          onInitialized: removePlaceholder
        });
        function removePlaceholder() {
          $('.long-term-gallery-wrap .gallery-container').removeClass('placeholder');
        }
      }
      //Owl Gallery
      if ($('.owl-gallery').length) {
        $.getScript('/javascripts/owl-gallery.js');
      }
    });
  }

  //Quick Search and /rentals/search
  if ($('#start-date').length) {
    $("#start-date").datepicker({
      minDate: '+1d',
      beforeShowDay: function(date) {
        var day = date.getDay();
        return [day == 6, ''];
      },
      onSelect: function( selectedDate ) {
        var newDate = $(this).datepicker('getDate');
        newDate.setDate(newDate.getDate()+7);
        $('#end-date').datepicker('setDate',newDate);
        $('#end-date').datepicker('option','minDate',selectedDate);
        setTimeout(function(){
          $( "#end-date" ).datepicker('show');
        }, 16);
      }
    });
  }
  if ($('#end-date').length) {
    $("#end-date").datepicker({
      minDate: '+1d',
      beforeShowDay: function (date) {
        var day = date.getDay();
        return [day == 6, ''];
      }
    });
  }

  //Fancybox
  if ($('.fancybox').length) {
    $.getScript('/javascripts/fancybox/jquery.fancybox.min.js',function(){
      $('head').append($('<link rel="stylesheet" type="text/css" />').attr('href','/javascripts/fancybox/jquery.fancybox.min.css'));
      $('.fancybox').fancybox();
    });
  }


  //Form Validation - Add class="validate" to your <form>
  if ($('.validate').length) {
    $('.validate').validate();
  }

  //Tooltips
  if ($('[data-toggle="tooltip"]').length) {
    $('[data-toggle="tooltip"]').tooltip();
  }

});