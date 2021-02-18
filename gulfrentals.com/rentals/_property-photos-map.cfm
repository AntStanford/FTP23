<cfoutput>
<div id="propertyBanner" class="property-banner">
  <!-- Property Banner -->
  <div id="propertyImage" class="property-image">
    <style>.property-image:before { content: "<cfoutput>#property.name#</cfoutput>"; }</style>
    <img class="lazy" data-src="#property.largePhoto#" src="/#settings.booking.dir#/images/1x1.png" alt="#property.name#">

    <!-- Property Gallery -->
    <div id="hiddenGallery" class="hidden-gallery">
	  <cfset PhotoCnt = 0>
      <cfloop query="#photos#">
    	  <cfset PhotoCnt = PhotoCnt + 1>
        <a href="#photos.original#" rel="pdpGallery" data-fancybox="property-images" data-caption="#photos.caption#">
          <!---
	        <cfif len(caption)>
        		<img src="#photos.thumbnail#" alt="#caption#">
	        <cfelseif isdefined('sort')>
        		<img src="#photos.thumbnail#" alt="#property.name# | Photo #sort#">
    			<cfelse>
    				<img src="#photos.thumbnail#" alt="#property.name# | Photo #PhotoCnt#">
          </cfif>
          --->
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

  <cfif getVT.recordcount gt 0 and getVT.virtualtour neq "">
      <!-- Property Videos/Virtual Tours -->
      <div id="propertyTour" class="property-tour property-iframe">
        <cfset youTubeID = "g3tB7aFoyjY"><!-- KEEP OTHER URL PARAMETERS FOR CLEANER VIDEO FRAME -->
        <iframe id="propertyTourFrame" class="lazy" data-src="#getVT.virtualtour#" <!---data-src="https://www.youtube.com/embed/<cfoutput>#youTubeID#</cfoutput>?rel=0&amp;controls=0&amp;showinfo=0&amp;enablejsapi=1"---> width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
      </div>
  <cfelse>
      <!-- Property Videos/Virtual Tours -->
      <div id="propertyTour" class="property-tour property-iframe">
        <cfset youTubeID = "g3tB7aFoyjY"><!-- KEEP OTHER URL PARAMETERS FOR CLEANER VIDEO FRAME -->
        <!---<iframe id="propertyTourFrame" class="lazy" data-src="https://www.youtube.com/embed/<cfoutput>#youTubeID#</cfoutput>?rel=0&amp;controls=0&amp;showinfo=0&amp;enablejsapi=1" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>--->
        #property.virtualtour#
      </div>
</cfif>

  <!--- Favorite Heart --->
  <a href="javascript:;" class="property-list-property-favorite add-to-favs add-to-fav-detail" data-unitcode="#property.propertyid#">
    <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
    <i class="fa fa-heart under<cfif ListFind(cookie.favorites,property.propertyid)> favorited</cfif>" aria-hidden="true"></i>
    <span class="hidden">Favorite</span>
  </a>

  <div class="banner-btn-wrap">
    <cfif len(property.latitude) and len(property.longitude)><button id="propertyMapBtn" class="btn property-map-btn collapse-btn inactive" type="button"><i class="fa fa-map-marker" aria-hidden="true"></i> <span>View Map</span></button></cfif>
    <button id="propertyGalleryBtn" rel="pdpGallery" data-caption="Pic 1" class="btn property-gallery-btn collapse-btn site-color-2-lighten-bg site-color-2-bg-hover inactive" type="button"><i class="fa fa-camera" aria-hidden="true"></i> <span>View Gallery</span></button>
  	<cfif len(property.virtualtour)><button id="propertyTourBtn" class="btn property-tour-btn collapse-btn inactive" type="button"><i class="fa fa-video-camera" aria-hidden="true"></i> <span>View Tour</span></button></cfif>
  </div>
</div><!-- END propertyBanner -->
</cfoutput>