<div class="panel panel-default property-more-info">
  <div class="panel-heading">
    <div class="h4 nomargin text-upper">More Information</div>
  </div>
  <div class="panel-body">
    <cfoutput>
      <cfif application.oFields.showOnPDP(9)>
        <a href="http://nces.ed.gov/globallocator/index.asp?search=1&State=#property.state#&city=&zipcode=#property.zip_code#&miles=10&itemname=&sortby=name&School=1&PrivSchool=1" class="btn btn-block site-color-2-bg site-color-2-lighten-bg-hover text-white" target="_blank">Nearby Schools</a>
      </cfif>
      <cfif application.oFields.showOnPDP(8)>
        <button type="button" class="btn btn-block site-color-2-bg site-color-2-lighten-bg-hover text-white" data-toggle="modal" data-target="##mortgageModal">Mortgage Calculator</button>
      </cfif>
      <!--- virtual tour link is now in _property-info.cfm
      <cfif LEN(property.Virtual_Tour)>
        <button type="button" class="btn btn-block site-color-2-bg site-color-2-lighten-bg-hover text-white" data-toggle="modal" data-target="##virtualTourModal">Virtual Tour</button>
      </cfif>
       --->
    </cfoutput>
    
    <div class="property-area-details">
      <cfoutput>
        <cfif isDefined('property.kind') and len(trim(property.kind))><p>Kind: #property.kind#</p></cfif>
        <cfif isDefined('property.parking') and len(trim(property.parking))><p>Parking: #property.parking#</p></cfif>
        <cfif isDefined('property.elementary_school') and len(trim(property.elementary_school))><p>Elementary School: #property.elementary_school#</p></cfif>
        <cfif isDefined('property.middle_school') and len(trim(property.middle_school))><p>Middle School: #property.middle_school#</p></cfif>
        <cfif isDefined('property.high_school') and len(trim(property.high_school))><p>High School: #property.high_school#</p></cfif>
      </cfoutput>
    </div>
    
    <cfif application.oFields.showOnPDP(7)>
      <cfinclude template="/mls/_market-trends.cfm">
    </cfif>
  </div>
</div>