<!--- <cfquery datasource="#dsnmls#" name="getCities" cachedwithin="#CreateTimeSpan(0, 12, 0, 0)#">
 SELECT distinct(city)
 FROM mastertable
 where mlsid in (<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#mls.MLSID#">) and city <> ''
 order by city
</cfquery> --->

<Cfset citylist = 'Surfside Beach,Garden City,Conway,Garden City Beach,Georgetown,Little River,Murrells Inlet,Myrtle Beach,North Myrtle Beach,Pawleys Island,Surfside Beach'>

<div class="quick-search mls">
	<form action="/sales/search-results.cfm" method="post">

		<input type="hidden" name="SubmitMainForm" value="">
		<div class="select-group no-arrow">
			<select class="chosen-select" name="city">
				<option selected="selected" value="">Please Choose an Area to Search</option>
		            <cfloop list="#citylist#" index="i">
		              <cfoutput><option value="#i#" <cfif isdefined('session.city') and session.city is i>selected="selected"</cfif>>#i#</option></cfoutput>
		            </cfloop>
			</select>
		</div>
		<div class="select-group">
			<select class="chosen-select" name="wsid">
				<option selected="selected" value="">Property Type</option>
	              <cfoutput>
	              <cfloop index="i" list="#getmlscoinfo.wsid#">
	                  <option value="#listgetat(i,'1','~')#"  <cfif isdefined('session.wsid') and session.wsid is "#listgetat(i,'1','~')#">selected</cfif>>#listgetat(i,'2','~')#</option>
	              </cfloop>
	              </cfoutput>
			</select>
		</div>
		<div class="select-group">
			<select class="chosen-select" name="bedrooms">
				<option selected="selected" value="">Beds</option>
	              <option value="1" <cfif isdefined('session.bedrooms') and session.bedrooms is "1">selected="selected"</cfif>>1+ Bedrooms</option>
	              <option value="2" <cfif isdefined('session.bedrooms') and session.bedrooms is "2">selected="selected"</cfif>>2+ Bedrooms</option>
	              <option value="3" <cfif isdefined('session.bedrooms') and session.bedrooms is "3">selected="selected"</cfif>>3+ Bedrooms</option>
	              <option value="4" <cfif isdefined('session.bedrooms') and session.bedrooms is "4">selected="selected"</cfif>>4+ Bedrooms</option>
	              <option value="5" <cfif isdefined('session.bedrooms') and session.bedrooms is "5">selected="selected"</cfif>>5+ Bedrooms</option>
	              <option value="6" <cfif isdefined('session.bedrooms') and session.bedrooms is "6">selected="selected"</cfif>>6+ Bedrooms</option>
			</select>
		</div>
		<div class="select-group">
			<select class="chosen-select" name="baths_full">
				<option selected="selected" value="">Baths</option>
              <option value="1" <cfif isdefined('session.baths_full') and session.baths_full is "1">selected="selected"</cfif>>1+ Bathrooms</option>
              <option value="2" <cfif isdefined('session.baths_full') and session.baths_full is "2">selected="selected"</cfif>>2+ Bathrooms</option>
              <option value="3" <cfif isdefined('session.baths_full') and session.baths_full is "3">selected="selected"</cfif>>3+ Bathrooms</option>
              <option value="4" <cfif isdefined('session.baths_full') and session.baths_full is "4">selected="selected"</cfif>>4+ Bathrooms</option>
              <option value="5" <cfif isdefined('session.baths_full') and session.baths_full is "5">selected="selected"</cfif>>5+ Bathrooms</option>
			</select>
		</div>
		<!--- If PMAX doesnt exist, default it. --->
<!--- 						<cfif isdefined('session.pmax') and session.pmax eq ''>
			<input type="hidden" name="pmax" value="999999999">
		<cfelse>
			<cfoutput><input type="hidden" name="pmax" value="#session.pmax#"></cfoutput>
		</cfif> ---><input type="hidden" name="pmax" value="999999999">
		<div class="select-group sm">
			<select class="chosen-select" name="pmin">
				<option selected="selected" value="0">Min Price</option>
					<cfoutput>
		              <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
		                  <option value="#i#" <cfif isdefined('session.PMIN') and session.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
		                <cfif #i# eq "1000000">
		                  <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
		                      <option value="#i#" <cfif isdefined('session.PMIN') and session.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
		                  </cfloop>
		                  <cfbreak>
		                </cfif>
		              </cfloop>
		             </cfoutput>
			</select>
		</div>
		<input type="submit" value="SEARCH">
	</form>
</div><!-- END quicksearch -->
