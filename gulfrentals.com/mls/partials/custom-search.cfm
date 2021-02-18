<!---  **************   query to pull custom search properties ********************* --->
<!--- the query should pull these fields and possibly others --->
<!--- Acreage, additional_information, Baths_full, baths_half, bedrooms, city, legal address, List_Price, photo_link, remarks, state,
street_address2, street_name, street_number, year_built, Zip_code, Zoning --->



<!--- change this query as required --->
<cfquery name="qProps" datasource="#DSNMLS#" result="qPropsResult">
    select Acreage, additional_information, Baths_full, baths_half, bedrooms, city,
    List_Price, photo_link, remarks, state, street_address2, street_name, street_number,
    year_built, Zip_code, Zoning, mastertable.mlsnumber, county, property_type, total_heated_square_feet, area, mastertable.mlsid, mastertable.wsid
    from mastertable
    Join property_dates
         where
            mastertable.MLSNumber =  property_dates.mlsnumber

            and  mastertable.mlsid =  property_dates.mlsid
            and  mastertable.wsid =  property_dates.wsid
    and mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#getSearches.mlsid#">
	and mastertable.Status != '6'

    <cfif pmax neq ''>
	   and mastertable.list_price <= #pmax#
	</cfif>
	<cfif pmin neq ''>
		and mastertable.list_price >= #pmin#
	</cfif>
	<cfif mcity neq ''>
		and mastertable.city = '#mcity#'
	</cfif>
	<cfif marea neq ''>
		and mastertable.area = '#marea#'
	</cfif>
	<cfif mBedsmin neq ''>
		and mastertable.bedrooms >= #mBedsmin#
	</cfif>
	<cfif mBedsmax neq ''>
		and mastertable.bedrooms <= #mBedsmax#
	</cfif>
	<cfif mBathsmin neq ''>
		and mastertable.Baths_full >= #mBathsmin#
	</cfif>
	<cfif mBathsmax neq ''>
		and mastertable.Baths_full <= #mBathsmax#
	</cfif>
    <cfif mPropertyType neq ''>
		and mastertable.property_type = '#mPropertyType#'
	</cfif>

   <cfif mPropertyType neq ''>
		and mastertable.property_type = '#mPropertyType#'
	</cfif>

   <cfif isDefined("mlsSearchData.showlistings") and mlsSearchData.showlistings eq "Company">
            and mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true"> )
         </cfif>

   <cfif isDefined("mlsSearchdata.subdivision") and mlsSearchdata.subdivision neq ''>
      and mastertable.subdivision = <cfqueryparam cfsqltype="cf_sql_varchar" value="#mlsSearchdata.subdivision#">
   </cfif>

    <cfif mSortby neq ''>
        ORDER BY #mSortby#
    </cfif>

   limit 20

<!--- add a parameter for date sold --->

</cfquery>

<!---<cfset session.mlssearch.status = 6>--->

<!--- the page should look a lot like the search results pages for vacation rentals --->
<cfoutput>
	<cfloop query="qProps">
		<cfset a = ListToArray(photo_link, ",", false, true)>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<span class="lead"> #street_number# #street_name#</span>
				<span class="lead pull-right">  #dollarformat(list_price)#</span>
			</h3>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<!---<div class="prop-map img-thumbnail img-responsive img-rounded">
						<div class="map"></div>
					</div>--->
					<div class="prop-image">
            <cfif arrayIsDefined(a, 1)>
            	<a href="/mls/property.cfm?mlsid=#mlsid#&wsid=#wsid#&mlsnumber=#mlsnumber#&from=/#slug#&nm=#page.name#" class="img-responsive">
            	<!--- <img src="#settings.booking.imagepath#/#getUnitInfo.mapPhoto#" class="img-thumbnail img-rounded"> --->
            	<img src="#a[1]#" class="img-thumbnail img-rounded"></a>
            	<cfelse>
            	<a href="javascript:;" class="img-responsive"><img src="/images/layout/placeholder.jpg" alt="placeholder" style="min-width: 100%" class="img-thumbnail"></a>
            </cfif>
          </div>
				</div>
				<div class="col-md-6">
					<ul class="list-group">
						<li class="list-group-item">
							<table class="table" style="margin:0">
								<tr><td colspan="2" class="quick-facts quick-facts-header" style="text-align:center;"><b>Property Highlights</b></td></tr>
								<tr>
									<td class="quick-facts">
										<!--- <cfif AddressDisplayYN is not "N"> --->
                       <!---
 <b>Address:</b>#street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif><br/>
                        </cfif>
                        <b>Subdivision</b><cfif subdivision is not "" and subdivision is not "none" and subdivision is not "NOT WITHIN A SUBDIVISION">#subdivision#,</cfif> #city#, #state# #zip_code#<br />
						            <cfif acreage is not ""><b>Acreage:</b>#acreage# Acres <br/></cfif>
						            <cfif zoning is not ""><b>Zoning:</b> #zoning# <br/></cfif>
						            <cfif kind is not ""><b>Kind:</b> #kind# <br/></cfif>
