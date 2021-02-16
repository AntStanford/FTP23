<cfquery name="getinfo" dataSource="#settings.dsn#">
	select * from cms_resorts order by name
</cfquery>

<style>
.cms-resorts-option-1 { margin: 10px 0 0; }
.cms-resorts-option-1 [class^="col-"] { margin-bottom: 25px; }
.cms-resorts-option-1 .col-md-4:nth-child(3n+1) { clear: both; }
.cms-resorts-option-1 .thumbnail { margin: 0 0 20px; box-shadow: #000 2px 2px 10px -5px; }
.cms-resorts-option-1 .thumbnail img { width: 100%; height: 200px; object-fit: cover; }
.cms-resorts-option-1 .block h3 { margin: 0 0 10px; }
.cms-resorts-option-1 .block p { margin: 0 0 10px; }
.cms-resorts-option-1 .block .btn { margin: 10px 0 0; }
@media (max-width: 992px) {
  .cms-resorts-option-1 .col-md-4:nth-child(3n+1) { clear: none; }
  .cms-resorts-option-1 .col-sm-6:nth-child(2n+1) { clear: both; }
}
@media (max-width: 480px) {
  .cms-resorts-option-1 [class^="col-"] { width: 100%; }
}
</style>

<div class="cms-resorts-option-1">
  <div class="row">
    <cfloop query="getinfo">
	    <cfoutput>
		    <div class="col-md-4 col-sm-6 col-xs-6">
		      <div class="block">
		        <div class="thumbnail">
		        	 <cfif len(mainphoto)>
		          	<a hreflang="en" href="/resort/#slug#"><img src="/images/resorts/#mainphoto#"></a>
		          <cfelse>
		          	<a hreflang="en" href="/resort/#slug#"><img src="http://placehold.it/400x300&text=placeholder"></a>
		          </cfif>
		        </div>
		        <p class="h3 site-color-2">#name#</p>
		        <p>#mid(description,1,200)#...</p>
		        <a hreflang="en" href="/resort/#slug#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white text-white-hover">More Information</a>
		      </div>
		    </div>
	    </cfoutput>
    </cfloop>
  </div>
</div>