<cfquery name="rentals" dataSource="#settings.dsn#">
  SELECT * from cms_long_term_rentals
</cfquery>


<div class="container mainContent booking">
  <cfoutput>
    <h1>#page.h1#</h1>
    #page.body#
  </cfoutput>
  <div class="row row-fluid bresults">
    <div class="col-md-12 col-sm-12">
      <div id="list-all-results">
        <cfoutput query="rentals">
          <cfset strFurnished = iif(furnished, DE("Yes"), DE("No"))>
          <cfset detailsLink = "/long-term/#id#">
          <div id="#name#" class="panel panel-default"
              data-seoname="#name#"
              data-unitshortname="#name#"
              data-photo="<!--- #defaultPhoto# --->"
              data-latitude="#latitude#"
              data-longitude="#longitude#"
              data-propertyid="<!--- #strpropid# --->"
              data-straddress1="#address1#"
              data-dblbeds="#beds#"
              data-intoccu="<!--- #intoccu# --->"
              data-strlocation="">
            <div class="panel-heading">
              <h3 style="margin:0;font-size:60px">
                <a hreflang="en" href="#detailslink#">#name#</a>
                <span class="lead pull-right" style="font-size:40px">
                  #DollarFormat(rate)# per month
                </span>
              </h3>
            </div>
            <div class="panel-body npbot">
              <div class="row row-fluid">
                <div class="span6 col-md-6">
                  <!---
                  <div class="prop-map img-thumbnail img-responsive img-rounded">
                    <div class="map"></div>
                  </div>
                  --->
                  <div class="prop-image">

                    <!--- Let's get an image --->
				            <cfquery name="AllImages" dataSource="#settings.dsn#">
                      select photo from cms_long_term_rentals_photos where rental_id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#rentals.id#"> order by sort
                    </cfquery>

                    <div class="long-term-gallery-wrap">
                      <div class="container gallery-container placeholder">
                        <div class="owl-carousel owl-theme long-term-carousel">
                          <cfif AllImages.recordcount gt 0>
                            <cfloop query = "AllImages">
                              <div class="item">
                                <a hreflang="en" href="#detailsLink#" class="fancybox" data-fancybox="owl-gallery-group">
                                  <div class="owl-lazy" data-src="/images/long-term/#photo#" alt=""></div>
                                </a>
                              </div>
                            </cfloop>
                          <cfelse>
                            <div class="item">
                              <a hreflang="en" href="javascript:;" class="fancybox" data-fancybox="owl-gallery-group">
                                <div class="owl-lazy" data-src="http://placehold.it/405x305&text=Image Not Available" alt=""></div>
                              </a>
                            </div>
                          </cfif>
                        </div>
                        <!---
                        <div class="cssload-container">
                          <div class="cssload-tube-tunnel"></div>
                        </div>
												--->
                      </div>
                    </div><!-- END owl-gallery-wrap -->

                  </div>
                </div>
                <div class="span6 col-md-6">
                  <ul class="list-group">
                    <li class="list-group-item">
                      <table class="table" style="margin:0">
                        <tr>
                          <td class="quick-facts">
                            <b>Quick Facts:</b><br>
                            <!--- <b>Type:</b> #strType#<br> --->
                            <!---
                            <cfif strType eq 'condo'>
                              <cfquery name="getResortSlug" dataSource="#settings.dsn#">
                                select slug from cms_resorts where name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rentals.strCountry#">
                              </cfquery>
                              <cfif getResortSlug.recordcount gt 0>
                                <b>Resort:</b> <a hreflang="en" href="/resort/#getResortSlug.slug#">#strCountry#</a><br />
                              <cfelseif strCountry is not "">
                                <b>Resort:</b> #strCountry#<br />
                              </cfif>
                            </cfif>
                            --->
                            <!--- <b>Area:</b> #strArea#<br> --->
                            <!---
                            <cfif featureList contains 'Pets Permitted'>
                              <b>Dogs Allowed:</b> Yes<br />
                            <cfelse>
                              <b>Dogs Allowed:</b> No<br />
                            </cfif>
                            --->
                          </td>
                          <td>
                            <ul class="list-group bbs">
                              <li class="list-group-item"><span class="badge">#beds#</span><b>Bedrooms:</b></li>
                              <li class="list-group-item"><span class="badge">#baths#</span><b>Baths:</b></li>
                              <li class="list-group-item"><span class="badge">#strFurnished#</span><b>Furnished:</b></li>
                              <!--- <li class="list-group-item"><span class="badge">#intoccu#</span><b>Sleeps:</b></li> --->
                            </ul>
                          </td>
                        </tr>
                        <tr>
                          <td colspan="2" class="highlights">
                            <!---QUERY TO COUNT THE NUMBER OF PEOPLE INTERESTED IN THE PROPERTY --->
                            <!---
                            <cfif ShowPropertyInterestCount is "Yes">
                              <cfset ThreeDaysEarlier = "#dateadd('d','-3',Now())#">
                              <CFQUERY DATASOURCE="#settings.dsn#" NAME="GetPropertyViews">
                                SELECT DISTINCT TrackingEmail,UserTrackerValue
                                FROM be_prop_view_stats WHERE createdAt >= <cfqueryparam value="#ThreeDaysEarlier#" cfsqltype="CF_SQL_TIMESTAMP">
                                and unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rentals.strpropid#">
                                GROUP BY TrackingEmail,UserTrackerValue desc
                              </CFQUERY>
                              <cfif GetPropertyViews.recordcount gte 10>
                                <br>#GetPropertyViews.recordcount# people are interested in this property!
                              </cfif>
                            </cfif>
                            --->
                          </td>
                        </tr>
                      </table>
                    </li>
                    <li class="list-group-item brdescription">
                      <b>Description:</b><br>
                      #Description#
                    </li>
                  </ul>
                  <div class="btn-group btn-group-justified bractions">
                    <div class="btn-group"><a hreflang="en" href="#detailsLink#" class="btn btn-info"><span class="glyphicon glyphicon-list"></span> Details</a></div>
                    <!---
                    <cfif ListFind(cookie.favorites,rentals.strpropid)>
                      <div class="btn-group"><a hreflang="en" href="javascript:;" class="btn btn-danger add-to-fav-results active"><span class="glyphicon glyphicon-heart-empty"></span> Unfavorite</a></div>
                    <cfelse>
                      <div class="btn-group"><a hreflang="en" href="javascript:;" class="btn btn-danger add-to-fav-results"><span class="glyphicon glyphicon-heart-empty"></span> Favorite</a></div>
                    </cfif>
                    --->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </cfoutput>
      </div>
    </div>
    <form class="ltr-form" name="rental-inquire" id="rental-inquire" method="post" action="/submit.cfm">
      <cfinclude template="/cfformprotect/cffp.cfm">
      <input type="hidden" name="longterminquire" value="">
      <h4>Long Term Rental Inquiry</h4>
      <div class="form-group">
        <label>Name</label> <font color="red"><b>*</b></font>
        <input class="form-control" type="text" name="name" placeholder="Name">
      </div>
      <div class="form-group">
        <label>Email</label> <font color="red"><b>*</b></font>
        <input class="form-control" type="text" name="email" placeholder="Email">
      </div>
      <div class="form-group">
        <label>Phone</label>
        <input class="form-control" type="text" name="phone" placeholder="Phone">
      </div>
      <div class="form-group">
        <label>Property Address</label>
        <input class="form-control" type="text" name="propaddr" placeholder="Property Address">
      </div>
      <div class="form-group">
        <label>Long Term Rental Inquiry</label>
        <textarea class="form-control" name="longterm_comments" placeholder="I'd like to learn more about..."></textarea>
      </div>
      <div class="form-group">
        <input class="btn coral" type="submit" value="Submit" onClick="ga('send', 'event', { eventCategory: 'contact', eventAction: 'submitted', eventLabel: 'long-term-rental-inquiry'});">
      </div>
    </form>
    <form class="ltr-form" name="management-inquire" id="management-inquire" method="post" action="/submit.cfm">
      <cfinclude template="/cfformprotect/cffp.cfm">
      <input type="hidden" name="propertymanagementinquire" value="">
      <h4>Property Management Inquiry</h4>
      <div class="form-group">
        <label>Name</label> <font color="red"><b>*</b></font>
        <input class="form-control" type="text" name="name" placeholder="Name">
      </div>
      <div class="form-group">
        <label>Email</label> <font color="red"><b>*</b></font>
        <input class="form-control" type="text" name="email" placeholder="Email">
      </div>
      <div class="form-group">
        <label>Phone</label>
        <input class="form-control" type="text" name="phone" placeholder="Phone">
      </div>
      <div class="form-group">
        <label>Property Address</label>
        <input class="form-control" type="text" name="propaddr" placeholder="Property Address">
      </div>
      <div class="form-group">
        <label>Property Management Inquiry</label>
        <textarea class="form-control" name="propmgmt_comments" placeholder="Can you manage our rental for us?"></textarea>
      </div>
      <div class="form-group">
        <input class="btn coral" type="submit" value="Submit">
      </div>
    </form>
  </div>
</div>



<!--- CSS for validation --->
<style>
label.error{color:red;}
label.valid{display:none !important;}
</style>

<cf_htmlfoot>
<script>
$(document).ready(function () {
  $('#management-inquire').validate({
    rules: {
      name: {
        minlength: 2,
        required: true
      },
      propmgmt_comments: {
        minlength: 2,
        required: true
      },
      email: {
        required: true,
        email: true
      },
    },
    highlight: function (element) {
      $(element).closest('.control-group').removeClass('success').addClass('error');
    },
    success: function (element) {
      element.text('OK!').addClass('valid')
      .closest('.control-group').removeClass('error').addClass('success');
    }
  });
  $('#rental-inquire').validate({
    rules: {
      name: {
        minlength: 2,
        required: true
      },
      longterm_comments: {
        minlength: 2,
        required: true
      },
      email: {
        required: true,
        email: true
      },
    },
    highlight: function (element) {
      $(element).closest('.control-group').removeClass('success').addClass('error');
    },
    success: function (element) {
      element.text('OK!').addClass('valid')
      .closest('.control-group').removeClass('error').addClass('success');
    }
  });
});
</script>
</cf_htmlfoot>