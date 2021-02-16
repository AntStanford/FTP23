<style>
/* Specials Page: /specials */
.i-specials-box { background: #f9f9f9; border-radius: 4px; margin: 0; display: table; width: 100%; }
.i-specials-box [class^=col] { padding: 0; position: relative; display: table-cell; float: none; }
.i-specials-img { display: block; position: relative; padding-bottom: 50%; background-size: cover !important; background-position: center center !important; background-repeat: no-repeat !important; border-radius: 4px 0 0 4px; position: absolute; top: 0; left: 0; right: 0; bottom: 0; }
.i-specials-info { padding: 25px; }
.i-specials-info p.h3 { margin: 0 0 20px; padding: 0; }
@media (max-width: 768px) {
  .i-specials-box, .i-specials-box .col-xs-6 { display: block; width: 100%; }
  .i-specials-img { position: relative; padding-bottom: 60%; }
}
</style>

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_specials where #createodbcdate(now())# between startdate and enddate 
  and active = 'yes'
  order by startdate
</cfquery>

<cfif getinfo.recordcount gt 0>
  <cfoutput query="getinfo">
    <div class="row i-specials-box">
      <div class="col-md-4 col-sm-5 col-xs-6">
        <a href="">
          <cfif len(photo)>
            <span class="i-specials-img" style="background:url('/images/specials/#photo#');"></span>
          <cfelse>
            <span class="i-specials-img" style="background:url('http://placehold.it/300x200&text=No Image');"></span>
          </cfif>
        </a>
      </div>
      <div class="col-md-8 col-sm-7 col-xs-6">
        <div class="i-specials-info">
          <p class="h3"><a href="">#title#</a></p>
          <p>#description#</p>
          <cfif len(slug)>
          	<a href="/special/#slug#" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white">More Info</a>
          </cfif>
        </div>
      </div>
    </div><br>
  </cfoutput>
<cfelse>
  <div class="alert alert-info">
    <p><b>No specials found.</b></p>
  </div>
</cfif>

