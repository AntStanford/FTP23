<cfinclude template="/#settings.mls.dir#/components/header.cfm">

<cfif NOT isdefined('cookie.loggedin')>
  <div class="content real-estate-wrapper real-estate-profile-login-wrapper">
  	<div class="container">
      <div class="row">
        <div class="col-xs-12">
          <div class="h3 text-center">You must first <a class="mlsLogin" href="/<cfoutput>#settings.mls.dir#</cfoutput>/components/mls-account.cfm?action=login">login</a> to access this page.</div>
        </div>
      </div>
  	</div>
  </div><!-- END real-estate-profile-login-wrapper -->
  <cfinclude template="/#settings.mls.dir#/components/footer.cfm">
  <cfabort>
</cfif>

<cfquery datasource="#application.settings.dsn#" name="GetProfile">
  select *
  from cl_accounts
  where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.loggedin#">
</cfquery>
<!--- <cfdump var="#GetProfile#"> --->

<div class="content real-estate-wrapper real-estate-profile-wrapper">
	<div class="container">

    <!-- MY PROFILE -->
		<div class="row">
			<div class="col-md-12">
        <cfoutput>
          <div class="h1">My Profile</div>

          <div class="h4 pull-left">Welcome Back, #capFirstTitle(lcase(GetProfile.firstname))#</div>
          <div class="btn-group pull-right">
            <a href="/#settings.mls.dir#/results" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white search-props">Search Properties</a><!--- removed .cfm --->
            <form action="/#application.settings.mls.dir#/results" method="POST" class="btn-logout pull-left"><!--- removed .cfm --->
              <input type="hidden" name="logout" value="true">
              <input type="hidden" name="camefromsearchform" value="true">
              <fieldset>
                <input type="submit" value="Logout" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" style="border-radius:0 4px 4px 0">
              </fieldset>
            </form>
          </div>
        </cfoutput>
      </div>
		</div><!-- END row -->

		<div class="my-favorites">
			<a name="favorites"></a>
      <cfinclude template="compare-favs.cfm">
		</div><!-- END my-favorites -->

    <!-- SHOW ALL FAVORITES SEARCHES -->
		<div class="row saved-searches">
			<div class="col-md-12">
        <cfif isdefined('url.RemoveFavoriteSearch')>
  	      <cfquery DATASOURCE="#application.settings.dsn#" NAME="GetInfo">
  	        delete
  	        FROM cl_saved_searches
  	        where id = '#RemoveFavoriteSearch#' and clientid = '#GetProfile.id#'
  	      </cfquery>
        </cfif>
        <cfif isdefined('FrequencyUpdate')>
          <cfif isdefined('howoften') and howoften is not "0">
            <cfset NextNotificationDate = "#dateformat(dateadd('d',howoften,now()),'yyyy-mm-dd')#">
            <cfelse>
            <cfset NextNotificationDate = "#dateformat(dateadd('d',-365,now()),'yyyy-mm-dd')#">
          </cfif>
  	      <cfquery DaTaSOURCE="#application.settings.dsn#" NaME="GetInfo">
  	        update cl_saved_searches
  	        set
  	          HowOften = '#HowOften#',
  	          NextNotificationDate = '#NextNotificationDate#'
  	        where id = '#FrequencyUpdate#'
  	      </cfquery>
        </cfif>
        <cfquery DATASOURCE="#application.settings.dsn#" NAME="GetFavSearches">
  	      SELECT *
  	      FROM cl_saved_searches
  	      where clientid = '#GetProfile.id#'  and searchname <> 'Tracking purpose'
  	      order by createdat
        </cfquery>

        <a name="savedsearches"></a>
        <div class="h2 nomargin">My Saved Searches <cfif isdefined('HowOften')> - Success</cfif></div>
        <cfif GetFavSearches.recordcount eq 0>
          <div class="notice">You have no saved searches at this time.</div>
        </cfif>

	    	<cfoutput query="GetFavSearches">
  	    	<form action="#script_name#?FrequencyUpdate=#id###savedsearches" method="post" class="">
          	<a class="h3 search-name" href="/#settings.mls.dir#/results?#searchparameters#&clearsession=&dontcountsearch=">#capFirstTitle(searchname)#</a><!--- removed .cfm --->

            <label for="HowOften" class="search-label">Notification Frequency:</label>
            <select name="HowOften" class="selectpicker search-select">
              <option value="0" <cfif HowOften is "0">selected</cfif>>Never</option>
              <option value="1" <cfif HowOften is "1">selected</cfif>>Daily</option>
              <option value="7" <cfif HowOften is "7">selected</cfif>>Weekly</option>
              <option value="14" <cfif HowOften is "14">selected</cfif>>Bi-Weekly</option>
              <option value="30" <cfif HowOften is "30">selected</cfif>>Monthly</option>
            </select>
            <div class="search-btns">
    		      <input type="submit" name="submit" value="Update Frequency" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white">
              <a href="#script_name#?RemoveFavoriteSearch=#id#" onClick="return NoteConfirm();" class="btn btn-danger text-white">Remove</a>
            </div>
	      	</form>
        </cfoutput>
      </div>
      <cfif isdefined('cookie.UserFirstName')>
        <cf_htmlfoot>
          <script language="javascript">
            function NoteConfirm() {
              var answer = confirm ("<cfoutput>#GetProfile.firstname#</cfoutput>, are you sure you would like to delete this saved search?");
              if (answer){
                //alert ("archived!");
                return true;
                //document.getElementById('LeadForm').submit();
              }else{
                return false;
              }
            }
          </script>
        </cf_htmlfoot>
      </cfif>
		</div><!-- END row saved-searches -->

    <!-- UPDATE PROFILE -->
		<div class="row update-profile">
			<div class="col-md-12">
	      <cfif isdefined('processform')>
  	      <cfparam name="firstname" default="">
  	      <cfparam name="lastname" default="">
  	      <cfparam name="Phone" default="">
  	      <cfparam name="officephone" default="">
  	      <cfparam name="CellPhone" default="">
  	      <cfparam name="email" default="">
  	      <cfparam name="spousefirstname" default="">
  	      <cfparam name="spouselastname" default="">
  	      <cfparam name="SpousePhone" default="">
  	      <cfparam name="spouseemail" default="">
  	      <cfparam name="Address" default="">
  	      <cfparam name="Address2" default="">
  	      <cfparam name="City" default="">
  	      <cfparam name="State" default="">
  	      <cfparam name="Country" default="">
  	      <cfparam name="zip" default="">
  	      <cfparam name="Password" default="">

          <!---has an account already been created with this email address--->
          <cfif isdefined('session.UserEmail') and session.UserEmail is not "#form.email#">
            <cfquery DaTaSOURCE="#application.settings.dsn#" NaME="Check">
              SELECT *
              FROM cl_accounts
              where email = '#form.email#'
            </cfquery>

            <cfif check.recordcount gt 0>
              <p><strong>NOTE: Our system shows that you already have an acccount with us. Please try <a href="javascript:history.back()">again.</a>.</strong></p>
              <cfabort>
            </cfif>
          </cfif>

          <!---do the passwords match--->
          <cfif password is not passwordcheck>
            <p><strong>NOTE: Your passwords do not match. Please <a href="javascript:history.back()">go back</a> and re-enter them.</strong></p>
            <cfinclude template="/components/footer.cfm">
            <cfabort>
          </cfif>

          <cfif isdefined('session.USERFirstName') and LEN(session.USERFirstName)>
          	<cfset session.USERFirstName = "#form.firstname#">
          	<cfcookie name="USERFirstName" value="#form.firstname#" expires="#LoginCookiepersist#">
          </cfif>
          <cfif isdefined('session.USERLastName') and LEN(session.USERLastName)>
            <cfset session.USERLastName = "#form.lastname#">
            <cfcookie name="USERLastName" value="#form.lastname#" expires="#LoginCookiepersist#">
          </cfif>
          <cfif isdefined('session.USEREmail') and LEN(session.USEREmail)>
            <cfset session.USEREmail = "#form.email#">
            <cfcookie name="USEREmail" value="#form.email#" expires="#LoginCookiepersist#">
          </cfif>
          <cfif isdefined('session.USERphone') and LEN(session.USERphone)>
            <cfset session.USERphone = "#form.phone#">
            <cfcookie name="USERphone" value="#form.phone#" expires="#LoginCookiepersist#">
          </cfif>

          <cfquery NaME="UpdateQuery" DaTaSOURCE="#application.settings.dsn#">
            UpDaTE cl_accounts
            SET
              firstname = '#form.firstname#',
              lastname = '#form.lastname#',
              phone = '#form.phone#',
              officephone = '#form.officephone#',
              Cellphone = '#form.Cellphone#',
              email = '#form.email#',
              spousefirstname = '#form.spousefirstname#',
              spouselastname = '#form.spouselastname#',
              Spousephone = '#form.Spousephone#',
              spouseemail = '#form.spouseemail#',
              address = '#form.address#',
              address2 = '#form.address2#',
              City = '#form.City#',
              State = '#form.state#',
              Country = '#form.Country#',
              zip = '#form.zip#',
            password = '#form.password#'
            where id = '#GetProfile.id#'
          </cfquery>

          <cfquery datasource="#application.settings.dsn#" name="GetProfile">
    			  select *
    			  from cl_accounts
    			  where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.loggedin#">
		      </cfquery>
        </cfif><!---END processform--->

  			<div class="client-profile clientProfileWrapper">
    		  <a name="profile"></a>
    			<div class="h2 nomargin">My Profile <cfif isdefined('processform')> - <em>Updated</em></cfif></div>
          <cfoutput>
  	      <form action="#script_name###profile" method="post" class="validate">
            <input type="hidden" name="processform" value="account Update - #script_name#">
            <p>Update your information below if needed.</p>
            <fieldset class="row">
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>First Name:</label>
                <input type="Text" name="firstname" value="#GetProfile.firstname#" class="required">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Last Name:</label>
                <input type="Text" name="lastname" value="#GetProfile.lastname#" class="required">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Home phone:</label>
                <input type="text" name="phone" value="#GetProfile.phone#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Office phone:</label>
                <input type="text" name="officephone" value="#GetProfile.officephone#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Cell phone:</label>
                <input type="text" name="Cellphone" value="#GetProfile.Cellphone#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Email:</label>
                <input type="text" name="email" value="#GetProfile.email#" class="required">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Spouse First Name:</label>
                <input type="text" name="spousefirstname" value="#GetProfile.spousefirstname#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Spouse Last Name:</label>
                <input type="text" name="spouselastname" value="#GetProfile.spouselastname#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Spouse phone:</label>
                <input type="text" name="Spousephone" value="#GetProfile.Spousephone#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Spouse Email:</label>
                <input type="text" name="spouseemail" value="#GetProfile.spouseemail#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Address:</label>
                <input type="text" name="address" value="#GetProfile.address#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Address 2:</label>
                <input type="text" name="address2" value="#GetProfile.address2#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>City:</label>
                <input type="text" name="City" value="#GetProfile.City#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>State:</label>
                <cfquery name="States" datasource="#application.settings.dsn#">
                  SELECT name_long as state
                  FROM states
                  ORDER BY state ASC
                </cfquery>
                <select name="State" class="selectpicker">
                  <cfloop query="states">
                    <option <cfif #state# IS #GetProfile.state#>SELECTED</cfif>>#State#</option>
                  </cfloop>
                </select>
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Country:</label>
                <cfquery name="Countries" datasource="#application.settings.dsn#">
                  SELECT Country
                  FROM countries
                  ORDER BY Country ASC
                </cfquery>
                <select name="Country" class="selectpicker">
                  <option VaLUE="US" selected>United States of America</option>
                  <option VaLUE="Canada">Canada</option>
                  <cfloop QUERY="Countries">
                    <option VaLUE="#Country#" <cfif #Country# IS #GetProfile.Country#>SELECTED</cfif>>#Country#</option>
                  </cfloop>
                </select>
              </div><!---START HERE--->
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Zip:</label>
                <input type="text" name="zip" value="#GetProfile.zip#" class="">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Password:</label>
                <input type="text" name="password" value="#GetProfile.password#" class="required">
              </div>
              <div class="col-xs-6 col-sm-6 col-md-4">
                <label>Re-Enter password:</label>
                <input type="text" name="passwordCheck" value="#GetProfile.password#" class="required">
              </div>
              <div class="col-xs-12 col-sm-12 col-md-12">
                <input type="submit" name="SubmitForm" value="Update profile" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white">
              </div>
            </fieldset>
          </form>
          </cfoutput>
  			</div><!-- END client-profile -->
      </div>
		</div><!-- END row update-profile -->

  </div>
</div><!-- END real-estate-profile-wrapper -->

<cfinclude template="/#settings.mls.dir#/components/footer.cfm">