<cfoutput>
<div id="propertyBanner" class="property-banner">
  <!-- Property Banner -->
  <div id="propertyImage" class="property-image">
    <style>.property-image:before { content: "<cfoutput>#property.name#</cfoutput>"; }</style>
    <img class="lazy" data-src="#property.largePhoto#" src="/#settings.booking.dir#/images/1x1.png" alt="#property.name#">
    <!--- If you add a PDP Gallery, name the main class="owl-carousel pdp-gallery" for the JS --->
    <!-- Property Gallery -->
    <div id="hiddenGallery" class="hidden-gallery">
	  <cfset PhotoCnt = 0>
      <cfloop query="#photos#">
    	  <cfset PhotoCnt = PhotoCnt + 1>
	      <a href="#photos.large#" data-fancybox="property-images" data-thumb="#photos.thumbnail#" data-caption="#photos.caption#">
	        <cfif len(caption)>
            <span class="hidden">#caption#</span>
	        <cfelseif isdefined('sort')>
            <span class="hidden">#property.name# | Photo #sort#</span>
    			<cfelse>
            <span class="hidden">#property.name# | Photo #PhotoCnt#</span>
	        </cfif>
	      </a>
      </cfloop>
    </div><!-- END hiddenGallery -->
  </div>

  <!-- Property Map -->
  <cfif len(property.latitude) and len(property.longitude)>
  <div id="propertyMap" class="property-map property-iframe">
    <div id="map"></div>
    <!--- <iframe class="lazy" data-src="https://maps.google.com/maps?q=#property.latitude#,#property.longitude#&ie=UTF8&output=embed" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> --->
  </div>
  </cfif>

<!---
  <!-- Property Videos/Virtual Tours -->
  <div id="propertyTour" class="property-tour property-iframe">
    <cfset youTubeID = "g3tB7aFoyjY"><!-- KEEP OTHER URL PARAMETERS FOR CLEANER VIDEO FRAME -->
    <iframe id="propertyTourFrame" class="lazy" data-src="https://www.youtube.com/embed/<cfoutput>#youTubeID#</cfoutput>?rel=0&amp;controls=0&amp;showinfo=0&amp;enablejsapi=1" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
  </div>
--->

  <!--- Favorite Heart --->
  <a href="javascript:;" class="property-list-property-favorite add-to-favs add-to-fav-detail" data-unitcode="#property.propertyid#">
    <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
    <i class="fa fa-heart under<cfif ListFind(cookie.favorites,property.propertyid)> favorited</cfif>" aria-hidden="true"></i>
    <span class="hidden">Favorite</span>
  </a>

  <div class="banner-btn-wrap">
    <cfif len(property.latitude) and len(property.longitude)><button id="propertyMapBtn" class="btn property-map-btn collapse-btn inactive" type="button"><i class="fa fa-map-marker" aria-hidden="true"></i> <span>View Map</span></button></cfif>
    <button id="propertyGalleryBtn" rel="pdpGallery" data-caption="Pic 1" class="btn property-gallery-btn collapse-btn site-color-3-bg site-color-4-bg-hover text-white inactive" type="button"><i class="fa fa-camera" aria-hidden="true"></i> <span>View Gallery</span></button>
<!---
  	<button id="propertyTourBtn" class="btn property-tour-btn collapse-btn inactive" type="button"><i class="fa fa-video-camera" aria-hidden="true"></i> <span>View Tour</span></button>
--->
  </div>
</div><!-- END propertyBanner -->
</cfoutput>