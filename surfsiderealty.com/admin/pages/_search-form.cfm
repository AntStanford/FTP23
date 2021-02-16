<cfif parameterexists(id) and getinfo.customSearchJSON neq ''>
  <!--- This is for the Custom Results form tab --->
  <cfset data = deserializeJSON(getinfo.customSearchJSON)>
  <cfset structure_key_list = structKeyList(data)>
  <cfloop list="#structure_key_list#" index="k">
    <cfset form[k] = data[k]>
  </cfloop>
</cfif>
<style type="text/css">
  .custom-search-fields > .control-group {padding-top: 25px;}
  .control-group {padding-bottom:10px}
  .control-group > .span6 {margin: 0; padding: 0 30px;}
  .control-group > .span6 > div {margin-bottom: 25px;}
  .form-group .input-append {margin: 0 10px 10px 0;}
  .form-group .split {display: inline-block; width: 49%; margin-right: -4px; box-sizing: border-box;}
  .form-group .split + .split {margin-left: 2%;}
  @media (max-width: 768px) {
    .form-horizontal .controls, .form-horizontal .control-label, .control-group > .span6 {padding: 0 15px;}
    .form-group .split, .form-group .split + .split {width: 100%; margin: 0 0 10px;}
  }
</style>
<script>
  $(document).ready(function(){
    $('#clearDates').on('click', function(){
      $('.datepicker').val('');
    });
  });
</script>

<cfoutput>

<div class="control-group">
  <div class="span6">
    <div class="form-group">
      <label><b>Choose dates</b></label>
      <div class="input-append">
        <cfif parameterexists(id) and isdefined('form.strcheckin') and form.strcheckin neq ''>
          <input type="text" class="input-small datepicker nomargin" placeholder="Arrival Date" name="strcheckin" value="#form.strcheckin#">
        <cfelse>
          <input type="text" class="input-small datepicker nomargin" placeholder="Arrival Date" name="strcheckin">
        </cfif>
        <span class="add-on"><i class="icon-calendar"></i></span>
      </div>

      <div class="input-append">
        <cfif parameterexists(id) and isdefined('form.strcheckout') and form.strcheckout neq ''>
          <input type="text" class="input-small datepicker nomargin" placeholder="Departure Date" name="strcheckout" value="#form.strcheckout#">
        <cfelse>
          <input type="text" class="input-small datepicker nomargin" placeholder="Departure Date" name="strcheckout">
        </cfif>
        <span class="add-on"><i class="icon-calendar"></i></span>
      </div>
      <br>
      <a href="javascript:;" id="clearDates" class="btn clear-dates">Clear Dates</a>
    </div>


    <cfset locationList = settings.booking.locationList>
    <cfif listlen(locationList)>
          <div class="form-group">
            <label><b>Location</b></label>
            <div>
              <cfloop list="#locationList#" index="i">
                <cfoutput>
                <label class="checkbox">
                <cfif parameterexists(id) and isdefined('form.location') and ListFind(form.location,i)>
                      <input type="checkbox" name="location" value="#i#" checked="checked">
                    <cfelse>
                      <input type="checkbox" name="location" value="#i#">
                    </cfif>
                    #i#
                  </label>
                  </cfoutput>
                </cfloop>
            </div>
          </div>
    </cfif>

    <cfset typelist = 'House,Condo'>
    <cfif listlen(typeList)>
          <div class="form-group">
            <label><b>Unit Type</b></label>
            <div>
            <cfset typeList = "House,Condominium">
              <cfloop list="#typeList#" index="i">
                <cfoutput>
                <label class="checkbox">
                <cfif parameterexists(id) and isdefined('form.type') and ListFind(form.type,i)>
                      <input type="checkbox" name="type" value="#i#" checked="checked">
                    <cfelse>
                      <input type="checkbox" name="type" value="#i#">
                    </cfif>
                    #i#
                  </label>
                  </cfoutput>
                </cfloop>
            </div>
          </div>
    </cfif>

    <cfset arealist = '2nd Row,3rd Row,Ocean Front,Ocean View,Walk to Beach'>
    <cfif listlen(arealist)>
          <div class="form-group">
            <label><b>Area</b></label>
            <div>
              <cfloop list="#arealist#" index="i">
                <cfoutput>
                <label class="checkbox">
                <cfif parameterexists(id) and isdefined('form.area') and ListFind(form.area,i)>
                      <input type="checkbox" name="area" value="#i#" checked="checked">
                    <cfelse>
                      <input type="checkbox" name="area" value="#i#">
                    </cfif>
                    #i#
                  </label>
                  </cfoutput>
                </cfloop>
            </div>
          </div>
    </cfif>

    <cfquery name="amenities" datasource="#settings.dsn#">
    select * from cms_amenities order by title
   </cfquery>

    <cfset attrlist = valuelist(amenities.title)>
    <cfif listlen(attrlist)>
          <div class="form-group">
            <label><b>Amenities</b></label>
            <div>
              <cfloop list="#attrlist#" index="i">
                <cfoutput>
                <label class="checkbox">
                <cfif parameterexists(id) and isdefined('form.amenities') and ListFind(form.amenities,i)>
                      <input type="checkbox" name="amenities" value="#i#" checked="checked">
                    <cfelse>
                      <input type="checkbox" name="amenities" value="#i#">
                    </cfif>
                    #i#
                  </label>
                  </cfoutput>
                </cfloop>
            </div>
          </div>
    </cfif>

          <div class="form-group">
            <label><b>Monthly Rentals</b></label>
            <div>
                <cfoutput>
                <label class="checkbox">
                <cfif parameterexists(id) and isdefined('form.monthlyRentals') and form.monthlyRentals EQ "Yes">
                      <input type="checkbox" name="monthlyRentals" value="Yes" checked="checked">
                    <cfelse>
                      <input type="checkbox" name="monthlyRentals" value="Yes">
                    </cfif>
                    Yes
                  </label>
                  </cfoutput>
            </div>
          </div>

  </div>

</div>

</cfoutput>