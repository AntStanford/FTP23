<cfset getFeaturedProperties = application.bookingObject.getFeaturedProperties()>

<cfquery name="getEnhancements" dataSource="#settings.booking.dsn#">
	select * 
	from cms_property_enhancements
</cfquery>

<cfquery name = "getSpecial" datasource = "#settings.dsn#">
  select *
  from cms_specials join cms_specials_properties ON(cms_specials.id = cms_specials_properties.specialID)
  where <!---<cfqueryparam value="#createodbcdate(session.booking.strcheckin)#" cfsqltype="cf_sql_date">
  between cms_specials.allowedBookingStartDate and cms_specials.allowedBookingEndDate--->
  1 = 1
  <!---<cfif isDefined('session.booking.specialid') AND LEN(session.booking.specialid)>
      and cms_specials.id IN( <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.specialid#" List="yes">)
  </cfif>--->
  AND cms_specials.active = <cfqueryparam value = "Yes" CFSQLType = "CF_SQL_VARCHAR">
  and cms_specials_properties.active = <cfqueryparam value = "Yes" CFSQLType = "CF_SQL_VARCHAR">
  <!---and cms_specials_properties.unitcode = <cfqueryparam value = "#propertyid#" CFSQLType = "CF_SQL_VARCHAR">--->
</cfquery>

<cfif getFeaturedProperties.recordcount gt 0>
	<div class="i-featured">
  	<div class="container">
  	  <h2 class="h1 site-color-1">Featured Rentals</h2>
      <h6 class="site-color-2">View some of our best properties selected just for you</h6>
  	</div>
  	<div class="container featured-container">
  	  <div class="owl-carousel owl-theme featured-props-carousel">
  		  <cfoutput query="getFeaturedProperties">
          <div class="featured-property">
            <div class="featured-property-img-wrap">
              <cfquery name="getspecialproperties" dbtype="query">
                select *
                from getSpecial 
                where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
                </cfquery>
              <cfif getspecialproperties.recordcount gt 0>
              <!---<a href="" class="featured-property-special featured-special site-color-2-bg text-white" target="_blank">
                Special
              </a>--->
              <span class="featured-property-special featured-special site-color-2-bg text-white">Special</span>
            </cfif>
              <cfquery name="getnew" dbtype="query">
                select new
                from getEnhancements 
                where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">
                </cfquery>
                <cfif getnew.recordcount gt 0 and getnew.new eq 'Yes'>
              <span class="featured-property-special featured-new site-color-1-bg text-white" target="_blank">
                New
              </span>
            </cfif>
              <a href="/#settings.booking.dir#/#seopropertyname#" class="featured-property-link" target="_blank">
                <cfif len(photo)>
                  <span class="featured-property-img" style="background-image:url(#replace(photo,' ','%20','all')#);"></span>
                <cfelse>
                  <span class="featured-property-img" style="background:url('https://placeholdit.imgix.net/~text?txtsize=14&txt=placeholder&w=200&h=150');"></span>
                </cfif>
                <span class="hidden">Featured Property</span>
              </a>
            </div><!-- END featured-property-img-wrap -->
            <div class="featured-property-info-wrap">
              <h3 class="featured-property-title text-black text-center">#name#</h3>
              <ul class="featured-property-info row">
                <li class="col"><i class="fa fa-bed" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bedrooms"></i> #bedrooms# Bedrooms</li>
                <li class="col"><i class="fa fa-bath" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Bathrooms"></i> #bathrooms# Bathrooms</li>
                <li class="col"><i class="fa fa-users" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="Guests"></i> Sleeps #sleeps#</li>
              </ul>
            </div><!-- END featured-property-info-wrap -->
          </div>
  		  </cfoutput>
  	  </div><!-- END featured-props-carousel -->
      <div class="cssload-container">
        <div class="cssload-tube-tunnel"></div>
      </div>
  	</div>
	</div><!-- END i-featured -->
</cfif>