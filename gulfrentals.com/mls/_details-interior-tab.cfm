<cfoutput>
<div id="details-interior" name="details-interior" class="info-wrap details-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> Interior Features</div>
  <div class="info-wrap-body">
    <ul class="details-list">
      <cfif LEN(property.cooling)><li><strong>Air Conditioning:</strong> <span>#replace(property.cooling,',',', ', 'all')#</span></li></cfif>

      <cfif LEN(property.appliances)><li><strong>Appliances:</strong> <span>
        <cfloop from="1" to="#listlen(property.appliances)#" index="i">
          <cfif !(isdefined('settings.noShowList') and settings.noShowList contains(listgetat(property.appliances,i)))>
            #listgetat(property.appliances,i)#<cfif i neq listlen(property.appliances)>, </cfif>
          </cfif>
        </cfloop>
        </span></li></cfif>

      <cfif LEN(property.countertops)><li><strong>Countertops:</strong> <span>#property.countertops#</span></li></cfif>
      <cfif LEN(property.extrainfo)><li><strong>Tillable Acres:</strong> <span>#replace(property.extrainfo,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.flooring)><li><strong>Floor Covering:</strong> <span>#replace(property.flooring,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.Furnished)><li><strong>Furnishings Available:</strong> <span><cfif left(lcase(property.furnished),1) is 'y'>Yes<cfelse>No</cfif></span></li></cfif>
      <cfif LEN(property.heating)><li><strong>Heating:</strong> <span>#replace(property.heating,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.interior_features) and property.interior_features gt 0><li><strong>Interior Features:</strong> <span>#replace(property.interior_features,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.other_rooms)><li><strong>Optional Rooms:</strong> <span>#replace(property.other_rooms,',',', ', 'all')#</span></li></cfif>
      <cfif LEN(property.water)><li><strong>Water:</strong> <span>#property.water#</span></li></cfif>
      <cfif LEN(property.water_heater)><li><strong>Water Heater:</strong> <span>#property.water_heater#</span></li></cfif>
    </ul>
  </div><!-- END info-wrap-body -->
</div><!-- END details-wrap -->
</cfoutput>
