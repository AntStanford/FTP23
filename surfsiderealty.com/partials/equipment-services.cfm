<form method="post" id="equipmentForm" action="/submit.cfm">
  <input type="hidden" name="equipmentForm">
  <cfinclude template="/cfformprotect/cffp.cfm">
<!---   <cfif len(page.h1)>
    <cfoutput><h1 class="site-color-1">#page.h1#</h1></cfoutput>
  <cfelse>
    <cfoutput><h1 class="site-color-1">#page.name#</h1></cfoutput>
  </cfif>
  <cfoutput>#page.body#</cfoutput> --->
	<div class="row">
		<div class="col-sm-3"><label for="name">Guest's Name:</label></div>
		<div class="col-sm-3"><input id="name" name="name" type="text"> <font color="red"><b>*</b></font></div>
		<div class="col-sm-6"></div>
	</div>
	<div class="row">
		<div class="col-sm-3"><label for="email">Email:</label></div>
		<div class="col-sm-3"><input id="email" name="email" type="text"> <font color="red"><b>*</b></font></div>
		<div class="col-sm-6"></div>
	</div>
	<div class="row">
		<div class="col-sm-3"><label for="phone">Cell Phone:</label></div>
		<div class="col-sm-3"><input id="phone" name="phone" type="text"></div>
		<div class="col-sm-6"></div>
	</div>
	<div class="row">
		<div class="col-sm-3"><label for="property">Property Name and Address:</label></div>
		<div class="col-sm-3"><input id="property" name="property" type="text"></div>
		<div class="col-sm-6"></div>
	</div>
<!--- 	<div class="row">
		<div class="col-sm-3"><label for="company">Rental Company:</label></div>
		<div class="col-sm-3"><input id="company" name="company" type="text"></div>
		<div class="col-sm-6"></div>
	</div> --->
 	<div class="row">
		<div class="col-sm-3"><label for="deliveryDate">Delivery Date and Time:</label></div>
		<div class="col-sm-3"><input id="deliveryDate" name="deliveryDate" type="text"></div>
		<div class="col-sm-6"></div>
	</div>
<!---	<div class="row">
		<div class="col-sm-3"><label for="pickupDate">Pick Up Date and Time:</label></div>
		<div class="col-sm-3"><input id="pickupDate" name="pickupDate" type="text"></div>
		<div class="col-sm-6"></div>
	</div>
 --->


	<h3>Beach Packages:</h3>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Beach-Packages.jpg" class="thumbnail" width="100%">
  	</div>
  	<div class="col-md-6">
    	<div class="row">
    		<div class="col-sm-4"><label for="pckg_sunLovers">Sun Lover's Package (2 Beach Chairs/1 umbrella)</label></div>
    		<div class="col-sm-2">$80</div>
    		<div class="col-sm-6"><input id="pckg_sunLovers" name="pckg_sunLovers" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="pckg_deluxeSunLovers">Deluxe Sun Lover's Package (4 chairs/1 umbrella)</label></div>
    		<div class="col-sm-2">$100</div>
    		<div class="col-sm-6"><input id="pckg_deluxeSunLovers" name="pckg_deluxeSunLovers" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="pckg_beachLovers">Beach Lover's Package (2 chairs/1umbrella/2 boogie boards)</label></div>
    		<div class="col-sm-2">$110</div>
    		<div class="col-sm-6"><input id="pckg_beachLovers" name="pckg_beachLovers" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
  	</div>
	</div>



  <h3>Bikes:</h3>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Bikes.jpg" class="thumbnail" width="100%">
  	</div>
		<div class="col-md-6">
