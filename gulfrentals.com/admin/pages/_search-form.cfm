<!--- Set some defaults just in case --->
<cfif !isdefined('settings.booking.minOccupancy') or settings.booking.minOccupancy eq ''>
  <cfset settings.booking.minOccupancy = 1>
  <cfset settings.booking.maxOccupancy = 10>
  <cfset settings.booking.minbed = 1>
  <cfset settings.booking.maxbed = 10>
  <cfset settings.booking.minprice = 1>
  <cfset settings.booking.maxprice = 10>
</cfif>

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
      <!---<div class="form-group">
  			<label><b>Must Haves</b></label>
  			<div>
  				<cfloop list="#mustHavesList#" index="i">
  					<label class="checkbox" for="checkboxes-0">
  						<cfif parameterexists(id) and isdefined('form.amenities') and ListFind(form.amenities,i)>
  							<input type="checkbox" name="amenities" id="checkboxes-0" value="<cfoutput>#i#</cfoutput>" checked="checked">
  						<cfelse>
  							<input type="checkbox" name="amenities" id="checkboxes-0" value="<cfoutput>#i#</cfoutput>">
  						</cfif>
  	      			<cfoutput>#i#</cfoutput>
  	    			</label>
      			</cfloop>
  			</div>
      </div>--->
  		<cfif listlen(amenityList)>
        <div class="form-group">
    			<label><b>Amenities</b></label>
    			<div>
    				<cfloop list="#amenityListIDs#" index="i">
    					<cfoutput>
    					<label class="checkbox">
    					<cfif parameterexists(id) and isdefined('form.amenities') and ListFind(form.amenities,i)>
    	      				<input type="checkbox" name="amenities" value="#i#" checked="checked">
    	      			<cfelse>
    	      				<input type="checkbox" name="amenities" value="#i#">
    	      			</cfif>
    	      			#ListGetAt(amenityList,ListFind(amenityListIDs,i))#
    	      			<!---<cfset filterCount = application.bookingObject.getSearchFilterCount(i,'amenity')>
    	      			(#filterCount#)--->
    	    			</label>
    	    			</cfoutput>
        			</cfloop>
    			</div>
        </div>
  		</cfif>
  		<cfif listlen(settings.booking.typeList)>
        <div class="form-group">
  				<label><b>Unit Type</b></label>
  				<div>
  					<cfloop list="#settings.booking.typeList#" index="i">
  						<cfoutput>
  						<label class="checkbox">
  							<cfif parameterexists(id) and isdefined('form.type') and ListFind(form.type,i)>
  		      				<input type="checkbox" name="type" value="#i#" checked="checked">
  		      			<cfelse>
  		      				<input type="checkbox" name="type" value="#i#">
  		      			</cfif>
  		      			#i#
  		      			<cfset filterCount = application.bookingObject.getSearchFilterCount(i,'type')>
  		      			(#filterCount#)
  		    			</label>
  		    			</cfoutput>
  	    			</cfloop>
  				</div>
        </div>
  		</cfif>
  		<cfif listlen(settings.booking.viewList)>
        <div class="form-group">
  				<label><b>View</b></label>
  				<div>
  					<cfloop list="#settings.booking.viewList#" index="i">
  						<cfoutput>
  						<label class="checkbox">
  							<cfif parameterexists(id) and isdefined('form.view') and ListFind(form.view,i)>
  		      				<input type="checkbox" name="view" value="#i#" checked="checked">
  		      			<cfelse>
  		      				<input type="checkbox" name="view" value="#i#">
  		      			</cfif>
  		      			#i#
  		      			<cfset filterCount = application.bookingObject.getSearchFilterCount(i,'view')>
  		      			(#filterCount#)
  		    			</label>
  	    			</cfoutput>
      			</cfloop>
  				</div>
        </div>
		</cfif>
		<cfif listlen(settings.booking.locationList)>
        <div class="form-group">
  				<label><b>Location</b></label>
  				<div>
  					<cfloop list="#settings.booking.locationList#" index="i">
  						<cfoutput>
  						<label class="checkbox">
  							<cfif parameterexists(id) and isdefined('form.location') and ListFind(form.location,i)>
  		      				<input type="checkbox" name="location" value="#i#" checked="checked">
  		      			<cfelse>
  		      				<input type="checkbox" name="location" value="#i#">
  		      			</cfif>
  		      			#i#
  		      			<!---<cfset filterCount = application.bookingObject.getSearchFilterCount(i,'location')>
  		      			(#filterCount#)--->
  		    			</label>
  	    			</cfoutput>
      			</cfloop>
  				</div>
        </div>
		</cfif>
		<cfif listlen(settings.booking.NeighborhoodList)>
        <div class="form-group">
  				<label><b>Neighborhood</b></label>
  				<div>
  					<cfloop list="#settings.booking.NeighborhoodList#" index="i">
  						<cfoutput>
  						<label class="checkbox">
  							<cfif parameterexists(id) and isdefined('form.Neighborhood') and ListFind(form.Neighborhood,i)>
  		      				<input type="checkbox" name="Neighborhood" value="#i#" checked="checked">
  		      			<cfelse>
  		      				<input type="checkbox" name="Neighborhood" value="#i#">
  		      			</cfif>
  		      			#i#
  		      			<!---<cfset filterCount = application.bookingObject.getSearchFilterCount(i,'Neighborhood')>
  		      			(#filterCount#)--->
  		    			</label>
  	    			</cfoutput>
      			</cfloop>
  				</div>
        </div>
  		</cfif>
  	</div>
  	<div class="span6">
      <div class="form-group">
  			<label><b>Bedrooms</b></label>
  			<div>
  				<select name="bedrooms" class="input-large">
  					<option value="0">- Choose One -</option>
  					<cfloop from="#settings.booking.minBed#" to="#settings.booking.maxBed#" index="i">
  						<option <cfif parameterexists(id) and isdefined('form.bedrooms') and form.bedrooms eq i>selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
  					</cfloop>
  				</select>
  			</div>
      </div>
      <div class="form-group">
  			<label><b>Number of Guests</b></label>
  			<div>
  				<select name="sleeps" class="input-large">
  					<option value="0">- Choose One -</option>
  					<cfloop from="#settings.booking.minOccupancy#" to="#settings.booking.maxOccupancy#" index="i">
  						<option <cfif parameterexists(id) and isdefined('form.sleeps') and form.sleeps eq i>selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
  					</cfloop>
  				</select>
  			</div>
      </div>
      <div class="form-group">
  			<label><b>Price Range</b></label>
  			<div class="split">
  				<select name="rentalRateMin" class="input-large">
  					<option value="0">- Choose Min -</option>
  					<cfloop from="#settings.booking.minPrice#" to="#settings.booking.maxPrice#" index="i" step="100">
  						<cfoutput><option value="#ceiling(i)#" <cfif parameterexists(id) and isdefined('form.rentalRateMin') and form.rentalRateMin eq #ceiling(i)#>selected="selected"</cfif>>$#ceiling(i)#</option></cfoutput>
  					</cfloop>
  				</select>
  			</div>
  			<div class="split">
  				<select name="rentalRateMax" class="input-large">
  					<option value="0">- Choose Max -</option>
  					<cfloop from="#settings.booking.minPrice#" to="#settings.booking.maxPrice#" index="i" step="100">
  						<cfoutput><option value="#ceiling(i)#" <cfif parameterexists(id) and isdefined('form.rentalRateMax') and form.rentalRateMax eq #ceiling(i)#>selected="selected"</cfif>>$#ceiling(i)#</option></cfoutput>
  					</cfloop>
  				</select>
  			</div>
      </div>
  	</div>

		<cfset getproperties = application.bookingObject.getAllProperties()>

		<!---<cfif isdefined('url.id')>
			<cfquery name="getPageProperties" dataSource="#dsn#">
					select unitcode from cms_pages_properties where pageID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
			</cfquery>
			<cfset propertyList = ValueList(getPageProperties.unitcode)>
		</cfif>--->
	
		

			<!---<div class="control-group">
				<label class="control-label">Popular search?</label>
				<div class="controls">
					<select name="popularSearch" style="width:200px">
						<option <cfif parameterexists(id) and getinfo.popularSearch eq 'No'>selected="selected"</cfif>>No</option>
						<option <cfif parameterexists(id) and getinfo.popularSearch eq 'Yes'>selected="selected"</cfif>>Yes</option>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">Popular Search Photo</label>
				<div class="controls">
					<div class="uploader" id="uniform-undefined">
						<input type="file" size="19" name="popularSearchPhoto" style="opacity:0;">
						<span class="filename">No file selected</span>
						<span class="action">Choose File</span>
					</div>
					<cfif parameterexists(id) and len(getinfo.popularSearchPhoto)>
						<a href="/images/popular/#getinfo.popularSearchPhoto#" target="_blank" class="btn btn-mini btn-info"><i class="icon-eye-open icon-white"></i> View Image</a>
					</cfif>
				</div>
			</div>--->

					<table class="table table-striped">
						<tr>
								<th></th>
								<th>Property</th>
								<th>Beds</th>
								<th>Bath</th>
								<th>Sleeps</th>
								<th>Type</th>
						</tr>
						<cfloop query="getproperties">
					<tr>

							<cfif isdefined('url.id')>

									<cfif  parameterexists(id) and isdefined('form.properties') and ListLen(form.properties) gt 0 and ListContains(form.properties,getProperties.propertyid)>
											<td><input type="checkbox" class="props" name="properties" value="#propertyid#" checked="checked"></td>
									<cfelse>
											<td><input type="checkbox" class="props" name="properties" value="#propertyid#"></td>
									</cfif>

							<cfelse>
								<td><input type="checkbox" class="props" name="properties" value="#propertyid#"></td>
							</cfif>

							<td>#name#</td>
							<td>#bedrooms#</td>
							<td>#bathrooms#</td>
							<td>#sleeps#</td>
							<td>#type#</td>
					</tr>
				</cfloop>
					</table>

		
  </div>
</cfoutput>