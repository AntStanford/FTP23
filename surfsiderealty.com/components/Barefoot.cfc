<cfcomponent hint="Barefoot CFC">
   
   <cffunction name="init" access="public" output="false" hint="constructor">
      <cfargument name="settings" type="struct" required="true" hint="settings" />
      <cfset variables.dsn = arguments.settings.dsn />
      <cfset variables.bookingDSN = arguments.settings.booking.dsn />
      <cfset variables.imagePath = arguments.settings.booking.imagePath>
      <cfreturn this />
   </cffunction>
   
   <cffunction name="getSearchResultsProperty" returnType="query">
   	
   	<cfargument name="searchterm" required="true">
   	
		<cfquery DATASOURCE="#variables.bookingDSN#" NAME="results">
			SELECT seoPropertyName,propertyid,name as propertyname,description as propertydesc
			FROM bf_properties
			where name like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or extdescription like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">	  
			or description like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or unitcomments like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or internetDescription like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">
			or propAddress like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.SearchTerm#%">  
		</cfquery>
		
		<cfreturn results>
   	
   </cffunction>
   
   <cffunction name="getFeaturedProperties" returnType="query">
      
         <cfquery name="getFeaturedProperties" dataSource="#variables.DSN#">
            select strpropid from cms_featured_properties order by rand()
         </cfquery>
         
         <cfif getFeaturedProperties.recordcount gt 0>
            
            <cfset var propList = ValueList(getFeaturedProperties.strpropid)>
            
            <cfquery name="getProperties" dataSource="#variables.bookingDSN#">
               select 
                  propertyid,
                  name,
                  bedrooms,
                  bathrooms,
                  maxoccupancy as sleeps,
                  imagePath as photo,
                  seopropertyname,
                  propAddress as address
               from bf_properties
               where propertyid IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propList#" list="yes">)
            </cfquery>
            
         <cfelse>
            
            <cfquery name="getProperties" dataSource="#variables.bookingDSN#">
               select 
                  propertyid,
                  name,
                  bedrooms,
                  bathrooms,
                  maxoccupancy as sleeps,
                  imagePath as photo,
                  seopropertyname,
                  propAddress as address
               from bf_properties
               order by rand()
               limit 6
            </cfquery>
            
         </cfif>
         
         <cfreturn getProperties>
      
   </cffunction>
   
   <cffunction name="setMetaData" returnType="string">
      
      <cfargument name="property" required="true">
      <cfargument name="settings" required="true">
      
      <cfsavecontent variable="temp">
         <cfoutput>
         <title>#property.name# - #arguments.settings.company#</title>
         <cfset tempDescription = striphtml(mid(property.description,1,155))>
         <meta name="description" content="#tempDescription#">
         <meta property="og:title" content="#property.name# - #arguments.settings.company#">
         <meta property="og:description" content="#tempDescription#">
         <meta property="og:url" content="http://#cgi.http_host#/rentals/#property.seopropertyname#/#property.propertyid#">
         <meta property="og:image" content="#property.imagePath#">
         </cfoutput>
      </cfsavecontent>
      
      <cfreturn temp>
   
   </cffunction>
   
   
   <cffunction name="setGoogleAnalytics" returnType="string">
      
      <cfargument name="settings" required="true">
      <cfargument name="form" required="true">
      <cfargument name="reservationNumber" required="true" type="string">
      
      <!--- remove apostraphes from unit name --->
      <cfset propertyNameSafe = replace(form.propertyname, "'", '', 'all')>
      
      <cfsavecontent variable="temp">
      <cfoutput>
         <script type="text/javascript" defer="defer">
           (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
           (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
           m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
           })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
         
           ga('create', '#settings.googleAnalytics#', 'auto','nativeTracker');
           ga('nativeTracker.send', 'pageview');
         
           ga('nativeTracker.require', 'ecommerce', 'ecommerce.js');
         
         	ga('nativeTracker.ecommerce:addTransaction', {
         	id: '#reservationNumber#', // Transaction ID - this is normally generated by your system.
         	affiliation: '#settings.company#', // Affiliation or store name
         	revenue: '#form.totalAmountForAPI#', // Grand Total
         	shipping: '0' , // Shipping cost
         	tax: '0' }); // Tax.
         
         	ga('nativeTracker.ecommerce:addItem', {
         	id: '#reservationNumber#', // Transaction ID.
         	sku: '#form.propertyid#', // SKU/code.
         	name: '#propertyNameSafe#', // Product name.
         	category: 'Rental', // Category or variation.
         	price: '#form.totalAmountForAPI#', // Unit price.
         	quantity: '1'}); // Quantity.
         
         	ga('nativeTracker.ecommerce:send');
         </script>
      </cfoutput>
      </cfsavecontent>
      
      <cfreturn temp>
   
   </cffunction>
   
   
   <cfscript>
   function stripHTML(str) {
   	str = reReplaceNoCase(str, "<*style.*?>(.*?)</style>","","all");
   	str = reReplaceNoCase(str, "<*script.*?>(.*?)</script>","","all");
   
   	str = reReplaceNoCase(str, "<.*?>","","all");
   	//get partial html in front
   	str = reReplaceNoCase(str, "^.*?>","");
   	//get partial html at end
   	str = reReplaceNoCase(str, "<.*$","");
   	return trim(str);
   }
   </cfscript>

</cfcomponent>