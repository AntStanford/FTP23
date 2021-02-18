<!DOCTYPE html>
<cfinclude template="property_.cfm">
	<cfloop query="property">
      <cfif settings.mls.getmlscoinfo.imageurl eq "">
         <cfset ThePhoto = application.oMLS.firstPhoto(photo_link)>
      <cfelse>
         <cfset ThePhoto = settings.mls.getmlscoinfo.imageurl & '/' & application.oMLS.firstPhoto(photo_link)>
      </cfif>

	   <cfset detailPage = application.oHelpers.optimizeMyURL(property.street_number,
                                        property.street_name,
                                        property.city,
                                        property.zip_code,
                                        property.mlsnumber,
                                        property.mlsid,
                                        property.wsid)>


<html>
	<head>
		<title><cfoutput>#settings.company#</cfoutput></title>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

		<script type="text/javascript" defer="defer">
    $(document).ready(function(){
			setTimeout(printWindow, 2000);
			function printWindow(){
				window.print();
			}
		});
		</script>
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	</head>
	<body>
		<cfinclude template="property_.cfm">
		<cfinclude template="components/m-header.cfm">
		<div class="wrapper">
			<div class="mls booking container bdetails">
				<cfoutput>
				<div class="row">
					<div class="col-md-6">
						<img align="left" style="margin-bottom: 15px;" src="/images/layout/logo.png">
					</div>
					<div class="col-md-6">
						<div class="pull-right"><cfoutput>#settings.tollFree#</cfoutput></div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h2 style="color:fff;"><cfif AddressDisplayYN is not "N">#street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif></cfif> <!--- <span class="lead pull-right"><cfoutput>#getPriceRange(property.unitcode)#</cfoutput></span> ---></h2>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-6 col-sm-6 col-xs-6 address">
										<address>
					            <b>MLS##:</b> #mlsnumber#<br>
					            <b>Address:</b><cfif AddressDisplayYN is not "N"> #street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif><cfelse>N/A</cfif><br />
					            <b>City / Zip:</b>#city#, #state# #zip_code#<br />
					            <cfif property_type is not ""> <b>Type:</b> #property_type# <cfif kind is not ""> / #kind#</cfif><br /></cfif>
					          </address>
									</div>
									<div class="col-md-2 col-sm-2 col-xs-2 bbk">
									  <cfif property.Total_Heated_Square_Feet neq '' and property.Total_Heated_Square_Feet neq '0'>
			                <div class="alert alert-info text-center"><h2>#property.Total_Heated_Square_Feet#</h2>Approx. Sq. Feet</div>
			              <cfelse>
			                <cfif property.acreage neq ''><div class="alert alert-info text-center"><h2>#property.acreage#</h2>Acreage</div></cfif>
			              </cfif>
									</div>
									<div class="col-md-2 col-sm-2 col-xs-2 bbk">
										<div class="alert alert-info text-center">
					            <cfswitch expression="#property.wsid#">
					               <cfcase value="1"><h2>#property.bedrooms#</h2>Bedrooms</cfcase>
					               <cfcase value="2"><h2>#property.Lot_Description#</h2>Lot Description</cfcase>
					               <cfcase value="3"><h2><cfif property.acreage neq ''>#property.acreage#<cfelse> N/A </cfif></h2>Acreage</cfcase>
					               <cfcase value="4"></cfcase>
					               <cfcase value="5"><h2><cfif property.bedrooms neq ''>#property.bedrooms#<cfelse>N/A</cfif></h2>Bedrooms</cfcase>
					               <cfcase value="6"><h2><cfif property.bedrooms neq ''>#property.bedrooms#<cfelse>N/A</cfif></h2>Bedrooms</cfcase>
					            </cfswitch>
					          </div>
									</div>
									<div class="col-md-2 col-sm-2 col-xs-2 bbk">
										<div class="alert alert-info text-center">
					            <cfswitch expression="#property.wsid#">
					               <cfcase value="1"><h2>#property.baths_full#</h2>Baths</cfcase>
					               <cfcase value="2"><h2>#getareas.city#</h2>Area</cfcase>
					               <cfcase value="3"><h2>#getareas.city#</h2>Area</cfcase>
					               <cfcase value="4"></cfcase>
					               <cfcase value="5"><h2>#property.baths_full#</h2>Baths</cfcase>
					               <cfcase value="6"><h2>#getareas.city#</h2>Area</cfcase>
					            </cfswitch>
					          </div>
									</div>
								</div>
							</div>
						</div><!-- END panel -->
					</div>
				</div>
				</cfoutput>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3>Overview</h3>
							</div>
							<div class="panel-body">
								<cfoutput>
									<!--- <img src="#settings.booking.imagepath#/#property.mapPhoto#"> --->
									<div class="img-responsive <cfif status eq '6'> sold</cfif>"><img src="<cfif thephoto is not ''>#thephoto#<cfelse>http://placehold.it/350x150</cfif>" class="img-thumbnail img-rounded"></div>
									<div class="description">
							   	  <div class="page-header">
							      	<h3>About</h3>
						      	  <address>
							          <li><b>Area:</b> #getareas.city#</li>
					              <cfif property.county is not ""><li><b>County:</b> #property.county#</li></cfif>
					              <cfif property.subdivision is not ""><li><b>Neighborhood:</b> #property.subdivision#</li></cfif>
					              <cfif property.bedrooms is not ""><li><b>Bedrooms:</b> #property.bedrooms#</li></cfif>
					              <cfif property.baths_full is not ""><li><b>Bathrooms:</b> #property.baths_full#</li></cfif>
					              <cfif property.baths_half is not ""><li><b>1/2 Bathrooms:</b> #property.baths_half#</li></cfif>
					              <cfif property.total_heated_square_feet is not ""><li><b>Sq Ft:</b> #trim(property.total_heated_square_feet)#</li></cfif>
					              <cfif property.building_square_feet is not ""><li><b>Sq Ft:</b> #trim(numberformat(property.building_square_feet,'__,___,___'))#</li></cfif>
					              <cfif property.ACREAGE is not ""><li><b>Acres:</b> #property.ACREAGE#</li></cfif>
					              <cfif property.stories is not "0" and property.stories is not ""><li><b>Stories:</b> #property.stories#</li></cfif>
					              <cfif property.year_built is not "0" and property.year_built is not ""><li><b>Year Built:</b> #property.year_built#</li></cfif>
					              <cfif property.estimated_lot_size is not "0" and property.estimated_lot_size is not ""><li><b>Estimated Lot Size:</b> #property.estimated_lot_size#</li></cfif>
					              <cfif property.zoning is not ""><li><b>Zoning:</b> #property.zoning#</li></cfif>
					              <li><b>Date Listed:</b> #dateformat(GetDatelisted.created_at,'mm/dd/yyyy')#</li>
					              <cfif property.association_fee is not ""><li><b>POA Fees:</b> #property.association_fee#</li></cfif>
					              <cfif property.property_type is not ""><li><b>Type:</b> #property.property_type# <cfif property.kind is not "">
					          			/ #property.kind# </cfif></li></cfif>

					              <cfif property.water is not ""><li><b>Water:</b> #property.water# </li></cfif>
					              <cfif property.sewer is not ""><li><b>Sewer:</b> #property.sewer# </li></cfif>
						      	  </address>
							      </div>

							      <cfset newString = replace(property.remarks,'#Chr(10)#','<br />','all')>
										<cfset newString = replace(newString,'<br /><br />','<br />','all')>
										<cfset newString = replace(newString,'?s','&apos;s','all')>
										<cfset newString = replace(newstring,'#Chr(63)#','#Chr(39)#','all')>
										<p>#newString#</p>
							    </div>
								</cfoutput>
							</div><!--END panel body-->
						</div><!-- END panel -->
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default booking-box">
							<!---
