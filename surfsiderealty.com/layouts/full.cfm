<div class="i-content">
  <div class="container">
  	<div class="row">
  		<div class="col-lg-12">
        <!---<cfcache key="cms_pages" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#settings.website#/temp_files">--->
          <cfif len(page.h1)>
            <cfoutput><h1 class="site-color-1">#page.h1#</h1></cfoutput>
          <cfelse>
            <cfoutput><h1 class="site-color-1">#page.name#</h1></cfoutput>
          </cfif>
          <cfoutput>#page.body#</cfoutput>
        <!---</cfcache>--->
        <cfif len(page.partial)><cfif page.partial eq '/sales/search-results.cfm'><cfinclude template="/sales/search-results.cfm"><cfelse><cfinclude template="/partials/#page.partial#"></cfif></cfif>
  		</div>
  	</div>
  </div>
</div>