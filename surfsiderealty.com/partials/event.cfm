      <form class="form" action="/submit.cfm" method="post" id="eventbookingform">
      <input type="hidden" name="eventbookingform">
      <cfinclude template="/cfformprotect/cffp.cfm">

        <div class="row">
          <div class="col-md-6">
            <div class="well">
              <legend>Contact Information</legend>
              <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" class="form-control" placeholder="First Name" name="firstName">
              </div>
              <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" class="form-control" placeholder="Last Name" name="lastName">
              </div>
              <div class="form-group">
                <label for="address">Address</label>
                <input type="text" class="form-control" placeholder="Address" name="address" >
              </div>
              <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" placeholder="City" name="city" >
              </div>
              <div class="form-group">
                <label for="state">State</label>
                <input type="text" class="form-control" placeholder="State" name="state" >
              </div>
              <div class="form-group">
                <label for="zipCode">Zip Code</label>
                <input type="text" class="form-control" placeholder="State" name="zip" >
              </div>
              <div class="form-group">
                <label for="country">Country</label>
                <input type="text" class="form-control" placeholder="Country" name="country" >
              </div>
              <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" class="form-control" placeholder="Phone Number" name="phone" >
              </div>
              <div class="form-group">
                <label for="emailAddress">Email Address</label>
                <input type="text" class="form-control" placeholder="Email Address" name="email" >
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="well">
            <legend>Vacation Information</legend>
              <div class="form-group">
                <label for="arrivalDate">Arrival Date</label>
                <input type="date" class="form-control" placeholder="Arrival Date" name="arrdate" >
              </div>
              <div class="form-group">
                <label for="departureDate">Departure Date</label>
                <input type="date" class="form-control" placeholder="Departure Date" name="depdate" >
              </div>
              <div class="form-group">
                <label for="eventCode">Event Code</label>
                <input type="text" class="form-control" placeholder="Event Code" name="eventcode">
              </div>
              <div class="form-group">
                <label for="howmanyinyourparty">How many in your party?</label>
                <input type="text" class="form-control" placeholder="How many in your party?" name="partynum" >
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="well">
                  <legend>Preferred Area</legend>
                  <div class="form-group">
                    <label for="surfside">
                      <input type="checkbox" id="surfside" name="prefarea" value="Surfside"> Surfside
                    </label><br>
                    <label for="gardencity">
                      <input type="checkbox" id="gardencity" name="prefarea" value="Garden City"> Garden City
                    </label>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="well">
                  <legend>Preferred Location</legend>
                  <div class="form-group">
                    <label for="oceanfront">
                      <input type="checkbox" id="oceanfront" name="preflocation" value="Oceanfront"> Oceanfront
                    </label><br>
                    <label for="secondrow">
                      <input type="checkbox" id="secondrow" name="preflocation" value="2nd Row"> 2nd Row
                    </label><br>
                    <label for="walktothebeach">
                      <input type="checkbox" id="walktothebeach" name="preflocation" value="Walk to the Beach"> Walk to the Beach
                    </label>
                  </div>
                </div>
              </div>
            </div>
            <div class="well">
              <legend>Type</legend>
              <div class="form-group">
                <label for="house">
                  <input type="checkbox" id="house" name="bldgtype" value="House"> House
                </label><br>
                <label for="condo">
                  <input type="checkbox" id="condo" name="bldgtype" value="Condo"> Condo
                </label>
              </div>
            </div>
          </div>
        </div>
        <input type="submit" class="btn btn-primary" value="Submit" name="submitEvent">
      </form>

<cf_htmlfoot>

<!--- CSS for validation --->
<style >
  label.error{color:red;}
  label.valid{display:none !important;}
</style>
<script >
  $(document).ready(function(){
    $('#eventbookingform').validate({
      rules: {
        firstName: {
          required: true
        },
        lastName: {
          required: true
        },
        address: {
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
          required: true
        },
        country: {
          required: true
        },
        email: {
          required: true
        },
        arrdate: {
          required: true
        },
        depdate: {
          required: true
        },
        eventcode: {
          required: true
        },
        partynum: {
          required: true
        },
        prefarea: {
          required: true
        },
        preflocation: {
          required: true
        },
        bldgtype: {
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


