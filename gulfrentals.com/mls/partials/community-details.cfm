<!--- THIS FILE IS INCLUDED ON THE RESUPTS PAGE FOR COMMUNITY PAGES --->
<!--- GET COMMUNITY DATA --->
<cfquery name="qryCommunity" datasource="#settings.dsn#">
	SELECT * FROM cms_communities WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.communityId#">
</cfquery>

<cfif len(qryCommunity.h1Tag)>
  <cfset variables.h1 = qryCommunity.h1Tag />
<cfelse>
  <cfset variables.h1 = qryCommunity.name & " | " & qryCommunity.city />
</cfif>

<cfoutput>
	<div class="community-list-results">
		<div class="results-breadcrumb">
			<p>#qryCommunity.state# <i class="fa fa-chevron-right"></i> #qryCommunity.city# <i class="fa fa-chevron-right"></i> #qryCommunity.name#</p>
		</div>
		
		<h1>#variables.h1#</h1>
    <h2 class="community-subtitle">Real Estate &amp; Homes for Sale</h2>
    
    <cfif len(qryCommunity.topLeftImage) and len(qryCommunity.topRightImage)>

      <div class="community-img-wrap">
        <div class="community-text-box">
          <div class="h3">About This Community</div>
          <p>#qryCommunity.topText#</p>
          <cfif len(qryCommunity.moreInfoLink)><a href="#qryCommunity.moreInfoLink#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" <cfif lcase(left(qryCommunity.moreInfoLink,4)) is 'http'>target="_blank"</cfif>>Read More</a></cfif>
        </div>
        <div class="community-img-box-left community-img-box">
          <cfif len(qryCommunity.topLeftImage)>
            <div style="background: url('/images/communities/#qryCommunity.topLeftImage#') no-repeat"></div>
          <cfelse>
            <div style="background: url('/<cfoutput>#settings.mls.dir#</cfoutput>/images/community-text-left-img.jpg') no-repeat"></div>
          </cfif>      
        </div>
        <div class="community-img-box-right community-img-box">
          <cfif len(qryCommunity.topRightImage)>
            <div style="background: url('/images/communities/#qryCommunity.topRightImage#') no-repeat"></div>
          <cfelse>
            <div style="background: url('/<cfoutput>#settings.mls.dir#</cfoutput>/images/community-text-right-img.jpg') no-repeat"></div>
          </cfif>
        </div>
      </div><!-- END community-img-wrap -->
   <cfelse>

      
      <cfif len(qryCommunity.topText)>
        <!--- <h1>#variables.h1#</h1> --->
        <p>#qryCommunity.topText#</p>
      </cfif>

  </cfif>

  <cfif len(qryCommunity.bottomLeftImage) and (len(qryCommunity.bottomRightVideo) or len(qryCommunity.bottomRightImage))>
    <div class="community-video-wrap">
      <div class="community-video-box-left community-video-box">
        <cfif len(qryCommunity.bottomLeftImage)>
          <div style="background: url('/images/communities/#qryCommunity.bottomLeftImage#') no-repeat"></div>
        <cfelse>
          <div style="background: url('/<cfoutput>#settings.mls.dir#</cfoutput>/images/community-vid-left-img.jpg') no-repeat"></div>
        </cfif>
      </div>
      <div class="community-video-box-right community-video-box">
        <cfif len(qryCommunity.bottomRightVideo)>
          <div id="videoOverlay" class="video-overlay"><a id="videoPlayBtn" class="video-play-btn" href="javascript:;"><i class="fa fa-play-circle-o" aria-hidden="true"></i></a></div>
          <a id="videoPauseBtn" class="video-pause-btn" href="javascript:;"><i class="fa fa-pause-circle-o" aria-hidden="true"></i></a>
          
          <video autoplay="false" muted poster="" id="bgvid" class="bg-vid">
            <source src="/images/videos/cbsloane-home.webm" type="video/webm">
          	<source src="/images/videos/cbsloane-home.mp4" type="video/mp4">
          </video>
        <cfelse>
          <div style="background: url('/images/communities/#qryCommunity.bottomRightImage#') no-repeat"></div>
        </cfif>
      </div>
    </div><!-- END community-video-wrap -->
  </cfif>
  </div><!-- END community-list-results -->
</cfoutput>