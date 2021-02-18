<!---<cfif cgi.script_name eq '/#application.settings.mls.dir#/results.cfm' or ( isdefined('page.isCustomSearchPage') and page.isCustomSearchPage eq 'mls' ) OR cgi.script_name eq '/#application.settings.mls.dir#/property.cfm'>

	<!-- Write Review Property Modal -->
	<div class="modal fade favorites-account-modal" id="favoritesAccountModal" tabindex="-1" role="dialog" aria-labelledby="favoritesAccountLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header site-color-1-bg text-white">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="favoritesAccountLabel"><i class="fa fa-user-plus" aria-hidden="true"></i> Create An Account!</h4>
	      </div>
	      <div class="modal-body">
	        <span class="fa-stack fa-lg">
	          <i class="fa fa-heart fa-stack-1x text-danger"></i>
	          <i class="fa fa-ban fa-stack-2x"></i>
	        </span>
	        <p><strong>SUCCESS!</strong>Looks like you've saved at least three favorites, don't lose them when you come back!</p>
	        <p class="nomargin">Create a quick account (less than 1 minute) to save these and share with friends.</p>
	        <hr>
	        <small>(Don't worry, we don't share your email with <em>anybody</em>!)</small>
	        <a href="/guest-focus/dashboard.cfm#createAnAccount" class="btn btn-lg site-color-1-bg site-color-1-lighten-bg-hover text-white">Create An Account</a>

          <div class="login-block">Already have an account? <a class="site-color-1" href="/guest-focus/index.cfm">Click Here</a> to login.</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>

	<script type="text/javascript">
	  $(document).ready(function(){
	    //$('#favoritesAccountModal').modal('show');
	  });
	</script>

</cfif>--->

<!--- Save Search Results Modal --->
<div class="modal fade" id="saveSearchModal" tabindex="-1" role="dialog" aria-labelledby="saveSearchModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <cfif isdefined('cookie.loggedin') and len(cookie.loggedin)>
      <div class="modal-header site-color-1-bg text-white">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="saveSearchModalLabel"><i class="fa fa-floppy-o"></i> Save your Search Criteria</h4>
      </div>
      </cfif>
      <div class="modal-body">
        <div class="special-modal-info">
          <div id="saveSearchModalContent">
            <div id="saveSearchModalMsg"></div>
            <cfif isdefined('cookie.loggedin') and len(cookie.loggedin)>
              <form class="user-login-form" id="saveSearchForm">
                <cfinclude template="/cfformprotect/cffp.cfm">
                <fieldset class="row">
                  <div class="form-group col-xs-12 col-sm-6">
                    <input type="text" placeholder="Name this search" name="searchname" class="form-control required">
                  </div>
                  <div class="form-group col-xs-12 col-sm-6">
                    <select class="form-control" name="HowOften">
                      <option value="0">Never</option>
                      <option value="1">Daily</option>
                      <option value="7">Weekly</option>
                      <option value="14">Bi-Weekly</option>
                      <option value="30">Monthly</option>
                    </select>
                  </div>
                  <div class="form-group col-xs-12">
                    <input type="submit" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" value="Save Search">
                  </div>
                </fieldset>
              </form>
            <cfelse>
              <p class="text-center">Please <a onclick="showLogin();"><strong>login</strong></a> or <a onclick="createAccount();"><strong>create an account</strong></a> to save a search.</p>
            </cfif>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!--- Login Modal  --->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header site-color-1-bg text-white">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="loginModalLabel"><i class="fa fa-sign-in"></i> Login</h4>
      </div>
      <div class="modal-body">
        <div class="special-modal-info">
          <div id="loginModalContent">
            <p>If you already have an account, login below. If not, please <a onclick="createAccount();">create one</a>.</p>
            <form class="user-login-form validate" id="loginForm">
              <cfinclude template="/cfformprotect/cffp.cfm">
              <fieldset class="row">
                <div class="form-group col-xs-12 col-sm-6">
                  <label>Email Address</label>
                  <input type="email" placeholder="Email address" name="email" class="form-control required">
                </div>
                <div class="form-group col-xs-12 col-sm-6">
                  <label>Password</label>
                  <input type="password" placeholder="Password" name="password" class="form-control required">
                </div>
                <div class="form-group col-xs-12">
                  <input type="submit" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" value="Login">
                </div>
              </fieldset>
            </form>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!--- Create Account Modal  --->
