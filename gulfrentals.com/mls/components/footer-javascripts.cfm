<!--- ALL PAGES --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js" defer type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js" defer type="text/javascript"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script> <!--- needed for Google reCaptcha --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js" defer type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js" defer type="text/javascript"></script>
<!--- GROWL --->
<cfoutput>
<link href="/#application.settings.mls.dir#/javascripts/vendors/growl/jquery.growl.min.css" rel="stylesheet" type="text/css">
<script src="/#application.settings.mls.dir#/javascripts/vendors/growl/jquery.growl.min.js" type="text/javascript"></script>
<!--- OWL CAROUSEL --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" defer type="text/javascript"></script>
<!---<script src="/javascripts/owl-gallery.js"></script>--->
<!--- FANCYBOX --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.3.5/jquery.fancybox.min.js" defer type="text/javascript"></script>
<!--- MORTGAGE CALCULATOR --->
<script src="/#application.settings.mls.dir#/javascripts/mortgage-calc.min.js"></script>
</cfoutput>

<!--- RESULTS PAGE ONLY --->
<cfif cgi.script_name eq '/#application.settings.mls.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (isdefined('page.isCustomSearchPage') and page.isCustomSearchPage eq 'yes') OR (isdefined('page.layout') and page.layout eq 'full-mls.cfm') or (isdefined('savedsearch') and savedsearch)>

<!---
	<!--- sets the min/max rates for the refine search price range slider --->
	<cfif
		isdefined('session.booking.strcheckin') and
		len(session.booking.strcheckin) and
		isvalid('date',session.booking.strcheckin) and
		isdefined('session.booking.strcheckout') and
		len(session.booking.strcheckout) and
		isvalid('date',session.booking.strcheckout)>
		<cfset minmaxprice = application.bookingObject.getMinMaxPrice(session.booking.strcheckin,session.booking.strcheckout)>
	<cfelse>
		<cfset minmaxprice = application.bookingObject.getMinMaxPrice()>
	</cfif>

	<cfset session.booking.priceRangeMin = minmaxprice.minPrice>
	<cfset session.booking.priceRangeMax = minmaxprice.maxPrice>
--->

	<cfoutput>
  <script src="/#application.settings.mls.dir#/javascripts/results.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.css" rel="stylesheet" type="text/css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.js" defer type="text/javascript"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/wnumb/1.1.0/wNumb.min.js" defer type="text/javascript"></script>
	</cfoutput>
  <script type="text/javascript">
    $(document).ready(function(){
      if ($('.refine-slider-price-wrap').length) {
        /////////////////////////////////////////
        // PRICE RANGE SLIDER - REFINE SEARCH  //
        /////////////////////////////////////////
        // REPLACE 'Price Range' TEXT WITH SLIDER VALUES ON CLICK
        $('.refine-price .refine-text').click(function(){
          $('.refine-price .refine-text-title').addClass('hidden');
          $('.refine-price .refine-min-max').removeClass('hidden');
        });

        var refinePriceSlider = document.getElementById('refinePriceSlider');
        noUiSlider.create(refinePriceSlider,{
          <cfif isdefined('session.mlssearch.listed_price') and listlen(session.mlssearch.listed_price) is 2>
        	 start: [ <cfoutput>#listfirst(session.mlssearch.listed_price)#, #listlast(session.mlssearch.listed_price)#</cfoutput> ],
          <cfelse>
            start: [ <cfoutput>#settings.mls.pricerangemin#, #settings.mls.pricerangemax#</cfoutput> ],
          </cfif>
        	tooltips: [ wNumb({ decimals: 0, thousand: ',', prefix: '$' }), wNumb({ decimals: 0, thousand: ',', prefix: '$' }) ],
          connect: [false, true, false],
          // step: <cfoutput>#settings.mls.incrementpricerange#</cfoutput>,
        	// range: {
        	// 	'min': [ <cfoutput>#settings.mls.pricerangemin#</cfoutput> ],
        	// 	'max': [ <cfoutput>#settings.mls.pricerangemax#</cfoutput> ]
          range: {
            'min': [ <cfoutput>#settings.mls.pricerangemin#</cfoutput>,10000 ],
            '50%': [750000,50000],
            '75%': [2500000,500000],
            'max': [ <cfoutput>#settings.mls.pricerangemax#</cfoutput> ]
        	},
        	format: wNumb({ decimals: 0 })
        });

        // SHOW REFINE PRICE - MIN/MAX VALUES
        var refinePriceMin = document.getElementById('refinePriceMin');
        var refinePriceMax = document.getElementById('refinePriceMax');
        refinePriceSlider.noUiSlider.on('update', function(values,handle){
          if (handle) {
            refinePriceMax.innerHTML = Math.floor(values[handle]);
          } else {
            refinePriceMin.innerHTML = Math.floor(values[handle]);
          }
        });

        // REFINE PRICE SLIDER APPLY
        $('#refinePriceApply').click(function(){
        	var priceSliderValues = refinePriceSlider.noUiSlider.get();
        	$('[name=listed_price]').val(priceSliderValues);
        	submitForm();
        });

        // CLOSE - RESET VALUES TI MIN AND PUT 'Price Range' TEXT BACK
        $('#refinePriceClose').click(function(){
          $('.refine-price .refine-text-title').removeClass('hidden');
          $('.refine-price .refine-min-max').addClass('hidden');
          refinePriceSlider.noUiSlider.reset();
          $('[name=listed_price]').val('');
    			submitForm();
        });

      }

      // ALL RANGER SLIDER THEME COLOR
      $('.noUi-connect').addClass('site-color-2-bg');
    });
  </script>

</cfif>


<!--- PROPERTY DETAIL PAGE ONLY --->
<cfif cgi.script_name eq '/#application.settings.mls.dir#/property.cfm'>
  <cfoutput><script src="/#application.settings.mls.dir#/javascripts/property.js"></script></cfoutput>
  <!--- <cfoutput><script src="/#application.settings.mls.dir#/javascripts/property.js"></script></cfoutput> --->
  <script type="text/javascript">
    $(document).ready(function(){

    });
  </script>

	<cfif len(property.latitude) and len(property.longitude)>
		<script type="text/javascript">
			function initialize() {
				<cfoutput>
					var myLatlng = new google.maps.LatLng(#property.latitude#,#property.longitude#);
				</cfoutput>
				var mapOptions = {
					zoom: 17,
					center: myLatlng,
					mapTypeId: google.maps.MapTypeId.STREET,
          //styles: [] MAP THEME STYLES GO IN HERE
				}
				var map = new google.maps.Map(document.getElementById('map'), mapOptions);

        var marker = new google.maps.Marker({
          map: map,
					position: myLatlng,
          title: '',
          icon: mlsFolder+'/images/marker.png'
        });

        function animateit(marker) {
          google.maps.event.addListener(marker, 'mouseover', function() {
            var icon = {url:mlsFolder+'/images/marker-hover.png', scaledSize: new google.maps.Size(31,38)};
            marker.setIcon(icon);
          });

          google.maps.event.addListener(marker, 'mouseout', function() {
            var icon = {url:mlsFolder+'/images/marker.png', scaledSize: new google.maps.Size(31,38)};
            marker.setIcon(icon);
          });
        }
        animateit(marker);
			}

			$('#propertyMapBtn').on('click', function(){
				setTimeout(function(){
					initialize();
				}, 10);
			});
		</script>
	</cfif>

</cfif>
