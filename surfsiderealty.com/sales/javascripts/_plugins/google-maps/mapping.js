var map;
var mapContainer;
var panorama;
var panoramaContainer;
var houseMarker;
var addLatLng;
var panoOptions;

$(document).ready( function() {
	if ( $('.map-view').length ) {
		updateMapViewState();
	}
	
	$('.map-view-button').click( function() {
		toggleMapViewState();
	});
	
	$('.map-view-prop-list li a').click( function(e) {
		mapOpenInfoWindow($(this).attr('data-position'));
		return false;
	});
});

function load_map_and_street_view_from_address(address) {
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode( { 'address': address}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			var gps = results[0].geometry.location;
			create_map_and_streetview(gps.lat(), gps.lng(), 'google-property-map', 'google-street-view');
		}
	});
}

function create_map_and_streetview(lat, lng, map_id, street_view_id) {
	
	var googlePos = new google.maps.LatLng(lat,lng);
	var service = new google.maps.StreetViewService();
	
	panoramaContainer = document.getElementById(street_view_id);
	mapContainer = document.getElementById(map_id);
	
	panorama = new google.maps.StreetViewPanorama(panoramaContainer);
	addLatLng = new google.maps.LatLng(lat,lng);
	service.getPanoramaByLocation(addLatLng, 50, showPanoData); 

	var myOptions = {
		zoom: 14,
		center: addLatLng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		backgroundColor: 'transparent',
		streetViewControl: false,
		keyboardShortcuts: false,
		scrollwheel: false
	}
	var map = new google.maps.Map(mapContainer, myOptions);
	var marker = new google.maps.Marker({
		map: map,
		position: addLatLng
	});
}

function showPanoData(panoData, status) {
	if (status != google.maps.StreetViewStatus.OK) {
		$(panoramaContainer).html('No Street View Available').attr('style', 'text-align:center;font-weight:bold').show();
		return;
	}
	$(panoramaContainer).show();
	
	var angle = computeAngle(addLatLng, panoData.location.latLng);
	var panoOptions = {
		position: addLatLng,
		addressControl: false,
		linksControl: false,
		panControl: false,
		scrollwheel: false,
		zoomControlOptions: {
			style: google.maps.ZoomControlStyle.SMALL
		},
		pov: {
			heading: angle,
			pitch: 10,
			zoom: 1
		},
		enableCloseButton: false,
		visible:true
	};
	panorama.setOptions(panoOptions);		
}

function computeAngle(endLatLng, startLatLng) {
	var DEGREE_PER_RADIAN = 57.2957795;
	var RADIAN_PER_DEGREE = 0.017453;
	
	var dlat = endLatLng.lat() - startLatLng.lat();
	var dlng = endLatLng.lng() - startLatLng.lng();
	// We multiply dlng with cos(endLat), since the two points are very closeby,
	// so we assume their cos values are approximately equal.
	var yaw = Math.atan2(dlng * Math.cos(endLatLng.lat() * RADIAN_PER_DEGREE), dlat) * DEGREE_PER_RADIAN;
	return wrapAngle(yaw);
}

function wrapAngle(angle) {
	if (angle >= 360) {
		angle -= 360;
	} else if (angle < 0) {
		angle += 360;
	}
	return angle;
}

function mapFitMarkerBounds() {  
    
	if (typeof map == 'object' && typeof markerCoords == 'object') {
		
		var latLngBounds = new google.maps.LatLngBounds();
		
		
		/* Uncomment out this for loop if you are setting custom boundaries */
		
		for ( var i = 0; i < markerCoords.length; i++ ) {
			if (typeof markerCoords[i] == 'object') latLngBounds.extend( markerCoords[i] );
		}
		
		
		
		
	/*
	  Begin Note for Custom Boundaries:
	  
  	  If you want to override the default boundaries set by the map markers, then zoom in on the map
  		around the area you want to highlight. Then pick 3 or 4 areas that are on the perimeter of that specific
  		targeted area, and use http://itouchmap.com/latlong.html to get the lat/long values for each area.
  		
  		For each of those areas, add them to the list below.
  		
  		Also be sure to comment out the default for loop above on line 120
	  
	  :End Note			
		
		var markerCoordsOverride = new Array();
		
		var pos = markerCoordsOverride.push( new google.maps.LatLng(32.237616, -80.809782) );
		var pos = markerCoordsOverride.push( new google.maps.LatLng(32.20778, -80.88444) );
		var pos = markerCoordsOverride.push( new google.maps.LatLng(32.118854, -80.864449) );
				
		
    for ( var i = 0; i < markerCoordsOverride.length; i++ ) {
			if (typeof markerCoordsOverride[i] == 'object') latLngBounds.extend( markerCoordsOverride[i] );
		}
		
*/
			
				
		map.fitBounds( latLngBounds );
			
	}
}

function mapOpenInfoWindow(pos) {
	infoWindow.close();
	infoWindow.setContent(content[pos]);
	infoWindow.open(map, markers[pos]);
	var scrollPos = $('#gMap_Properties').offset().top - ($(window).height() - $('#gMap_Properties').height())/2;
	$('html,body').animate({scrollTop: scrollPos}, 'slow');
}

function parseBool(string) {
	if ( typeof string == 'undefined' || string == null ) return false;
	switch(string.toLowerCase()) {
		case "true": case "yes": case "1": return true;
		case "false": case "no": case "0": return false;
		default: return Boolean(string);
	}
}

function toggleMapViewState() {
	var state = parseBool($.cookie('show_map_view')) || false;
	$.cookie('show_map_view', !state);
	updateMapViewState();
}

function updateMapViewState() {
	var state = parseBool($.cookie('show_map_view')) || false;
	if ( state ) {
		$('.map-view').show();
		$('.search-results').hide();
		if (typeof map == 'object') google.maps.event.trigger(map, 'resize'); mapFitMarkerBounds();
	} else {
		$('.map-view').hide();
		$('.search-results').show();
	}
}