<div class="panel-heading">
								<h3 class="text-center">Amenities</h3>
							</div>
--->
						<!--- 	<div class="panel-body"> --->
								<cfinclude template="_amenities.cfm">
						<!--- 	</div> ---><!-- END panel body -->
						</div><!-- END panel booking-box -->
					</div>
				</div>
				<!---
				<div class="row">
					<div class="col-md-12">
						<cfinclude template="_calendar-tab.cfm">
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<cfinclude template="_map-tab.cfm">
					</div>
				</div>
				--->
				<!---
<div class="row">
					<div class="col-md-12">
						<cfinclude template="_rates-tab.cfm">
					</div>
				</div>
--->
				<!---
<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3>Recent Reviews About This Property</h3>
							</div>
							<div class="panel-body">
								<cfquery name="getReviewsFromWebsite" dataSource="#settings.bcdsn#">
									select *
									from be_reviews
									where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.unitcode#">
									and approved = 'Yes'
									order by createdAt desc
								</cfquery>

								<cfquery name="getEscapiaReviews" dataSource="#settings.dsn#">
									select title,review,reviewername,reviewercity,reviewdate
									from escapia_reviews where propertymanagerrejected = 'false' and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.unitcode#">
									order by reviewdate
								</cfquery>

								<cfif getReviewsFromWebsite.recordcount gt 0 OR getEscapiaReviews.recordcount gt 0>

									<cfoutput query="getReviewsFromWebsite">
										<blockquote>
											<h3>#title#</h3>
											<p>"#review#"</p>
											<footer>
												#firstname# #Left(lastname,1)#. from #hometown#, #DateFormat(createdAt,'mm/dd/yyyy')#
											</footer>
										</blockquote>
									</cfoutput>

									<cfoutput query="getEscapiaReviews">
										<blockquote>
											<h3>#title#</h3>
											<p>"#review#"</p>
											<footer>#reviewername# from #reviewercity#, #DateFormat(reviewdate,'mm/dd/yyyy')#</footer>
										</blockquote>
									</cfoutput>

								<cfelse>

									<p>No reviews found.</p>

								</cfif>
							</div>
						</div>
---><!-- END panel -->
				<!--- 	</div> --->
				</div>

			</div><!-- END booking container bdetails -->
		</div><!-- END wrapper -->
	</body>
</html>
</cfloop>