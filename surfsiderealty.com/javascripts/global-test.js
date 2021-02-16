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

  //Owl Carousel
  if ($('.owl-carousel').length) {
    $.getScript('/javascripts/owl-carousel/owl.carousel.min.js',function(){
      $('head')
        .append($('<link rel="stylesheet" type="text/css" />').attr('href','/javascripts/owl-carousel/assets/owl.carousel.min.css'))
        .append($('<link rel="stylesheet" type="text/css" />').attr('href','/javascripts/owl-carousel/assets/owl.theme.default.min.css'));
      //HP Banner Rotation (hero)
      if ($('.owl-carousel.hp').length) {
        $('.owl-carousel.hp').owlCarousel({
          items: 1, autoplay: true, autoplayTimeout: 5000, smartSpeed: 1000, lazyLoad: true, loop: true
        });
      }
      //Featured Slider
      if ($('.owl-carousel.i-featured-slider').length) {
        $('.owl-carousel.i-featured-slider').owlCarousel({
          lazyLoad: true, loop: true, nav: true, navText: [], margin: 15,
          responsive: { 0: { items: 1 }, 481: { items: 2 }, 993: { items: 3 } }
        });
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
      beforeShowDay: function (date) {
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