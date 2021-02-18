<h4>Map View</h4>

<style>
  html, body, #map-canvas {
    height: 100%;
    margin: 0px;
    padding: 0px
  }
  html, body, #map-canvas img  {
  max-width: none;
}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
<cfoutput> 
<script>
function initialize() {
  var myLatlng = new google.maps.LatLng(#latitude#,#longitude#);
  var mapOptions = {
    zoom: 18,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.HYBRID
  }
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: '#street_number# #street_name#'
  });
}
  google.maps.event.addDomListener(window, 'load', initialize);
</script>
</cfoutput>
<div style="width:100%;font-size:13px;">
  <div id="map-canvas" style="width: 100%; height: 300px;float:left;"></div>
  *Map location is an approximation. Drag and drop yellow figure on to map for street view.
</div>