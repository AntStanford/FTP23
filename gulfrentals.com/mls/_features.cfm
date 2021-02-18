<cftry>
<cfoutput>
<cfset amenitylist = "0">
<cfset lastamenity = "none">
<cfif LEN(property.interior_features)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "interior_features"></cfif>
<cfif LEN(property.exterior_features) or LEN(property.Miscellaneous_Exterior)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "exterior_features"></cfif>
<cfif LEN(property.rooms)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "rooms"></cfif>
<cfif LEN(property.utilities)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "utilities"></cfif>
<cfif LEN(property.Flooring)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "Flooring"></cfif>
<cfif LEN(property.appliances)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "appliances"></cfif>
<cfif LEN(property.cooling)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "cooling"></cfif>
<cfif LEN(property.heating)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "heating"></cfif>
<cfif LEN(property.fireplace)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "fireplace"></cfif>
<cfif LEN(property.roof)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "roof"></cfif>
<cfif LEN(property.dining_description)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "dining_description"></cfif>
<cfif LEN(property.lotfront)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "lotfront"></cfif>
<!--- <cfif LEN(property.lot_description)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "lot_description"></cfif> --->

<!--- Access the Beach was breaking the waterfront_type and water_view_type variables hard. So, this fixed it. TDF --->
<cfparam name="waterfront_type" default="">
<cfif isdefined('property.waterfront_type')>
  <cfset waterfront_type = property.waterfront_type>
</cfif>
<cfparam name="water_view_type" default="">
<cfif isdefined('property.water_view_type')>
  <cfset water_view_type = property.water_view_type>
</cfif>
<cfif LEN(waterfront_type) or LEN(water_view_type)><cfset amenitylist = amenitylist + 1><cfset lastamenity = "waterfront_type"></cfif>

 <!--- Determine if its odd amount --->
<cfif amenitylist mod 2 neq 0><cfset oddamenities = "yes"></cfif>

<style>
h4 {font-weight: bold !important;}

</style>
<div class="panel panel-default booking-box">
	<div class="panel-heading">
		<h3 class="text-center">Amenities</h3>
	</div>
	<div class="panel-body">
		<cfif amenitylist neq "0">
        <ul class="amenities-list">
            <div class="box property-amenities">
              <h2>Property Amenities</h2>
              <ul class="amenities-list">
                <cfif property.interior_features is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'interior_features'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(60)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.interior_features#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

              <cfif property.rooms is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'rooms'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(62)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.rooms#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.utilities is not "">
                <li class="item" <cfif isdefined('oddamenities') or lastamenity eq 'utilities'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(63)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.utilities#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.Flooring is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'Flooring'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(64)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.Flooring#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.appliances is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'appliances'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(65)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.appliances#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.cooling is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'cooling'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(66)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.cooling#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

              <cfif property.heating is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'heating'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(31)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.heating#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
            <cfif property.water_heater is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'water_heater'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(74)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.water_heater#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

              <cfif property.sewer is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'sewer'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(48)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.sewer#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>


              <cfif property.fireplace is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'fireplace'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(67)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.fireplace#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.roof is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'roof'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(32)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.roof#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.dining_description is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'dining_description'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(68)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.dining_description#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>



              <cfif property.foundation is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'foundation'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(72)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.foundation#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

                <cfif property.exterior_features is not "" or property.Miscellaneous_Exterior is not "">
                <li class="item" <cfif isdefined('oddamenities') and (lastamenity eq 'exterior_features' or lastamenity eq 'Miscellaneous_Exterior')>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(61)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.exterior_features#">
                      <li>#i#</li>
                    </cfloop>
                    <cfloop index="i" list="#property.Miscellaneous_Exterior#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

              <cfif property.parking is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'parking'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(73)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.parking#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

              <cfif property.amentities is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'amentities'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(75)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.amentities#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

               <cfif property.pool is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'pool'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(76)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.pool#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

              <cfif property.road is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'road'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(77)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.road#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.exterior_finish is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'exterior_finish'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(78)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.exterior_finish#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.exterior_structures is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'exterior_structures'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(79)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.exterior_structures#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.fencing is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'fencing'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(80)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.fencing#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.hoa_amenities is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'hoa_amenities'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(81)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.hoa_amenities#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.laundry_location is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'laundry_location'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(82)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.laundry_location#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>
              <cfif property.lot_water_features is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'lot_water_features'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(83)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.lot_water_features#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>

              <cfif property.porch_balcony_deck is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'porch_balcony_deck'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(84)#</h4>
                  <ul>
                    <cfloop index="i" list="#property.porch_balcony_deck#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>




              <cfif property.lotfront is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'lotfront'>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(27)#</h4>
                  <ul>
                    <li>#property.lotfront# front</li>
                    <li>#property.lotright# right</li>
                    <li>#property.lotrear# rear</li>
                    <li>#property.lotleft# left</li>
                  </ul>
                </li>
              </cfif>
<!---               <cfif lot_description is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'lot_description'>style="width:100%;"</cfif>>
                  <h4>Lot Description</h4>
                  <ul>
                    <cfloop index="i" list="#property.lot_description#" delimiters=",">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif> --->


              <cfif waterfront_type is not "" or water_view_type is not "">
                <li class="item" <cfif isdefined('oddamenities') and (lastamenity eq 'waterfront_type' or lastamenity eq 'water_view_type')>style="width:100%;"</cfif>>
                  <h4>#application.oFields.cLabel(14)# </h4>
                  <ul>
                     <cfif waterfront_type is not "">
                        <cfloop index="i" list="#property.waterfront_type#">
                         <li>#i#</li>
                        </cfloop>
                     </cfif>
                     <cfif water_view_type is not "" and water_view_type is not waterfront_type>
                       <cfloop index="i" list="#property.water_view_type#">
                         <li>#i#</li>
                       </cfloop>
                     </cfif>

                  </ul>
                </li>
              </cfif>

              <cfif property.extrainfo is not "">
                <li class="item" <cfif isdefined('oddamenities') and lastamenity eq 'extrainfo'>style="width:100%;"</cfif>>
                  <h4>Extras</h4>
                  <ul>
                    <cfloop index="i" list="#property.extrainfo#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </li>
              </cfif>




            </ul>
          </div>
        </ul>
</cfif>
	</div>
</div>
</cfoutput>
<cfcatch>
<cfdump var="#cfcatch#">
</cfcatch>
</cftry>