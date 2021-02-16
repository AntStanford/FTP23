<style>
.testimonial-wrap { margin: 0 0 10px; }
.testimonial-item { margin: 0 0 25px; padding: 50px; border: none; box-shadow: #000 0 0 4px -2px; position: relative; transition: all .25s ease-in-out; }
.testimonial-item::before, .testimonial-item::after { display: block; position: absolute; line-height: 100px; font-size: 100px; opacity: 0.1; }
.testimonial-item::before { content: "\201C"; top: -21px; left: -12px; }
.testimonial-item::after { content: "\201D"; bottom: -65px; right: -12px; }
.testimonial-item:hover { box-shadow: #000 0 0 10px -2px; }
.testimonial-text { font-style: italic; font-size: 16px; line-height: 27px; }
.testimonial-user { display: block; text-align: right; font-weight: bold; font-size: 15px; margin: 15px 0 -15px; }
</style>

<cfcache key="cms_testimonials" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_testimonials order by createdAt
</cfquery>

<cfif getinfo.recordcount gt 0>
<div class="testimonial-wrap">
  <cfoutput query="getinfo">
    <blockquote class="testimonial-item">
      <span class="testimonial-text">#body#</span>
      <span class="testimonial-user">#user#</span>
    </blockquote>
  </cfoutput>
</div>
</cfif>

</cfcache>