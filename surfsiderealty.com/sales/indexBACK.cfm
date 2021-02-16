<cfinclude template="/sales/index_.cfm">
<cfinclude template="/sales/components/header.cfm">

<cfif isdefined('LinkToLogin') and (isdefined('session.loggedin') is "No" or isdefined('cookie.loggedin') is "No")>
  <script>
  $(document).ready(function(){
    $.fancybox('<div style="width:780px"><iframe src="/sales/lightboxes/create-account.cfm" width="765" height="434" frameborder="0"></iframe></div>',{'enableEscapeButton': false,'showCloseButton': false,'hideOnContentClick': true,'hideOnOverlayClick': false,'width': '75%','height': '75%','autoScale': false,'overlayOpacity': 0.9});
  });
  </script>
</cfif>



<!--- Start: Used to close Lightbox and Reload page --->
<cfset session.RememberMePage = "#script_name#?#query_string#">
<!--- End: Used to close Lightbox and Reload page --->



<div id="custom-advanced-search-page">

<div class="casp_left">
  <img src="/userfiles/group2.jpg">
</div>


<div class="casp_right">
<div class="qs-wrapper">
  
  <div class="mls-quick-search">

  <form action="/sales/search-results.cfm" class="enhanced-form" method="POST">

      <div class="small">
    <div class="form-field">
    
     <cfquery name="getmlscoinfo" datasource="#DSNMLS#">
        SELECT *
        FROM mlsfeeds
        where id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
     </cfquery>
    
      <label for="wsid">Property Type</label>
     <select id="wsid" name="wsid">
              <option value="">All Types</option>
              <cfloop index="i" list="#getmlscoinfo.wsid#">
                <cfoutput>
                  <option value="#listgetat(i,'1','~')#">#listgetat(i,'2','~')#</option>
                </cfoutput>
              </cfloop>
            </select>
    </div>

    <div class="form-field">

    <cfquery datasource="#dsnmls#" name="getCities" cachedwithin="#CreateTimeSpan(0, 12, 0, 0)#">  
      SELECT distinct(city)
      FROM mastertable
      where mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#mls.MLSID#">) and city <> ''
      order by city
    </cfquery>

      <label for="city">City</label>
      <select id="city" multiple="multiple" name="city">
              <cfoutput query="getCities">
                <option value="#city#">#city#</option>
              </cfoutput>
       </select> 
    </div>
</div>

    <div class="small">
      <div class="form-field">
        <label for="pmin">Minimum Price</label>
        <select id="pmin" name="pmin">
              <option value="0" <cfif isdefined('PMIN') is "No">selected</cfif>>No Min</option>
              <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
                <cfoutput>
                  <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
                </cfoutput>
                <cfif #i# eq "1000000">
                  <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
                    <cfoutput>
                      <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
                    </cfoutput>
                  </cfloop>
                  <cfbreak>
                </cfif>
              </cfloop>
            </select>
      </div>
          <cfoutput>
      <div class="form-field">
        <label for="pmax">Maximum Price</label>
        <SELECT id="pmax" name="pmax">
        <option value="999999999" <cfif isdefined('pmax') is "No">selected</cfif>>No Max</option>
          <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
            <cfoutput>
              <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
            </cfoutput>

          <cfif #i# eq "1000000">
            <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
              <cfoutput>
              <option value="#i#">$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
          </cfloop>

          <cfbreak>
          </cfif>
          </cfloop>
        </SELECT>
      </div>
      </cfoutput>
      <div class="form-field">
        <label for="bedrooms">Bedrooms</label>
        <select data-wsid="1" id="bedrooms" name="bedrooms">
          <option selected="selected" value="">No Preference</option>
              <option value="1">1+ Bedrooms</option>
              <option value="2">2+ Bedrooms</option>
              <option value="3">3+ Bedrooms</option>
              <option value="4">4+ Bedrooms</option>
              <option value="5">5+ Bedrooms</option>
              <option value="6">6+ Bedrooms</option>
        </select>
      </div>
      <div class="form-field">
        <label for="baths_full">Bathrooms</label>
        <select data-wsid="1" id="baths_full" name="baths_full">
          <option selected="selected" value="">No Preference</option>
              <option value="1">1+ Bathrooms</option>
              <option value="2">2+ Bathrooms</option>
              <option value="3">3+ Bathrooms</option>
              <option value="4">4+ Bathrooms</option>
              <option value="5">5+ Bathrooms</option>
        </select>
      </div>
   
    <div class="form-field">
      <label for="mlsnumber">MLS Number</label><input id="mlsnumber" name="mlsnumber" type="text" value=""></div>

   </div>

    <span class="search-buttons">
    <input class="button light" type="submit" value="Search">
    </span>
  </form>
  </div>

</div>
</div> <!--- casp_right --->




<div style="clear:both;"></div>
<p>&nbsp;</p>

<p>Surfside Beach is a small seaside community nestled in the heart of South Carolina's Grand Strand area. It encompasses 2 miles of pristine beach, enjoys a temperate climate and is both an active residential community and a thriving vacation destination.</p>

<p>This is the place where you will hear the ocean breezes, feel the soft white sand underneath your toes, and see the sandpiper birds race across the beach!  Whether it is your dream home or your vacation getaway you will just love living here creating lifetime memories with your family and friends.</p>

<p>We have been helping families find their homes along the South Strand in Surfside Beach and Garden City Beach since 1962.  We are your experts in this area. We love where we live, and you will too!</p>

<p>So if you're looking for that perfect place at the beach...  Look no more.  Just tell us what you want,  and let us do the rest!</p>

<p><b>Why We Love Living Here!</b></p>

<p>How could we not love living here? Each day starts with the sun peeking above a majestic ocean. Golfers can play a different course every day for more than three months. We have a healthy economy and a prosperous cultural community. The perfect place to work, play and raise a family. It's paradise. And it just doesn't get much better than that. </p>

<p><b>Myrtle Beach Real Estate</b></p>

<p>Real estate here runs the spectrum of your desires. Whether you want a simple starter home, or a grand palace, Surfside Realty will be able to help. What awaits outside of your dream home is what brings many to this area. The views of the Grand Strand are wondrous. From the marshes along the Waccamaw Neck, to deep-water access along the area's many rivers and creeks, to the shores of the Atlantic, there is something for every taste here.</p>

</div>

<cfinclude template="/sales/components/footer.cfm">
