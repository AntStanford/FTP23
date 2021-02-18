// MASTER VARIABLE FOR MLS DIRECTORY
var mlsFolder = '/mls';

// Mobile Geolocation
function showLocation(position) {
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  alert("Latitude : " + latitude + " Longitude: " + longitude);
}

function GeoErrorHandler(err) {
  if(err.code == 1) {
    alert("Error: Access is denied!");
  } else if( err.code == 2) {
    alert("Error: Position is unavailable!");
  }
}

function getLocation() {
  if(navigator.geolocation) {
    // timeout at 60000 milliseconds (60 seconds)
    var options = {timeout:60000};
    navigator.geolocation.getCurrentPosition(showLocation, GeoErrorHandler, options);
  } else {
    alert("Sorry, browser does not support geolocation!");
  }
}

$("body").on('submit','#savesearchform',function(e){
  e.preventDefault(); //STOP default action
  var action = $("#savesearchform").attr('action');
  var postData = $(this).serializeArray();
  $.ajax({
    url : action,
    type: "POST",
    data : postData,
    success: function(data) {
      $("#saveSearchModal .modal-content").html(data)
    },
    error: function(errorThrown){
      alert();
      //if fails
    }
  });
});

// PAGINATION
function paginate(newPage){
  $.ajax({
    type: "POST",
    url: mlsFolder+'/ajax/results.cfm',
    data: {page: newPage},
    beforeSend: function(){
      $('.results-loader-overlay').fadeIn(200);
    },
    success: function(data) {
      $('#searchResults').html(data);
      // THIS LOADS THE loading.gif IN TOP RIGHT CORNER
      $('.results-loader-overlay').fadeOut(200);
    }
  })
}

$('#refineForm, #sortForm').find('[name=page]').val(0);
// FORM SUBMITTER FUNCTION
function submitForm() {
  function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1);
      if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
    }
    return "";
  }
  $('#refineForm').submit();
};


