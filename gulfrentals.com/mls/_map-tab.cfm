<div class="panel panel-default">
	<div class="panel-heading">
		<h3>Map</h3>
	</div>
	<div class="panel-body">
		<div class="map-area">
      <style>
	      #map * { max-width: none; }
      </style>
      <cfif len(property.street_name) and len(property.city)>
        <div id="map" style="width:100%;height:500px"></div>
        <p>Map may not be 100% accurate.</p>
      <cfelse>
        No map available.
      </cfif>
		</div><!-- END map-area -->
	</div>
</div>