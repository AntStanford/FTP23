<cfif cgi.script_name does not contain '/sales/' AND cgi.script_name does not contain '/mls/'>

  <!--- BOOKING NAV --->
	<ul class="header-nav">
		<li><a hreflang="en" href="javascript:;">Vacation Rentals</a>
			<ul>
				<li><a hreflang="en" href="/rentals/search.cfm">Advanced Search</a></li>
				<li><a hreflang="en" href="/alphabetical-listings.cfm?letter=#">Alphabetical Listings</a></li>
				<li><a hreflang="en" href="/south-myrtle-beach-vacation-rental-specials.cfm">Specials</a></li>
        <li><a hreflang="en" href="/golf.cfm">Golf</a></li>
        <li><a hreflang="en" href="/eventbooking.cfm">Events</a></li>
				<li><a hreflang="en" href="/surfside-realty-rental-info.cfm">Rental Info</a></li>
				<li><a hreflang="en" href="/equipment-services.cfm">Equipment Services</a></li>
				<li><a hreflang="en" href="/owner-services.cfm">Owner Services</a></li>
				<li><a hreflang="en" href="/rentals/surfside-beach-pet-friendly-rentals.cfm">Pet Friendly Rentals</a></li>
				<li><a hreflang="en" href="/rentals/Surfside-Beach-vacation-rentals.cfm">Surfside Beach</a>
					<ul>
						<li><a hreflang="en" href="/rentals/Surfside-Beach-condo-rentals.cfm">Condo Rentals</a></li>
						<li><a hreflang="en" href="/rentals/Surfside-Beach-oceanfront-rentals.cfm">Oceanfront Rentals</a></li>
					</ul>
				</li>
				<li><a hreflang="en" href="/rentals/Garden-City-Beach-vacation-rentals.cfm">Garden City</a>
  				<ul>
  					<li><a hreflang="en" href="/rentals/Garden-City-Beach-condo-rentals.cfm">Condo Rentals</a></li>
  					<li><a hreflang="en" href="/rentals/Garden-City-Beach-oceanfront-rentals.cfm">Oceanfront Rentals</a></li>
  				</ul>
  			</li>
  			<li><a hreflang="en" href="/long-term/listing.cfm">Long-Term</a></li>
  			<li><a hreflang="en" href="/condo-rentals">Condo Rentals</a></li>
  		</ul>
		</li>
		<li><a hreflang="en" href="/sales">Real Estate</a>
		  <ul>
  		  <li><a hreflang="en" href="/sales/our-staff.cfm">Our Agents</a></li>
		  </ul>
		</li>
		<li><a hreflang="en" href="/propertymanagement.cfm">Vacation Rental Management</a>
		  <!--- <ul>
  		  <li><a hreflang="en" href="/owner-services.cfm">Homeowner Services</a></li>
  		  <li><a hreflang="en" href="/propertymanagement/our-team.cfm">Our Team</a></li>
		  </ul> --->
		</li>
	  <li class="logo"><a hreflang="en" href="/">Surfside Realty Company</a></li>
	  <li><a hreflang="en" href="/association-management.cfm">Association Management</a>
		  <!--- <ul>
  		  <li><a hreflang="en" href="/association-management/our-team.cfm">Our Team</a></li>
		  </ul> --->
		</li>
		<li><a hreflang="en" href="javascript:;">Local Info</a>
			<ul>
				<li><a hreflang="en" href="http://www.mysurfside.com" target="_blank">Surfside Beach</a></li>
				<li><a hreflang="en" href="http://www.mymurrellsinlet.com" target="_blank">Murrells Inlet</a></li>
				<li><a hreflang="en" href="/about-garden-city-beach-south-carolina.cfm">Garden City Beach</a></li>
				<li><a hreflang="en" href="/about-myrtle-beach-south-carolina.cfm">Myrtle Beach</a></li>
			</ul>
		</li>
		<li><a hreflang="en" href="/contact-surfside-realty.cfm">Contact</a>
			<ul>
				<li><a hreflang="en" href="/about-us.cfm">About Surfside Realty</a></li>
				<li><a hreflang="en" href="/our-staff.cfm">Our Team</a></li>
				<li><a hreflang="en" href="/locations.cfm">Getting Here</a></li>
				<li><a hreflang="en" href="/vacation-rental-blog/">Blog</a></li>
			</ul>
		</li>
	</ul>

<cfelse>

  <!--- MLS NAV --->
	<ul class="header-nav">
		<li><a hreflang="en" href="javascript:;">Vacation Rentals</a>
			<ul>
				<li><a hreflang="en" href="/rentals/search.cfm">Advanced Search</a></li>
				<li><a hreflang="en" href="/alphabetical-listings.cfm?letter=#">Alphabetical Listings</a></li>
				<li><a hreflang="en" href="/south-myrtle-beach-vacation-rental-specials.cfm">Specials</a></li>
				<li><a hreflang="en" href="/surfside-realty-rental-info.cfm">Rental Info</a></li>
				<li><a hreflang="en" href="/equipment-services.cfm">Equipment Services</a></li>
				<li><a hreflang="en" href="/owner-services.cfm">Owner Services</a></li>
    		<li><a hreflang="en" href="/long-term/listing.cfm">Long-Term</a></li>
  			<li><a hreflang="en" href="/condo-rentals">Condo Rentals</a></li>
			</ul>
		</li>
		<li><a hreflang="en" href="/sales" >Real Estate</a>
		  <ul>
  		  <li><a hreflang="en" href="/sales/our-staff.cfm">Our Agents</a></li>
		  </ul>
		</li>
		<li><a hreflang="en" href="/propertymanagement.cfm">Vacation Rental Management</a>
		  <ul>
  		  <!--- <li><a hreflang="en" href="/owner-services.cfm">Homeowner Services</a></li> --->
  		  <li><a hreflang="en" href="/propertymanagement/our-team.cfm">Our Team</a></li>
		  </ul>
		</li>
		<li class="logo"><a hreflang="en" href="/">Surfside Realty Company</a></li>
	  <li><a hreflang="en" href="/association-management.cfm">Association Management</a>
		  <!--- <ul>
  		  <li><a hreflang="en" href="/association-management/our-team.cfm">Our Team</a></li>
		  </ul> --->
		</li>
		<li><a hreflang="en" href="javascript:;">Local Info</a>
			<ul>
				<li><a hreflang="en" href="http://www.mysurfside.com" target="_blank">Surfside Beach</a></li>
				<li><a hreflang="en" href="http://www.mymurrellsinlet.com" target="_blank">Murrells Inlet</a></li>
				<li><a hreflang="en" href="/about-garden-city-beach-south-carolina.cfm">Garden City Beach</a></li>
				<li><a hreflang="en" href="/about-myrtle-beach-south-carolina.cfm">Myrtle Beach</a></li>
			</ul>
		</li>
		</li>
		<li><a hreflang="en" href="/contact-surfside-realty.cfm">Contact</a>
			<ul>
				<li><a hreflang="en" href="/about-us.cfm">About Surfside Realty</a></li>
				<li><a hreflang="en" href="/our-staff.cfm">Our Team</a></li>
				<li><a hreflang="en" href="/locations.cfm">Getting Here</a></li>
				<li><a hreflang="en" href="/vacation-rental-blog/">Blog</a></li>
			</ul>
		</li>
	</ul>

</cfif>