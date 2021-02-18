<cfoutput query="property">
  <div class="property-overview">
    <h1 class="property-name">#street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif>, <span>#city#</span></h1>
    <div class="price-range">$<cfif status eq 6 AND isdefined('soldprice') AND isValid('numeric',soldprice) AND soldprice gt 0 >#NumberFormat(soldprice)#<cfelse>#NumberFormat(list_price)#</cfif><cfif wsid is "4">/ Monthly</cfif></div>
    <hr>
    <div class="property-info">
      <span class="property-info-item"><strong>MLS##:</strong> #mlsnumber#</span>
      <cfif LEN(property_type)><span class="property-info-item"><strong>Property Type:</strong> #property_type#</span></cfif>
      <span class="property-info-item"><strong>Address:</strong> <cfif AddressDisplayYN is not "N">#street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif><cfelse>N/A</cfif></span>
      <span class="property-info-item"><strong>City / Zip:</strong> #city#, #state# #zip_code#</span>
      <cfif LEN(getareas.city)><span class="property-info-item"><strong>Area:</strong> #getareas.city#</span></cfif>
      <cfif LEN(county)><span class="property-info-item"><strong>County:</strong> #county#</span></cfif>
      <cfif LEN(subdivision)><span class="property-info-item"><strong>Subdivision or Area:</strong> #subdivision#</span></cfif>
      <cfif LEN(bedrooms)><span class="property-info-item"><strong>Bedrooms:</strong> #bedrooms#</span></cfif>
      <cfif LEN(baths_full)><span class="property-info-item"><strong>Bathrooms:</strong> #baths_full#</span></cfif>
      <cfif LEN(baths_half) and baths_half neq 0><span class="property-info-item"><strong>1/2 Bathrooms:</strong> #baths_half#</span></cfif>
      <cfif LEN(total_heated_square_feet) and total_heated_square_feet neq 0><span class="property-info-item"><strong>Heated Sq Ft:</strong> #trim(numberformat(total_heated_square_feet,'__,___,___'))#</span></cfif>
      <cfif LEN(building_square_feet) and building_square_feet neq 0><span class="property-info-item"><strong>Building Sq Ft:</strong> #trim(numberformat(building_square_feet,'__,___,___'))#</span></cfif>
      <cfif LEN(ACREAGE) and ACREAGE neq 0><span class="property-info-item"><strong>Acres:</strong> #ACREAGE#</span></cfif>
      <cfif LEN(stories) and stories neq 0><span class="property-info-item"><strong>Stories:</strong> #stories#</span></cfif>
      <cfif LEN(year_built) and year_built neq 0><span class="property-info-item"><strong>Year Built:</strong> #year_built#</span></cfif>
      <cfif LEN(trim(zoning))><span class="property-info-item"><strong>Zoning:</strong> #zoning#</span></cfif>
      <span class="property-info-item"><strong>Date Listed:</strong> #dateformat(GetDatelisted.created_at,'mm/dd/yyyy')#</span>
      <cfif LEN(association_fee)><span class="property-info-item"><strong>POA Fees:</strong> #association_fee#</span></cfif>
      <cfif status eq 4>
        <span class="property-info-item"><strong>Status:</strong> Under Contract</span>
      </cfif>
      <cfif status eq 6>
        <cfif len(status)><span class="property-info-item"><strong>Date Sold:</strong> #dateformat(solddate,'mm/dd/yyyy')#</span></cfif>
        <cfif len(soldprice)><span class="property-info-item"><strong>Sale Price:</strong> $#numberformat(soldprice)#</span></cfif>
      </cfif>
      </ul>
    </div>

  </div>
</cfoutput>