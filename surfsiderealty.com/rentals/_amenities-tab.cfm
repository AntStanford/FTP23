<cfset qryAmenities = application.bookingObject.getPropertyAmenities(property.propertyid)>

<div id="amenities" name="amenities" class="info-wrap amenities-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> Amenities</div>
  <div class="info-wrap-body">
		<cfoutput query="qryAmenities" group="category">
    	<h3 class="site-color-1">#ReplaceNoCase(qryAmenities.category,'BedInfo','Bed Info')#</h3>
    	<ul class="amenities-list">
      	<cfoutput>
	    	  <li>#qryAmenities.categoryvalue#</li>
      	</cfoutput>
    	</ul>
		</cfoutput>
  </div><!-- END info-wrap-body -->
</div><!-- END amenities-wrap -->