<cfquery name="getinfo" dataSource="#settings.dsn#">
	select * from cms_resorts order by name
</cfquery>

<style>
.cms-resorts-option-2 { margin: 25px 0; }
.cms-resorts-option-2 ul { margin: 0; padding: 0; }
.cms-resorts-option-2 li  { list-style: none; margin: 0 0 15px; }
.cms-resorts-option-2 img { width: 100%; }
.cms-resorts-option-2 .block { padding: 0 0.5%; }
.cms-resorts-option-2 h3 { margin: 0 0 10px; }
.cms-resorts-option-2 p { margin: 0 0 10px; }
@media (max-width: 480px) {
  .cms-resorts-option-2 [class^="col-"] { width: 100%; }
  .cms-resorts-option-2 img { margin: 0 0 25px; }
}
</style>

<div class="cms-resorts-option-2">
  <ul>
    <cfloop query="getinfo">
	    <cfoutput>
	    <li>
	      <div class="well">
	        <div class="row">
	          <div class="col-md-3 col-sm-4 col-xs-6">
	            <cfif len(mainphoto)>
		          	<a hreflang="en" href="/resort/#slug#"><img src="/images/resorts/#mainphoto#"></a>
		          <cfelse>
		          	<a hreflang="en" href="/resort/#slug#"><img src="http://placehold.it/400x300&text=placeholder"></a>
		          </cfif>
	          </div>
	          <div class="col-md-9 col-sm-8 col-xs-6">
	            <div class="block">
	              <p class="h3"><a hreflang="en" href="/resort/#slug#" class="site-color-1 site-color-1-lighten-hover">#name#</a></p>
	              <p>#mid(description,1,200)#...</p>
	            </div>
	          </div>
	        </div>
	      </div>
	    </li>
	    </cfoutput>
    </cfloop>
  </ul>
</div>