<!---     	<div class="row">
    		<div class="col-sm-4"><label for="adultBikeFor4">Adult Bike for 4 (4 bikes)</label></div>
    		<div class="col-sm-2">$160</div>
    		<div class="col-sm-6"><input id="adultBikeFor4" name="adultBikeFor4" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div> --->
    	<div class="row">
    		<div class="col-sm-4"><label for="bikeSurfFor2">Bike &amp; Surf for 2 (2 bikes, 2 beach chairs, 1 umbrella)</label></div>
    		<div class="col-sm-2">$150</div>
    		<div class="col-sm-6"><input id="bikeSurfFor2" name="bikeSurfFor2" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="bikeSurfFor4">Bike &amp; Surf for 4 (4 bikes, 4 beach chairs, 1 umbrella)</label></div>
    		<div class="col-sm-2">$225</div>
    		<div class="col-sm-6"><input id="bikeSurfFor4" name="bikeSurfFor4" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="youthBike">Youth Bike</label></div>
    		<div class="col-sm-2">$50</div>
    		<div class="col-sm-6"><input id="youthBike" name="youthBike" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="adultBike">Adult Bike</label></div>
    		<div class="col-sm-2">$50</div>
    		<div class="col-sm-6"><input id="adultBike" name="adultBike" type="text" value="0" onblur="CalculateOrder()"></div>
			</div>
			<div class="row">
    		<div class="col-sm-4"><label for="adultBikeFor4">Adult Bike Package for 4</label></div>
    		<div class="col-sm-2">$170</div>
    		<div class="col-sm-6"><input id="adultBikeFor4" name="adultBikeFor4" type="text" value="0" onblur="CalculateOrder()"></div>
			</div>
			<div class="row">
    		<div class="col-sm-4"><label for="speedBike">3 Speed Bike</label></div>
    		<div class="col-sm-2">$60</div>
    		<div class="col-sm-6"><input id="speedBike" name="speedBike" type="text" value="0" onblur="CalculateOrder()"></div>
			</div>
			<div class="row">
    		<div class="col-sm-4"><label for="beachCart">Beach Cart</label></div>
    		<div class="col-sm-2">$40</div>
    		<div class="col-sm-6"><input id="beachCart" name="beachCart" type="text" value="0" onblur="CalculateOrder()"></div>
			</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="adultBikeBabySeat">Adult Bike with Baby Seat</label></div>
    		<div class="col-sm-2">$60</div>
    		<div class="col-sm-6"><input id="adultBikeBabySeat" name="adultBikeBabySeat" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
		</div>
	</div>


  <h3>Sports & Beach Items:</h3>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Sports-and-Beach.jpg" class="thumbnail" width="100%">
  	</div>
		<div class="col-md-6">
    	<div class="row">
    		<div class="col-sm-4"><label for="boogieBoard">Boogie Board</label></div>
    		<div class="col-sm-2">$30</div>
    		<div class="col-sm-6"><input id="boogieBoard" name="boogieBoard" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="woodenBeachUmbrella">8' Beach Umbrella</label></div>
    		<div class="col-sm-2">$50</div>
    		<div class="col-sm-6"><input id="woodenBeachUmbrella" name="woodenBeachUmbrella" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="aluminumLowBeachChair">Aluminum Low Sitting Beach Chair</label></div>
    		<div class="col-sm-2">$25</div>
    		<div class="col-sm-6"><input id="aluminumLowBeachChair" name="aluminumLowBeachChair" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
		</div>
	</div>


  <h3>Convenience Items:</h3>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Convenience-Items.jpg" class="thumbnail" width="100%">
  	</div>
		<div class="col-md-6">
    	<div class="row">
    		<div class="col-sm-4">
          <label for="gasGrill">
            Gas Grill - Three main burners at 540 sq in of cooking space (house only)
            <!---Gas Grill (540" 1 Propane Tank 3 burner) (house only)--->
          <!---<a href="https://www.lowes.com/pd/Char-Broil-Black-3-Burner-Liquid-Propane-Gas-Grill/50329717" target="_blank">info</a>--->
          </label>
        </div>
    		<div class="col-sm-2">$105</div>
    		<div class="col-sm-6"><input id="gasGrill" name="gasGrill" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
      <div class="row">
        <div class="col-sm-4">
          <label for="gasGrillDeluxe">
            Deluxe Gas Grill - Four Main burners at 650 sq in of cooking space (house only)
            <!---Deluxe Gas Grill (650" 1 Propane Tank 4 burner) (house only)--->
          <!---<a href="https://www.lowes.com/pd/Char-Broil-Performance-Black-4-Burner-Liquid-Propane-Gas-Grill-with-1-Side-Burner/1000248459" target="_blank">info</a>--->
          </label>
        </div>
        <div class="col-sm-2">$135</div>
        <div class="col-sm-6"><input id="gasGrillDeluxe" name="gasGrillDeluxe" type="text" value="0" onblur="CalculateOrder()"></div>
      </div>
    	<div class="row">
    		<div class="col-sm-4"><label for="charcoalGrill">Charcoal Grill (22" charcoal not included) (house only)</label></div>
    		<div class="col-sm-2">$50</div>
    		<div class="col-sm-6"><input id="charcoalGrill" name="charcoalGrill" type="text" value="0" onblur="CalculateOrder()"></div>
		</div>
		<!---
    	<div class="row">
    		<div class="col-sm-4"><label for="rollawayBed">Roll-a-way bed (Twin Size)</label></div>
    		<div class="col-sm-2">$50</div>
    		<div class="col-sm-6"><input id="rollawayBed" name="rollawayBed" type="text" value="0" onblur="CalculateOrder()"></div>
		</div>
		--->
		</div>
	</div>



  <h3>Baby Items: (Crib linens NOT included):</h3>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Baby-Items.jpg" class="thumbnail" width="100%">
  	</div>
		<div class="col-md-6">
    	<div class="row">
    		<div class="col-sm-4"><label for="largeCrib">Large Crib (54" X 32")</label></div>
    		<div class="col-sm-2">$100</div>
    		<div class="col-sm-6"><input id="largeCrib" name="largeCrib" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="highChair">Highchair (Plastic)</label></div>
    		<div class="col-sm-2">$50</div>
    		<div class="col-sm-6"><input id="highChair" name="highChair" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="babyGate">Baby Gate (wooden 24" X 42")</label></div>
    		<div class="col-sm-2">$25</div>
    		<div class="col-sm-6"><input id="babyGate" name="babyGate" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="packPlay">Pack & Play</label></div>
    		<div class="col-sm-2">$60</div>
    		<div class="col-sm-6"><input id="packPlay" name="packPlay" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="compactCrib">Compact Crib (40" X 26")</label></div>
    		<div class="col-sm-2">$80</div>
    		<div class="col-sm-6"><input id="compactCrib" name="compactCrib" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    <!--- 	<div class="row">
    		<div class="col-sm-12"><h3>Linen Packages</h3></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-8"><p><i>Please contact one of our vacation planners for details.  Our linen packages include everything your family and friends will need to enjoy a comfortable vacation.</i></p></div>
    	</div> --->
		</div>
	</div>



  <h3>Miscellaneous:</h3>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Miscellaneous.jpg" class="thumbnail" width="100%">
  	</div>
		<div class="col-md-6">
    	<div class="row">
    		<div class="col-sm-4"><label for="additionalPropaneTankRefill">Additional Propane Tank (refill)</label></div>
    		<div class="col-sm-2">$60</div>
    		<div class="col-sm-6"><input id="additionalPropaneTankRefill" name="additionalPropaneTankRefill" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="sandAnchor">Sand Anchor</label></div>
    		<div class="col-sm-2">$15</div>
    		<div class="col-sm-6"><input id="sandAnchor" name="sandAnchor" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
		</div>
	</div>


<!---

  <h3>Mopeds:</h3>
  <p>Payment of Mopeds are made at check-in with personal check only.</p>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Mopeds.jpg" class="thumbnail" width="100%">
  	</div>
		<div class="col-md-6">
    	<div class="row">
    		<div class="col-sm-4"><label for="mopedOneDay">1 Day Rental</label></div>
    		<div class="col-sm-2">$85</div>
    		<div class="col-sm-6"><input id="mopedOneDay" name="mopedOneDay" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="mopedThreeDay">3 Day Rental</label></div>
    		<div class="col-sm-2">$150</div>
    		<div class="col-sm-6"><input id="mopedThreeDay" name="mopedThreeDay" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
    	<div class="row">
    		<div class="col-sm-4"><label for="mopedWeek">Week Rental</label></div>
    		<div class="col-sm-2">$225</div>
    		<div class="col-sm-6"><input id="mopedWeek" name="mopedWeek" type="text" value="0" onblur="CalculateOrder()"></div>
    	</div>
		</div>
	</div>
--->



  <h3>Golf Carts:</h3>
	<div class="row">
  	<div class="col-md-6">
    	<img src="/images/equipment-services/Golf-Carts.jpg" class="thumbnail" width="100%">
  	</div>
		<div class="col-md-6">
		</div>
	</div>


	<div class="row">
		<div class="col-sm-12"><p><i>Please contact one of our vacation planners for details. Golf carts are allowed at houses only. Payment of golf carts are made at check-in with personal check only.</i></p></div>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-4"><label for="subtotal">Subtotal:</label></div>
		<div class="col-sm-8"><input id="subtotal" name="subtotal" type="text" value="0" readonly="readonly" style="width:100%;"></div>
	</div>
	<div class="row">
		<div class="col-sm-4"><label for="salesTax">8% Sales Tax: </label></div>
		<div class="col-sm-8"><input id="salesTax" name="salesTax" type="text" value="0" readonly="readonly" style="width:100%;"></div>
	</div>
	<div class="row">
		<div class="col-sm-4"><label for="formTotal">Total : </label></div>
		<div class="col-sm-8"><input id="formTotal" name="formTotal" type="text" value="0" readonly="readonly" style="width:100%;"></div>
	</div>
	<div class="row" style="margin-top:10px;">
		<div class="col-sm-12">
  		<div class="alert alert-danger">
    		<label for="agreeTerms" style="cursor:pointer;margin:0;">
      		<input id="agreeTerms" name="agreeTerms" type="checkbox" value="0"> <font color="red"><b>*</b></font> <b>I have read , understand and agreed with the conditions and provisions of the <a href="/userfiles/pdf/SBO-Bike-Rental-Liabilty-Form.pdf" target="_blank">Equipment Rental Agreement</a> set forth.</b>
    		</label>
      </div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12"><input type="Submit" value="Submit" class="btn"></div>
	</div>
</form>

<cf_htmlfoot>
<!--- Calculate Item Values --->
<script>
function CalculateOrder() {
  var GrandTotal = 0
  // add up fields
  // First Check if they entered a Number then multiply it by Per Price and add it to GrandTotal
  if($.isNumeric($('#gasGrill').val())) {
    var GrandTotal = (Number($("#gasGrill").val()) * 105) + Number(GrandTotal);
  }
  if($.isNumeric($('#gasGrillDeluxe').val())) {
    var GrandTotal = (Number($("#gasGrill").val()) * 135) + Number(GrandTotal);
  }
  if($.isNumeric($('#charcoalGrill').val())) {
  	var GrandTotal = (Number($("#charcoalGrill").val()) * 50) + Number(GrandTotal);
  }
  if($.isNumeric($('#rollawayBed').val())) {
  	var GrandTotal = (Number($("#rollawayBed").val()) * 50) + Number(GrandTotal);
  }
  if($.isNumeric($('#pckg_sunLovers').val())) {
  	var GrandTotal = (Number($("#pckg_sunLovers").val()) * 80) + Number(GrandTotal);
  }
  if($.isNumeric($('#pckg_deluxeSunLovers').val())) {
  	var GrandTotal = (Number($("#pckg_deluxeSunLovers").val()) * 100) + Number(GrandTotal);
  }
  if($.isNumeric($('#pckg_beachLovers').val())) {
  	var GrandTotal = (Number($("#pckg_beachLovers").val()) * 110) + Number(GrandTotal);
  }
  // if($.isNumeric($('#adultBikeFor4').val())) {
  // 	var GrandTotal = (Number($("#adultBikeFor4").val()) * 160) + Number(GrandTotal);
  // }
  if($.isNumeric($('#bikeSurfFor2').val())) {
  	var GrandTotal = (Number($("#bikeSurfFor2").val()) * 150) + Number(GrandTotal);
  }
  if($.isNumeric($('#bikeSurfFor4').val())) {
  	var GrandTotal = (Number($("#bikeSurfFor4").val()) * 225) + Number(GrandTotal);
  }
  if($.isNumeric($('#youthBike').val())) {
  	var GrandTotal = (Number($("#youthBike").val()) * 50) + Number(GrandTotal);
  }
  if($.isNumeric($('#adultBike').val())) {
  	var GrandTotal = (Number($("#adultBike").val()) * 50) + Number(GrandTotal);
  }
  if($.isNumeric($('#adultBikeBabySeat').val())) {
  	var GrandTotal = (Number($("#adultBikeBabySeat").val()) * 60) + Number(GrandTotal);
  }
  // if($.isNumeric($('#adultBikeKiddieCart').val())) {
  // 	var GrandTotal = (Number($("#adultBikeKiddieCart").val()) * 70) + Number(GrandTotal);
  // }
  if($.isNumeric($('#largeCrib').val())) {
  	var GrandTotal = (Number($("#largeCrib").val()) * 100) + Number(GrandTotal);
  }
  if($.isNumeric($('#highChair').val())) {
  	var GrandTotal = (Number($("#highChair").val()) * 50) + Number(GrandTotal);
  }
  if($.isNumeric($('#babyGate').val())) {
  	var GrandTotal = (Number($("#babyGate").val()) * 25) + Number(GrandTotal);
  }
  if($.isNumeric($('#packPlay').val())) {
  	var GrandTotal = (Number($("#packPlay").val()) * 60) + Number(GrandTotal);
  }
  if($.isNumeric($('#compactCrib').val())) {
  	var GrandTotal = (Number($("#compactCrib").val()) * 80) + Number(GrandTotal);
  }
  if($.isNumeric($('#boogieBoard').val())) {
  	var GrandTotal = (Number($("#boogieBoard").val()) * 30) + Number(GrandTotal);
  }
  if($.isNumeric($('#woodenBeachUmbrella').val())) {
  	var GrandTotal = (Number($("#woodenBeachUmbrella").val()) * 50) + Number(GrandTotal);
  }
  if($.isNumeric($('#aluminumLowBeachChair').val())) {
  	var GrandTotal = (Number($("#aluminumLowBeachChair").val()) * 25) + Number(GrandTotal);
  }
  if($.isNumeric($('#additionalPropaneTankRefill').val())) {
  	var GrandTotal = (Number($("#additionalPropaneTankRefill").val()) * 60) + Number(GrandTotal);
  }
  if($.isNumeric($('#sandAnchor').val())) {
  	var GrandTotal = (Number($("#sandAnchor").val()) * 15) + Number(GrandTotal);
  }

  if($.isNumeric($('#mopedOneDay').val())) {
  	var GrandTotal = (Number($("#mopedOneDay").val()) * 85) + Number(GrandTotal);
  }
  if($.isNumeric($('#mopedThreeDay').val())) {
  	var GrandTotal = (Number($("#mopedThreeDay").val()) * 150) + Number(GrandTotal);
  }
  if($.isNumeric($('#mopedWeek').val())) {
  	var GrandTotal = (Number($("#mopedWeek").val()) * 225) + Number(GrandTotal);
  }
	if($.isNumeric($('#adultBikeFor4').val())) {
  	var GrandTotal = (Number($("#adultBikeFor4").val()) * 170) + Number(GrandTotal);
  }
	if($.isNumeric($('#speedBike').val())) {
  	var GrandTotal = (Number($("#speedBike").val()) * 60) + Number(GrandTotal);
  }
	if($.isNumeric($('#beachCart').val())) {
  	var GrandTotal = (Number($("#beachCart").val()) * 40) + Number(GrandTotal);
  }


  // Set Total Values
  $('#subtotal').val(GrandTotal);
  var salesTax = .08
  var salesTaxTotal = Number(GrandTotal) * salesTax;
  var salesTaxTotal = salesTaxTotal.toFixed(2);
  $('#salesTax').val(salesTaxTotal);
  var GrandTotal = Number(GrandTotal) + Number(salesTaxTotal)
  $('#formTotal').val(GrandTotal);
}
</script>

<!--- CSS for validation --->
<style>
label.error{color:red;}
label.valid{display:none !important;}
input[type='text'] { width: 90%; padding: 2px 8px; }
</style>

<!--- Validate Form --->
<script>
$(document).ready(function () {
  $('#equipmentForm').validate({
    rules: {
      name: {
        minlength: 2,
        required: true
      },
      email: {
        required: true,
        email: true
      },
      agreeTerms: {
        required: true
      },
    },
    highlight: function (element) {
      $(element).closest('.control-group').removeClass('success').addClass('error');
    },
    success: function (element) {
      element.text('OK!').addClass('valid').closest('.control-group').removeClass('error').addClass('success');
    }
  });
});
</script>

</cf_htmlfoot>