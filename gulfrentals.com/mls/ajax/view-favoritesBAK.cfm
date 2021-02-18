<script>
	$(document).ready(function(){
		$(".closeButton").click(function() {
			$(".bfavoriteslist").hide();
		});
	});
</script>
<div class="closeButton glyphicon glyphicon-remove-circle pull-right"></div>

   <cfif isDefined("cookie.loggedIn")>
      <cfset clientid = cookie.loggedIn>
   <cfelse>
      <Cfset clientid = 0>
   </cfif>

   <!--- Init Session Variables --->
   <cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
   <cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER"><!--- just to make sure the cookie favorite list is up to date --->


   <cfset qFavoriteProperties = application.oMLS.getFavoriteProperties(strFavorites, settings.mls.mlsid)>

   <cfif qFavoriteProperties.recordcount gt 0>
	<a href="/mls/compare-favorites.cfm" class="btn btn-info btn-block"><span class="glyphicon glyphicon-home"></span> Compare Favs</a>
   <ul class="bflist">
		<cfoutput query="qFavoriteProperties">
          <cfif settings.mls.getmlscoinfo.imageurl eq "">
            <cfset mapPhoto = application.oMLS.firstPhoto(photo_link)>
         <cfelse>
            <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & application.oMLS.firstPhoto(photo_link)>
         </cfif>


         <cfif listlen(photo_link) gte 1><cfset map_photo = listgetat(photo_link,1)></cfif>
         <cfset detailPage = application.oHelpers.optimizeMyURL(street_number,
                                        street_name,
                                        city,
                                        zip_code,
                                        mlsnumber,
                                        mlsid,
                                        wsid)>
		<li id="#mlsnumber#">
			<div class="row">
				<div class="col-md-4">
					<cfif len(mapPhoto)>
					<a href="#detailpage#"><img src="#mapPhoto#" class="img-thumbnail img-responsive img-rounded" style="width:115px"></a>
					<cfelse>
					<a href="#detailpage#"><img src="http://placehold.it/150x100&text=No Image" class="img-thumbnail img-responsive img-rounded"></a>
					</cfif>
				</div>
				<div class="col-md-8">
					<h3 class="panel-title"><a href="#detailpage#">#street_number# #Street_Name#</a></h3>
					<p class="lead">$#NumberFormat(list_price)#</p>
					<div class="btn-group btn-group-justified bractions">
						<div class="btn-group"><a href="#detailpage#" class="btn btn-xs btn-info"><span class="glyphicon glyphicon-list"></span> Details</a></div>
						<div class="btn-group"><a data-seopropertyname="" data-mlsnumber="#mlsnumber#" href="javascript:;" class="btn btn-xs btn-danger remove-from-favs"><span class="glyphicon glyphicon-heart-empty"></span> Unfavorite</a></div>
					</div>
				</div>
			</div>
		</li>
		</cfoutput>
	</ul>
   <cfelse>
      You do not have any favorites saved at this time.
      <script type="text/javascript">
         $('.well.bfavoriteslist').delay(1500).fadeOut(2000);
      </script>
   </cfif>
