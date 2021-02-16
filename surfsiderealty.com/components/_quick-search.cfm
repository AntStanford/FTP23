<div class="quick-search">
	<form method="post" action="/rentals/results.cfm">
	   <input type="hidden" name="camefromsearchform" />
		<div class="group-select">
			<select class="chosen-select" name="type">
				<option selected="selected" value="">Property Type</option>
				<cfloop index="i" list="#settings.booking.typeList#">
				  <cfoutput>
            <option>#i#</option>
					</cfoutput>
				</cfloop>
			</select>
		</div>
		<div class="group-input qs">
			<input id="start-date" type="text" name="strcheckin" placeholder="Check In" readonly>
		</div>
		<div class="group-input qs">
			<input id="end-date" type="text" name="strcheckout" placeholder="Check Out" readonly>
		</div>
		<div class="group-select">
			<select class="chosen-select" name="bedrooms">
				<option selected="selected" value="">Bedrooms</option>
				<cfloop from="#settings.booking.minBed#" to="#settings.booking.maxBed#" index="i">
				  <cfoutput><option value="#i#,#settings.booking.maxBed#">#i#+</option></cfoutput>
				</cfloop>
			</select>
		</div>
		
		<div class="group-select">
			<select class="chosen-select" name="area">
				<option selected="selected" value="">Area</option>
				<cfloop list="#areaList#" index="i">
				  <cfoutput><option value="#i#">#i#</option></cfoutput>
				</cfloop>
			</select>
		</div>	

		<!--- <div class="group-select">
			<select class="chosen-select" name="sleeps">
				<option selected="selected" value="">Sleeps</option>
				<cfloop from="#settings.booking.minOccupancy#" to="#settings.booking.maxOccupancy#" index="i">
				  <cfoutput><option value="#i#">#i#</option></cfoutput>
				</cfloop>
			</select>
		</div> --->
	

			<input type="submit" value="Begin Your Search">

	</form>
</div>
