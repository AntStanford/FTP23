

      <form class="form" action="submit.cfm" method="post" id="golfbookingform">
        <input type="hidden" name="golfbookingform">
      	<cfinclude template="/cfformprotect/cffp.cfm" >
      	<fieldset>
        <div class="row">
          <div class="col-md-6">
            <div class="well">
              <legend>Contact Information</legend>
              <div class="form-group">
                <label for="firstName">First Name<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="First Name" name="firstname" id="firstname">
              </div>
              <div class="form-group">
                <label for="lastName">Last Name<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Last Name" name="lastname" id="lastname">
              </div>
              <div class="form-group">
                <label for="address">Address<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Address" name="address" id="address">
              </div>
              <div class="form-group">
                <label for="city">City<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="City" name="city" id="city">
              </div>
              <div class="form-group">
                <label for="state">State<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="State" name="state" id="state">
              </div>
              <div class="form-group">
                <label for="zipCode">Zip Code<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Zip Code" name="zip" id="zip">
              </div>
              <div class="form-group">
                <label for="country">Country<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Country" name="country" id="country">
              </div>
              <div class="form-group">
                <label for="phoneNumber">Phone Number<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Phone Number" name="phone" id="phone">
              </div>
              <div class="form-group">
                <label for="emailAddress">Email Address<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Email Address" name="email" id="email">
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="well">
            <legend>Vacation Information</legend>
              <div class="form-group">
                <label for="arrivalDate">Arrival Date<span style="color:red;font-weight:bold">*</span></label>
                <input type="date" class="form-control required" placeholder="Arrival Date" name="arrdate" id="arrdate" >
              </div>
              <div class="form-group">
                <label for="departureDate">Departure Date<span style="color:red;font-weight:bold">*</span></label>
                <input type="date" class="form-control required" placeholder="Departure Date" name="depdate" id="depdate" >
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="well">
                  <legend>Preferred Area<span style="color:red;font-weight:bold">*</span></legend>
                  <div class="form-group required">
                    <label for="surfside">
                      <input type="checkbox" id="surfside" name="prefArea" value="Surfside"> Surfside
                    </label><br>
                    <label for="gardencity">
                      <input type="checkbox" id="gardencity" name="prefArea" value="Garden City"> Garden City
                    </label>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="well">
                  <legend>Preferred Location<span style="color:red;font-weight:bold">*</span></legend>
                  <div class="form-group required" >
                    <label for="oceanfront">
                      <input type="checkbox" id="oceanfront" name="prefLocation" value="Oceanfront"> Oceanfront
                    </label><br>
                    <label for="secondrow">
                      <input type="checkbox" id="secondrow" name="prefLocation" value="2nd Row"> 2nd Row
                    </label><br>
                    <label for="walktothebeach">
                      <input type="checkbox" id="walktothebeach" name="prefLocation" value="Walk to the Beach"> Walk to the Beach
                    </label>
                  </div>
                </div>
              </div>
            </div>
            <div class="well">
              <legend>Golf Information</legend>
              <div class="form-group">
                <label for="numberOfGolfers">Number of Golfers<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Number of Golfers" name="numGolfers" id="numGolfers">
              </div>
              <div class="form-group">
                <label for="numberOfRounds">Number of Rounds<span style="color:red;font-weight:bold">*</span></label>
                <input type="text" class="form-control required" placeholder="Number of Rounds" name="numRounds" id="numRounds">
              </div>
            </div>
          </div>
        </div>
        <h4>Golf Course</h4>
        <div class="row">
          <div class="col-md-12">
            <div class="well">
              <legend>South End Myrtle Beach</legend>
              <div class="row">
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="blackmoor">
                      <input type="checkbox" id="blackmoor" name="golfcourses" value="Blackmoor"> Blackmoor
                    </label><br>
                    <label for="heronpoint">
                      <input type="checkbox" id="heronpoint" name="golfcourses" value="Heron Point"> Heron Point
                    </label><br>
                    <label for="indianwells">
                      <input type="checkbox" id="indianwells" name="golfcourses" value="Indian Wells"> Indian Wells
                    </label><br>
                    <label for="pawleysplantation">
                      <input type="checkbox" id="pawleysplantation" name="golfcourses" value="Pawleys Plantation"> Pawleys Plantation
                    </label><br>
                    <label for="tpcofmb">
                      <input type="checkbox" id="tpcofmb" name="golfcourses" value="TPC of MB"> TPC of MB
                    </label><br>
                    <label for="wachesawplantationeast">
                      <input type="checkbox" id="wachesawplantationeast" name="golfcourses" value="Wachesaw Plantation East"> Wachesaw Plantation East
                    </label>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="caledoniagolfandfishclub">
                      <input type="checkbox" id="caledoniagolfandfishclub" name="golfcourses" value="Caledonia Golf & Fish Club"> Caledonia Golf & Fish Club
                    </label><br>
                    <label for="heritageclub">
                      <input type="checkbox" id="heritageclub" name="golfcourses" value="Heritage Club"> Heritage Club
                    </label><br>
                    <label for="internationalclub">
                      <input type="checkbox" id="internationalclub" name="golfcourses" value="International Club"> International Club
                    </label><br>
                    <label for="prestwickcountyclub">
                      <input type="checkbox" id="prestwickcountyclub" name="golfcourses" value="Prestwick Country Club"> Prestwick Country Club
                    </label><br>
                    <label for="trueblue">
                      <input type="checkbox" id="trueblue" name="golfcourses" value="True Blue"> True Blue
                    </label><br>
                    <label for="willbrookplantation">
                      <input type="checkbox" id="willbrookplantation" name="golfcourses" value="Willbrook Plantation"> Willbrook Plantation
                    </label>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="foundersclubatpawleys">
                      <input type="checkbox" id="foundersclubatpawleys" name="golfcourses" value="Founders Club at Pawleys"> Founders Club at Pawleys
                    </label><br>
                    <label for="indigocreek">
                      <input type="checkbox" id="indigocreek" name="golfcourses" value="Indigo Creek"> Indigo Creek
                    </label><br>
                    <label for="litchfiledcc">
                      <input type="checkbox" id="litchfiledcc" name="golfcourses" value="Litchfiled C.C."> Litchfiled C.C.
                    </label><br>
                    <label for="rivercLub">
                      <input type="checkbox" id="rivercLub" name="golfcourses" value="River CLub"> River CLub
                    </label><br>
                    <label for="tradition">
                      <input type="checkbox" id="tradition" name="golfcourses" value="Tradition"> Tradition
                    </label><br>
                    <label for="wickedstick">
                      <input type="checkbox" id="wickedstick" name="golfcourses" value="Wicked Stick"> Wicked Stick
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="well">
              <legend>Central Myrtle Beach</legend>
              <div class="row">
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="arrowheadcountryclub">
                      <input type="checkbox" id="arrowheadcountryclub" name="golfcourses" value="Arrowhead Country Club"> Arrowhead Country Club
                    </label><br>
                    <label for="legendshealthland">
                      <input type="checkbox" id="legendshealthland" name="golfcourses" value="Legends Healthland"> Legends Healthland
                    </label><br>
                    <label for="manowar">
                      <input type="checkbox" id="manowar" name="golfcourses" value="Man O'War"> Man O'War
                    </label><br>
                    <label for="mbnationalsouthcreek">
                      <input type="checkbox" id="mbnationalsouthcreek" name="golfcourses" value="MB National Southcreek"> MB National Southcreek
                    </label><br>
                    <label for="pinelakes">
                      <input type="checkbox" id="pinelakes" name="golfcourses" value="Pine Lakes"> Pine Lakes
                    </label><br>
                    <label for="wildwingavocet">
                      <input type="checkbox" id="wildwingavocet" name="golfcourses" value="Wild Wing Avocet"> Wild Wing Avocet
                    </label><br>
                    <label for="worldtour">
                      <input type="checkbox" id="worldtour" name="golfcourses" value="World Tour"> World Tour
                    </label>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="burningridge">
                      <input type="checkbox" id="burningridge" name="golfcourses" value="Burning Ridge"> Burning Ridge
                    </label><br>
                    <label for="legendsmoorland">
                      <input type="checkbox" id="legendsmoorland" name="golfcourses" value="Legends Moorland"> Legends Moorland
                    </label><br>
                    <label for="myrtlewoodpalmetto">
                      <input type="checkbox" id="myrtlewoodpalmetto" name="golfcourses" value="Myrtlewood Palmetto"> Myrtlewood Palmetto
                    </label><br>
                    <label for="mnnationalwest">
                      <input type="checkbox" id="mnnationalwest" name="golfcourses" value="MN National West"> MN National West
                    </label><br>
                    <label for="riveroaks">
                      <input type="checkbox" id="riveroaks" name="golfcourses" value="River Oaks"> River Oaks
                    </label><br>
                    <label for="witch">
                      <input type="checkbox" id="witch" name="golfcourses" value="Witch"> Witch
                    </label>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="grandedunes">
                      <input type="checkbox" id="grandedunes" name="golfcourses" value="Grande Dunes"> Grande Dunes
                    </label><br>
                    <label for="legendsparkland">
                      <input type="checkbox" id="legendsparkland" name="golfcourses" value="Legends Parkland"> Legends Parkland
                    </label><br>
                    <label for="myrtlewoodpinehills">
                      <input type="checkbox" id="myrtlewoodpinehills" name="golfcourses" value="Myrtlewood Pinehills"> Myrtlewood Pinehills
                    </label><br>
                    <label for="kingsnorth">
                      <input type="checkbox" id="kingsnorth" name="golfcourses" value="Kings North"> Kings North
                    </label><br>
                    <label for="whisperingpines">
                      <input type="checkbox" id="whisperingpines" name="golfcourses" value="Whispering Pines"> Whispering Pines
                    </label><br>
                    <label for="wizard">
                      <input type="checkbox" id="wizard" name="golfcourses" value="Wizard"> Wizard
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="well">
              <legend>North End</legend>
              <div class="row">
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="aberdeencountryclub">
                      <input type="checkbox" id="aberdeencountryclub" name="golfcourses" value="Aberdeen Country Club"> Aberdeen Country Club
                    </label><br>
                    <label for="barefootdye">
                      <input type="checkbox" id="barefootdye" name="golfcourses" value="Barefoot Dye"> Barefoot Dye
                    </label><br>
                    <label for="barefootnorman">
                      <input type="checkbox" id="barefootnorman" name="golfcourses" value="Barefoot Norman"> Barefoot Norman
                    </label><br>
                    <label for="bricklanding">
                      <input type="checkbox" id="bricklanding" name="golfcourses" value="Brick Landing"> Brick Landing
                    </label><br>
                    <label for="crowcreek">
                      <input type="checkbox" id="crowcreek" name="golfcourses" value="Crow Creek"> Crow Creek
                    </label><br>
                    <label for="eaglenest">
                      <input type="checkbox" id="eaglenest" name="golfcourses" value="Eagle Nest"> Eagle Nest
                    </label><br>
                    <label for="heatherglen">
                      <input type="checkbox" id="heatherglen" name="golfcourses" value="Heather Glen"> Heather Glen
                    </label><br>
                    <label for="lockwoodfolly">
                      <input type="checkbox" id="lockwoodfolly" name="golfcourses" value="Lockwood Folly"> Lockwood Folly
                    </label><br>
                    <label for="panthersrun">
                      <input type="checkbox" id="panthersrun" name="golfcourses" value="Panthers Run"> Panthers Run
                    </label><br>
                    <label for="possumtrot">
                      <input type="checkbox" id="possumtrot" name="golfcourses" value="Possum Trot"> Possum Trot
                    </label><br>
                    <label for="sandpiperbay">
                      <input type="checkbox" id="sandpiperbay" name="golfcourses" value="Sandpiper Bay"> Sandpiper Bay
                    </label><br>
                    <label for="seatrailjones">
                      <input type="checkbox" id="seatrailjones" name="golfcourses" value="Sea Trail Jones"> Sea Trail Jones
                    </label><br>
                    <label for="tidewater">
                      <input type="checkbox" id="tidewater" name="golfcourses" value="Tidewater"> Tidewater
                    </label>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="arcadianshoresgolfclub">
                      <input type="checkbox" id="arcadianshoresgolfclub" name="golfcourses" value="Arcadian Shores Golf Club"> Arcadian Shores Golf Club
                    </label><br>
                    <label for="barefootfazio">
                      <input type="checkbox" id="barefootfazio" name="golfcourses" value="Barefoot Fazio"> Barefoot Fazio
                    </label><br>
                    <label for="baldheadislandclub">
                      <input type="checkbox" id="baldheadislandclub" name="golfcourses" value="Bald Head Island Club"> Bald Head Island Club
                    </label><br>
                    <label for="brunswickplantation">
                      <input type="checkbox" id="brunswickplantation" name="golfcourses" value="Brunswick Plantation"> Brunswick Plantation
                    </label><br>
                    <label for="crownpark">
                      <input type="checkbox" id="crownpark" name="golfcourses" value="Crown Park"> Crown Park
                    </label><br>
                    <label for="farmstead">
                      <input type="checkbox" id="farmstead" name="golfcourses" value="Farmstead"> Farmstead
                    </label><br>
                    <label for="lionspaw">
                      <input type="checkbox" id="lionspaw" name="golfcourses" value="Lions Paw"> Lions Paw
                    </label><br>
                    <label for="meadowlands">
                      <input type="checkbox" id="meadowlands" name="golfcourses" value="Meadowlands"> Meadowlands
                    </label><br>
                    <label for="pearleast">
                      <input type="checkbox" id="pearleast" name="golfcourses" value="Pearl East"> Pearl East
                    </label><br>
                    <label for="riversedge">
                      <input type="checkbox" id="riversedge" name="golfcourses" value="Rivers Edge"> Rivers Edge
                    </label><br>
                    <label for="shaftsburyglen">
                      <input type="checkbox" id="shaftsburyglen" name="golfcourses" value="Shaftsbury Glen"> Shaftsbury Glen
                    </label><br>
                    <label for="seatrailmaples">
                      <input type="checkbox" id="seatrailmaples" name="golfcourses" value="Sea Trail Maples"> Sea Trail Maples
                    </label><br>
                    <label for="tigerseye">
                      <input type="checkbox" id="tigerseye" name="golfcourses" value="Tigers Eye"> Tigers Eye
                    </label>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="azaleasands">
                      <input type="checkbox" id="azaleasands" name="golfcourses" value="Azalea Sands"> Azalea Sands
                    </label><br>
                    <label for="barefootlove">
                      <input type="checkbox" id="barefootlove" name="golfcourses" value="Barefoot Love"> Barefoot Love
                    </label><br>
                    <label for="blackbear">
                      <input type="checkbox" id="blackbear" name="golfcourses" value="Black Bear"> Black Bear
                    </label><br>
                    <label for="carolinanational">
                      <input type="checkbox" id="carolinanational" name="golfcourses" value="Carolina National"> Carolina National
                    </label><br>
                    <label for="diamondback">
                      <input type="checkbox" id="diamondback" name="golfcourses" value="Diamond Back"> Diamond Back
                    </label><br>
                    <label for="glendornoch">
                      <input type="checkbox" id="glendornoch" name="golfcourses" value="Glen Dornoch"> Glen Dornoch
                    </label><br>
                    <label for="longbay">
                      <input type="checkbox" id="longbay" name="golfcourses" value="Long Bay"> Long Bay
                    </label><br>
                    <label for="oysterbay">
                      <input type="checkbox" id="oysterbay" name="golfcourses" value="Oyster Bay"> Oyster Bay
                    </label><br>
                    <label for="pearlwest">
                      <input type="checkbox" id="pearlwest" name="golfcourses" value="Pearl West"> Pearl West
                    </label><br>
                    <label for="riverhills">
                      <input type="checkbox" id="riverhills" name="golfcourses" value="River Hills"> River Hills
                    </label><br>
                    <label for="seatrailbyrd">
                      <input type="checkbox" id="seatrailbyrd" name="golfcourses" value="Sea Trail Byrd"> Sea Trail Byrd
                    </label><br>
                    <label for="thistle">
                      <input type="checkbox" id="thistle" name="golfcourses" value="Thistle"> Thistle
                    </label><br>
                    <label for="waterwayhills">
                      <input type="checkbox" id="waterwayhills" name="golfcourses" value="Waterway Hills"> Waterway Hills
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <input type="submit" class="btn btn-primary" value="Submit" name="golfBooking" id="golfBooking">
        </fieldset>
      </form>


<cf_htmlfoot>

<!--- CSS for validation --->
<style >
	label.error{color:red;}
	label.valid{display:none !important;}
</style>
<script>
$(document).ready(function(){
	$('#golfbookingform').validate({
		rules: {
			firstname:{
				required: true
			},
			lastname: {
				required: true
			},
			email: {
				required: true
			},
			city: {
				required: true
			},
			state: {
				required: true
			},
			zip: {
				minlength: 5,
				required:true
			},
			prefLocation: {
				required: true
			},
			prefArea: {
				required: true
			},
			golfcourses: {
				required: true
			},
			arrdate: {
				required: true
			},
			depdate: {
				required: true
			},
		},
		highlight: function(element){
			$(element).closest('.control-group').removeClass('success').addClass('error');
		},
		success: function(element) {
			element.text('OK!').addClass('valid')
			.closest('.control-group').removeClass('error').addClass('success');
		}
	});
});
</script>  
</cf_htmlfoot>