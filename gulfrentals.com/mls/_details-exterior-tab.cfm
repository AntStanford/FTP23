<cfoutput>
<div id="details-exterior" name="details-exterior" class="info-wrap details-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> External Features</div>
  <div class="info-wrap-body">
    <ul class="details-list">
      <cfif LEN(property.association_amenities)><li><strong>Association Amenities:</strong> <span>#replace(property.association_amenities,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.exterior_finish)><li><strong>Exterior:</strong> <span>#replace(property.exterior_finish,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.miscellaneous_exterior)><li><strong>Exterior:</strong> <span>#replace(property.miscellaneous_exterior,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.exterior_features) and property.exterior_features gt 0><li><strong>Exterior Features:</strong> <span>#replace(property.exterior_features,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.foundation)><li><strong>Foundation:</strong> <span>#replace(property.foundation,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.garage)><li><strong>Garage:</strong> <span>#replace(property.garage,',',', ', 'all')#</span></li></cfif>

      <cfif LEN(property.Lot_Description)><li><strong>Lot Description:</strong> <span>
        <cfloop from="1" to="#listlen(property.Lot_Description)#" index="i">
          <cfif !(isdefined('settings.noShowList') and settings.noShowList contains(listgetat(property.Lot_Description,i)))>
            #listgetat(property.Lot_Description,i)#<cfif i neq listlen(property.Lot_Description)>, </cfif>
          </cfif>
        </cfloop>
        </span></li></cfif>

      <cfif LEN(property.Lot_Description)><li><strong>Lot Description:</strong> <span>#replace(property.Lot_Description,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.Lot_number)><li><strong>Lot no.:</strong> <span>#property.Lot_number#</span></li></cfif>
      <cfif LEN(property.Topography)><li><strong>Topography:</strong> <span>#property.Topography#</span></li></cfif>
      <cfif LEN(property.Utilities)><li><strong>Utilities Available:</strong> <span>#property.Utilities#</span></li></cfif>

      <cfif LEN(property.Parking)><li><strong>Parking:</strong> <span>#replace(property.Parking,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.pool_text_2)><li><strong>Pool:</strong> <span>#replace(property.pool_text_2,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.pool_text_1)><li><strong>Pool:</strong> <span>#replace(property.pool_text_1,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.pool)><li><strong>Rool Type:</strong> <span>#replace(property.pool,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.road_access)><li><strong>Access:</strong> <span>#replace(property.road_access,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.roof)><li><strong>Roof:</strong> <span>#replace(property.roof,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.sewer)><li><strong>Sewer/Septic:</strong> <span>#replace(property.sewer,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.Style)><li><strong>Style:</strong> <span>#replace(property.Style,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.Waterfront_Type)><li><strong>Waterfront Location:</strong> <span>#replace(property.Waterfront_Type,',',', ', 'all')#</span></li></cfif>
    </ul>
  </div><!-- END info-wrap-body -->
</div><!-- END details-wrap -->
</cfoutput>
