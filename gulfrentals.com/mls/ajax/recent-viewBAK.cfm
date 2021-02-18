<cf_htmlfoot>
<script>
	$(document).ready(function(){
		$(".closeButton").click(function() {
			$(".brecentlist").hide();
		});
	});
</script>
<cf_htmlfoot>
<div class="closeButton glyphicon glyphicon-remove-circle pull-right"></div>

<cfif ListLen(cookie.mlsrecent)>
	<ul class="brvlist bflist">
		<cfloop list="#cookie.mlsrecent#" index="i">

		<!--- Now I need to get some basic info about the properties in the recent --->
		<cfquery name="getFavInfo" dataSource="#settings.mls.propertydsn#">
		select mlsnumber,street_name, street_number, unit_number, photo_link, city, zip_code, mlsid,wsid, list_price
		from mastertable where mlsnumber = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#i#">
		</cfquery>

		<cfoutput query="getFavInfo">
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
		<li id="#i#">
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
						<div class="btn-group"><a data-seopropertyname="" data-mlsnumber="#i#" href="javascript:;" class="btn btn-xs btn-danger remove-from-favs"><span class="glyphicon glyphicon-heart-empty"></span> Unfavorite</a></div>
					</div>
				</div>
			</div>
		</li>
		</cfoutput>

		</cfloop>
	</ul>
<cfelse>
	You do not have any recent saved at this time.
<cf_htmlfoot>
	<script type="text/javascript">
		$('.well.brecentlist').delay(1500).fadeOut(2000);
	</script>
</cf_htmlfoot>
</cfif>