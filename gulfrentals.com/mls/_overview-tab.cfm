<div class="panel panel-default property-overview">
	<div class="panel-body">
    <div class="owl-gallery-wrap">
      <div class="owl-gallery-loader-container"><div class="owl-gallery-loader-tube-tunnel"></div></div>
      <div class="owl-carousel owl-theme owl-gallery">
        <cfloop list="#property.photo_link#" index="origPhoto">
          <!--- <cfset photo = replacenocase(origPhoto,'http:','https:') /> --->
          <cfset photo = origPhoto /><!--- for non-https sites --->
          <cfoutput>
            <div class="item">
              <a href="<cfif settings.mls.getmlscoinfo.imageurl neq ''>#settings.mls.getmlscoinfo.imageurl#/</cfif>#photo#" class="fancybox" data-fancybox="owl-gallery-group">
                <div style="background:url('<cfif settings.mls.getmlscoinfo.imageurl neq ''>#settings.mls.getmlscoinfo.imageurl#/</cfif>#photo#') no-repeat"></div>
              </a>
            </div>
          </cfoutput>
        </cfloop>
      </div>
      <div class="owl-carousel owl-theme owl-gallery-thumbs">
        <cfloop list="#property.photo_link#" index="origPhoto">
          <!--- <cfset photo = replacenocase(origPhoto,'http:','https:') /> --->
          <cfset photo = origPhoto /><!--- for non-https sites --->
          <cfoutput>
            <div class="item">
              <span class="owl-lazy" data-src="<cfif settings.mls.getmlscoinfo.imageurl neq ''>#settings.mls.getmlscoinfo.imageurl#/</cfif>#photo#"></span>
            </div>
          </cfoutput>
        </cfloop>
      </div>
    </div>
    <div class="slider-caption">Click the main image above for larger images</div>
		
    <cfoutput>
    <div class="property-description">
      <ul class="property-description-list">
        <li>#application.oFields.cLabel(6)#: #property.city#</li>
        <cfif property.county is not ""><li>#application.oFields.cLabel(33)#: #property.county#</li></cfif>
        <cfif property.subdivision is not ""><li>#application.oFields.cLabel(34)#: #property.subdivision#</li></cfif>
        <cfif property.bedrooms is not ""><li>#application.oFields.cLabel(35)#: #property.bedrooms#</li></cfif>
        <cfif property.baths_full is not ""><li>#application.oFields.cLabel(36)#: #property.baths_full#</li></cfif>
        <cfif property.baths_half is not ""><li>#application.oFields.cLabel(37)#: #property.baths_half#</li></cfif>
        <cfif property.total_heated_square_feet is not "" and property.total_heated_square_feet is not 0>
          <li>#application.oFields.cLabel(38)#: #trim(property.total_heated_square_feet)#</li>
        <cfelseif property.building_square_feet is not "" and property.building_square_feet is not 0>
          <li>#application.oFields.cLabel(38)#: #trim(numberformat(property.building_square_feet,'__,___,___'))#</li>
        </cfif>
        <cfif application.oFields.showOnPDP(27)>
          <cfif property.ACREAGE is not ""><li>#application.oFields.cLabel(27)#: #property.ACREAGE#</li></cfif>
        </cfif>
        <cfif property.stories is not "0" and property.stories is not ""><li>#application.oFields.cLabel(39)#: #property.stories#</li></cfif>
        <cfif property.year_built is not "0" and property.year_built is not ""><li>#application.oFields.cLabel(40)#: #property.year_built#</li></cfif>
        <cfif property.estimated_lot_size is not "0" and property.estimated_lot_size is not "" and property.estimated_lot_size is not property.ACREAGE><li>#application.oFields.cLabel(41)#: #property.estimated_lot_size#</li></cfif>
        <cfif property.zoning is not ""><li>#application.oFields.cLabel(42)#: #property.zoning#</li></cfif>
        <li>#application.oFields.cLabel(43)#: #dateformat(GetDatelisted.created_at,'mm/dd/yyyy')#</li>
        <cfif property.daysOnSite neq ""><li>#application.oFields.cLabel(44)#: #property.daysOnSite#</li></cfif>
        <cfif property.solddate is not ""><li>#application.oFields.cLabel(45)#: #dateformat(property.solddate,'mm/dd/yyyy')#</li></cfif>
        <cfif property.association_fee is not ""><li>#application.oFields.cLabel(46)#: #property.association_fee#</li></cfif>
        <cfif property.water is not ""><li>#application.oFields.cLabel(47)#: #property.water# </li></cfif>
        <cfif property.sewer is not ""><li>#application.oFields.cLabel(48)#: #property.sewer# </li></cfif>
        <cfif property.hotwater neq ""><li>#application.oFields.cLabel(49)#: #property.hotwater#</li></cfif>
        <cfif application.oFields.showOnPDP(26)>
          <cfif property.salelease neq ""><li>#application.oFields.cLabel(26)#: #property.salelease#</li></cfif>
        </cfif>
        <cfif application.oFields.showOnPDP(28)>
          <cfif property.associated_document_count neq ""><li>#application.oFields.cLabel(28)#: #property.associated_document_count#</li></cfif>
        </cfif>
        <cfif property.lot_number neq ""><li>#application.oFields.cLabel(50)#: #property.lot_number#</li></cfif>
        <cfif property.block_number neq ""><li>#application.oFields.cLabel(51)#: #property.block_number#</li></cfif>
        <cfif property.total_rooms neq ""><li>#application.oFields.cLabel(52)#: #property.total_rooms#</li></cfif>
        <cfif property.new_construction neq ""><li>#application.oFields.cLabel(53)#: #property.new_construction#</li></cfif>
        <cfif property.foreclosure neq ""><li>#application.oFields.cLabel(12)#: #property.foreclosure#</li></cfif>
        <cfif application.oFields.showOnPDP(30)>
          <cfif property.Municipality neq ""><li>#application.oFields.cLabel(30)#: #property.Municipality#</li></cfif>
        </cfif>
        <cfif application.oFields.showOnPDP(29)>
          <cfif property.frontage neq ""><li>#application.oFields.cLabel(29)#: #property.frontage#</li></cfif>
        </cfif>
        <cfif application.oFields.showOnPDP(85)>
          <cfif property.lotmeasurement neq ""><li>#application.oFields.cLabel(85)#: #property.lotmeasurement#</li></cfif>
        </cfif>
        <!--- <cfif property.taxes neq ""><li>#application.oFields.cLabel(54)#: #property.taxes#</li></cfif> --->
        <cfif property.third_party_approval neq ""><li>#application.oFields.cLabel(55)#: #property.third_party_approval#</li></cfif>
        <cfif property.construction neq ""><li>#application.oFields.cLabel(56)#: #property.construction#</li></cfif>
        <cfif property.basement neq ""><li>#application.oFields.cLabel(57)#: #property.basement#</li></cfif>
      </ul>
      <hr>
      <cfset newString = replace(property.remarks,'#Chr(10)#','<br />','all')>
      <cfset newString = replace(newString,'<br /><br />','<br />','all')>
      <cfset newString = replace(newString,'?s','&apos;s','all')>

      <cfset newString = replace(newstring,'#Chr(63)#','#Chr(39)#','all')>
      <p>#newString#</p>
      <p class="providedBy">This listing is provided courtesy by <cfif application.oFields.showOnPDP(87)>#property.listing_Agent_First_Name# #property.listing_agent_last_name#,</cfif> #property.listing_office_name#</p>
    </div>
		</cfoutput>
	</div>
</div>