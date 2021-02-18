<span class="header-dropbox-close"><i class="fa fa-close"></i></span>
<span class="header-dropbox-title">
  Favorites
  <cfif ListLen(cookie.mlsfavorites)>
    <a href="/mls/compare-favs.cfm" class="btn btn-mini site-color-1-bg site-color-1-lighten-bg-hover text-white text-white-hover pull-right compare-favs-btn">Compare Favs</a>
  </cfif>
</span>

<cfif isDefined("cookie.loggedIn")>
  <cfset clientid = cookie.loggedIn>
<cfelse>
  <cfset clientid = 0>
</cfif>

<!--- Init Session Variables --->
<cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
<cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER"><!--- just to make sure the cookie favorite list is up to date --->

<cfset qFavoriteProperties = application.oMLS.getFavoriteProperties(strFavorites, settings.mls.mlsid)>

<cfif qFavoriteProperties.recordcount gt 0>

  <ul class="header-dropbox-list">
    <cfoutput query="qFavoriteProperties">

      <cfset thisProp = application.oMLS.getListing(mlsid,mlsnumber,wsid,'photo_link') />
      <cfif settings.mls.getmlscoinfo.imageurl eq "">
        <cfset mapPhoto = application.oMLS.firstPhoto(thisProp.photo_link)>
      <cfelse>
        <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & wsid & '/' & application.oMLS.firstPhoto(thisProp.photo_link)>
      </cfif>

      <li class="header-dropbox-list-item" data-unitcode="#mlsnumber#" id="#mlsnumber#" data-wsid="#qFavoriteProperties.wsid#" data-mlsid="#qFavoriteProperties.mlsid#">
        <a href="/mls/#thisprop.proplink#" class="header-dropbox-list-link site-color-1" target="_blank">
          <div class="row">
            <div class="col-lg-5 col-md-4 col-sm-5 col-xs-12">
              <span class="header-dropbox-list-img" style="background:url('#mapPhoto#');"></span>
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
        <button type="button" class="btn btn-mini site-color-1-bg site-color-1-lighten-bg-hover text-white is-favorited remove-from-favs-list">Remove</button>
      </li>
		</cfoutput>
  </ul>

<cfelse>

	<div class="alert alert-danger" style="margin:0;">
  	You do not have any favorites saved at this time.
	</div>

</cfif>