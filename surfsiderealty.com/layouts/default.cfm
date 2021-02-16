<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">
      <!---<cfcache key="cms_pages" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#settings.website#/temp_files">--->
        <cfoutput>
   			  <h1 class="site-color-1">
     			  <cfif len(page.h1)>#page.h1#<cfelse>#page.name#</cfif>
     			</h1>
     	    #page.body#
     	  </cfoutput>
			<!---</cfcache>--->
			<cfif len(page.partial)><cfinclude template="/partials/#page.partial#"></cfif>
		</div>
	</div>
</div>