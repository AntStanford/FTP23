

<cfinclude template="/sales/components/header.cfm">

    <cfif NOT isdefined('cookie.loggedin')>
      <div class="notice"><h2>You must first <a hreflang="en" class="colorbox-link" href="/sales/index.cfm?linkToLogin=">login</a> to access this page.</h2></div>
      <cfinclude template="/sales/components/footer.cfm">
      <cfabort>
    </cfif>

<cfquery datasource="#mls.dsn#" name="GetProfile">
  select *
  from cl_accounts
  where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.loggedin#">
</cfquery>


<cfinclude template="/sales/includes/session-killer.cfm">

<div class="full-width" id="content">
  <div class="mls-advanced-search my-profile">
  <cfif isdefined('cookie.UserFirstName')>
    <script language="javASCript">
    function NoteConfirm() {
      var answer = confirm ("<cfoutput>#GetProfile.firstname#</cfoutput>, are you sure you would like to delete this listing?");
      if (answer){
        //alert ("archived!");
        return true;
        //document.getElementById('LeadForm').submit();
      }else{
        return false;
      }
    }
    </script>
  </cfif>
    <!---GETS IMaGE paTH--->
    <cfquery name="getmlscoinfo" datasource="#DSNMLS#">
      SELECT *
      FROM mlsfeeds
      where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
    </cfquery>
    <h1>My Profile</h1>

    <cfoutput>
      <div class="notice">
        <p style="text-transform:capitalize;">Welcome Back, #capFirstTitle(lcase(GetProfile.firstname))#</p>
      </div>
    </cfoutput>



    <!---START: SHOW aLL FaVORITES--->
    <cfif isdefined('url.Removemlsnumber')>
      <cfquery DaTaSOURCE="#mls.dsn#" NaME="GetInfo">
        delete
        FROM cl_favorites
        where mlsnumber = '#Removemlsnumber#' and mlsid = '#mlsid#' and wsid = '#wsid#' and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetProfile.id#">
      </cfquery>
    </cfif>
    <cfquery DaTaSOURCE="#mls.dsn#" NaME="GetFavorites">
      SELECT *
      FROM cl_favorites
      where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetProfile.id#">
      order by thedate
    </cfquery>
    <a name="favorites"></a>
    <h2>My Favorites <cfif isdefined('Removemlsnumber')> - Success</cfif></h2>
    <div class="mls-search-results">
      <ul class="search-results">
        <cfif GetFavorites.recordcount eq 0><p>You have no favorites at this time.</p></cfif>
        <cfoutput query="GetFavorites">



          <!---START: REaCH OUT aND GRaB liSTING DaTa--->
          <cfquery DaTaSOURCE="#DSNMLS#" NaME="Getlistings">
            SELECT
            mastertable.*,
            property_dates.created_at
            FROM mastertable
            Inner Join property_dates
            where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
            and mastertable.mlsnumber = '#mlsnumber#' and mastertable.mlsid = '#mlsid#' and mastertable.wsid = '#wsid#'
          </cfquery>
          <!---END: REaCH OUT aND GRaB liSTING DaTa--->

          <cfif Getlistings.recordcount gt 0>
            <cfset seolink = optimizeMyURL(GetListings.street_number,GetListings.street_name,GetListings.city,GetListings.zip_code,GetListings.mlsnumber,GetListings.mlsid,GetListings.wsid)>
            <li class="search-result">
              <cfinclude template="/sales/includes/image-handler.cfm">
              <a hreflang="en" href="/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#"><cfif HowManyphotos gt 0><IMG src="#thephoto#" alt="#mls.companyname# - MLS Number: #Getlistings.mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/sales/images/not_avail.jpg" alt="#mls.companyname# - MLS Number: #Getlistings.mlsnumber#"></cfif></a>
              <h3>#Getlistings.street_number# #Getlistings.street_name# <span class="list-price">#dollarformat(Getlistings.list_price)#</span></h3>
              <h4><cfif Getlistings.subdivision is not "" and Getlistings.subdivision is not "none">#Getlistings.subdivision#,</cfif> #Getlistings.city#</h4>
              <p class="attributes">MLS## #mlsnumber#</p>
              <p class="attributes">#Getlistings.acreage# acres <cfif Getlistings.zoning is not "">| Zoning: #Getlistings.zoning#</cfif> <cfif Getlistings.kind is not "">| Kind: #Getlistings.kind#</cfif></p>
              <p class="provider">Courtesy of #Getlistings.listing_office_name#</p>
              <ul class="actions" style="height:30px">
                <li class="view-property"><a hreflang="en" href="#seolink#" title="View MLS##: #mlsnumber#" class="button light">View property</a></li>
                <li class="favorite"><a hreflang="en" href="#script_name#?Removemlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid###favorites" onClick="return NoteConfirm();" class="button light">Remove</a><br><br></li>
              </ul>
            </li>
          <cfelse>
          <li class="search-result">
          <h4>The listing for MLS## #mlsnumber# is no longer available.</h4>
          </cfif>





        </cfoutput>
      </ul>
    </div>



    <!---START: SHOW aLL FaVORITES--->



    <!---START: SHOW aLL FaVORITES SEaRCHES--->
    <cfif isdefined('url.RemoveFavoriteSearch')>
      <cfquery DaTaSOURCE="#mls.dsn#" NaME="GetInfo">
        delete
        FROM cl_saved_searches
        where id = '#RemoveFavoriteSearch#' and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetProfile.id#">
      </cfquery>
    </cfif>
    <cfif isdefined('FrequencyUpdate')>
      <cfif isdefined('howoften') and howoften is not "0">
        <cfset NextNotificationDate = "#dateformat(dateadd('d',howoften,now()),'yyyy-mm-dd')#">
      <cfelse>
        <cfset NextNotificationDate = "#dateformat(dateadd('d',-365,now()),'yyyy-mm-dd')#">
      </cfif>
      <cfquery DaTaSOURCE="#mls.dsn#" NaME="GetInfo">
        update cl_saved_searches
        set
          HowOften = '#HowOften#',
          NextNotificationDate = '#NextNotificationDate#'
        where id = '#FrequencyUpdate#'
      </cfquery>
    </cfif>
    <cfquery DaTaSOURCE="#mls.dsn#" NaME="GetFavSearches">
      SELECT *
      FROM cl_saved_searches
      where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetProfile.id#">  and searchname <> 'Tracking purpose'
      order by createdat
    </cfquery>
    <a name="savedsearches"></a>
    <h2>My Saved Searches <cfif isdefined('HowOften')> - Success</cfif></h2>
    <cfif GetFavSearches.recordcount eq 0><div class="notice"><p>You have no saved searches at this time.</p></div></cfif>

      <ol class="saved-searches">
    <cfoutput query="GetFavSearches">
    <form action="#script_name#?FrequencyUpdate=#id###savedsearches" method="post">
       <li>
          <div class="search-name">
            <a hreflang="en" href="/sales/search-results.cfm?#searchparameters#&clearsession=&dontcountsearch=" class="button">#capFirstTitle(searchname)#</a>
          </div>
          <div class="search-notify notice">
            <!--- <label for="Notification">Notification Frequency:</label> --->
            Notification Frequency:<br>
            <select name="HowOften" class="chzn-select">
              <option value="0" <cfif HowOften is "0">selected</cfif>>Never</option>
              <option value="1" <cfif HowOften is "1">selected</cfif>>Daily</option>
              <option value="7" <cfif HowOften is "7">selected</cfif>>Weekly</option>
              <option value="14" <cfif HowOften is "14">selected</cfif>>Bi-Weekly</option>
              <option value="30" <cfif HowOften is "30">selected</cfif>>Monthly</option>
            </select>
            <input type="submit" name="submit" value="Update Frequency" class="button light">
            <a hreflang="en" href="#script_name#?RemoveFavoriteSearch=#id#" onClick="return NoteConfirm();" class="button light">Remove</a>
          </div>
        </li>
        </form>
     </cfoutput>
      </ol>



    <!---START: SHOW aLL FaVORITE SEaRCHES--->



    <!---START: UpDaTE pROFILE--->
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
        <cfquery DaTaSOURCE="#mls.dsn#" NaME="Check">
          SELECT *
          FROM cl_accounts
          where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif check.recordcount gt 0>
          <div class="notice">
            <p>NOTE: Our system shows that you already have an acccount with us.  please try <a hreflang="en" href="javASCript:history.back()">again.</a>.</p>
          </div>
          <cfinclude template="/components/footer-lightboxes.cfm">
          <cfabort>
        </cfif>
      </cfif>
      <!---do the passwords match--->
      <cfif password is not passwordcheck>
        <div class="notice">
          <p>NOTE: Your passwords do not match.  please <a hreflang="en" href="javASCript:history.back()">go back</a> and re-enter them.</strong></p>
        </div>
        <cfinclude template="/sales/components/footer.cfm">
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


      <cfquery NaME="UpdateQuery" DaTaSOURCE="#mls.dsn#">
        UpDaTE cl_accounts
        SET
          firstname = <cfqueryparam value="#form.firstname#" cfsqltype="CF_SQL_VARCHAR">,
          lastname = <cfqueryparam value="#form.lastname#" cfsqltype="CF_SQL_VARCHAR">,
          phone = <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_integer">,
          officephone = <cfqueryparam value="#form.officephone#" cfsqltype="cf_sql_integer">,
          Cellphone = <cfqueryparam value="#form.Cellphone#" cfsqltype="cf_sql_integer">,
          email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">,
          spousefirstname = <cfqueryparam value="#form.spousefirstname#" cfsqltype="CF_SQL_VARCHAR">,
          spouselastname = <cfqueryparam value="#form.spouselastname#" cfsqltype="CF_SQL_VARCHAR">,
          Spousephone = <cfqueryparam value="#form.Spousephone#" cfsqltype="cf_sql_integer">,
          spouseemail = <cfqueryparam value="#form.spouseemail#" cfsqltype="CF_SQL_VARCHAR">,
          address = <cfqueryparam value="#form.address#" cfsqltype="CF_SQL_VARCHAR">,
          address2 = <cfqueryparam value="#form.address2#" cfsqltype="CF_SQL_VARCHAR">,
          City = <cfqueryparam value="#form.City#" cfsqltype="CF_SQL_VARCHAR">,
          State = <cfqueryparam value="#form.state#" cfsqltype="CF_SQL_VARCHAR">,
          Country = <cfqueryparam value="#form.Country#" cfsqltype="CF_SQL_VARCHAR">,
          zip = <cfqueryparam value="#form.zip#" cfsqltype="cf_sql_integer">,
        password = <cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR">
        where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetProfile.id#">
      </cfquery>

      <cfquery datasource="#mls.dsn#" name="GetProfile">
  select *
  from cl_accounts
  where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.loggedin#">
