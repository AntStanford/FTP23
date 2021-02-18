<cfoutput>
<div id="details-additionals" name="details-additionals" class="info-wrap details-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> Additional Features</div>
  <div class="info-wrap-body">
    <ul class="details-list">
      <cfif LEN(property.associated_document_count)><li><strong>Associated Document Count:</strong> <span>#property.associated_document_count#</span></li></cfif>
      <cfif LEN(property.new_construction)><li><strong>Contruction:</strong> <span>#replace(property.new_construction,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.County)><li><strong>County:</strong> <span>#property.County#</span></li></cfif>
      <cfif LEN(property.deed_book)><li><strong>Deed Book:</strong> <span>#property.deed_book#</span></li></cfif>
      <cfif LEN(property.deed_book_pg)><li><strong>Deed Book Pg:</strong> <span>#property.deed_book_pg#</span></li></cfif>
      <cfif LEN(property.disclaimer)><li><strong>Disclaimer:</strong> <span>#replace(property.disclaimer,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.ownership)><li><strong>Ownership:</strong> <span>#replace(property.ownership,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.rental_co)><li><strong>Rental Company:</strong> <span>#property.rental_co#</span></li></cfif>
      <cfif LEN(property.rental_cottage_no)><li><strong>Rental Cottage Number:</strong> <span>#property.rental_cottage_no#</span></li></cfif>
      <cfif LEN(property.updatedat) and isdate(property.updatedat)><li><strong>Status Date:</strong> <span>#dateformat(property.updatedat,'yyyy-mm-dd')#</span></li></cfif>
      <cfif LEN(property.SubCategory)><li><strong>Property Sub Type:</strong> <span>#replace(property.SubCategory,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.view)><li><strong>View Description:</strong> <span>#replace(property.view,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.Year_Built)><li><strong>Year Built:</strong> <span>#property.Year_Built#</span></li></cfif>
      <cfif LEN(property.Zoning)><li><strong>Zoning:</strong> <span>#replace(property.Zoning,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.waterfront)><li><strong>Waterfront:</strong> <span>#replace(property.waterfront,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.miscellaneous_features)><li><strong>Farm:</strong> <span><cfif property.miscellaneous_features eq 0>No<cfelse>Yes</cfif></span></li></cfif>
        <cfif LEN(property.foundation)><li><strong>Foundation:</strong> <span>#property.foundation#</span></li></cfif>
        <cfif LEN(property.lotmeasurement)><li><strong>Lot Size +/-:</strong> <span>#property.lotmeasurement#</span></li></cfif>
        <cfif LEN(property.building)><li><strong>Storage:</strong> <span>#property.building#</span></li></cfif>
        <cfif LEN(property.stories)><li><strong>Stories:</strong> <span>#property.stories#</span></li></cfif>
        <cfif LEN(property.year_built)><li><strong>Age:</strong> <span>#year(now())-property.year_built# yrs</span></li></cfif>
        <cfif LEN(property.Uses)><li><strong>Suitable Use:</strong> <span>#property.Uses#</span></li></cfif>
    </ul>
  </div><!-- END info-wrap-body -->
</div><!-- END details-wrap -->
</cfoutput>