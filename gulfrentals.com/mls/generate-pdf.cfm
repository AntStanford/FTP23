<cfset randomString = application.oHelpers.createPIN(15)>

<cfset path = expandPath("/mls/compare-favs-pdfs/#settings.id#/")>
<cfif directoryExists(path) eq false>
   <cfdirectory action="create" directory="#path#">
</cfif>
<cfset filename = '#path#/#randomString#.pdf'>

<cfif isDefined("cookie.loggedIn")>
   <cfset clientid = cookie.loggedIn>
<cfelse>
   <Cfset clientid = 0>
</cfif>

<!--- Init Session Variables --->
<cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
<cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER"><!--- just to make sure the cookie favorite list is up to date --->
<cfset qResults = application.oMLS.getFavoriteProperties(strFavorites, settings.mls.mlsid)>


<cfdocument filename="#filename#" format="PDF" overwrite="true">

<style>
	.compare {font-family: arial;}
	.compare .compare-head {width: 100%;}
	.compare .compare-head .logo {display: block; width: 200px;}
	.compare .compare-head p {text-align: right;}
	.compare .compare-head p span {font-size: 16pt; line-height: 16pt;}
	.compare p {font-size: 10pt; line-height: 12pt;}
	.compare .compare-info {width: 200px; height: 100%; height: 400px;}
	.compare .compare-info .empty.compare-pic {height: 147px}
	.compare .jcarousel-wrapper {width: 700px;}
	.compare .jcarousel-wrapper .favsLoop li {width: 150px; /*height: 50%; */margin: 35px 5px; float: left; list-style: none; /*display: inline-block; */list-style-type: none; }
	.compare .jcarousel-wrapper .favsLoop li img {width: 100%;}
	.compare .jcarousel-wrapper .favsLoop li p {/*font-size: 10pt*/}
	/*.compare-details-container {min-height: 490px !important;}*/
	.compare-details-container .compare-details p, .compare-info p {height: 35px;}
	.compare-info p {text-align: right;}
</style>

<div class="compare container">

	<table class="compare-head">
		<tr>
			<td width="200"><img src="/images/layout/logo.png" class="logo" alt=""></td>
			<td width="400"></td>
			<td valign="top" width="300">
			   <cfoutput>
				<p><span>#settings.company#</span><br>
				#settings.address#<br>
            #settings.city#, #settings.state# #settings.zip#</p>
				<p>#settings.tollfree#</p>
				</cfoutput>
			</td>
		</tr>
	</table>

	<div class="panel panel-default">
	  <div class="panel-heading">
			<div class="pull-left">
	  		<h1>Compare Your Favorites.</h1>
			</div>
			<div style="clear:both;"></div>
	  </div>
	  <div class="panel-body">

		  <!--- THE PICS --->
		  <div class="row">
		    <table>
		    	<tr>
		    		<td valign="top" class="compare-info">

					    <cfif StructKeyExists(cookie,'mlsfavorites') and ListLen(cookie.mlsfavorites)>

							<div class="empty compare-pic">
								<h4 id="favTotal"><cfoutput>#ListLen(cookie.mlsfavorites)#</cfoutput> Properties Total</h4>
							</div>
							<p><strong>Address</strong></p>
						<p><strong>City, State, Zip</strong></p>
							<p><strong>Type</strong></p>
				    <p><strong>Bedrooms</strong></p>
				    <p><strong>Bathrooms</strong></p>
				    <p><strong>Sq. Feet</strong></p>
				    <p class="heating"><strong>Heating</strong></p>
				    <p><strong>Cooling</strong></p>
				    <p><strong>Price</strong></p>

				    </td>
						<td valign="top" class="jcarousel-wrapper">
							<ul class="favsLoop">

							    <!--- <cfoutput query="qResults">
                        <cfset ThePhoto = settings.mls.getmlscoinfo.imageurl & '/' & application.oMLS.firstPhoto(photo_link)>
	                     <cfset detailPage = application.oHelpers.optimizeMyURL(qResults.street_number,
                                        qResults.street_name,
                                        qResults.city,
                                        qResults.zip_code,
                                        qResults.mlsnumber,
                                        qResults.mlsid,
                                        qResults.wsid)> --->
                                         <cfoutput query="qResults">
	                <cfif settings.mls.getmlscoinfo.imageurl eq "">
	                  <cfset ThePhoto = application.oMLS.firstPhoto(photo_link)>
	                <cfelse>
	                  <cfset ThePhoto = settings.mls.getmlscoinfo.imageurl & '/' & application.oMLS.firstPhoto(photo_link)>
	                </cfif>
	                <cfset detailPage = application.oHelpers.optimizeMyURL(qResults.street_number,
                    qResults.street_name,
                    qResults.city,
                    qResults.zip_code,
                    qResults.mlsnumber,
                    qResults.mlsid,
                    qResults.wsid)>

	   							<li id="#currentrow#" class="compare-details-container">
									<div class="compare-details">
										<div class="compare-pic">
											<a href="#detailPage#"><img src="#thephoto#"></a>
										</div>
										<!--- <div class="btn-group">
											<a href="#detailPage#" class="btn btn-success"> Details</a>
											<a data-counter="#currentrow#" data-propertyid="#mlsnumber#" href="javascript:;" class="btn btn-danger cfavorites" id="removeFromFavs">Remove Favorite</a>
										</div> --->
										<p>#street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif></p>
											<p>#city#, #state# #zip_code#</p>
											<cfif subdivision is not "" and subdivision is not "none" and subdivision is not "NOT WITHIN A SUBDIVISION"><p>#subdivision#</p><cfelse></cfif>
	                    <cfif kind neq ''><p>#kind#</p><cfelse><p>-</p></cfif>
											<p>#bedrooms# Bed(s)</p>
											<p>#baths_full# Bath(s)</p>
											<p>Sq. Feet</p>
											<p class="heating"><cfif Heating neq ''>#Heating#<cfelse>-</cfif></p>
											<p><cfif Cooling neq ''>#Cooling#<cfelse>-</cfif></p>
											<p>#NumberFormat(list_price)#</p>
									</div>
								</li>
	   							</cfoutput>



							</ul>
						</td>

					</tr>
				</table>

			  <cfelse>
			      <p style="padding:20px">You have no favorites saved at this time.</p>
			  </cfif>

		  </div>


  	</div><!-- END panel-body -->
	</div>


</div><!-- END compare -->


</cfdocument>

<cflocation addToken="no" url="/mls/compare-favs-pdfs/#settings.id#/#randomString#.pdf">
