<cfif cgi.script_name neq "/#settings.mls.dir#/my-profile.cfm">
  <!--- HIDE THE HEADER IN THE MY PROFILE PAGE --->
  <cfinclude template="/#settings.mls.dir#/components/header.cfm">
</cfif>

<cfif isDefined("cookie.loggedIn")>
  <cfset clientid = cookie.loggedIn>
<cfelse>
  <cfset clientid = 0>
</cfif>

<cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
<cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER"><!--- just to make sure the cookie favorite list is up to date --->
<cfset qFavoriteProperties = application.oMLS.getFavoriteProperties(strFavorites, settings.mls.mlsid)>

<div class="compare-wrap">

  <div class="container">
		<cfif StructKeyExists(cookie,'mlsfavorites') and ListLen(cookie.mlsfavorites)>
      <cfif cgi.script_name eq "/#settings.mls.dir#/my-profile.cfm">
        <div class="h2 pull-left">My Favorites <em id="favTotal"><cfoutput>#ListLen(cookie.mlsfavorites)#</cfoutput></em> Favorites</div>
      <cfelse>
        <h1 class="pull-left">Compare Your <em id="favTotal"><cfoutput>#ListLen(cookie.mlsfavorites)#</cfoutput></em> Favorites</h1>
      </cfif>

      <cfif cgi.script_name neq "/#settings.mls.dir#/my-profile.cfm">
      <!--- HIDE THE BUTTON IN THE MY PROFILE PAGE --->
        <cfif cgi.HTTP_REFERER neq ''>
  				<a href="<cfoutput>#cgi.HTTP_REFERER#</cfoutput>" class="btn back-btn pull-right site-color-4-bg site-color-4-lighten-bg-hover text-black" title="Back One Page"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back One Page</a>
  			</cfif>
      </cfif>

      <div class="owl-carousel-wrap">
    	  <div class="owl-carousel compare-carousel">
      	  <cfset counter = 1>

    			<!--- <cfloop list="#cookie.mlsfavorites#" index="i"> --->
          <cfoutput query="qFavoriteProperties">

            <cfset thisProp = application.oMLS.getListing(mlsid,mlsnumber,wsid) />

            <cfif settings.mls.getmlscoinfo.imageurl eq "">
              <cfset mapPhoto = application.oMLS.firstPhoto(thisProp.photo_link)>
            <cfelse>
              <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & thisProp.wsid & '/' & application.oMLS.firstPhoto(thisProp.photo_link)>
            </cfif>

            <cfset seoAddress = replace('#thisProp.street_number#-#thisProp.street_name#', ' ','-','all') />
            <cfset seoAddress = replace(seoAddress, "'","","all") />
            <cfset seoAddress = lcase(seoAddress) />

    				<!--- <cfoutput query="getFavPropertyForComparison"> --->

  	        <div class="compare-list-property" data-unitcode="#qFavoriteProperties.mlsnumber#" id="#qFavoriteProperties.mlsnumber#" data-seoname="#seoAddress#" data-unitshortname="#seoAddress#" data-photo="#mapPhoto#" data-straddress1="#street_number# #Street_Name#" data-dblbeds="#bedrooms#" data-intoccu="#bedrooms#" data-strlocation="#city#" data-wsid="#qFavoriteProperties.wsid#" data-mlsid="#qFavoriteProperties.mlsid#">
              <div class="compare-list-property-img-wrap">
                <!--- PROPERTY STATUS --->
                <!---
                <span class="property-status-wrap">
                  <cfswitch expression="#session.mls.qResults.query.status_name#">
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
                      <span class="property-status property-status-other">#session.mls.qResults.query.status_name#</span>
                    </cfdefaultcase>
                  </cfswitch>
                  <!--- <span class="property-status property-status-active">Active</span>
                  <span class="property-status property-status-pending">Pending</span>
                  <span class="property-status property-status-sold">Sold</span>
                  <span class="property-status property-status-other">Other</span> --->
                </span>
                --->
  	            <!--- FAVORITE HEART --->
                <a href="javascript:;" class="compare-list-property-favorite remove-from-favs" data-counter="#counter#">
                  <i class="fa fa-heart-o overlay" aria-hidden="true"></i>
                  <i class="fa fa-heart under<cfif ListFind(cookie.mlsfavorites,mlsnumber)> favorited</cfif>" aria-hidden="true"></i>
                </a>

  	            <!--- PROPERTY LINK --->
                <a href="#thisProp.proplink#" class="compare-list-property-link" target="_blank">
                  <span class="compare-list-property-title-wrap">
                    <span class="compare-list-property-title">
                      <h3><cfif wsid eq 2>Land<cfelseif wsid eq 3>Commercial Property<cfelse>House</cfif>  for Sale</h3>
      	            	<!--- PROPERTY TYPE --->
        	            <cfif AddressDisplayYN is not "N">
          	            <span class="results-list-property-info-type">#street_number# #street_name# <cfif LEN(unit_number) and application.oFields.showOnResults(86)>#application.oHelpers.FormatUnit(unit_number)#</cfif></span>
                      </cfif>
                    </span>
                  </span>
  	              <!--- PROPERTY IMAGE --->
                  <cfif mapPhoto is not ''>
  	                <span class="results-list-property-img" style="background:url('#mapPhoto#');"></span>
  	              <cfelse>
  	              	<span class="results-list-property-img" style="background:url('/#application.settings.mls.dir#/images/no-img.jpg');"></span>
  	              </cfif>
                </a>
              </div><!-- END compare-list-property-img-wrap -->

              <div class="compare-list-property-info-wrap">
  	            <!--- PROPERTY PRICE --->
  	            <span class="results-list-property-info-price">
                  $<cfif status eq 6 AND isdefined('soldprice') AND isValid('numeric',soldprice) AND soldprice gt 0>#NumberFormat(soldprice)#<cfelse>#NumberFormat(list_price)#</cfif>
  	            </span>

