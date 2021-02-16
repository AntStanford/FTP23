<cfquery name="getCallouts" dataSource="#settings.dsn#">
  select id,title,description,photo,link
  from cms_callouts
</cfquery>
<div class="i-callouts">
	<div class="row">
  	<cfoutput query="getCallouts">
  		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
        <div class="thumbnail site-color-3-bg site-color-1-bg-hover">
          <a hreflang="en" href="#link#"><img src="/images/callouts/#photo#" alt="#title#" width="100%"></a>
          <div class="caption">
            <p class="h4 text-white">#title#</p>
            #description#
            <p><a hreflang="en" href="#link#" class="btn btn-block site-color-3 site-color-4-bg site-color-4-lighten-bg-hover"><i class="fa fa-file-text-o"></i> Click for Details</a></p>
          </div>
        </div>
  		</div>
  	</cfoutput>
	</div>
</div>