<cfoutput query="property">
<div class="panel panel-default <cfif ListFind(cookie.mlsfavorites,url.mlsnumber) gt 0>panel-danger</cfif> property-info" data-unitcode="#property.mlsnumber#" data-id="#property.mlsnumber#" id="#property.mlsnumber#" data-wsid="#property.wsid#" data-mlsid="#property.mlsid#">
  <div class="panel-heading">
    <h1> #street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif> <span class="property-price pull-right">$<cfif status eq 6 AND isdefined('soldprice') AND isValid('numeric',soldprice) AND soldprice gt 0 >#NumberFormat(soldprice)#<cfelse>#NumberFormat(list_price)#</cfif></span></h1>
  </div>
  <div class="panel-body <cfif ListFind(cookie.mlsfavorites,url.mlsnumber) gt 0>bg-danger</cfif>">
    <div class="row">
      <div class="col-md-4 col-sm-5 col-xs-7 property-address">
        <address>
          <b>MLS##:</b> #mlsnumber#<br>
          <b>Address:</b><cfif AddressDisplayYN is not "N"> #street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif><cfelse>N/A</cfif><br>
          <b>City / Zip:</b> #city#, #state# #zip_code#<br>
          <cfif property_type is not ""> <b>#application.oFields.cLabel(58)#:</b> #property_type# <cfif kind is not ""> / #kind#</cfif><br></cfif>
        </address>
      </div>

      <div class="col-md-2 col-sm-2 col-xs-2 property-info-box">
        <cfif property.Total_Heated_Square_Feet neq '' and property.Total_Heated_Square_Feet neq '0'>
          <div class="alert site-color-1-bg text-white text-center">
            <div class="h2">#numberformat(property.Total_Heated_Square_Feet, ',')#</div>
            #application.oFields.cLabel(38)#
          </div>
        <cfelseif property.building_square_feet is not '' and property.building_square_feet neq 0>
          <div class="alert site-color-1-bg text-white text-center">
            <div class="h2">#numberformat(property.building_square_feet, ',')#</div>
            #application.oFields.cLabel(38)#
          </div>
        <cfelse>
          <cfif property.acreage neq ''>
            <div class="alert site-color-1-bg text-white text-center">
              <div class="h2">#numberformat(property.acreage, ',.')#</div>
              #application.oFields.cLabel(27)#
            </div>
          </cfif>
        </cfif>
      </div>

      <div class="col-md-2 col-sm-2 col-xs-2 property-info-box">
        <cfif property.wsid neq 2 and property.wsid neq 3>
          <div class="alert site-color-1-bg text-white text-center">
            <cfswitch expression="#property.wsid#">
              <cfcase value="1,4,5,6"><div class="h2">#property.bedrooms#</div>#application.oFields.cLabel(35)#</cfcase>
              <!--- <cfcase value="2"><div class="h2">#property.Lot_Description#</div>#application.oFields.cLabel(59)#</cfcase> --->
              <cfcase value="3"><div class="h2"><cfif property.year_built is not "0" and property.year_built is not "">#property.year_built#<cfelse> N/A </cfif></div> #application.oFields.cLabel(40)#</cfcase>
              <!---
              <cfcase value="4"><div class="h2">#property.bedrooms#</div>#application.oFields.cLabel(35)#</cfcase>
              <cfcase value="5"><div class="h2"><cfif property.bedrooms neq ''>#property.bedrooms#<cfelse>N/A</cfif></div>#application.oFields.cLabel(35)#</cfcase>
              <cfcase value="6"><div class="h2"><cfif property.bedrooms neq ''>#property.bedrooms#<cfelse>N/A</cfif></div>#application.oFields.cLabel(35)#</cfcase>
              --->
              <cfdefaultcase/>
            </cfswitch>
          </div>
        </cfif>
      </div>

      <div class="col-md-2 col-sm-2 col-xs-2 property-info-box">
        <cfif property.wsid neq 2 and property.wsid neq 3>
          <div class="alert site-color-1-bg text-white text-center">
            <cfswitch expression="#property.wsid#">
              <cfcase value="1,4,5,6"><div class="h2">#property.baths_full#</div>#application.oFields.cLabel(36)#</cfcase>
              <cfcase value="2"><div class="h2">#property.city#</div>#application.oFields.cLabel(6)#</cfcase>
              <cfcase value="3"><div class="h2">#property.city#</div>#application.oFields.cLabel(6)#</cfcase>
              <!---
              <cfcase value="4"><div class="h2">#property.baths_full#</div>#application.oFields.cLabel(36)#</cfcase>
              <cfcase value="5"><div class="h2">#property.baths_full#</div>#application.oFields.cLabel(36)#</cfcase>
              <cfcase value="6"><div class="h2">#property.city#</div>#application.oFields.cLabel(6)#</cfcase>
              --->
              <cfdefaultcase />
            </cfswitch>
          </div>
        </cfif>
      </div>

      <div class="col-md-2 col-sm-3 col-xs-7 property-fav-print">
        <cfif property.status neq '6'>
          <cfif ListFind(cookie.mlsfavorites,url.mlsnumber) gt 0>
            <a href="javascript:;" data-mlsnumber="#property.mlsnumber#" data-mlsid="#property.mlsid#" data-wsid="#property.wsid#" class="btn btn-block btn-favorite add-to-fav-detail favorited"><i class="fa fa-heart"></i> Unfavorite</a>
          <cfelse>
            <a href="javascript:;" data-mlsnumber="#property.mlsnumber#" data-mlsid="#property.mlsid#" data-wsid="#property.wsid#" class="btn btn-block btn-favorite add-to-fav-detail"><i class="fa fa-heart"></i> Favorite</a>
          </cfif>
        </cfif>
        <!--- <a href="/mls/print.cfm?mlsnumber=#url.mlsnumber#&mlsid=#mlsid#&wsid=#wsid#" class="btn btn-block" target="_blank"><span class="glyphicon glyphicon-print"></span> Print</a> --->
        <a href="" class="btn btn-block" target="_blank"><i class="fa fa-print"></i> Print</a>
        
        <cfif len(variables.virtualTourLink) and lcase(left(variables.virtualTourLink, 4)) is 'http' and variables.virtualTourModal>
          <a href="javascript:;" data-toggle="modal" data-target="##virtualTourModal" class="btn btn-block site-color-1-bg site-color-1-lighten-bg-hover text-white" target="_blank"><i class="fa fa-video-camera"></i> Virtual Tour</a>
        <cfelseif variables.virtualTourModal is false and len(variables.virtualTourLink)>
          <a href="#variables.virtualTourLink#" target="_blank" class="btn btn-block site-color-1-bg site-color-1-lighten-bg-hover text-white"><i class="fa fa-video-camera"></i> Virtual Tour</a>
        </cfif>
      </div>
    </div>
  </div>
</div>
</cfoutput>