<cfinclude template="property_.cfm">
<cfset request.location_id = 3><!--- real-estate is location 3 --->
<cfinclude template="/#application.settings.mls.dir#/components/header.cfm">

<cfset page.metatitle = "#property.street_number# #property.street_name# - #application.ohelpers.capFirst(property.city)# | #property.mlsnumber# For Sale | #Settings.company#">

<cfset page.metadescription = "#property.bedrooms# Bedroom Home for Sale in #application.ohelpers.capFirst(property.city)#, #property.state#" />
  <cfif LEN(property.subdivision)>
    <cfset page.metadescription &= ", in the #property.subdivision# neighborhood" />
  </cfif>
<cfset page.metadescription &= ". $#numberformat(property.list_price)#. " />
<cfif isdefined('checkEnhanced.showonwebsite') and isdefined('checkEnhanced.alternatedescription') and checkEnhanced.showonwebsite eq 'Yes' and LEN(checkEnhanced.alternatedescription)>
  <cfset page.metadescription &= "#left(checkEnhanced.alternatedescription,30)#" />
  <cfif len(checkEnhanced.alternatedescription) gt 30>
    <cfset page.metadescription &= "..." />
  </cfif>
<cfelse>
  <cfset page.metadescription &= "#left(property.remarks,30)#" />
  <cfif len(property.remarks) gt 30>
    <cfset page.metadescription &= "..." />
  </cfif>
</cfif>

<div class="property-wrap">
  <cfoutput>
  <div id="propertyDetails" class="property-details-wrap" data-unitcode="#property.mlsnumber#" data-id="#property.mlsnumber#" data-unitshortname="#property.mlsnumber#" data-latitude="#property.latitude#" data-longitude="#property.longitude#" data-straddress1="#property.street_number# #property.street_name#" data-dblbeds="#property.bedrooms#" data-strlocation="" data-wsid="#property.wsid#" data-mlsid="#property.mlsid#">
  </cfoutput>
    <!-- Property Banner/Gallery/Map -->
    <cfinclude template="_property-photos-map.cfm">

    <!-- Property Base Info -->
    <cfinclude template="_property-info.cfm">

    <!-- Property Agent Comments -->
    <cfinclude template="_property-agent-comments.cfm">

    <!-- Property Tabs -->
    <div class="property-tabs-wrap">
      <div id="propertyTabsAnchor"><!-- TRAVEL STICKY TABS ANCHOR FOR SCROLL --></div>
      <ul id="propertyTabs" class="property-tabs tabs tab-group">
        <!--- <li><a href="#details-room"><i class="fa fa-list" aria-hidden="true"></i> <span>Rooms</span></a></li> --->
        <li><a href="#details-amenities"><i class="fa fa-list" aria-hidden="true"></i> <span>Amenities</span></a></li>
        <li><a href="#details-interior"><i class="fa fa-list" aria-hidden="true"></i> <span>Interior Features</span></a></li>
        <li><a href="#details-exterior"><i class="fa fa-list" aria-hidden="true"></i> <span>Exterior Features</span></a></li>
        <li><a href="#details-additionals"><i class="fa fa-list" aria-hidden="true"></i> <span>Additional Features</span></a></li>
      </ul><!-- END propertyTabs -->
    </div>

    <!-- Property Description | #description-room -->
    <!--- <cfinclude template="_details-room-tab.cfm"> --->

    <!-- Property Amenities | #description-amenities -->
    <cfinclude template="_details-amenities-tab.cfm">

    <!-- Property Description | #description-interior -->
    <cfinclude template="_details-interior-tab.cfm">

    <!-- Property Description | #description-exterior -->
    <cfinclude template="_details-exterior-tab.cfm">

    <!-- Property Description | #description-additionals -->
    <cfinclude template="_details-additionals-tab.cfm">

    <!-- JUMP LINK IN _travel-dates.cfm Request More Info Button -->
    <cfinclude template="_request-info.cfm">

    <div class="disclaimer">
      <p>Listings provided courtesy of the MLS<!---  and #listing_office_name# --->.</p>
      <p><em>Information deemed reliable but not guaranteed. Listings come from many brokers and not all listings from MRIS may be visible on this site.</em></p>
      <p>Copyright <cfoutput>&copy; #dateformat(now(),'YYYY')#</cfoutput> MRIS - All Rights Reserved</p>
    </div><!-- END disclaimer -->

  </div><!-- END propertyDetails -->

  <div class="property-sidebar-wrap">
    <cfinclude template="_property-sidebar.cfm">
  </div><!-- END property-dates-container -->

</div><!-- END property-wrap -->

<button id="returnToTop" class="btn site-color-3-lighten-bg site-color-3-bg-hover text-white" type="button"><i class="fa fa-chevron-up" aria-hidden="true"></i></button>

<!--- <cftry> --->
  <!--- <cfquery name="InsertPropertyView" datasource="#settings.dsn#">
    Insert into cms_mls_views (mlsnumber,remote_addr)
    values (
      <cfqueryparam value="#property.mlsnumber#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#cgi.remote_addr#" cfsqltype="cf_sql_varchar">
    )
  </cfquery> --->
<!---   <cfcatch></cfcatch>
</cftry>
 --->
<cfinclude template="/#application.settings.mls.dir#/components/property-modals.cfm">

<cfinclude template="/#application.settings.mls.dir#/components/footer.cfm">