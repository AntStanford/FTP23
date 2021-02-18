<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_testimonials order by rand(),createdAt limit 1
</cfquery>

<div class="i-testimonials lazy" data-src="/images/layout/testimonials-bg.jpg">
  <div class="container">
    <h2 class="h1 text-white text-center">Recent Client Testimonials</h2>
    <h6 class="text-white text-center">Hear what some of our clients have said about us</h6>
    <div class="testimonial-block">
      <cfif getinfo.recordcount gt 0>
        <cfoutput query="getinfo">
          <blockquote>
            <em class="open-quote">&##8220;</em>
            #body#
            <em class="end-quote">&##8221;</em>
          </blockquote>
          <div class="testimonial-signature text-white">
            <h5 class="site-color-2">#user#</h5>
            <!---<span class="text-black">Ocean Isle Beach</span>--->
          </div>
        </cfoutput>
      </cfif>
    </div>
  </div>
</div>