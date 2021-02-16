<style>
.cms-faqs-option-1 { margin: 25px 0; }
.cms-faqs-option-1 .panel-default > .panel-heading { padding: 0; }
.cms-faqs-option-1 .panel-title > a { display: block; padding: 10px; }
.cms-faqs-option-1 .panel-title > a:hover, .cms-faqs-option-1 .panel-title > a:active, .cms-faqs-option-1 .panel-title > a:focus { text-decoration: none; background: #eee; }
.cms-faqs-option-1 .panel-title > a .fa { border-right: 1px rgba(0,0,0,0.2) solid; padding: 0 13px 0 5px; margin: 0 10px 0 0; }
</style>

<cfcache key="cms_faqs" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">

	<cfquery name="getinfo" dataSource="#settings.dsn#">
	  select * from cms_faqs order by id
	</cfquery>
	
	<cfif getinfo.recordcount gt 0>
	  <div class="cms-faqs-option-1">
	    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
	      <cfset currentrow = 1>
	      <cfoutput query="getinfo">
	    	  <cfset numAsString = NumberAsString(currentrow)>
	    	  <cfset numAsString = trim(numAsString)>
	        <div class="panel panel-default">
	          <div class="panel-heading" role="tab" id="heading#numAsString#">
	            <p class="h4 panel-title">
	              <a hreflang="en" href="##collapse#numAsString#" aria-controls="collapse#numAsString#" aria-expanded="true" role="button" data-toggle="collapse" data-parent="##accordion">
	                <i class="fa fa-question-circle"></i> #question#
	              </a>
	            </p>
	          </div>
	          <div id="collapse#numAsString#" class="panel-collapse collapse" role="tabpanel">
	            <div class="panel-body">
	              #answer#
	            </div>
	          </div>
	        </div>
	    	  <cfset currentrow = currentrow + 1>
	      </cfoutput>
	    </div>
	  </div>
	</cfif>

</cfcache>