<!---
                <span class="compare-list-property-info-price">
                  $#NumberFormat(list_price)#
                </span>
--->
                <!--- PROPERTY INFO --->
                <ul class="compare-list-property-info">
                  <cfif mlsnumber is not "">
      	            <li><i class="fa fa-hashtag site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="MLS Number"></i> MLS##: #mlsnumber#</li>
                  </cfif>
                  <cfif wsid eq 1 or wsid eq 5>
                    <li><i class="fa fa-bed site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bedrooms"></i> #bedrooms# Beds</li>
                    <li><i class="fa fa-bath site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bathrooms"></i> #baths_full# Baths</li>
                  </cfif>
                  <cfif acreage is not "">
                    <li><i class="fa fa-leaf site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Acreage"></i> #acreage# Acres</li>
                  </cfif>
                  <cfif zoning is not "">
                    <li><i class="fa fa-home site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Zoning"></i> Zoning: #zoning#</li>
                  </cfif>
                  <cfif style is not "">
                    <li><i class="fa fa-paint-brush site-color-1" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Style"></i> Style: #style#</li>
                  </cfif>
                </ul><!-- END compare-list-property-info -->
              </div><!-- END compare-list-property-info-wrap -->
            </div><!-- END compare-list-property -->

            <cfset counter = counter + 1>
    				</cfoutput>
        </div><!-- END compare-carousel -->

        <div class="cssload-container">
          <div class="cssload-tube-tunnel"></div>
        </div>
      </div><!-- END owl-carousel-wrap -->

			<div class="btn-group">
  			<a href="#" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white staf-btn" title="Send to a Friend" data-toggle="modal" data-target="#sendtofriend"><i class="fa fa-share" aria-hidden="true"></i> Send to A Friend</a>
        <a href="compare-print.cfm" target="_blank" class="btn site-color-3-bg site-color-3-lighten-bg-hover text-white print-btn"><i class="fa fa-print" aria-hidden="true"></i> Print</a>
			</div>

  	<cfelse>

      <cfif cgi.script_name eq "/#settings.mls.dir#/my-profile.cfm">
        <div class="h2 pull-left">My Favorites - <em id="favTotal"><cfoutput>#ListLen(cookie.mlsfavorites)#</cfoutput></em> Favorites</div>
      <cfelse>
    	  <h1 class="pull-left site-color-1">Compare Your Favorites</h1>
      </cfif>
  	  <div class="h3 no-favs">You do not have any Favorites at this time!</div>

		</cfif>

  </div>
