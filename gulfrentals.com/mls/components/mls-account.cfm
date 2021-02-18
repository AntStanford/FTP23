<!--- <cfinclude template="/components/header.cfm"> --->
<cfinclude template="/#settings.mls.dir#/components/header.cfm">

<cfparam name="form.processform" default="">
<cfparam name="form.ReferringPage" default="">
<cfparam name="form.firstname" default="">
<cfparam name="form.lastname" default="">
<cfparam name="form.Phone" default="">
<cfparam name="form.email" default="">
<cfparam name="form.password" default="">
<cfparam name="form.agentid" default="">
<cfparam name="url.action" default="login">
<cfparam name="url.action2" default="">
<cfparam name="variables.e" default= "">

<cfif cgi.request_method is "POST">
  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

  <cfif Cffp.testSubmission(form)>
    <cfswitch expression="#url.action#">
      <cfcase value="register">
        <cfinclude template="mls-account_create_.cfm">
      </cfcase>
      <cfcase value="login">
        <cfinclude template="mls-account_login_.cfm">
      </cfcase>
    </cfswitch>
  <cfelse>
    <cfset variables.e = "<li>Form processing error">
  </cfif>
</cfif>

<cfswitch expression="#url.action#">
	<!-- MLS Register -->
  <cfcase value="register">
  	<div class="container mls-account-wrap mlsCreateForm" id="mlsCreateFormDiv">
  		<div class="row">
  			<div class="col-xs-12">
          <cfif variables.e neq ''>
            <div class="alert alert-danger">
              <a href="#" class="close" data-dismiss="alert">&times;</a>
              <cfoutput>#variables.e#</cfoutput>
            </div>
          </cfif>

          <div class="h1">Create an Account</div>
          <a class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" href="/<cfoutput>#application.settings.mls.dir#</cfoutput>/components/mls-account.cfm?action=login&action2=#url.action2#">Login</a>
          <br><br>
          <form id="mlsCreateForm" action="<cfoutput>/#application.settings.mls.dir#/components/mls-account.cfm?action=register&action2=#url.action2#</cfoutput>" method="post">
            <input type="hidden" name="agentid" value="No">
            <cfinclude template="/cfformprotect/cffp.cfm">
            <div id="mlsCreateTable">
              <p style="margin-bottom:10px;">Enjoy all the great features our website offers by filling out the form below.</p>
            </div>
            <div class="form-group">
              <div class="row">
                <input type="hidden" name="processform" value="Create Account">
                <div class="col-xs-12 col-sm-6">
                  <label>First Name:</label>
                  <input type="text" name="firstname" class="" value="<cfoutput>#form.firstname#</cfoutput>">
                </div>
                <div class="col-xs-12 col-sm-6">
                  <label>Last Name:</label>
                  <input type="text" name="lastname" class="" value="<cfoutput>#form.lastname#</cfoutput>">
                </div>
                <div class="col-xs-12 col-sm-6">
                  <label>Phone:</label>
                  <input type="text" name="Phone" class="" value="<cfoutput>#form.phone#</cfoutput>">
                </div>
                <div class="col-xs-12 col-sm-6">
                  <label>Email:</label>
                  <input type="text" name="email" class="" value="<cfoutput>#form.email#</cfoutput>">
                </div>
              </div>
              <div class="row">
                <div class="col-xs-12 col-sm-6">
                  <label>Password:</label>
                  <input type="password" name="password" class="" value="<cfoutput>#form.password#</cfoutput>">
                  <em>Must be 8 characters</em>
                </div>
              </div>

              <!--- Add reCaptcha if client has public/private key setup in mls_clients --->
              <!--- <cfif isDefined('application.settings.mls.reCaptcha_public_key') AND application.settings.mls.reCaptcha_public_key neq "" AND isDefined('application.settings.mls.reCaptcha_private_key') AND application.settings.mls.reCaptcha_private_key neq "">
                <div id="mlsCreateAccountRecaptcha" class="g-recaptcha"></div>
                <div class="g-recaptcha-error" name="g-recaptcha-error"></div>
              </cfif> --->
              <div id="mlsCreateAccountRecaptcha" class="g-recaptcha"<!---  data-callback="recaptchaCallback" data-sitekey="<cfoutput>#application.settings.mls.reCaptcha_public_key#</cfoutput>" --->></div>
              <div class="g-recaptcha-error" name ="g-recaptcha-error"></div>
  					</div>
  					<div id="success-msg"></div>
            <input type="submit" name="submit" value="Submit" id="submitMlsCreateForm" class="btn site-color-2-bg site-color-2-bg-lighten-hover text-white" data-backdrop="static" onClick="ga('send', 'event', { eventCategory: 'New Account', eventAction: 'Created', eventLabel: 'New Account', eventValue: 1});">
          </form>
  			</div>
  		</div>
  	</div>
  </cfcase>

	<!-- MLS Login -->
  <cfcase value="login">
  	<div class="container mls-account-wrap mlsAccount" id="mlsModalLogin">
  		<div class="row">
  			<div class="col-xs-12">

  				<div class="h1">Login</div><a href="<cfoutput>/#application.settings.mls.dir#/components/mls-account.cfm?action=register&action2=#url.action2#</cfoutput>" class="" id="ClearCreate">Create Account</a>
  				<form id="mlsformLogin1" action="<cfoutput>/#application.settings.mls.dir#/components/mls-account.cfm?action=login&action2=#url.action2#</cfoutput>" method="post">
            <cfinclude template="/cfformprotect/cffp.cfm">
  	      	<p>If you already have an account, login below. If not, click Create Account.</p>
            <div id="success-login"></div>
            <cfif variables.e neq ''>
              <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <cfoutput>#variables.e#</cfoutput>
              </div>
            </cfif>
            <div class="form-group" id="mlsLoginTable">
              <div class="row">
                <div class="col-xs-12 col-sm-6">
                  <label>Email:</label>
                  <input type="text" name="Email" class="">
                </div>
                <div class="col-xs-12 col-sm-6">
                  <label>Password:</label>
                  <input type="password" name="Password" class="">
                </div>
              </div>
            </div>
            <input type="submit" name="submit" value="Submit" id="submitMlsLogin1" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-backdrop="static">
            <a href="mls-account.cfm?action=forgot">Forgot your password?</a>
  				</form>
  			</div>
  		</div><!-- END row -->
  	</div><!-- END container -->
  </cfcase>

	<!-- MLS PW Retrieval -->
  <cfcase value="forgot">
  	<div class="container mls-account-wrap mlsAccount" id="mlsPWRetrieval">
  		<div class="row">
  			<div class="col-xs-12">
  			  <h1>Password Retrieval</h1>
  			  <div class="pass-retrieval">
  			    <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

              <cfinclude template="mls-account_forgot_.cfm">

  			      <p>Enter your email address below and we will email you your account information to login.</p>
  			      <div>
  			        <cfform action="/#application.settings.mls.dir#/components/mls-account.cfm?action=forgot" method="post" class="validate">
  			          <cfinclude template="/cfformprotect/cffp.cfm">
  			          <cfinput type="hidden" name="processRetrieval" value="Retrieval Password - #script_name#">
  			          <div class="form-group">
  				        	<div class="row">
                      <div class="col-xs-12 col-sm-6">
                        <label>Email:</label>
                        <cfinput type="text" name="email" class="required">
                      </div>
                      <div class="col-xs-12 col-sm-6">
                        <label>&nbsp;</label>
                        <cfinput type="submit" name="SubmitForm" value="Retrieve Password" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white">
                      </div>
                    </div>
                    <a href="mls-account.cfm?action=Login">Back to Login</a>
  								</div><!---END form-group--->
  			        </cfform>
  			      </div>

  			  </div>
  			</div>
  		</div>
  	</div>
	</cfcase>
</cfswitch>

<cfinclude template="/#settings.mls.dir#/components/footer.cfm">