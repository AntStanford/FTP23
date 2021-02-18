<cfquery name="getCMSDesc" datasource="#settings.dsn#">
  select photo_link_path,photo_desc
  from mls_photos
  where mlsnumber = '#property.mlsnumber#'
</cfquery>

<cfoutput>
<div class="property-banner-wrap">
  <div id="propertyBanner" class="property-banner">
    <!-- Property Banner -->
    <div id="propertyImage" class="property-image">
      <style>.property-image:before { content: "<cfoutput>#property.mlsnumber#</cfoutput>"; }</style>
      <!--- HIDDEN PROPERTY IMAGE IN PLACE OF GALLERY --->
      <cfif len(property.photo_link)>
        <img src="<cfif settings.mls.getmlscoinfo.imageurl neq ''>#application.settings.mls.getmlscoinfo.imageurl#/</cfif>#listgetat(property.photo_link,1)#" alt="#property.mlsnumber#">
      </cfif>

      <!--- PROPERTY GALLERY IN PLACE OF PROPERTY IMAGE --->
      <!---
      <div class="owl-gallery-wrap">
        <div class="owl-gallery-loader-container"><div class="owl-gallery-loader-tube-tunnel"></div></div>
        <div class="owl-carousel owl-theme owl-gallery">
          <cfloop list="#property.photo_link#" index="origPhoto">
            <cfset photo = replacenocase(origPhoto,'http:','https:') />
            <cfoutput>
              <div class="item">
                <a href="<cfif settings.mls.getmlscoinfo.imageurl neq ''>#settings.mls.getmlscoinfo.imageurl#/</cfif>#photo#" class="fancybox" data-fancybox="owl-gallery-group">
                  <div class="owl-lazy" data-src="<cfif settings.mls.getmlscoinfo.imageurl neq ''>#settings.mls.getmlscoinfo.imageurl#/</cfif>#photo#"></div>
                </a>
              </div>
            </cfoutput>
          </cfloop>
        </div>
        <div class="owl-carousel owl-theme owl-gallery-thumbs">
          <cfloop list="#property.photo_link#" index="origPhoto">
            <cfset photo = replacenocase(origPhoto,'http:','https:') />
            <cfoutput>
              <div class="item">
                <div class="owl-lazy" data-src="<cfif settings.mls.getmlscoinfo.imageurl neq ''>#settings.mls.getmlscoinfo.imageurl#/</cfif>#photo#"></div>
              </div>
            </cfoutput>
          </cfloop>
        </div>
      </div>
      <div class="slider-caption">Click the main image above for larger images!</div>
      --->

      <!-- Property Gallery -->
      <div id="hiddenGallery" class="hidden-gallery">
        <cfset variables.loopCount = 1 />
        <cfloop list="#property.photo_link#" index="origPhoto">

          <cfquery name="getThisDescription" dbtype="query">
            select photo_desc
            from getCMSDesc
            where photo_link_path = '#origPhoto#'
          </cfquery>

          <cfif getThisDescription.recordcount eq 1 and getThisDescription.photo_desc neq ''>
            <cfset theDescription = getThisDescription.photo_desc>
          <cfelse>
            <cfset theDescription = 'Image #variables.loopCount#'>
          </cfif>

          <cfset photo = replacenocase(origPhoto,'http:','https:') />
  	      <a href="<!--- <cfif settings.mls.getmlscoinfo.imageurl neq ''>#application.settings.mls.getmlscoinfo.imageurl#/</cfif> --->#photo#" rel="pdpGallery" data-fancybox="property-images" data-caption="#property.subdivision# Real Estate<Br>#theDescription#">
            <img src="<!--- <cfif settings.mls.getmlscoinfo.imageurl neq ''>#application.settings.mls.getmlscoinfo.imageurl#/</cfif> --->#photo#" alt="#property.mlsnumber# | Photo #variables.loopCount#">
  	      </a>
          <cfset variables.loopCount += 1 />
        </cfloop>
      </div><!-- END hiddenGallery -->
    </div>

    <!-- Property Map -->
    <cfif len(property.latitude) and len(property.longitude)>
      <div id="propertyMap" class="property-map property-iframe">
        <div id="map"></div>
        <!--- <iframe src="https://maps.google.com/maps?q=#property.latitude#,#property.longitude#&ie=UTF8&output=embed" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe> --->
      </div>
    </cfif>

    <!-- Property 3D Videos/Virtual Tours -->
