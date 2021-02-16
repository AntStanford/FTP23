<cfcache key="cms_assets" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">
  <cfquery name="getinfo" dataSource="#settings.dsn#">
  	select * from cms_assets
  	where section = 'Gallery'
  	order by `sort`
  </cfquery>
  <cfoutput>
    <div class="owl-gallery-wrap site-color-1-bg">
      <div class="owl-gallery-loader-container"><div class="owl-gallery-loader-tube-tunnel"></div></div>
      <div class="owl-carousel owl-theme owl-gallery">
        <cfloop query="getinfo">
          <cfoutput>
            <div class="item">
              <a hreflang="en" href="/images/gallery/#replace(thefile,' ','%20','all')#" class="fancybox" data-fancybox="owl-gallery-group">
                <img class="owl-lazy" data-src="/images/gallery/#replace(thefile,' ','%20','all')#">
                <!--- Caption Here if needed
                <span class="owl-caption">#caption#</span>
                --->
              </a>
            </div>
          </cfoutput>
        </cfloop>
      </div>
      <div class="owl-carousel owl-theme owl-gallery-thumbs">
        <cfloop query="getinfo">
          <cfoutput>
            <div class="item">
              <span class="owl-lazy" data-src="/images/gallery/#replace(thefile,' ','%20','all')#"></span>
            </div>
          </cfoutput>
        </cfloop>
      </div>
    </div>
  </cfoutput>
</cfcache>