</div><!-- END compare-wrap -->

<cf_htmlfoot>
<div class="modal fade" id="sendtofriend" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Send to a Friend</h4>
			</div>
			<div class="modal-body">
				<style>label.error{color:red}</style>
				<div id="sendToFriendCompareMSG"></div>
				<form role="form" method="post" class="send-to-friend-form" id="sendToFriendCompare">
					<input type="hidden" name="sendToFriendCompare">
					<input type="hidden" name="camefrom" value="sendToFriendCompare">
					<cfinclude template="/cfformprotect/cffp.cfm">
					<p>Fill out the form below to send this property to a friend.</p>
					<fieldset>
  					<cfset counterforModal = 1>
  					<!--- <cfloop list="#cookie.favorites#" index="i"> --->
              <cfoutput query="qFavoriteProperties">

                <cfset thisProp = application.oMLS.getListing(mlsid,mlsnumber,wsid) />

                <cfif settings.mls.getmlscoinfo.imageurl eq "">
                  <cfset mapPhoto = application.oMLS.firstPhoto(thisProp.photo_link)>
                <cfelse>
                  <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & thisProp.wsid & '/' & application.oMLS.firstPhoto(thisProp.photo_link)>
                </cfif>

                <cfset seoAddress = replace('#qFavoriteProperties.street_number#-#qFavoriteProperties.street_name#', ' ','-','all') />
                <cfset seoAddress = replace(seoAddress, "'","","all") />
                <cfset seoAddress = lcase(seoAddress) />

  						<div class="property-info" id="#counterforModal#">
  							<label>#street_number# #Street_Name# - $#numberformat(list_price,',')#</label><br />
                  <cfif LEN(bedrooms) and bedrooms gt 0>#bedrooms# Bedrooms</cfif>
                  <cfif LEN(baths_full) and baths_full gt 0> | #baths_full# Full Baths</cfif>
                  <cfif LEN(baths_half) and baths_half gt 0> | #baths_half# Half Baths</cfif>
                <br /><br />
  							<div class="row">
    							<div class="col-lg-3 col-md-3 col-sm-3 col-xs-4">
    								<img src="#mapPhoto#" class="thumbnail propertyPic" width="100%">
    							</div>
    							<div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
      							<textarea name="comments_for_#counterforModal#" class="propertyNotes" placeholder="Add your comments here"></textarea>
    							</div>
  							</div>
  						</div>
                <cfset counterforModal = counterforModal + 1>
  						</cfoutput>

    					<div class="form-group">
    						<label>Your Email</label>
    						<input type="text" name="youremail" class="form-control required email">
    					</div>
    					<div class="form-group">
    						<label>Friend's Email</label>
    						<input type="text" name="friendsemail" class="form-control required email">
    					</div>
    					<div class="form-group">
      					<div id="sendtofriendcomparecaptcha"></div>
      					<div class="g-recaptcha-error"></div>
      				</div>
  					<input type="submit" name="submit" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" value="Submit">
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
</cf_htmlfoot>

<cfif cgi.script_name neq "/#settings.mls.dir#/my-profile.cfm">
  <!--- HIDE THE FOOTER IN THE MY PROFILE PAGE --->
  <cfinclude template="/#settings.mls.dir#/components/footer.cfm">
</cfif>