<div class="modal fade" id="createAccountModal" tabindex="-1" role="dialog" aria-labelledby="createAccountModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header site-color-1-bg text-white">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="createAccountModalLabel"><i class="fa fa-plus"></i> Create An Account</h4>
      </div>
      <div class="modal-body">
        <div class="special-modal-info">
          <div id="createAccountModalContent">
            <div id="createAccountModalMsg"></div>
            <form class="user-login-form" id="createAccountForm">
              <cfinclude template="/cfformprotect/cffp.cfm">

              <fieldset>
                <input type="hidden" name="processform" value="Create Account - #script_name#">
                <!---START: THIS IS TO AUTOMATE THE PROCESS OF ADDING THE FAVORITE PROPERTY TO YOUR ACCOUNT WHEN CREATED--->
                <cfoutput>
                  <input type="hidden" name="ReferringPage" value="#cgi.http_referer#">
                  <cfif isdefined('action')>
                    <input type="hidden" name="action" value="#action#">
                  </cfif>
                  <cfif isdefined('FavoriteWSID')>
                    <input type="hidden" name="FavoriteWSID" value="#FavoriteWSID#">
                  </cfif>
                  <cfif isdefined('FavoriteMLSID')>
                    <input type="hidden" name="FavoriteMLSID" value="#FavoriteMLSID#">
                  </cfif>
                  <cfif isdefined('Favoritemlsnumber')>
                    <input type="hidden" name="Favoritemlsnumber" value="#Favoritemlsnumber#">
                  </cfif>
                  <cfif isdefined('SendToAFriendWSID')>
                    <input type="hidden" name="SendToAFriendWSID" value="#SendToAFriendWSID#">
                  </cfif>
                  <cfif isdefined('SendToAFriendMLSID')>
                    <input type="hidden" name="SendToAFriendMLSID" value="#SendToAFriendMLSID#">
                  </cfif>
                  <cfif isdefined('SendToAFriendmlsnumber')>
                    <input type="hidden" name="SendToAFriendmlsnumber" value="#SendToAFriendmlsnumber#">
                  </cfif>
                  <cfif isdefined('propertycount')>
                    <input type="hidden" name="propertycount" value="#propertycount#">
                  </cfif>
                </cfoutput>
              </fieldset>

              <cfif isdefined('action') and action is "addtofavorites">
                <p><b>To Save Your Favorites</b></p>
              <cfelse>
                <p>Enjoy all the great features <cfoutput>#settings.company#'s</cfoutput> website offers by filling out the form below.</p>
              </cfif>

              <fieldset class="row">
                <div class="form-group col-xs-12 col-sm-6">
                  <label>First Name</label>
                  <input type="text" id="firstName" name="firstName" placeholder="First" class="form-control required">
                </div>
                <div class="form-group col-xs-12 col-sm-6">
                  <label>Last Name</label>
                  <input type="text" id="lastName" name="lastName" placeholder="Last" class="form-control required">
                </div>
                <div class="form-group col-xs-12 col-sm-6">
                  <label>Email Address</label>
                  <input type="email" id="email" name="email" placeholder="Email" class="form-control required">
                </div>
                <div class="form-group col-xs-12 col-sm-6">
                  <label>Password</label>
                  <input type="password" name="thepassword" id="thePassword" class="form-control required">
                </div>

                <cfif application.settings.mls.EnableRoundRobin is "Yes">
                  <cfif isdefined('session.useremail') and session.useremail is not "">
                    <cfquery datasource="#settings.dsn#" name="CheckExists">
                      SELECT  *
                      FROM    cl_accounts
                      WHERE   email = '#session.useremail#'
                    </cfquery>
                    <cfoutput><input type="hidden" name="agentid" value="#CheckExists.agentid#"></cfoutput>
                  <cfelse>
                    <div class="form-group col-xs-12 col-sm-6">
                      <label>Are you working with an existing agent?</label>
                      <select class="form-control" name="agentid">
                        <option value="No" SELECTED>No</option>
                        <cfoutput query="application.settings.mls.rrAgents">
                          <option value="#application.settings.mls.rrAgents.id#">Yes - #application.settings.mls.rrAgents.firstname# #application.settings.mls.rrAgents.lastname#</option>
                        </cfoutput>
                      </select>
                    </div>
                  </cfif>
                <cfelse>
                  <input type="hidden" name="agentid" value="No">
                </cfif>

                <div class="form-group col-xs-12">
                  <input type="submit" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" value="Create Account">
                </div>
              </fieldset>
            </form>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!--- moving this code to footer-modals.cfm from results.cfm to better control execution order (footer-modals.cfm is the last thing loaded) --->