<!---
    <cfif LEN(checkEnhanced.virtualtourlink)>
      <cfif isdefined('checkEnhanced.showonwebsite') and isdefined('checkEnhanced.virtualtourlink') and checkEnhanced.showonwebsite eq 'Yes' and LEN(checkEnhanced.virtualtourlink)>
        <div id="property3DTour" class="property-tour property-iframe">
          <iframe class="iframe-video" id="propertyTourFrame" src="#checkEnhanced.virtualtourlink#" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
        </div>
      </cfif>
    </cfif>
--->

    <cfif isdefined('checkEnhanced.showonwebsite') and isdefined('checkEnhanced.videolink') and checkEnhanced.showonwebsite eq 'Yes' and LEN(checkEnhanced.videolink)>
      <!-- Property Video Videos/Virtual Tours -->
      <div id="propertyVideoTour" class="property-tour property-iframe">
        <cfif checkEnhanced.videolink contains "watch?v=">
          <cfset variables.youTubeUrl = "#replacenocase(checkEnhanced.videolink,'watch?v=','embed/','all')#?rel=0&controls=0&showinfo=0&enablejsapi=1" />
        <cfelseif checkEnhanced.videolink CONTAINS "youtu.be">
         <cfset variables.youTubeUrl = "#replacenocase(checkEnhanced.videolink,'youtu.be','youtube.com/embed/','all')#?rel=0&controls=0&showinfo=0&enablejsapi=1" />
        <cfelse>
          <cfset variables.youTubeUrl = checkEnhanced.videolink />
        </cfif>
        <!-- KEEP OTHER URL PARAMETERS FOR CLEANER VIDEO FRAME -->
        <iframe class="iframe-video" id="propertyTourFrame" src="#variables.youTubeUrl#" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
      </div>
    </cfif>

    <!--- PROPERTY STATUS --->
    <cfif isdefined('property.status_name')>
    <span class="property-status-wrap">
      <cfswitch expression="#property.status_name#">
        <cfcase value="Active">
          <span class="property-status property-status-active">Active</span>
        </cfcase>
        <cfcase value="Pending">
          <span class="property-status property-status-pending">Pending</span>
        </cfcase>
        <cfcase value="Sold">
          <span class="property-status property-status-sold">Sold</span>
        </cfcase>
        <cfdefaultcase>
          <span class="property-status property-status-other">#property.status_name#</span>
        </cfdefaultcase>
      </cfswitch>
    </span>
    </cfif>

    <!--- Favorite Heart --->
    <a href="javascript:;" class="property-list-property-favorite add-to-fav-detail" data-unitcode="#property.mlsnumber#">
      <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
      <i class="fa fa-heart under<cfif ListFind(cookie.mlsfavorites,property.mlsnumber)> favorited</cfif>" aria-hidden="true"></i>
    </a>

  </div><!-- END propertyBanner -->

  <div class="banner-btn-wrap">
    <cfif len(property.latitude) and len(property.longitude)><button id="propertyMapBtn" class="btn property-map-btn collapse-btn inactive" type="button"><i class="fa fa-map-marker" aria-hidden="true"></i> <span>View Map</span></button></cfif>
    <button id="propertyGalleryBtn" rel="pdpGallery" data-caption="Pic 1" class="btn property-gallery-btn collapse-btn site-color-2-lighten-bg site-color-2-bg-hover text-white inactive" type="button"><i class="fa fa-camera" aria-hidden="true"></i> <span>View Gallery</span></button>
  	<cfif isdefined('checkEnhanced.showonwebsite') and isdefined('checkEnhanced.virtualtourlink') and checkEnhanced.showonwebsite eq 'Yes' and LEN(checkEnhanced.virtualtourlink)>
      <button id="property3DTourBtn" class="btn video-btn property-tour-btn collapse-btn inactive" type="button"><i class="fa fa-video-camera" aria-hidden="true"></i> <span>View 3D Tour</span></button>
    </cfif>
  	<cfif isdefined('checkEnhanced.showonwebsite') and isdefined('checkEnhanced.videolink') and checkEnhanced.showonwebsite eq 'Yes' and LEN(checkEnhanced.videolink)>
      <button id="propertyVideoTourBtn" class="btn video-btn property-tour-btn collapse-btn inactive" type="button"><i class="fa fa-video-camera" aria-hidden="true"></i> <span>View Video</span></button>
    </cfif>
  </div>

</div><!-- END property-banner-wrap -->
</cfoutput>

<cffunction name="convertYouTube">
  <cfargument name="theUrl">

  <cfset return = rereplace(arguments.theUrl,
                  "/\s*[a-zA-Z\/\/:\.]*youtu(be.com\/watch\?v=|.be\/)([a-zA-Z0-9\-_]+)([a-zA-Z0-9\/\*\-\_\?\&\;\%\=\.]*)/i",
                  "//www.youtube.com/embed/$2\") />
  <cfreturn return>
</cffunction>