//   ****     ****    ****  **  **   ***  ***   ******  **   **  ******       *****   ******   ****   ****    **  **
//   **  **  **  **  **     **  **  ** **** **  **      ***  **    **         **  **  **      **  **  **  **  **  **
//   **  **  **  **  **     **  **  **  **  **  *****   ** ** *    **         ** **   *****   ******  **  **   ****
//   **  **  **  **  **     **  **  **  **  **  **      **  ***    **         *** *   **      **  **  **  **    **
//   ****     ****    ****   ****   **      **  ******  **   **    **         **  **  ******  **  **  ****      **
$(document).ready(function(){
/////////////////////////////////////////
///////////   REFINE SEARCH   ///////////
/////////////////////////////////////////

  // SUBMIT ON CHANGE
  $('.selectpicker:not([multiple])').on('change', function(){
    var fieldName = $(this).attr("name");
    if (fieldName == 'SQFtMin' || fieldName == 'SQFtMax') {
      // nothing
    } else {
      submitForm();
    }
  });

  // SUBMIT ON CHANGE - IF THE SELECT BOX IS MULTIPLE ADD data-actions-box="true" TO THE SELECT TAG
  $('.selectpicker[multiple]').on('hidden.bs.select', function(){
    submitForm();
  });

  // REPEATABLE FUNCTION TO HIDE MORE FILTERS BOX
  function hideMoreFilters() {
    if (!$('.refine-filter-box').hasClass('hidden')) {
      $('.refine-filter-box').addClass('hidden');
      $('.refine-filters').find('.fa-chevron-up').addClass('fa-chevron-down').removeClass('fa-chevron-up');
    }
  }

  // DROP DOWN IN REFINE WRAP
  $('.refine-text').on('click', function(){
    // TOGGLE DROP DOWNS
    if ($(this).next().hasClass('hidden')) {
      hideMoreFilters();
      $('.refine-dropdown').addClass('hidden');
      $(this).addClass('active');
    	$('.refine-text').find('.fa-chevron-up').addClass('fa-chevron-down').removeClass('fa-chevron-up'); // FIND ADJACENT CHEVRONS, FLIP TOGGLE WHEN OTHER REFINE ITEM IS SELECTED
    	$(this).find('.fa-chevron-down').removeClass('fa-chevron-down').addClass('fa-chevron-up');
      $(this).next().removeClass('hidden');
    } else {
      $(this).removeClass('active');
    	$(this).find('.fa-chevron-up').addClass('fa-chevron-down').removeClass('fa-chevron-up');
      $(this).next().addClass('hidden');
    }
  });

  // OUTSIDE CLICK TO CLOSE THE DROPDOWNS
  $(document).on('click', function(e) {
    if ($(e.target).is('.refine-text, .refine-text *, .refine-dropdown, .refine-dropdown *, .refine-filter-box, .refine-filter-box *, .ui-datepicker-next, .ui-datepicker-prev')) {
      e.stopPropagation();
    } else {
      $('.refine-dropdown, .refine-filter-box').addClass('hidden');
      $('.refine-text').removeClass('active');
      $('.refine-text').find('.fa-chevron-up').addClass('fa-chevron-down').removeClass('fa-chevron-up');
    }
  });

	// REFINE APPLY/CANCEL - HIDES CURRENT BOX
	$('.refine-apply, .refine-close').on('click', function(){
  	// GENERAL DROPDOWNS
  	if ($(this).parent().hasClass('refine-dropdown')) {
    	$(this).parent().addClass('hidden');
    }
  	// FILTERS
  	if ($(this).parent().hasClass('refine-filter-action')) {
    	$(this).parent().parent().addClass('hidden');
  	}
  	if ($(this).parent().parent().hasClass('refine-filter-box')) {
      $(this).parent().parent().prev().find('.fa-chevron-up').addClass('fa-chevron-down').removeClass('fa-chevron-up');
    } else {
    	$(this).parent().prev().find('.fa-chevron-up').addClass('fa-chevron-down').removeClass('fa-chevron-up');
    }
	});

	// REFINE SELECT COUNTER
	$('.refine-counter').each(function(){
  	var countTop = $(this).parent().find('.refine-count');
  	var countDropdown = $(this).parent().find('.refine-drop-count');
  	var currentCount = countTop.text();
  	var min = $(this).find('.refine-drop-count').data('min');
  	var max = $(this).find('.refine-drop-count').data('max');
  	var counter = currentCount;
    if (currentCount > min) {
      $(this).find('.fa-minus').removeClass('disabled');
    }
  	// COUNTING UP
  	$(this).find('.fa-plus').on('click', function(){
      if (counter >= min && counter < max) {
        counter++;
        countTop.text(counter);
        countDropdown.text(counter);
        $(this).prev().prev().removeClass('disabled');
      }
      if (counter === max) {
        $(this).addClass('disabled');
      }
    });
  	// COUNTING DOWN
  	$(this).find('.fa-minus').on('click', function(){
      if (counter <= max && counter > min) {
        --counter;
        countTop.text(counter);
        countDropdown.text(counter);
        $(this).next().next().removeClass('disabled');
      }
      if (counter === min) {
        $(this).addClass('disabled');
      }
    });
	});

  // REFINE BEDROOMS COUNTER
  if($('.refine-bedrooms-counter-wrap').length) {
    $('#refineBedsCountApply').on('click', function(){
      var bedCount = $('.refine-beds').text();
      $('input[name=bedrooms]').val(bedCount);
      console.log('bedCount: ' + bedCount);
      submitForm();
    });
  }

  // REFINE BATHROOMS COUNTER
  if($('.refine-bathrooms-counter-wrap').length) {
    $('#refineBathsCountApply').on('click', function(){
      var bathCount = $('.refine-baths').text();
      $('input[name=baths_full]').val(bathCount);
      console.log('bathCount: ' + bathCount);
      submitForm();
    });
  }

	// MUST HAVES CUSTOM MULTISELECT
	$('.refine-list-item').on('click', function(){
  	$(this).find('.fa').toggleClass('hidden').toggleClass('checked');
  	var numChecked = $('.refine-list-item .fa-check.checked').length;
  	var refineCount = $(this).parent().parent().prev().find('.refine-count');
  	refineCount.text(numChecked);
  	refineCount.removeClass('hidden');
  	if (refineCount.text() == 0) {
    	refineCount.addClass('hidden');
  	}
  	var amenityText = $(this).find('em').text();
  	var amenityInput = $(this).find('input[name=]');
  	if (amenityInput.val()) {
      amenityInput.val('');
    } else {
      amenityInput.val(amenityText);
    }
	});

  // MORE FILTERS SELECTED COUNT
  $('#refineMoreFiltersApply').on('click', function(){
    var checkedBoxes = $('.refine-filter-checkbox[type=checkbox]:checked').length;
    $('#filtersCount').text('(' + checkedBoxes + ')');
  });

  $('.refine-filter-checkbox').on('click', function(){
    var checkedBoxes = $('.refine-filter-checkbox[type=checkbox]:checked').length;
    var checked = $(this).prop('checked');
  });

  // MORE FILTERS - SEE ALL *
  $('.refine-filter-see-all').on('click', function(){
    $(this).prev().toggleClass('hidden');
    $(this).find('.fa').toggleClass('fa-chevron-down').toggleClass('fa-chevron-up');
  });

  // MORE FILTERS - APPLY BUTTON SUBMIT FORM
  $(document).on('click','#refineMoreFiltersApply', function(){
    submitForm();
  });


  // THIS IS FOR THE LARGE MAP
  //////////////////////////////////////////////////////////////////////////////////////
  window.map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14,
    maxZoom: 18,
    mapTypeId: google.maps.MapTypeId.street,
    //styles: [] MAP THEME STYLES GO IN HERE
  });
  window.markers = [];

  $.ajax({
		type: "POST",
		url: mlsFolder+'/ajax/map-all-results.cfm',
		data: $('#refineForm, #sortForm').serialize(),
		dataType: 'json',
		success: function(data) {
			var props = serializeCFJSON(data);
      //console.log(props);
			drawMapAllResults(map, markers, props);
		},
		error: function(xhr, textStatus, error){
			//console.log(xhr.statusText);
			//console.log(textStatus);
			//console.log(error);
		}
  });

  function drawMapAllResults(map, markers, data, imagepath) {
    var infowindow = new google.maps.InfoWindow({
      size: new google.maps.Size(150, 50)
    });

    if (markers.length) {
      var length = markers.length;
      for (var i = length - 1; i >= 0; i--) {
        markers[i].setMap(null);
        markers[i] = null;
        markers.splice(i, 1);
      }
    }

    // DRAW ALL NEW MARKERS
    ///////////////////////
    var bounds = new google.maps.LatLngBounds();

    for (var i = 0; i < data.length; i++) {
      var prop = data[i];
      if (prop.latitude != null || '') { // if null or empty, don't put this into the map
        var myLatlng = new google.maps.LatLng(prop.latitude, prop.longitude);

        var marker = new google.maps.Marker({
          map: map,
          position: new google.maps.LatLng(prop.latitude, prop.longitude),
          title: '',
          icon: mlsFolder+'/images/marker.png',
          zIndex: 1
        });

        function animateit(marker) {
          google.maps.event.addListener(marker, 'mouseover', function() {
            var icon = {url:mlsFolder+'/images/marker-hover.png', scaledSize: new google.maps.Size(12,12)};
            marker.setIcon(icon);
          });

          google.maps.event.addListener(marker, 'mouseout', function() {
            var icon = {url:mlsFolder+'/images/marker.png', scaledSize: new google.maps.Size(12,12)};
            marker.setIcon(icon);
          });

					$(".results-list-property").mouseover(function(){
					  var markerid = $(this).attr('data-mapMarkerID');
					  var icon = {url:mlsFolder+'/images/marker-hover.png', scaledSize: new google.maps.Size(12,12)};
            markers[markerid].setIcon(icon);
            markers[markerid].setZIndex(100);
					});

					$(".results-list-property").mouseout(function(){
					  var markerid = $(this).attr('data-mapMarkerID');
            var icon = {url:mlsFolder+'/images/marker.png', scaledSize: new google.maps.Size(12,12)};
            markers[markerid].setIcon(icon);
            markers[markerid].setZIndex(1);
					});
        }
        (function(prop, marker) {

          // MAP PIN DESCRIPTION BOX
          //////////////////////////
          var propImgUrlAry = prop.photo_link.split(',');

          var listPrice = prop.list_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); //regex to add a comma as a thousand seperator

          if((isNaN(prop.bedrooms) || isNaN(prop.baths_full)) || prop.bedrooms + prop.baths_full == 0){

            var desc = '<a href="' + mlsFolder + '/' + prop.proplink + '" target="_blank"><img src="' + propImgUrlAry[0] + '" width="180" height="100" /></a><br>' + '<h4><a href="' + mlsFolder + '/' + prop.proplink + '" target="_blank">' + prop.city + '</a></h4>' + '<strong>Listing Price: $' + listPrice + '</strong><br>' + '<strong>MLS# ' + prop.mlsnumber + '</strong><br>' + '<a class="btn btn-mini site-color-2-bg site-color-2-lighten-bg-hover text-white" href="' + mlsFolder + '/' + prop.proplink + '" target="_blank">Learn More</a>';
          }else{
            var desc = '<a href="' + mlsFolder + '/' + prop.proplink + '" target="_blank"><img src="' + propImgUrlAry[0] + '" width="180" height="100" /></a><br>' + '<h4><a href="' + mlsFolder + '/' + prop.proplink + '" target="_blank">' + prop.city + '</a></h4>' + '<strong>Listing Price: $' + listPrice + '</strong><br>' + '<strong>MLS# ' + prop.mlsnumber + '</strong><br>' + '<strong>Bedrooms: ' + prop.bedrooms + ' | ' + 'Bathrooms: ' + prop.baths_full + ' | ' + '1/2 Baths: ' + prop.baths_half + '</strong><br>' + '<a class="btn btn-mini site-color-2-bg site-color-2-lighten-bg-hover text-white" href="' + mlsFolder + '/' + prop.proplink + '" target="_blank">Learn More</a>';
          }

          google.maps.event.addListener(marker, 'click', function() {
            infowindow.setContent(desc);
            infowindow.open(map, marker);
          });

        })(prop, marker);

        animateit(marker);
        markers.push(marker);
        bounds.extend(myLatlng);
      } // end if prop.lat...
    }
    map.fitBounds(bounds);

  }
  window.drawMapAllResults = drawMapAllResults;
  window.serializeCFJSON = serializeCFJSON;

  // SELECT ALL/DESELECT ALL TOGGLE FOR MORE FILTERS SELECTS
  $('.refine-filter-select-all').on('click', function(){
    var filterCheckBox = $(this).closest('.refine-filter-section').find('.refine-filter-checkbox');
    var checked = $(this).prop('checked');
    filterCheckBox.prop('checked', checked);
    $(this).next().text($(this).next().text() == 'Deselect All' ? 'Select All' : 'Deselect All');
  });

  // SELECT ALL/DESELECT ALL TOGGLE WHEN A SINGLE OR ALL INDIVIDUAL ITEMS ARE SELECTED TO SWAP SELECT/DESELECT ALL
  $('.refine-filter-checkbox').on('click', function(){
    var refineFilterCheckbox = $(this).closest('.refine-filter-section').find('.refine-filter-checkbox');
    var refineFilterSelectAll = $(this).closest('.refine-filter-section').find('.refine-filter-select-all');
    var selectAll = $(this).closest('.refine-filter-section').find('.select-all');
    if (!$(refineFilterCheckbox).filter(':checked').length > 0) {
      $(refineFilterSelectAll).prop('checked',false);
      $(selectAll).text('Select All');
    }
    if ($(refineFilterCheckbox).filter(':checked').length == $(refineFilterCheckbox).length) {
      $(refineFilterSelectAll).prop('checked',true);
      $(selectAll).text('Deselect All');
    } else {
      $(refineFilterSelectAll).prop('checked',false);
      $(selectAll).text('Select All');
    }
  });

  // SPECIFIC PROPERTY JUMP TO (Name and Number)
	$('.refine-filter-specific-property-select').change(function(){
		var url = $(this).val();
    var redirectWindow = window.open(url, '_blank');
    redirectWindow.location;
  });


