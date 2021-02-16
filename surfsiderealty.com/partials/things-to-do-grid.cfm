<style>
.cms-thingstodo-option-2 { margin: 25px 0; }
.cms-thingstodo-option-2 .hover-border { background: #000; position: relative; float: left; overflow: hidden; margin: 10px 0; height: auto; background: #000; text-align: center; cursor: pointer; }
.cms-thingstodo-option-2 .hover-border + p { display: inline-block; width: 22%; vertical-align: top; }
.cms-thingstodo-option-2 .hover-border img { height: 300px; object-fit: cover; opacity: 0.9; -webkit-transition: opacity 0.35s; transition: opacity 0.35s; position: relative; display: block; min-height: 100%; width: 100%; opacity: 0.8; cursor: pointer; }
.cms-thingstodo-option-2 .hover-border span { padding: 2em; color: #fff; text-transform: uppercase; font-size: 1.25em; -webkit-backface-visibility: hidden; backface-visibility: hidden; }
.cms-thingstodo-option-2 .hover-border span, .cms-thingstodo-option-2 .hover-border span > a { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
.cms-thingstodo-option-2 .hover-border span:before { content: ""; position: absolute; top: 30px; right: 30px; bottom: 30px; left: 30px; border: 2px solid #fff; box-shadow: 0 0 0 30px rgba(255,255,255,0.2); opacity: 0; -webkit-transition: opacity 0.35s, -webkit-transform 0.35s; transition: opacity 0.35s, transform 0.35s; -webkit-transform: scale3d(1.4,1.4,1); transform: scale3d(1.4,1.4,1); }
.cms-thingstodo-option-2 .hover-border span:before { top: 10px; right: 10px; bottom: 10px; left: 10px; }
.cms-thingstodo-option-2 .hover-border .h2, .cms-thingstodo-option-2 .hover-border p { margin: 0; }
.cms-thingstodo-option-2 .hover-border .h2 { font-style: normal; opacity: 0; -webkit-transition: -webkit-transform 0.35s; transition: transform 0.35s; font-weight: 300; color: #fff; font-size: 70px; text-align: center; position: absolute; top: 50%; left: 50%; -webkit-transform: translate(-50%,-50%); -moz-transform: translate(-50%,-50%); -ms-transform: translate(-50%,-50%); -o-transform: translate(-50%,-50%); transform: translate(-50%,-50%); padding: 0; margin: 0; width: auto; height: auto; }
.cms-thingstodo-option-2 .hover-border p {  padding: 1em; opacity: 0; -webkit-transition: opacity 0.35s, -webkit-transform 0.35s; transition: opacity 0.35s, transform 0.35s; -webkit-transform: scale(1.5); transform: scale(1.5); letter-spacing: 1px; font-size: 68.5%; color: #fff; }
.cms-thingstodo-option-2 .hover-border span > a { text-indent: 200%; white-space: nowrap; font-size: 0; opacity: 0; cursor: pointer; z-index: 1000; }
.cms-thingstodo-option-2 .hover-border span, .cms-thingstodo-option-2 .hover-border span > a { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
.cms-thingstodo-option-2 .hover-border:hover span::before, .cms-thingstodo-option-2 .hover-border:hover p { opacity: 1; -webkit-transform: scale3d(1,1,1); transform: scale3d(1,1,1); }
.cms-thingstodo-option-2 .hover-border:hover .h2 { opacity: 1; -webkit-transition: opacity 0.35s, -webkit-transform 0.35s; transition: opacity 0.35s, transform 0.35s; -webkit-transform: translate(-50%,-50%) scale(0.5); transform: translate(-50%,-50%) scale(0.5); }
.cms-thingstodo-option-2 .hover-border:hover span { background-color: rgba(0,0,0,0); }
.cms-thingstodo-option-2 .hover-border:hover img { opacity: 0.4; }
.cms-thingstodo-option-2 .hover-border .view { position: absolute; bottom: 10%; left: 0; right: 0; }
@media only screen and (max-width: 1200px) {
	.cms-thingstodo-option-2 .hover-border + p { width: 47%; text-align: left; margin-left: 3%; }
	.cms-thingstodo-option-2 .hover-border .h2 { font-size: 34px; }
}
@media only screen and (max-width: 992px) {
	.cms-thingstodo-option-2 .hover-border .h2 { margin-top: 12%; font-size: 39px; }
}
</style>

<cfcache key="cms_thingstodo" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select
      cms_thingstodo_categories.title as category,
      cms_thingstodo_categories.photo as categoryPhoto,
      cms_thingstodo_categories.slug as categorySlug,
      cms_thingstodo.*
    from cms_thingstodo
    join cms_thingstodo_categories on cms_thingstodo.catId = cms_thingstodo_categories.id
    order by category, createdAt
  </cfquery>
  <cfif getinfo.recordcount gt 0>
    <div class="cms-thingstodo-option-2">
      <div class="row">
        <cfset currentrow = 1>
        <cfoutput query="getinfo" group="category">
          <div class="col-md-6">
            <div class="hover-border">
              <cfif len(categoryPhoto)>
              	<img src="/images/thingstodo/#getinfo.categoryPhoto#">
              <cfelse>
              	<img src="http://placehold.it/400x300&text=placeholder">
              </cfif>
              <span>
                <em class="h2">#category#</em>
                <p class="view">View <i class="glyphicon glyphicon-chevron-right"></i></p>
                <a hreflang="en" href="/thingstodo/#categorySlug#">#category#</a>
              </span>
            </div>
          </div>
      	  <cfset currentrow = currentrow + 1>
        </cfoutput>
      </div>
    </div>
  </cfif>
</cfcache>