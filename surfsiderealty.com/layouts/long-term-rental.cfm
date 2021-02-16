<cfquery name="getLongTermRental" dataSource="#settings.dsn#">
	select * from cms_longterm_rentals where slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cgi.query_string#"> and status = 'active'
</cfquery>

<!--- <cfinclude template="/components/header.cfm"> --->

<cfif getLongTermRental.recordcount gt 0>

	<cfquery name="getPhotos" dataSource="#settings.dsn#">
		select * from cms_assets where section = 'Long Term Rental' and foreignKey = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getLongTermRental.id#">
	</cfquery>

	<div class="i-content">
	  <div class="container">
	  	<div class="row">
	  		<div class="col-lg-12">
	    		<div class="row">
	      		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	            <cfoutput>
	              <div class="owl-gallery-wrap">
	                <div class="owl-carousel owl-theme owl-gallery">
	                  <div class="item">
	                     <a hreflang="en" href="/images/longtermrentals/#getLongTermRental.mainphoto#" class="fancybox" data-fancybox="owl-gallery-group">
	                       <img class="owl-lazy" data-src="/images/longtermrentals/#getLongTermRental.mainphoto#">
	                     </a>
	                  </div>
	                  <cfloop query="getPhotos">
	                      <div class="item">
	                        <a hreflang="en" href="/images/longtermrentals/#thefile#" class="fancybox" data-fancybox="owl-gallery-group">
	                          <img class="owl-lazy" data-src="/images/longtermrentals/#thefile#">
	                        </a>
	                      </div>
	                  </cfloop>
	                </div>
	                <div class="owl-carousel owl-theme owl-gallery-thumbs">
	                  <div class="item">
	                     <a hreflang="en" href="/images/longtermrentals/#getLongTermRental.mainphoto#" class="fancybox" data-fancybox="owl-gallery-group">
	                       <img class="owl-lazy" data-src="/images/longtermrentals/#getLongTermRental.mainphoto#">
	                     </a>
	                  </div>
	                  <cfloop query="getPhotos">
	                      <div class="item">
	                        <span class="owl-lazy" data-src="/images/longtermrentals/#thefile#"></span>
	                      </div>
	                  </cfloop>
	                </div>
	              </div>
	            </cfoutput>
	      		</div>
	      		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
	      		<cfoutput>
	            <p class="h2 site-color-1 nomargin">#getLongTermRental.name#</p>
	            <p class="h5" style="line-height:1.5;">
	              <cfif len(getLongTermRental.address)><b>Address:</b> #getLongTermRental.address#<br></cfif>
	              <cfif len(getLongTermRental.type)><b>Type:</b> #getLongTermRental.type#<br></cfif>
	              <cfif len(getLongTermRental.bedrooms)><b>Beds:</b> #getLongTermRental.bedrooms#<br /></cfif>
	              <cfif len(getLongTermRental.bathrooms)><b>Baths:</b> #getLongTermRental.bathrooms#<br /></cfif>
	              <cfif len(getLongTermRental.pet_friendly)><b>Pet Friendly:</b> #getLongTermRental.pet_friendly#<br /></cfif>
	              <cfif len(getLongTermRental.monthly_rate)><b>Monthly Rate:</b> $#getLongTermRental.monthly_rate#<br /></cfif>
	            </p>
	            </cfoutput>
	      		</div>
	    		</div><br>
	        <ul class="nav nav-tabs nav-justified i-resort-tabs" role="tablist">
	          <li role="presentation" class="active"><a class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white text-white-hover" href="#overviewTab" aria-controls="overviewTab" role="tab" data-toggle="tab">Overview</a></li>
	          <li role="presentation"><a class="btn site-color-3-bg site-color-3-lighten-bg-hover text-white text-white-hover" href="#amenitiesTab" aria-controls="amenitiesTab" role="tab" data-toggle="tab">Amenities</a></li>
	          <cfif len(getLongTermRental.address) and len(getLongTermRental.city) and len(getLongTermRental.state) and len(getLongTermRental.zip)><li role="presentation"><a class="btn site-color-3-bg site-color-3-lighten-bg-hover text-white text-white-hover" href="#mapTab" aria-controls="mapTab" role="tab" data-toggle="tab">Map</a></li></cfif>
	          <li role="presentation"><a class="btn site-color-3-bg site-color-3-lighten-bg-hover text-white text-white-hover" href="#contactTab" aria-controls="contactTab" role="tab" data-toggle="tab">Contact</a></li>
	        </ul>
	        <div class="tab-content">
	          <div role="tabpanel" class="tab-pane active" id="overviewTab">
	            <cfoutput>#getLongTermRental.description#</cfoutput>
	          </div>
	          <div role="tabpanel" class="tab-pane" id="amenitiesTab">
	            <ul class="list-group">
						<cfset cleanAmenities = replace(getLongTermRental.amenities,'<p>','','all')>
						<cfset cleanAmenities = replace(cleanAmenities,'</p>','','all')>
						<cfloop list="#cleanAmenities#" delimiters=";" index="i">
							<li class="list-group-item col-lg-6"><cfoutput>#i#</cfoutput></li>
						</cfloop>
					</ul>
	          </div>
	          <cfif len(getLongTermRental.address) and len(getLongTermRental.city) and len(getLongTermRental.state) and len(getLongTermRental.zip)>
		          <div role="tabpanel" class="tab-pane" id="mapTab"><br>
		              <div class="embed-responsive embed-responsive-16by9">
		                <cfoutput>
		                  <iframe src="https://maps.google.com/maps?q=#getLongTermRental.address#%2C+#getLongTermRental.city#%2C+#getLongTermRental.state#+#getLongTermRental.zip#&ie=UTF8&output=embed" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
		                </cfoutput>
		              </div><br>
		          </div>
	          </cfif>
	          <div role="tabpanel" class="tab-pane" id="contactTab"><br>
	            <div class="well">
	              <form id="resort-contactform" method="post" action="/submit.cfm" novalidate="novalidate" class="validate">
	              	<cfinclude template="/cfformprotect/cffp.cfm">
	              	<span style="display:none">Leave this field empty <input id="fp4" type="text" name="formfield1234567894" value=""></span>
	              	<fieldset>
	              		<div class="form-group">
	              		  <div class="col-xs-12 col-sm-12 col-md-12">
	              				<label class="control-label" for="firstname">First Name</label>
	              				<div class="controls">
	              					<input type="text" class="form-control required" name="firstname" data-msg-required="Please enter first name" aria-required="true">
	              				</div>
	              		  </div>
	              		  <div class="col-xs-12 col-sm-12 col-md-12">
	              				<label class="control-label" for="lastname">Last Name</label>
	              				<div class="controls">
	              					<input type="text" class="form-control required" name="lastname" data-msg-required="Please enter last name" aria-required="true">
	              				</div>
	              		  </div>
	              		  <div class="col-xs-12 col-sm-12 col-md-12">
	              				<label class="control-label" for="phone">Phone (optional)</label>
	              				<div class="controls">
	              					<input type="text" class="form-control" name="phone">
	              				</div>
	              			</div>
	              		  <div class="col-xs-12 col-sm-12 col-md-12">
	              				<label class="control-label" for="email">Email</label>
	              				<div class="controls">
	              					<input type="text" class="form-control required email" name="email" data-msg-required="Please enter Email" aria-required="true">
	              				</div>
	              		  </div>
	              		  <div class="col-xs-12 col-sm-12 col-md-12">
	              				<label class="control-label">Comments</label>
	              				<div class="controls">
	              					<textarea name="comments" class="form-control"></textarea>
	              				</div>
	              		  </div>
	              		  <div class="col-xs-12 col-sm-12 col-md-12">
	              				<div class="controls">
	                				<br><button id="contactform" name="contactform" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" onclick="ga('send', 'event', { eventCategory: 'contact', eventAction: 'more information request'});">Send my question!</button>
	              				</div>
	              		  </div>
	                    <cfoutput><input type="hidden" name="longtermrental" value="#getLongTermRental.name#"></cfoutput>
	              		  </div>
	              		</div>
	              	</fieldset>
	              </form>
	            </div>
	          </div>
	        </div>
	  		</div>
	  	</div>
	  </div>
	<!--- </div> --->
	<cf_htmlfoot>
	<script type="text/javascript">
	$(document).ready(function(){
	  //Color Themes Active Tabs for Overview/Amenities/Map/Rates/Contact
	  $('.i-resort-tabs li a').click(function(){
	  	$('.i-resort-tabs li.active a')
	  		.removeClass('site-color-2-bg site-color-2-lighten-bg-hover')
	  	  .addClass('site-color-3-bg site-color-3-lighten-bg-hover');
	    $(this).removeClass('site-color-3-bg site-color-3-lighten-bg-hover');
	    $(this).addClass('site-color-2-bg site-color-2-lighten-bg-hover');
	  });
	});
	</script>
	<style>
	.i-resort-tabs > li > a { border: none !important; }
	</style>
	</cf_htmlfoot>

<cfelse>
	<div class="i-content">
		<div class="container">
			<div class="row">
				<div class="col-lg-9 col-md-8 col-sm-12">
		     		<h1>Record Not Found</h1>
		     		<p>Sorry, that record was not found.</p>
				</div>
				<div class="col-lg-3 col-md-4 col-sm-12">
			 		<div class="i-sidebar">
			 			<cfinclude template="/components/callouts.cfm">
			 		</div>
				</div>
			</div>
		</div>
	</div>
</cfif>
<!--- <cfinclude template="/components/footer.cfm"> --->