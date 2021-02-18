<cfoutput>
<div class="property-overview">
  <h1 class="property-name">#property.name#</h1>
  <!---<div class="price-range">#priceRange#</div>  --->
  <cfif getAvgRating.recordcount gt 0 and getAvgRating.average neq ''>
	  <div class="star-rating">
	    <cfif ceiling(getAvgRating.average) eq 1>
	    	<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	    <cfelseif ceiling(getAvgRating.average) eq 2>
	    	<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	    <cfelseif ceiling(getAvgRating.average) eq 3>
	    	<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	    <cfelseif ceiling(getAvgRating.average) eq 4>
	    	<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	    <cfelseif ceiling(getAvgRating.average) eq 5>
	    	<i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i>
	    </cfif>
	    Average Rating
	  </div>
  </cfif>
  <hr>
  <div class="property-info">
    <cfif len(property.address)><span class="property-info-item"><strong>Address:</strong> #property.address#</span></cfif>
    <cfif len(property.location)><span class="property-info-item"><strong>Location:</strong> #property.location#</span></cfif>
    <cfif len(property.type)><span class="property-info-item"><strong>Type:</strong> #property.type#</span></cfif>
    <cfif len(property.view)><span class="property-info-item"><strong>View:</strong> #property.view#</span></cfif>
    <!---<cfif len(property.turnday)><span class="property-info-item"><strong>Turn Day:</strong> #property.turnday#</span></cfif>
    <cfif len(property.neighborhood)><span class="property-info-item"><strong>Neighborhood:</strong> #property.neighborhood#</span></cfif>--->
  </div><!-- END property-info -->  
  <div class="property-info property-info-icons">
    <span class="property-info-item info-icon"><i class="fa fa-bed" aria-hidden="true"></i> #property.bedrooms# Bedrooms <!--- (2K, 3Q, 4T) ---></span>
    <span class="property-info-item info-icon"><i class="fa fa-bath" aria-hidden="true"></i> #property.bathrooms# Baths <cfif property.half_bathrooms gt 0>& #property.half_bathrooms# Half BA</cfif></span>
    <span class="property-info-item info-icon"><i class="fa fa-users" aria-hidden="true"></i> Sleeps #property.sleeps#</span>
    <!---<span class="property-info-item info-icon"><i class="fa fa-paw" aria-hidden="true"></i> #property.petsallowed#</span>--->
  </div><!-- END property-info -->  
  <div class="amenities-icons property-info">
    <!---<cfif property.has_hottub><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/hottub.png" alt="Hot Tub" title="Hot Tub"></span></cfif>
    <cfif property.has_pool><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/pool.png" alt="Pool" title="Pool"></span></cfif>
    <cfif property.has_elevator><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/elevator.png" alt="Elevator" title="Elevator"></span></cfif>
    <cfif property.petsallowed eq "pets allowed"><span><img src="/<cfoutput>#settings.booking.dir#</cfoutput>/images/icons/pets.png" alt="Pets" title="Pets"></span></cfif>--->
  </div>
</div><!-- END property-overview -->
</cfoutput>
