<!--- ALL PAGES --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js" defer type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js" defer type="text/javascript"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script> <!--- needed for Google reCaptcha --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js" defer type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/jquery.lazy.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/plugins/jquery.lazy.iframe.min.js" type="text/javascript"></script>
<!--- GROWL --->
<cfoutput>
<link href="/#settings.booking.dir#/javascripts/vendors/growl/jquery.growl.min.css" rel="stylesheet" type="text/css" media="all">
<script src="/#settings.booking.dir#/javascripts/vendors/growl/jquery.growl.min.js" defer type="text/javascript"></script>
</cfoutput>
<!--- OWL CAROUSEL --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" defer type="text/javascript"></script>
<script src="/javascripts/owl-gallery.min.js?v=3"></script>
<!--- FANCYBOX --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.js" defer type="text/javascript"></script>
<script defer src="https://cdn.jsdelivr.net/npm/css-vars-ponyfill@2"></script>
<script defer type="text/javascript">
$(document).ready(function(){
  cssVars({
    onlyLegacy: true
  });
});
</script>

<!--- RESULTS PAGE ONLY --->
<cfif cgi.script_name eq '/#settings.booking.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (StructKeyExists(request,'resortContent')) OR (isdefined('page') and page.isCustomSearchPage eq 'Yes') OR (cgi.script_name eq '/layouts/special.cfm')>

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

	<cfoutput><script src="/#settings.booking.dir#/javascripts/results.min.js?v=3" defer></script></cfoutput>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.css" rel="stylesheet" type="text/css" media="all">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.js" defer type="text/javascript"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/wnumb/1.1.0/wNumb.min.js" defer type="text/javascript"></script>
  <script type="text/javascript">
    $(document).ready(function(){
      /* SLIDER VERSION */
      if ($('.refine-slider-bedrooms-wrap').length) {
        /////////////////////////////////////
        // BEDROOMS SLIDER - REFINE SEARCH //
        /////////////////////////////////////
        // REPLACE 'Bedrooms' TEXT WITH SLIDER VALUES ON CLICK
        $('.refine-bedrooms .refine-text').click(function(){
          $('.refine-bedrooms .refine-text-title').addClass('hidden');
          $('.refine-bedrooms .refine-min-max').removeClass('hidden');
        });

      	// REFINE BEDROOM SLIDER
      	var refineBedroomsSlider = document.getElementById('refineBedroomsSlider');
        noUiSlider.create(refineBedroomsSlider,{
        	start: [ <cfoutput>#settings.booking.minBed#, #settings.booking.maxBed#</cfoutput> ],
        	step: 1,
        	tooltips: [ wNumb({ decimals: 0 }), wNumb({ decimals: 0 }) ],
          connect: [false, true, false],
        	range: {
        		'min': [ <cfoutput>#settings.booking.minBed#</cfoutput> ],
        		'max': [ <cfoutput>#settings.booking.maxBed#</cfoutput> ]
        	},
        	format: wNumb({ decimals: 0 })
        });

        // SHOW REFINE BEDROOM - MIN/MAX VALUES
        var refineBedroomsMin = document.getElementById('refineBedroomsMin');
        var refineBedroomsMax = document.getElementById('refineBedroomsMax');
        refineBedroomsSlider.noUiSlider.on('update', function(values,handle){
          if (handle) {
            refineBedroomsMax.innerHTML = Math.floor(values[handle]);
          } else {
            refineBedroomsMin.innerHTML = Math.floor(values[handle]);
          }
        });

        // IF THE SESSION HAS BEDROOM INFO, ON RELOAD, LOAD IT
        <cfif isdefined('session.booking.bedrooms') and len(session.booking.bedrooms)>
  	      refineBedroomsSlider.noUiSlider.set(<cfoutput>#session.booking.bedrooms#</cfoutput>);
  	      $('.refine-bedrooms .refine-text-title').addClass('hidden');
  	      $('.refine-bedrooms .refine-min-max').removeClass('hidden');
        </cfif>

        // CLOSE - RESETS AND HIDES THE NUMBER
        $('#refineBedroomsClear').click(function(){
          $('.refine-bedrooms .refine-text-title').removeClass('hidden');
          $('.refine-bedrooms .refine-min-max').addClass('hidden');
          refineBedroomsSlider.noUiSlider.reset();
          $('[name=bedrooms]').val('');
    			submitForm();
        });

        // MASTER APPLY
        $('#refineApplyAll').on('click', function(){
        	var bedroomValues = refineBedroomsSlider.noUiSlider.get();
        	$('[name=bedrooms]').val(bedroomValues);
        });
      }

      if ($('.refine-slider-bathrooms-wrap').length) {
        /////////////////////////////////////
        // BATHROOMS SLIDER - REFINE SEARCH //
        /////////////////////////////////////
        // REPLACE 'Bathrooms' TEXT WITH SLIDER VALUES ON CLICK
        $('.refine-bathrooms .refine-text').click(function(){
          $('.refine-bathrooms .refine-text-title').addClass('hidden');
          $('.refine-bathrooms .refine-min-max').removeClass('hidden');
        });

      	// REFINE BATHROOM SLIDER
      	var refineBathroomsSlider = document.getElementById('refineBathroomsSlider');
        noUiSlider.create(refineBathroomsSlider,{
        	start: [ <cfoutput>#settings.booking.minBath#, #settings.booking.maxBath#</cfoutput> ],
        	step: 1,
        	tooltips: [ wNumb({ decimals: 0 }), wNumb({ decimals: 0 }) ],
          connect: [false, true, false],
        	range: {
        		'min': [ <cfoutput>#settings.booking.minBath#</cfoutput> ],
        		'max': [ <cfoutput>#settings.booking.maxBath#</cfoutput> ]
        	},
        	format: wNumb({ decimals: 0 })
        });

        // SHOW REFINE BEDROOM - MIN/MAX VALUES
        var refineBathroomsMin = document.getElementById('refineBathroomsMin');
        var refineBathroomsMax = document.getElementById('refineBathroomsMax');
        refineBathroomsSlider.noUiSlider.on('update', function(values,handle){
          if (handle) {
            refineBathroomsMax.innerHTML = Math.floor(values[handle]);
          } else {
            refineBathroomsMin.innerHTML = Math.floor(values[handle]);
          }
        });

        // IF THE SESSION HAS BATHROOM INFO, ON RELOAD, LOAD IT
        <cfif isdefined('session.booking.bathrooms') and len(session.booking.bathrooms)>
  	      refineBathroomsSlider.noUiSlider.set(<cfoutput>#session.booking.bathrooms#</cfoutput>);
  	      $('.refine-bathrooms .refine-text-title').addClass('hidden');
  	      $('.refine-bathrooms .refine-min-max').removeClass('hidden');
        </cfif>

        // CLOSE - RESETS AND HIDES THE NUMBER
        $('#refineBathroomsClear').click(function(){
          $('.refine-bathrooms .refine-text-title').removeClass('hidden');
          $('.refine-bathrooms .refine-min-max').addClass('hidden');
          refineBathroomsSlider.noUiSlider.reset();
          $('[name=bathrooms]').val('');
    			submitForm();
        });

        // MASTER APPLY
        $('#refineApplyAll').on('click', function(){
        	var bathroomValues = refineBathroomsSlider.noUiSlider.get();
        	$('[name=bathrooms]').val(bathroomValues);
        });
      }


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
        	start: [ <cfoutput>#session.booking.priceRangeMin#, #session.booking.priceRangeMax#</cfoutput> ],
        	tooltips: [ wNumb({ decimals: 0 }), wNumb({ decimals: 0 }) ],
          connect: [false, true, false],
        	range: {
        		'min': [ <cfoutput>#session.booking.priceRangeMin#</cfoutput> ],
        		'max': [ <cfoutput>#session.booking.priceRangeMax#</cfoutput> ]
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

        // CLOSE - RESET VALUES TO MIN/MAX RANGES AND PUT 'Price Range' TEXT BACK
        $('#refinePriceClear').on('click', function(){
          $('.refine-price .refine-text-title').removeClass('hidden');
          $('.refine-price .refine-min-max').addClass('hidden');
          refinePriceSlider.noUiSlider.reset();
          $('[name=rentalRate]').val('');
    			submitForm();
        });

        // MASTER APPLY
        $('#refineApplyAll').on('click', function(){
        	var priceSliderValues = refinePriceSlider.noUiSlider.get();
        	$('[name=rentalRate]').val(priceSliderValues);
        });
      }

      // ALL RANGER SLIDER THEME COLOR
      $('.noUi-connect').addClass('site-color-2-bg');
    });
  </script>

</cfif>


<!--- PROPERTY DETAIL PAGE ONLY --->
<cfif cgi.script_name eq '/#settings.booking.dir#/property.cfm'>
  <cfoutput><script src="/#settings.booking.dir#/javascripts/property.min.js?v=3" defer></script></cfoutput>
  <script type="text/javascript">
    $(document).ready(function(){

    	//DETAIL PAGE CALENDAR TAB/PDP DATEPICKER VARIABLES & FUNCTION
    	var myBadDates = [];
    	var myBadCheckinDates = [];
    	var myBadCheckoutDates = [];
    	var counter = 0;

      // nonAvailListForDatepicker IS DEFINED IN _calendar-tab.cfm
    	<cfloop list="#nonAvailListForDatepicker#" index="i">
    		<cfoutput>
					<cfset PreviousDate = DateFormat(DateAdd('d',-1,i),'mm/dd/yyyy')>
          <cfset NextDate = DateFormat(DateAdd('d',1,i),'mm/dd/yyyy')>
					<cfif ListFind(nonAvailListForDatepicker,PreviousDate) AND NOT ListFind(nonAvailListForDatepicker,NextDate) AND DateCompare(i,Now()) GT 0> <!--- Checkout day --->
						myBadCheckoutDates[counter] = '#DateFormat(NextDate,"yyyy-mm-dd")#';
          <cfelseif ListFind(nonAvailListForDatepicker,NextDate) AND NOT ListFind(nonAvailListForDatepicker,PreviousDate) AND DateCompare(i,Now()) GT 0> <!--- Checkin day --->
						myBadCheckinDates[counter] = '#DateFormat(PreviousDate,"yyyy-mm-dd")#';
          </cfif>
					myBadDates[counter] = '#DateFormat(i,"yyyy-mm-dd")#';
    		</cfoutput>
    		counter = counter + 1;
    	</cfloop>

    	function checkAvailabilityStart(mydate){
    		var $return=true;
    		var $returnclass ="available";
    		$checkdate = $.datepicker.formatDate('yy-mm-dd', mydate);

    		for(var i = 0; i < myBadDates.length; i++)
    		{
    			if(myBadDates[i] == $checkdate){
    				$return = false;
    				$returnclass= "unavailable";
    			}
    		}
    		for(var i = 0; i < myBadCheckoutDates.length; i++)
    		{
    			if(myBadCheckoutDates[i] == $checkdate){
    				$return = true;
    				$returnclass= "availableCheckout";
    			}
    		}
    		for(var i = 0; i < myBadCheckinDates.length; i++)
    		{
    			if(myBadCheckinDates[i] == $checkdate){
    				$return = false;
    				$returnclass= "unavailableCheckin";
    			}
    		}

        // RESTRICT DATES SATURDAY ONLY
        if(mydate.getDay() == 6) {
          return [$return,$returnclass];
        } else {
          $return = false;
          //$returnclass= "unavailableCheckin";
          $returnclass= "unavailable";
          return [$return,$returnclass];
        }
    	}

    	function checkAvailabilityEnd(mydate){
    		var $return=true;
    		var $returnclass ="available";
    		$checkdate = $.datepicker.formatDate('yy-mm-dd', mydate);

    		for(var i = 0; i < myBadDates.length; i++)
    		{
    			if(myBadDates[i] == $checkdate){
    				$return = false;
    				$returnclass= "unavailable";
    			}
    		}
    		for(var i = 0; i < myBadCheckoutDates.length; i++)
    		{
    			if(myBadCheckoutDates[i] == $checkdate){
    				$return = false;
    				$returnclass= "unavailableCheckout";
    			}
    		}
    		for(var i = 0; i < myBadCheckinDates.length; i++)
    		{
    			if(myBadCheckinDates[i] == $checkdate){
    				$return = true;
    				$returnclass= "availableCheckin";
    			}
    		}
    		return [$return,$returnclass];
    	}

      // ARRIVAL/DEPARTURE DATES
      if ($('.datepicker').length) {
        // DISABLE END DATE - PREVENT USER FROM SELECTING THIS BEFORE THE START DATE
        $('#endDateDetail').attr('disabled', 'disable');

      	$('#startDateDetail').datepicker({
      		minDate: '+1d',
          beforeShow:function(instance){
            $('#detailDatepickerCheckin').append($('#ui-datepicker-div'));
          },
      		beforeShowDay: checkAvailabilityStart,
      		onSelect: function( selectedDate ) {
      			var newDate = $(this).datepicker('getDate');
      			newDate.setDate(newDate.getDate()+7);
      			// MAKE THE END DATE SELECTABLE
      			$('#endDateDetail').removeAttr('disabled');
      			$('#endDateDetail').datepicker('setDate',newDate);
      			$('#endDateDetail').datepicker('option','minDate',selectedDate);
      			setTimeout(function(){
      				$('#endDateDetail').datepicker('show');
      			}, 16);
      			// ON SELECT HIDE SELECT DATES BUTTON
    		    $('#selectDates').fadeOut();

            // RESET SPLIT COST FORMS
            if ($('#peopleForm').length) {
              $('#peopleForm')[0].reset();
            }
            if ($('#familyForm').length) {
              $('#howmanyfamilies').val('');
              $('#familyForm')[0].reset();
              $("#familyForm fieldset.clone").remove();
            }
      		}
      	});
      	$('#endDateDetail').datepicker({
          minDate: '+1d',
          beforeShow:function(instance){
            $('#detailDatepickerCheckout').append($('#ui-datepicker-div'));
          },
      		beforeShowDay: checkAvailabilityEnd,
      		onSelect: function(selectedDate){
      			submitForm();
      		}
      	});
      }

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
					fullscreenControl: true,
          fullscreenControlOptions: {
            position: google.maps.ControlPosition.TOP_LEFT
          },
					mapTypeControl: true,
          mapTypeControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER
          }
				}
				var map = new google.maps.Map(document.getElementById('map'), mapOptions);

        var marker = new google.maps.Marker({
          map: map,
					position: myLatlng,
          title: '',
          icon: '<cfoutput>/#settings.booking.dir#</cfoutput>/images/marker.png'
        });

        function animateit(marker) {
          google.maps.event.addListener(marker, 'mouseover', function() {
            var icon = {url:'<cfoutput>/#settings.booking.dir#</cfoutput>/images/marker-hover.png', scaledSize: new google.maps.Size(31,38)};
            marker.setIcon(icon);
          });

          google.maps.event.addListener(marker, 'mouseout', function() {
            var icon = {url:'<cfoutput>/#settings.booking.dir#</cfoutput>/images/marker.png', scaledSize: new google.maps.Size(31,38)};
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

<!--- BOOK NOW PAGE - ALL SCRIPTS ARE ON PAGE --->
