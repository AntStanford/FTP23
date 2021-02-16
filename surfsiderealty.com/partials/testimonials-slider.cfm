<!--- This uses FontAwsome --->
<style>
#testimonial-carousel { padding: 0 10px 30px 10px; margin-top: 30px; }
#testimonial-carousel .carousel-control { background: none; color: #222; font-size: 30px; text-shadow: none; margin-top: 30px; }
#testimonial-carousel .carousel-control.left { left: -12px; }
#testimonial-carousel .carousel-control.right { right: -12px !important; }
#testimonial-carousel .carousel-indicators { right: 50%; top: auto; bottom: 0px; margin-right: -19px; }
#testimonial-carousel .carousel-indicators li { background: #c0c0c0; }
#testimonial-carousel .carousel-indicators .active { background: #333333; }
#testimonial-carousel img { width: 100px; height: 100px; }
#testimonial-carousel .item blockquote { border-left: none; margin: 0 30px; }
#testimonial-carousel .item blockquote img { margin-bottom: 10px; }
#testimonial-carousel .item blockquote p:before { content: "\f10d"; font-family: 'Fontawesome'; float: left; margin-right: 10px; }
@media (min-width: 768px) {
  #testimonial-carousel { margin-bottom: 0; padding: 0 40px 30px 40px; }
}
@media (max-width: 768px) {
  #testimonial-carousel .carousel-indicators { bottom: -20px !important; }
  #testimonial-carousel .carousel-indicators li { display: inline-block; margin: 0px 5px; width: 15px; height: 15px; }
  #testimonial-carousel .carousel-indicators li.active { margin: 0px 5px; width: 20px; height: 20px; }
}
</style>

<cfcache key="cms_testimonials" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_testimonials order by createdAt
</cfquery>

<cfif getinfo.recordcount gt 0>

<div class="testimonial-wrap">
  <div class="carousel slide" data-ride="carousel" id="testimonial-carousel" data-interval="false">
    <ol class="carousel-indicators">
      <cfset counter = 0>
      <cfoutput query="getinfo">
        <li data-target="##testimonial-carousel" data-slide-to="#counter#"<cfif counter eq 0> class="active"</cfif>></li>
    	  <cfset counter = counter + 1>
      </cfoutput>
    </ol>
    <div class="carousel-inner">
      <cfset counter = 0>
      <cfoutput query="getinfo">
        <div class="item<cfif counter eq 0> active</cfif>">
          <blockquote>
            <div class="row">
              <div class="col-sm-12">
                #body#
                <small>#user#</small>
              </div>
            </div>
          </blockquote>
        </div>
    	  <cfset counter = counter + 1>
      </cfoutput>
    </div>
    <a data-slide="prev" href="#testimonial-carousel" class="left carousel-control"><i class="fa fa-chevron-left"></i></a>
    <a data-slide="next" href="#testimonial-carousel" class="right carousel-control"><i class="fa fa-chevron-right"></i></a>
  </div>
</div>

</cfif>

</cfcache>