/////////////////////////////////////////
///////////   RESULTS LIST   ////////////
/////////////////////////////////////////

  // SORT BY FOR RESULTS LIST
  $('#sortForm').on('click', function(e){
    e.stopPropagation();
    $(this).find('ul').toggleClass('hidden');
  });
  $('#sortForm ul li').on('click', function(){
    var txt = $(this).find('span').text();
    $('#resultsListSortTitle i').text(txt);
    var sortFormData = $(this).attr('data-resultsList');
    $('#refineForm').find('input[name=sortBy]').val(sortFormData);
    submitForm();
  });


  // VIEW GRID OR SPLIT (GRID/MAP) VIEW
  $('#viewListAndMap').on('click', function(){
    hideMoreFilters();
    // $(this).html($(this).html() == '<i class="fa fa-columns site-color-1" aria-hidden="true"></i><span class="site-color-1">Split View</span>' ? '<i class="fa fa-th-large site-color-1" aria-hidden="true"></i><span class="site-color-1">Grid View</span>' : '<i class="fa fa-columns site-color-1" aria-hidden="true"></i><span class="site-color-1">Split View</span>');
    if(!$('.results-list-wrap').hasClass('results-list-full-width community-list-full-width')) {
      $(this).html($(this).html() == '<i class="fa fa-columns site-color-1" aria-hidden="true"></i><span class="site-color-1">Split View</span>' ? '<i class="fa fa-th-large site-color-1" aria-hidden="true"></i><span class="site-color-1">Grid View</span>' : '<i class="fa fa-columns site-color-1" aria-hidden="true"></i><span class="site-color-1">Split View</span>');
    } else {
      $(this).html($(this).html() == '<i class="fa fa-th-large site-color-1" aria-hidden="true"></i><span class="site-color-1">Grid View</span>' ? '<i class="fa fa-columns site-color-1" aria-hidden="true"></i><span class="site-color-1">Split View</span>' : '<i class="fa fa-th-large site-color-1" aria-hidden="true"></i><span class="site-color-1">Grid View</span>');
    }
    $('.results-list-wrap').toggleClass('results-list-full-width').removeClass('hidden');
    $('.map-wrap').toggleClass('hidden').removeClass('map-wrap-full');
    setTimeout(function() {
      var center = map.getCenter();
      google.maps.event.trigger(map, "resize");
      map.setCenter(center);
    }, 500);
  });

	// VIEW MAP ONLY
	$('#viewMapOnly').on('click', function(){
    hideMoreFilters();
    $('.results-list-wrap').toggleClass('hidden').removeClass('results-list-full-width');
    $('.map-wrap').toggleClass('map-wrap-full').removeClass('hidden');
    // DISABLE SPLIT/GRID TOGGLE
    $('#viewListAndMap').toggleClass('inactive');

    if(!$('.results-list-wrap').hasClass('results-list-full-width') || $('.map-wrap').hasClass('map-wrap-full')) {
      // FULL WIDTH RESULTS
      $('#viewListAndMap').children('i').addClass('fa-th-large').removeClass('fa-columns');
    } else if($('.results-list-wrap').hasClass('results-list-full-width')) {
      // SPLIT VIEW
      $('#viewListAndMap').children('i').addClass('fa-columns').removeClass('fa-th-large');
    } else {
      // ELSE
      $('#viewListAndMap').children('i').addClass('fa-th-large').removeClass('fa-columns');
    }

    // IF REFINE IS OPEN, CLOSE IT
    if ($(window).width() < 1200){
      if ($('#viewFiltersMobile').html() === '<a href="javascript:;" id="viewFiltersMobile" rel="tooltip" data-placement="bottom" title="" data-original-title="Refine Your Search"><i class="fa site-color-1 fa-toggle-on" aria-hidden="true"></i> <span class="site-color-1">Close Refine</span></a>') {
        $('#viewFiltersMobile').html('<i class="fa site-color-1 fa-toggle-on" aria-hidden="true"></i> <span class="site-color-1">Close Refine</span>');
      } else {
        $('#viewFiltersMobile').html('<i class="fa fa-toggle-off site-color-1" aria-hidden="true"></i> <span class="site-color-1">Refine Your Search</span>');
      }
      $('.refine-form').addClass('mobile-hidden');
    }

  	if ($(window).width() > 1025 && $(window).width() < 1200){
    	var text = $(this).find('span');
    	if (text.text() === 'Map View') {
      	text.text('Split View');
        $(this).children('i').addClass('fa-columns').removeClass('fa-map-marker');
    	} else {
        text.text('Map View');
        $(this).children('i').addClass('fa-map-marker').removeClass('fa-columns');
    	}
    }
    if ($(window).width() < 1024){
    	var text = $(this).find('span');
    	if (text.text() === 'Map View') {
      	text.text('Grid View');
        $(this).children('i').addClass('fa-th-large').removeClass('fa-map-marker');
    	} else {
        text.text('Map View');
        $(this).children('i').addClass('fa-map-marker').removeClass('fa-th-large');
    	}
    }
    if ($(window).width() < 736){
      $('.mls-footer-wrap').toggleClass('hidden');
    }
    setTimeout(function() {
      $.ajax({
    		type: "POST",
    		url: mlsFolder+'/ajax/map-all-results.cfm',
    		data: $('#refineForm, #sortForm').serialize(),
    		dataType: 'json',
    		success: function(data) {
    			var props = serializeCFJSON(data);
          //console.log(props);
    			drawMapAllResults(map, markers, props);
    		},
    		error: function(xhr, textStatus, error){
    			//console.log(xhr.statusText);
    			//console.log(textStatus);
    			//console.log(error);
    		}
      });
      var center = map.getCenter();
      google.maps.event.trigger(map, "resize");
      map.setCenter(center);
    }, 500);
    console.log("map btn has been clicked");
	});

  // VIEW FILTERS MOBILE
  $('#viewFiltersMobile').on('click', function(){
    var text = $(this).find('span');
    if (text.text() === 'Refine Your Search') {
      text.text('Close Refine');
      $(this).children('i').addClass('fa-toggle-on').removeClass('fa-toggle-off');
    } else {
      text.text('Refine Your Search');
      $(this).children('i').addClass('fa-toggle-off').removeClass('fa-toggle-on');
    }
    $('.refine-form').toggleClass('mobile-hidden');
  });

  // SPECIALS MODAL HTML SWAP - IF YOU HAVE TO CHANGE THIS, UPDATE IN ajax/results.cfm
  $('.results-list-property-img-wrap').on('click','.results-list-property-special',function(){
    var test = $(this).parent().find('.special-modal-content').html();
    $('#specialModalContent').html(test);
  });





  // COMMUNITY PAGE VIDEO CONTROLS
  if ($('.community-video-wrap').length) {
    $('#videoPlayBtn').on('click', function(){
      $('#bgvid').attr('autoplay', 'true');
      $('#videoOverlay').fadeOut();
      $('#videoPauseBtn').delay(500).fadeIn(500);
    });
    $('#videoPauseBtn').on('click', function(){
      $('#bgvid')[0].currentTime = 0;
      $('#videoOverlay').fadeIn(800);
      $(this).fadeOut();
    });
  }


  //////////////////////////////////////////////////////////////
  function serializeCFJSON(obj) {
    var json = [];
    for (var i = 0; i < obj.DATA.length; i++) {
      var o = {};
      var item = obj.DATA[i];
      for (var j = 0; j < obj.COLUMNS.length; j++) {
        o[obj.COLUMNS[j].toLowerCase()] = item[j];
      }
      json.push(o);
    }
    return json;
  }

});