--->
										<b>MLS ##</b>: #mlsnumber#<br />
										<b>City/Zip:</b> #City# #zip_code#<br />
                                        <cfif total_heated_square_feet is not ""><b>Sq Ft:</b> #total_heated_square_feet#<br /></cfif>
										<!---<b>County:</b> #county#<br />
										<b>Zoning:</b> #zoning#<br />--->
										<b>Year Built:</b> #year_built#<br />
										<!---<b>POA Fees:</b>--->
									</td>
									<td>
										<b>Bedrooms:</b> #bedrooms#<br />
										<b>Bathrooms:</b> #baths_full#<br />
										<cfif acreage is not ""><b>Acreage:</b>#acreage# Acres <br/></cfif>
										<b>Property Type:</b> #property_type#<br />
										<!--- <b>Date Sold:</b> <br /> --->
										<!---<b>Neighborhood:</b> #area#<br />--->

									<!---
	<ul class="list-group bbs">
											<li class="list-group-item"><span class="badge"></span><b>Bedrooms</b></li>
											<li class="list-group-item"><span class="badge"></span><b>Bath</b></li>
										</ul>
--->

									</td>
								</tr>
								<tr>
									<td colspan="2" class="highlights">
									</td>
								</tr>
							</table>
						</li>

						<cfset trimmedRemarks = "">
                        <cfif len( trim( remarks ) ) gt 500>
                            <cfset trimmedRemarks = left( trim( remarks ), 500 ) & "...">
                        <cfelse>
                            <cfset trimmedRemarks = remarks>
                        </cfif>
						<li class="list-group-item brdescription">
							<b>Description:</b><br>
							<p>#trimmedRemarks#</p>
							<!--- <a href="" class="readMore">Read More</a> --->
						</li>
					</ul>
					<div class="btn-group btn-group-justified bractions">
						<div class="btn-group"><a href="/mls/property.cfm?mlsid=#mlsid#&wsid=#wsid#&mlsnumber=#mlsnumber#&from=/#slug#&nm=#page.name#" class="btn btn-info"><span class="glyphicon glyphicon-list"></span> Details</a></div>
						<!--- <div class="btn-group"><a href="javascript:;" class="btn btn-success prop-map-toggle"><span class="glyphicon glyphicon-map-marker"></span> Quick Map</a></div> --->
						<!--- <div class="btn-group"><a href="javascript:;" class="btn btn-danger add-to-fav-results "><span class="glyphicon glyphicon-heart-empty"></span> #application.oHelpers.isFavorite(mlsnumber,cookie.favorites)#</a></div> --->
					</div><!-- END bractions -->
				</div>

			</div>
		</div><!-- END npbot -->
	</div>

<!---
			<div>
				<img src="" style="width:25%;">
--->
		<!---
	</div>
			<div>Description:</div>
			<div><a href="##">View Property</a><a href="##">Request Info</a><a href="##">Favorite</a><a href="##">Send To Friend</a></div>
--->







	</cfloop>
</cfoutput>

<cfif cgi.remote_addr eq '68.80.62.233'>
<cfdump var="#qPropsResult#" label="qPropsResult">
<cfdump var="#getSearches#" label="getSearches">
</cfif>