<script>
  $(document).ready(function(){
    // FORM VALIDATION
    $('#loginForm').validate();
    $('#createAccountForm').validate();
    $('#saveSearchForm').validate();
  });

  // LOGIN SUBMIT
  $("#loginForm").submit(function(e){
    var postData = $(this).serializeArray();
    $.ajax({
      url : "/<cfoutput>#application.settings.mls.dir#</cfoutput>/ajax/login.cfm",
      type: "POST",
      data : postData,
      success: function(data)
      {
        var response = data.trim();

        if (response == 'yes') {
          // Login Verified
          console.log('logged in');
          $("#loginModalContent").html('<h3>Processing log in request</h3>');
          window.location.href = '/mls/results';
        } else if(response == 'forgotpassword') {
          // Login Failed
          console.log('forgotpassword');
          $("#forgotLoginModal").modal();
        } else if (response == 'noaccount') {
          console.log('noaccount');
        } else {
          console.log('other error');
        }
      }
    });
    e.preventDefault();
  });

  // LOGIN SUBMIT
  $("#createAccountForm").submit(function(e){
    $("#createAccountModalMsg").html('');
    var postData = $(this).serializeArray();

    var pw = $('#thePassword').val();
    // this regex returns true if the string has an upper case letter, a number, and a special character
    var pwRegex = new RegExp("^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

    if(pwRegex.test(pw)) {
      $.ajax({
        url : "/<cfoutput>#application.settings.mls.dir#</cfoutput>/ajax/create-account.cfm",
        type: "POST",
        data : postData,
        success: function(data)
        {
          var response = data.trim();

          if (response == 'yes') {
            // Login Verified
            console.log('logged in');
            $("#createAccountModalMsg").html('<h3>Processing new account</h3>');
            window.location.href = '/mls/results';
          } else if(response == 'accountexists') {
            //account exists - link to
            console.log('accountexists');
            $("#createAccountModalMsg").html('An account with that email address already exists.<br>Please use a different email address or <a onclick="showLogin()">log in</a>.');
          } else {
            console.log('other error');
          }
        }
      });
    } else {
      $("#createAccountModalMsg").html('Passwords must be at least 8 characters long, have at least one upper case letter, a number, and a special character (! @ # $ % ^ & or *)');
    }
    e.preventDefault();
  });

  // LOGIN SUBMIT
  $("#saveSearchForm").submit(function(e){
    var postData = $(this).serializeArray();
    $.ajax({
      url : "/<cfoutput>#application.settings.mls.dir#</cfoutput>/ajax/save-search.cfm",
      type: "POST",
      data : postData,
      success: function(data)
      {
        var response = data.trim();

        if (response == 'yes') {
          // saved
          console.log('saved');
          $("#saveSearchModalContent").html('<h3>Your search has been saved.</h3>');
          setTimeout(function() { $('#saveSearchModal').modal('hide'); }, 3000);
        } else if(response == 'duplicatename') {
          // Failed
          console.log('duplicatename');
          $("#saveSearchModalMsg").html('<h4>That name is already in use - please use a different name.</h4>');
        } else {
          console.log('other error');
        }
      }
    });
    e.preventDefault();
  });

  function createAccount(){
    $('#loginModal').modal('hide');
    $('#saveSearchModal').modal('hide');
    $('#createAccountModal').modal('show');
  }

  function showLogin(){
    $("#createAccountModalMsg").html('');
    $('#createAccountModal').modal('hide');
    $('#saveSearchModal').modal('hide');
    $('#loginModal').modal('show');
  }
</script>
<!--- end code move to footer-modals.cfm from results.cfm to better control execution order --->