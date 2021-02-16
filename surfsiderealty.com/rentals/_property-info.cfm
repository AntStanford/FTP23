<cfoutput>
<div class="property-overview">
  <h1 class="property-name site-color-1">#property.name#</h1>
  <!--- <div class="price-range">#priceRange#</div> --->
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
    <cfif len(property.area)><span class="property-info-item"><strong>Area:</strong> #property.area#</span></cfif>
    <cfif len(property.type)><span class="property-info-item"><strong>Type:</strong> #property.type#</span></cfif>
    <cfif len(property.view)><span class="property-info-item"><strong>View:</strong> #property.view#</span></cfif>
  </div><!-- END property-info -->
  <div class="property-info property-info-icons">
    <span class="property-info-item info-icon"><i class="fa fa-bed" aria-hidden="true"></i> #property.bedrooms# Beds <!--- (2K, 3Q, 4T) ---></span>
    <span class="property-info-item info-icon"><i class="fa fa-bath" aria-hidden="true"></i> #property.bathrooms# Baths</span>
    <span class="property-info-item info-icon"><i class="fa fa-users" aria-hidden="true"></i> Sleeps #property.sleeps#</span>
    <span class="property-info-item info-icon"><i class="fa fa-paw" aria-hidden="true"></i> #property.petsallowed#</span>
    <cfif len(trim(property.allowsNightly)) GT 0><span class="property-info-item info-icon"><i class="fa fa-calendar" aria-hidden="true"></i> Allows Nightly Rentals</span></cfif>
    <cfif len(trim(property.allowsMonthly)) GT 0><span class="property-info-item info-icon"><i class="fa fa-calendar" aria-hidden="true"></i> Allows Monthly Rentals</span></cfif>
  </div><!-- END property-info -->
</div><!-- END property-overview -->
</cfoutput>
