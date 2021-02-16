<cfquery name="page" datasource="#settings.dsn#">
  Select * from cms_pages where slug = 'condo-rentals'
</cfquery>

<cfif isDefined('url.slug')>

  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select *
    from cms_condos where slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.slug#">
  </cfquery>

	<cfset form.camefromsearchform = ''>
  <cfset form.fieldnames = 'complex'>

  <cfset form.complex = getinfo.complex>

  <cfsavecontent variable="request.resortContent">
  <cfoutput query="getinfo">
    <div class="content int">
      <div class="container" style="width:100%;max-width:1400px">
        <div class="row">
          <div class="col-lg-12 text" style="padding:0">
            <div class="booking container bdetails" id="" style="width:100%;margin-bottom:0;padding:0">
              <!---
                <div class="row">
                  <div class="col-md-12"><a hreflang="en" href="javascript:history.go(-1)" class="btn"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Back to Search Results</a></div>
                </div>
              --->
              <div class="row">
                <div class="col-lg-6 col-md-5 col-sm-8 col-xs-12">
                  <div class="panel panel-default">
                    <div class="panel-heading">Condo Photos</div>
                    <div class="panel-body">
                      <div class="owl-gallery-wrap site-color-1-bg">
                        <div class="owl-gallery-loader-container"><div class="owl-gallery-loader-tube-tunnel"></div></div>
                        <div class="owl-carousel owl-theme owl-gallery">
                          <cfif getinfo.picture1 neq ''>
                            <div class="item">
                              <a hreflang="en" href="/images/condos/#getinfo.picture1#" class="fancybox" data-fancybox="owl-gallery-group">
                                <img class="owl-lazy" data-src="/images/condos/#getinfo.picture1#">
                                <!--- Caption Here if needed
                                <span class="owl-caption">#caption#</span>
                                --->
                              </a>
                            </div>
                          </cfif>
                          <cfif getinfo.picture2 neq ''>
                            <div class="item">
                              <a hreflang="en" href="/images/condos/#getinfo.picture2#" class="fancybox" data-fancybox="owl-gallery-group">
                                <img class="owl-lazy" data-src="/images/condos/#getinfo.picture2#">
                                <!--- Caption Here if needed
                                <span class="owl-caption">#caption#</span>
                                --->
                              </a>
                            </div>
                          </cfif>
                          <cfif getinfo.picture3 neq ''>
                            <div class="item">
                              <a hreflang="en" href="/images/condos/#getinfo.picture3#" class="fancybox" data-fancybox="owl-gallery-group">
                                <img class="owl-lazy" data-src="/images/condos/#getinfo.picture3#">
                                <!--- Caption Here if needed
                                <span class="owl-caption">#caption#</span>
                                --->
                              </a>
                            </div>
                          </cfif>
                          <cfif getinfo.picture4 neq ''>
                            <div class="item">
                              <a hreflang="en" href="/images/condos/#getinfo.picture4#" class="fancybox" data-fancybox="owl-gallery-group">
                                <img class="owl-lazy" data-src="/images/condos/#getinfo.picture4#">
                                <!--- Caption Here if needed
                                <span class="owl-caption">#caption#</span>
                                --->
                              </a>
                            </div>
                          </cfif>
                          <cfif getinfo.picture5 neq ''>
                            <div class="item">
                              <a hreflang="en" href="/images/condos/#getinfo.picture5#" class="fancybox" data-fancybox="owl-gallery-group">
                                <img class="owl-lazy" data-src="/images/condos/#getinfo.picture5#">
                                <!--- Caption Here if needed
                                <span class="owl-caption">#caption#</span>
                                --->
                              </a>
                            </div>
                          </cfif>
                        </div><!--- END owl-gallery --->

                        <div class="owl-carousel owl-theme owl-gallery-thumbs">
                          <cfif getinfo.picture1 neq ''>
                            <div class="item">
                              <span class="owl-lazy" data-src="/images/condos/#getinfo.picture1#"></span>
                            </div>
                          </cfif>
                          <cfif getinfo.picture2 neq ''>
                            <div class="item">
                              <span class="owl-lazy" data-src="/images/condos/#getinfo.picture2#"></span>
                            </div>
                          </cfif>
                          <cfif getinfo.picture3 neq ''>
                            <div class="item">
                              <span class="owl-lazy" data-src="/images/condos/#getinfo.picture3#"></span>
                            </div>
                          </cfif>
                          <cfif getinfo.picture4 neq ''>
                            <div class="item">
                              <span class="owl-lazy" data-src="/images/condos/#getinfo.picture4#"></span>
                            </div>
                          </cfif>
                          <cfif getinfo.picture5 neq ''>
                            <div class="item">
                              <span class="owl-lazy" data-src="/images/condos/#getinfo.picture5#"></span>
                            </div>
                          </cfif>
                        </div><!--- END owl-gallery-thumbs --->
                      </div><!--- END owl-gallery-wrap --->
                    </div>
                  </div><!-- END panel -->
                </div>
                <div class="col-lg-6 col-md-7 col-sm-12 col-xs-12">
                  <div class="panel panel-default">
                    <div class="panel-heading" style="line-height:normal">
                      <h2 style="margin:0;padding:0">#getinfo.condoname#</h2>
                      <h4 style="margin:0;text-transform:none">#getinfo.address#</h4>
                    </div>
                    <div class="panel-body">
                      <div class="row" style="padding:0 10px">
                        #getinfo.description#
                      </div>
                    </div><!-- END panel-body -->
                  </div><!-- END panel -->
                </div>
                  <div class="col-xs-12 col-sm-4 col-md-3">
                    <div class="panel panel-default booking-box">
                      <div class="panel-heading"><h3 class="text-center">Amenities</h3></div>
                      <div class="panel-body">
                        <cfif len(getinfo.amenities)>
                          <ul class="amenities-list">
                            <cfloop list="#getinfo.amenities#" index="i" delimiters=",">
                              <li style="float:none">#trim(i)#</li>
                            </cfloop>
                          </ul>
                        </cfif>
                      </div>
                    </div>
                  </div>

              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </cfoutput>

  <style>
  .gallery-controls a, .gallery-controls span { display: block; color: #fff; position: absolute; }
  .gallery-images, .gallery-images a { padding-bottom: 68%; }
  .gallery-slideshow {position: relative; }
  .gallery-controls { position: absolute; top: 50%; right: 0; left: 0; z-index: 999;}
  .gallery-controls a { height: 44px; padding: 15px; margin: auto; top: 0; bottom: 0; background: rgba(51,51,51,.5); box-sizing: border-box; }
  .gallery-controls a:hover { background: #333; text-decoration: none; }
  .gallery-controls a.cycle-prev { left: 0; border-radius: 0 4px 4px 0; }
  .gallery-controls a.cycle-next { right: 0; border-radius: 4px 0 0 4px; }
  .gallery-controls span, .gallery-thumb-controls a.cycle-prev { border-radius: 0 4px 4px 0; left: 0; }
  .gallery-controls a i { top: -4px; }
  .gallery-controls span { padding: 10px; top: -125px; background: #333; }
  .gallery-images > div { position: absolute !important; top: 0; left: 0; right: 0; bottom: 0; }
  .gallery-images, .gallery-images > div { width: 100%; overflow: hidden; }
  .gallery-thumbs:after, .gallery-thumbs:before { width: 10px; position: absolute; top: 0; background-color: #444; display: block; bottom: 0; z-index: 10; content: ""; }
  .gallery-images a { display: block; position: relative; }
  .gallery-thumbs { width: 100%; height: 82px; padding: 10px; position: relative; z-index: 999; background-color: #444; box-sizing: border-box; }
  .gallery-thumbs:before { left: 0; }
  .gallery-thumbs:after { right: 0; }
  .gallery-thumbs > div { margin-left: 10px !important; top: 10px !important; cursor: pointer; }
  .gallery-thumbs > div > div { width: 100px !important; height: 62px !important; margin-right: 5px; overflow: hidden; opacity: .5; -webkit-transition: opacity 250ms, border 250ms; -moz-transition: opacity 250ms, border 250ms; transition: opacity 250ms, border 250ms; position: relative !important; }
  .gallery-thumbs > div > div:hover { opacity: 1; }
  .gallery-thumbs > div > div.cycle-slide-active { display: block; height: 2px; border-bottom: 2px solid #fff; opacity: 1; }
  .gallery-thumb-controls { position: absolute; right: 0; left: 0; z-index: 999 !important; }
  .gallery-thumb-controls a { display: block; width: 30px; height: 44px; padding: 15px 5px; margin: auto; position: absolute; top: -64px; background: rgba(51,51,51,.65); color: #fff; text-align: center; box-sizing: border-box; }
  .gallery-thumb-controls a:hover { background: #333; text-decoration: none; }
  .gallery-thumb-controls a.cycle-next { right: 0; border-radius: 4px 0 0 4px; }
  .gallery-thumb-controls a i { top: -4px; }
  .gallery-images span, .gallery-thumbs > div > div span { display: block; width: 100%; height: 100%; position: absolute; top: 0; left: 0; right: 0; bottom: 0; background-size: cover !important; background-position: center center !important; background-repeat: no-repeat !important; }
  </style>
  </cfsavecontent>

  <!--- getinfo.condoname --->

  <hr>
  <cfinclude template="/partials/results.cfm">


<cfelse>

  <cfinclude template="/components/header.cfm">

  <div class="container mainContent">
    <cfquery name="GetCondos" datasource="#settings.dsn#">
      Select * from cms_condos
      order by condoname
    </cfquery>

    <h1>Condo Rentals | Surfside Beach & Garden City Beach</h1>
    <div class="row">
      <cfoutput query="GetCondos">
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
          <a hreflang="en" href="/condo-rentals/#slug#">
            <cfif len(picture1)>
              <img src="/images/condos/#picture1#" class="thumbnail" width="100%" height="250" style="margin:0;object-fit:cover;">
            <cfelse>
              <img src="//placehold.it/300x200&text=No%20Image" class="thumbnail" width="100%" height="250" style="margin:0;object-fit:cover;">
            </cfif>
          </a>
          <h4><a hreflang="en" href="/condo-rentals/#slug#">#condoname#</a></h4>
          <div class="description-text">
          #description2#
          </div>
          <a hreflang="en" href="/condo-rentals/#slug#" class="btn btn-primary">View Units</a><br><br>
        </div>
      </cfoutput>
    </div>
  </div>

  <style>
  @media (min-width: 769px) {
    .description-text { display: block; display: -webkit-box; max-width: 400px; height: 88px; margin: 0 auto; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; }
  }
  .description-text p, .description-text p span { font-size: 14px !important; }
  </style>
	<cfinclude template="/components/footer.cfm">
</cfif>

