<!DOCTYPE html>
<html lang="en">
	<head>
  	<cfoutput>
		<title>#settings.company#</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="/#settings.mls.dir#/stylesheets/styles.css" rel="stylesheet">
  	</cfoutput>
		<style>
  		.compare .logo {margin: 10px 0;}
      .compare .property-info { margin: 10px 0; font-size: 16px; line-height: 1.25; font-weight: 700; }
      .compare .h2 {margin: 0 0 10px;}
      .compare .compare-list [class^="col-"] {display: inline-block; vertical-align: top; float: none; margin: 0 -4px 25px 0;}
      .compare .compare-list .compare-pic {width: 100%; padding-bottom: 70%; position: relative; overflow: hidden; margin-bottom: 5px;}
      .compare .compare-list .compare-pic img {width: 100%; position: absolute; top: 0; right: 0; left: 0;}
      .compare .compare-list .compare-details p {margin-bottom: 0; font-size: 16px; line-height: 1.5;}
		</style>
	</head>
	<body>
    <cfif isDefined("cookie.loggedIn")>
       <cfset clientid = cookie.loggedIn>
    <cfelse>
       <Cfset clientid = 0>
    </cfif>

    <!--- Init Session Variables --->
    <cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
    <cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER"><!--- just to make sure the cookie favorite list is up to date --->
    <cfset qResults = application.oMLS.getFavoriteProperties(strFavorites, settings.mls.mlsid)>

		<div class="wrapper">
      <div class="compare container">
        <div class="row">
          <div class="col-xs-6">
            <img src="https://<cfoutput>#settings.website#</cfoutput>/mls/images/logo.png" class="logo" alt="">
          </div>
          <div class="col-xs-6">
            <cfoutput>
            <p class="property-info text-right"><span>#settings.company#</span><br>
            #settings.address#<br>
            #settings.city#, #settings.state# #settings.zip#<br>
            #settings.tollfree#</p>
            </cfoutput>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12">

          	<div class="panel panel-default">
          	  <div class="panel-body">
        	  		<div class="h2">Your Favorites - <span><cfoutput>#qResults.recordcount#</cfoutput> Properties Total</span></div>

                <cfif qResults.recordcount>
                  <div class="row compare-list">
                    <cfoutput query="qResults">

                      <cfif settings.mls.getmlscoinfo.imageurl eq "">
                        <cfset ThePhoto = application.oMLS.firstPhoto(photo_link)>
                      <cfelse>
                        <cfset ThePhoto = settings.mls.getmlscoinfo.imageurl & '/' & wsid & '/' & application.oMLS.firstPhoto(photo_link)>
                      </cfif>

	                    <div class="col-xs-4">
	                      <div class="compare-details">
	                        <div class="compare-pic"><img src="#ThePhoto#"></div>
	                        <p><strong>#qResults.street_number# #qResults.street_name# <cfif LEN(qResults.unit_number)>#application.oHelpers.FormatUnit(qResults.unit_number)#</cfif></strong></p>
	                        <p>#qResults.city#, #qResults.state# #qResults.zip_code#</p>
      	    							<p>$#NumberFormat(list_price)#</p>
      	    							<p>Bedrooms: #qResults.bedrooms#</p>
      	    							<p>Full Bathrooms: #qResults.baths_full#</p>
                          <p>Half Bathrooms: #qResults.baths_half#</p>
	                      </div>
	                    </div>
	                  </cfoutput>
                  </div><!-- END  -->
                </cfif>

            	</div><!-- END panel-body -->
          	</div><!-- END panel -->

          </div>
        </div>
      </div><!-- END compare -->

		</div><!-- END wrapper -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" type="text/javascript"></script>
		<script type="text/javascript" defer="defer">
    $(document).ready(function(){
			setTimeout(printWindow, 2000);
			function printWindow(){
        window.print();
      }
		});
		</script>
	</body>
</html>