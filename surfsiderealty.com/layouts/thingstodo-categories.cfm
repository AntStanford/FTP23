<cfinclude template="/components/header.cfm">

<cfquery name="getCategory" dataSource="#settings.dsn#">
	select * from cms_thingstodo_categories where slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cgi.query_string#">
</cfquery>

<cfif getCategory.recordcount gt 0>
	<cfquery name="getThingstodo" dataSource="#settings.dsn#">
		select * from cms_thingstodo where catID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getCategory.id#">
	</cfquery>
	<cfquery name="getAllCategories" dataSource="#settings.dsn#">
		select title,slug from cms_thingstodo_categories order by title
	</cfquery>
	<div class="i-content">
	  <div class="container">
	  	<div class="row">
	  		<div class="col-lg-12">
	        <cfcache key="cms_pages" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">
	     			<cfoutput><h1 class="site-color-1">#getCategory.title#</h1></cfoutput>
	         	<p class="h4 site-color-2">Quick Nav</p>
	         	<div class="i-quick-nav">
	          	<cfloop query="getAllCategories">
	           		<cfoutput><a hreflang="en" href="/thingstodo/#slug#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white">#title#</a></cfoutput>
	           	</cfloop>
	         	</div><br>
	      		<div class="row i-ttd-wrap">
	        		<cfloop query="getThingstodo">
	        			<cfoutput>
    	      			<div class="col-xs-12 col-sm-6 col-md-4">
    	      				<div class="i-ttd-boxes site-color-1-bg site-color-1-lighten-bg-hover text-white">
    	      			    <cfif len(website)>
    		      			    <a hreflang="en" href="#website#" target="_blank">
    		      			    	<cfif len(photo)>
    		      			    		<img src="/images/thingstodo/#photo#">
    		      			    	<cfelse>
    		      			    		<img src="http://placehold.it/359x177&text=No%20Image">
    		      			    	</cfif>
    		      			    </a>
    	      			    <cfelse>
    	      			    	<cfif len(photo)>
    	      			    		<img src="/images/thingstodo/#photo#">
    	      			    	<cfelse>
    	      			    		<img src="http://placehold.it/359x177&text=No%20Image">
    	      			    	</cfif>
    	      			    </cfif>
    	      					<div class="box-info">
    	      						<p class="h4 text-black">#title#</p>
    	      					  <p>#description#</p>
    	      						<cfif len(website)>
    	      							<a hreflang="en" href="#website#" target="_blank" class="btn site-color-4-bg site-color-4-lighten-bg-hover text-black details">More Info</a>
    	      						</cfif>
    	      					</div>
    	      				</div>
    	      			</div>
  	      			</cfoutput>
	        		</cfloop>
	      		</div>
	  			</cfcache>
	  		</div>
	  	</div>
	  </div>
	</div>
<cfelse>
	Sorry, that category was not found.
</cfif>

<cfinclude template="/components/footer.cfm">