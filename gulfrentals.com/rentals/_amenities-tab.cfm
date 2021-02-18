<cfset amenities = application.bookingObject.getPropertyAmenities(property.propertyid)>

<div id="amenities" name="amenities" class="info-wrap amenities-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> Amenities</div>
  <div class="info-wrap-body">
    <ul class="amenities-list">
      <!---<cfloop collection="#amenities#" item="amenity">    	--->
      	<cfoutput>    		  			
      		<cfloop query="#amenities#">
    			<!---<cfif settings.booking.pms eq 'Escapia' or settings.booking.pms eq 'Homeaway'>
	    			<li>
	    				<cftry>#upperFirst(amenity)#<cfcatch>#amenity#</cfcatch></cftry>
    					<cfif amenities[amenity] neq ''>- #amenities[amenity]#</cfif>
    				</li>
    			<cfelseif settings.booking.pms eq 'Barefoot'>
    				
    					<li>
    						<cftry>#upperFirst(amenity)#<cfcatch>#amenity#</cfcatch></cftry>
							<cfif amenities[amenity] neq '-1' and amenities[amenity] neq '' >- #amenities[amenity]#</cfif>
							<cfif amenities[amenity] eq '-1' >- Yes</cfif>
    					</li>
    				
				</cfif>    			--->
					<li>
						<cftry>#upperFirst(amenities.name)#<cfcatch>#amenities.name#</cfcatch></cftry>
						<cfif amenities.amenityvalue neq '-1' and amenities.amenityvalue neq '' >- #amenities.amenityvalue#</cfif>
						<cfif amenities.amenityvalue eq '-1' >- Yes</cfif>
					</li>
			</cfloop>
      	</cfoutput>
      <!---</cfloop>--->
    </ul>
  </div><!-- END info-wrap-body -->
</div><!-- END amenities-wrap -->
