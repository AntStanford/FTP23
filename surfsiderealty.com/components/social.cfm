<cfoutput>
  <cfset social="facebookURL,twitterURL,pinterestURL,youtubeURL,linkedinURL,instagramURL,googlePlusURL,yelpURL,blogURL,flickrURL">
  <ul class="i-social">
    <cfloop list="#social#" index="i">
      <cfif len(settings[i])>
        <li class="i-social-item">
          <a class="i-social-link-#i#" href="#settings[i]#" target="_blank">
            <i class="fa fa-<cfif i eq "googlePlusURL">google-plus<cfelseif i eq "blogURL">rss<cfelse>#replace(i,'URL','')#</cfif>"></i>
            <span class="i-social-link-text">#replace(i,'URL','')#</span>
          </a>
        </li>
      </cfif>
    </cfloop>
  </ul>
</cfoutput>