</cfquery>

    </cfif>

    <a name="profile"></a><br>
    <h2>My Profile <cfif isdefined('processform')> - Updated</cfif></h2>
    <div align="center">
      <cfform action="#script_name###profile" method="post">
        <cfinput type="hidden" name="processform" value="account Update - #script_name#">
        <table class="client-profile">
        <tr>
          <td colspan="2">
            <p>Update your information below if needed.</p>
          </td>
        </tr>
        <tr>
          <td class="ContactForm">First Name:<br><cfinput type="Text" name="firstname" message="please Enter Your First Name!" required="Yes" value="#GetProfile.firstname#"></td>
          <td class="ContactForm">Last Name:<br><cfinput type="Text" name="lastname" message="please enter Your Last Name." required="Yes" value="#GetProfile.lastname#"></td>
        </tr>
        <tr>
          <td class="ContactForm">Home phone:<br><cfinput type="text" name="phone" value="#GetProfile.phone#"></td>
          <td class="ContactForm">Office phone:<br><cfinput type="Text" name="officephone" value="#GetProfile.officephone#"></td>
        </tr>
        <tr>
          <td class="ContactForm">Cell phone:<br><cfinput type="text" name="Cellphone" value="#GetProfile.Cellphone#"></td>
          <td class="ContactForm">Email:<br><cfinput type="Text" name="email" value="#GetProfile.email#" message="please enter a valid email address." required="Yes"></td>
        </tr>
        <tr>
          <td class="ContactForm">Spouse First Name:<br><cfinput type="text" name="spousefirstname" value="#GetProfile.spousefirstname#"></td>
          <td class="ContactForm">Spouse Last Name:<br><cfinput type="Text" name="spouselastname" value="#GetProfile.spouselastname#"></td>
        </tr>
        <tr>
          <td class="ContactForm">Spouse phone:<br><cfinput type="text" name="Spousephone" value="#GetProfile.Spousephone#"></td>
          <td class="ContactForm">Spouse Email:<br><cfinput type="Text" name="spouseemail" value="#GetProfile.spouseemail#"></td>
        </tr>
        <tr>
          <td class="ContactForm">Address:<br><cfinput type="text" name="address" value="#GetProfile.address#"></td>
          <td class="ContactForm">Address 2:<br><cfinput type="Text" name="address2" value="#GetProfile.address2#"></td>
        </tr>
        <tr>
          <td class="ContactForm">City:<br><cfinput type="text" name="City" value="#GetProfile.City#"></td>
          <td class="ContactForm">State:<br>
            <cfquery name="States" datasource="#mls.dsn#">
              SELECT state
              FROM states
              ORDER BY state ASC
            </cfquery>
            <select  name="State">
              <cfoutput query="states">
                <option <cfif #state# IS #GetProfile.state#>SELECTED</cfif>>#State#</option>
              </cfoutput>
            </select>
          </td>
        </tr>
        <tr>
          <td class="ContactForm">Country:<br>
            <cfquery name="Countries" datasource="#mls.dsn#">
              SELECT Country
              FROM countries
              ORDER BY Country ASC
            </cfquery>
            <select  name="Country">
              <option VaLUE="US" selected>United States of America</option>
              <option VaLUE="Canada">Canada</option>
              <cfoutput QUERY="Countries">
                <option VaLUE="#Country#" <cfif #Country# IS #GetProfile.Country#>SELECTED</cfif>>#Country#</option>
              </cfoutput>
            </select>
          </td>
          <td class="ContactForm">Zip:<br><cfinput type="Text" name="zip" value="#GetProfile.zip#"></td>
        </tr>
        <tr>
          <td class="ContactForm">password:<br><cfinput type="Text" name="password" message="please enter a password!" value="#GetProfile.password#" required="Yes"></td>
          <td class="ContactForm">Re-Enter password:<br><cfinput type="Text" name="passwordCheck" message="please re-enter a password!" value="#GetProfile.password#" required="Yes"></td>
        </tr>
        <tr>
          <td class="ContactForm" colspan="2"><cfinput type="submit" name="SubmitForm" value="Update profile" class="button"><br><br></td>
        </tr>
        </table>
      </cfform>
    </div>
    <!---END UpDaTE pROFILE--->



  </div>
</div>

<cfinclude template="/sales/components/footer.cfm">
