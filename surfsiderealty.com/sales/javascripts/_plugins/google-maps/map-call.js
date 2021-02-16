Modernizr.load([
	{
		test: $('.google-map').length,
		yep: {
			'markerClusterer' : '/mls/javascripts/_plugins/google-maps/markerClusterer.js',
			'mapping' : '/mls/javascripts/_plugins/google-maps/mapping.js'
		},
		callback: {
			'mapping' : function() {
				$(document).ready( function() { initializeMap() });
			}
		}
	}
]);