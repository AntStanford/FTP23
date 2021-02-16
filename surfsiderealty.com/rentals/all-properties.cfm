<cfinclude template="/components/header.cfm">

<div class="i-content">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
          <cfset getAllProperties = application.bookingObject.getAllProperties()>

      		<cfif isdefined('noUnitMessage')>

            <!--- Send 404 in header, but hide Server Error --->
            <cfheader statusCode = "404" statusText = "Page Not Found">

            <style>
            #header{display:none;}
            #content{display:none;}
            </style>
            <!--- END 404 header override --->

            <cfoutput>
        			<div class="alert alert-warning">#noUnitMessage#</div>
            </cfoutput>
          </cfif>

          <cfoutput>
          	<cfif isdefined('page.h1') and len(page.h1)>
          		<h1 class="site-color-1">#page.h1#</h1>
          	<cfelseif isdefined('page.name') and len(page.name)>
          		<h1 class="site-color-1">#page.name#</h1>
          	<cfelse>
          		<h1 class="site-color-1">All Properties</h1>
          	</cfif>

            <p class="h4">#getAllProperties.recordcount# properties listed.</p>
          </cfoutput>
          <cfset thelist = "">
          <cfoutput query="getAllProperties">
        		<cfif ListFind("A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z",left(getAllProperties.name,1)) AND NOT ListFind(thelist,left(getAllProperties.name,1))>
            	<cfset thelist = ListAppend(thelist,UCase(left(getAllProperties.name,1)))>
            </cfif>
        	</cfoutput>
          <h3 class="properties-abc">
            <span>#</span>
          	<cfoutput>
            <cfloop list="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z" index="i">
            	<cfif ListFindNoCase(thelist,i)>
              	<a href="###i#">#i#</a>
              <cfelse>
              	<span>#i#</span>
              </cfif>
            </cfloop>
        		</cfoutput>
          </h3>

          <div class="mobile-scroller"><i class="fa fa-arrows-h" aria-hidden="true"></i> Swipe to see Table contents</div>
          <div class="table-wrap table-responsive">
            <table class="table" data-toggle="table">
              <thead>
                <tr style="font-weight:bold">
                  <th data-field="property">Property</th>
                  <th data-field="sleeps">Sleeps</th>
                  <th data-field="bedrooms">Bedrooms</th>
                  <th data-field="bedrooms">Bathrooms</th>
                  <th data-field="rate">Price Range</th>
                </tr>
              </thead>
              <cfset latest="">
              <cfoutput query="getAllProperties">
                <cfset current = left(getAllProperties.name,1)>
                <tr>
                  <td>
                    <cfif Current is not Latest><cfset Latest=Current><a name="#latest#"></a></cfif>
                    <a href="/#settings.booking.dir#/#seoPropertyName#">#name#</a>
                  </td>
                  <td>#trim(sleeps)#</td>
                  <td>#bedrooms#</td>
                  <td>#bathrooms#</td>
                  <cfset weeklyPriceRange = application.bookingObject.getPropertyPriceRange(propertyid)>
                  <td>#weeklyPriceRange#</td>
                </tr>
              </cfoutput>
            </table>
          </div>
      </div>
    </div>
  </div>
</div>

<cfinclude template="/components/footer.cfm">