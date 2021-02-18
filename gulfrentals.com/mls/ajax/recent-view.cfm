<span class="header-dropbox-close"><i class="fa fa-close"></i></span>
<span class="header-dropbox-title">Recently Viewed</span>

<cfif isdefined('cookie.mlsrecent') and ListLen(cookie.mlsrecent)>
  <ul class="header-dropbox-list">
  	<cfloop list="#cookie.mlsrecent#" index="i">

  		<cfset thisProp = application.oMLS.getListing(settings.mls.mlsid, i, '') />  		

        <cfif settings.mls.getmlscoinfo.imageurl eq "">
          <cfset mapPhoto = application.oMLS.firstPhoto(thisProp.photo_link)>
        <cfelse>
          <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & thisProp.wsid & '/' & application.oMLS.firstPhoto(thisProp.photo_link)>
        </cfif>

      	<cfoutput query="thisProp">
    		<li class="header-dropbox-list-item" data-unitcode="#mlsnumber#" id="#mlsnumber#" data-wsid="#session.mls.qResults.query.wsid#" data-mlsid="#session.mls.qResults.query.mlsid#">
          <a href="/mls/#thisprop.proplink#" class="header-dropbox-list-link site-color-1" target="_blank">
            <div class="row">
              <div class="col-lg-5 col-md-4 col-sm-5 col-xs-12">
                <cfif len(mapPhoto)>
                  <span class="header-dropbox-list-img" style="background:url('#mapPhoto#');"></span>
                <cfelse>
                  <span class="header-dropbox-list-img" style="background:url('https://placehold.it/150x100&text=No Image');"></span>
                </cfif>
              </div>
              <div class="col-lg-7 col-md-8 col-sm-7 col-xs-12">
                <span class="header-dropbox-list-title">
                  <strong>#street_number# #Street_Name#</strong>
                  <em>MLS##: #mlsnumber#</em>
                </span>
                <span class="header-dropbox-list-price">
                	$#NumberFormat(list_price)#
                </span>
            </div>
          </div>
        </a>
       <!---  <button type="button" class="btn btn-mini site-color-1-bg site-color-1-lighten-bg-hover text-white is-favorited remove-from-favs-list">Remove</button> --->
      </li>
    	</cfoutput>
  	</cfloop>
  </ul>

<cfelse>

	<div class="alert alert-danger" style="margin:0;">
  	You have not recently viewed any properties.
	</div>

</cfif>