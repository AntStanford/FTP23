<cfif CGI.REMOTE_ADDR eq "219.91.238.243">
	#cfmail.clientEmail# : <cfoutput>#cfmail.clientEmail#</cfoutput><br />
    #cfmail.company# : <cfoutput>#cfmail.company#</cfoutput><br />
</cfif>
<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

<cfif Cffp.testSubmission(form)>

  <cfif isdefined('form.contactform')>

  		<!--- reCaptcha ---->
		<cfset recaptcha = "">
        <cfif structKeyExists(FORM,"g-recaptcha-response")>
            <cfset recaptcha = FORM["g-recaptcha-response"]>
        </cfif>
        <cfset isHuman = false>

        <cfif len(recaptcha)>

            <!--- POST to google and verify submission --->
            <cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
            <cfset secret = settings.google_recaptcha_secretkey>
            <cfset ipaddr = CGI.REMOTE_ADDR>
            <cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>

            <cfhttp url="#request_url#" method="get" timeout="10">

            <cfset response = deserializeJSON(cfhttp.filecontent)>
            <cfif response.success eq "true">
                <cfset isHuman = true>
            </cfif>
        </cfif>

        <cfif isHuman is true>

	<cfsavecontent variable="emailbody">
		<cfoutput>
        <cfinclude template="/components/email-template-top.cfm">
        <p>First Name: #firstname#</p>
        <p>Last Name: #lastname#</p>
        <p>Email: #email#</p>
        <p>Phone Number: #phone#</p>
        <p>Comments: #comments#</p>
        <p>Came From: #camefrom#</p>
        <cfif isdefined('form.resort') and len(form.resort)>
          <p>This user has a question about: #form.resort#</p>
        </cfif>
        <cfif isdefined('form.longtermrental') and len(form.longtermrental)>
          <p>This user is interested in the following long term rental: #form.longtermrental#</p>
        </cfif>
        <cfinclude template="/components/email-template-bottom.cfm">
		</cfoutput>
	</cfsavecontent>

	<cfif form.camefrom EQ "Property Management">
		<cfset sendEmail("tyler@surfsiderealty.com",emailbody,"New contact from #cgi.http_host#")>
  <cfelseif form.camefrom EQ "Association Management">
		<cfset sendEmail("nancyg@surfsiderealty.com",emailbody,"New contact from #cgi.http_host#")>
  <cfelse>
		<cfset sendEmail(settings.clientEmail,emailbody,"New contact from #cgi.http_host#")>
  </cfif>


            <cfif len(form.email)>
              <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
            <cfelse>
              <cfset variables.encEmail = ''>
            </cfif>
            <cfif len(form.phone)>
              <cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
            <cfelse>
              <cfset variables.encPhone = ''>
            </cfif>

            <cfquery dataSource="#settings.dsn#">
              insert into cms_contacts(firstname,lastname,email,comments,phone,camefrom)
              values(
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#firstname#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#lastname#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#comments#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encPhone#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#camefrom#">
              )
            </cfquery>

            <cfif settings.ListrakEnabled is "Yes">
                <cfinclude template="/components/listrak.cfm">
            </cfif>

            <cfif settings.hasLeadtracker eq 'yes'>
                <cfinclude template="/components/leadtracker.cfm">
           </cfif>

           <cfinclude template="/components/mailchimp.cfm">

        <cflocation addToken="no" url="/thanks">

      <cfelse>

        <cflocation addToken="no" url="/bad-captcha">

      </cfif>



  </cfif>

  <cfif isDefined('form.whichform') and form.whichform is 'footerContactForm'>
    <!--- reCaptcha ---->
    <cfset recaptcha = "">
        <cfif structKeyExists(FORM,"g-recaptcha-response")>
            <cfset recaptcha = FORM["g-recaptcha-response"]>
        </cfif>
        <cfset isHuman = false>

        <cfif len(recaptcha)>

            <!--- POST to google and verify submission --->
            <cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
            <cfset secret = settings.google_recaptcha_secretkey>
            <cfset ipaddr = CGI.REMOTE_ADDR>
            <cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>

            <cfhttp url="#request_url#" method="get" timeout="10">

            <cfset response = deserializeJSON(cfhttp.filecontent)>
            <cfif response.success eq "true">
                <cfset isHuman = true>
            </cfif>
        </cfif>

        <cfif isHuman is true>

            <cfmail subject="New request more information from #cgi.http_host#" to="#cfmail.clientEmail#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">

              <cfparam name="camefrom" default="Request More Info">

              <cfinclude template="/components/email-template-top.cfm">
              <p>First Name: #firstname#</p>
              <p>Last Name: #lastname#</p>
              <p>Email: #email#</p>
              <p>Comments: #comments#</p>
              <p>Came From: #camefrom#</p>
              <cfinclude template="/components/email-template-bottom.cfm">

            </cfmail>

            <cfif len(form.email)>
              <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
            <cfelse>
              <cfset variables.encEmail = ''>
            </cfif>

            <cfquery dataSource="#settings.dsn#">
              insert into cms_contacts(firstname,lastname,email,comments,camefrom)
              values(
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#firstname#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#lastname#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#comments#">,
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#camefrom#">
              )
            </cfquery>

            <cfif settings.ListrakEnabled is "Yes">
                <cfinclude template="/components/listrak.cfm">
            </cfif>

            <cfif settings.hasLeadtracker eq 'yes'>
                <cfinclude template="/components/leadtracker.cfm">
           </cfif>
           success
      </cfif>
  </cfif>

  <cfif isdefined('form.newsletterform')>

        <cfmail subject="New contact from #cgi.http_host#" to="#cfmail.clientEmail#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">

          <cfinclude template="/components/email-template-top.cfm">
          <p>First Name: #form.firstname#</p>
          <p>Last Name: #form.lastname#</p>
          <p>Email: #email#</p>
          <cfinclude template="/components/email-template-bottom.cfm">

        </cfmail>

        <cfif len(form.email)>
          <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
        <cfelse>
          <cfset variables.encEmail = ''>
        </cfif>

        <cfquery dataSource="#settings.dsn#">
          insert into cms_contacts(email,camefrom,firstname,lastname)
          values(
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,
            'Newsletter Form',
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">
          )
        </cfquery>

   		<cfif settings.ListrakEnabled is "Yes">
   			<cfinclude template="/components/listrak.cfm">
   		</cfif>

   		<cfif settings.hasLeadtracker eq 'yes'>
		    <cfinclude template="/components/leadtracker.cfm">
      </cfif>

      <cfinclude template="/components/mailchimp.cfm">

       <cflocation addToken="no" url="/thanks">

  </cfif>


  <cfif isdefined('form.equipmentForm')>

    <cfoutput>
      <cfsavecontent variable="formcopy">
            <p>Name: <b>#form.NAME#</b></p>
            <p>Email: <b>#form.EMAIL#</b></p>
            <p>Cell Phone: <b>#form.PHONE#</b></p>
            <p>Property Name and Address: <b>#form.PROPERTY#</b></p>
            <!--- <p>Rental Company: <b>#form.COMPANY#</b></p> --->
            <p>Delivery Date and Time: <b>#form.DELIVERYDATE#</b></p>
<!---             <p>Pick Up Date and Time: <b>#form.PICKUPDATE#</b></p> --->

            <table>
              <tr><td>Gas Grill (540" 1 Propane Tank 3 burner) (house only) :</td><td><b>#form.GASGRILL#</b></td></tr>
              <tr><td>Deluxe Gas Grill (650" 1 Propane Tank 4 burner) (house only) :</td><td><b>#form.GASGRILL#</b></td></tr>
              <tr><td>Charcoal Grill (22" charcoal not included) (house only):</td><td><b>#form.CHARCOALGRILL#</b></td></tr>
              <tr><td>Roll-a-way bed (Twin Size):</td><td><b>#form.ROLLAWAYBED#</b></td></tr>
              <tr><td>Sun Lover's Package (2 Beach Chairs/1 umbrella):</td><td><b>#form.PCKG_SUNLOVERS#</b></td></tr>
              <tr><td>Deluxe Sun Lover's Package (4 chairs/1 umbrella):</td><td><b>#form.PCKG_DELUXESUNLOVERS#</b></td></tr>
              <tr><td>Beach Lover's Package (2 chairs/1umbrella/2 boogie boards):</td><td><b>#form.PCKG_BEACHLOVERS#</b></td></tr>
              <!--- <tr><td>Adult Bike for 4 (4 bikes):</td><td><b>#form.ADULTBIKEFOR4#</b></td></tr> --->
              <tr><td>Bike & Surf for 2 (2 bikes, 2 beach chairs, 1 umbrella):</td><td><b>#form.BIKESURFFOR2#</b></td></tr>
              <tr><td>Bike & Surf for 4 (4 bikes, 4 beach chairs, 1 umbrella):</td><td><b>#form.BIKESURFFOR4#</b></td></tr>
              <tr><td>Youth Bike:</td><td><b>#form.YOUTHBIKE#</b></td></tr>
              <tr><td>Adult Bike:</td><td><b>#form.ADULTBIKE#</b></td></tr>
              <tr><td>Adult Bike with Baby Seat:</td><td><b>#form.ADULTBIKEBABYSEAT#</b></td></tr>
              <!--- <tr><td>Adult Bike with Kiddie Cart:</td><td><b>#form.ADULTBIKEKIDDIECART#</b></td></tr> --->
              <tr><td>Large Crib (54" X 32"):</td><td><b>#form.LARGECRIB#</b></td></tr>
              <tr><td>Highchair (Plastic):</td><td><b>#form.HIGHCHAIR#</b></td></tr>
              <tr><td>Baby Gate (wooden 24" X 42"):</td><td><b>#form.BABYGATE#</b></td></tr>
              <tr><td>Pack & PlayCompact Crib (40" X 26"):</td><td><b>#form.PACKPLAY#</b></td></tr>
              <tr><td>Compact Crib (40" X 26"):</td><td><b>#form.COMPACTCRIB#</b></td></tr>
              <tr><td>Boogie Board:</td><td><b>#form.BOOGIEBOARD#</b></td></tr>
              <tr><td>8' Wooden Beach Umbrella:</td><td><b>#form.WOODENBEACHUMBRELLA#</b></td></tr>
              <tr><td>Aluminum Low Sitting Beach Chair:</td><td><b>#form.ALUMINUMLOWBEACHCHAIR#</b></td></tr>
              <tr><td>Additional Propane Tank (refill):</td><td><b>#form.ADDITIONALPROPANETANKREFILL#</b></td></tr>
              <tr><td>Sand Anchor:</td><td><b>#form.SANDANCHOR#</b></td></tr>
              <!---
              <tr><td>One Day Moped:</td><td><b>#form.mopedOneDay#</b></td></tr>
              <tr><td>Three Day Moped:</td><td><b>#form.mopedThreeDay#</b></td></tr>
              <tr><td>Week Moped:</td><td><b>#form.mopedWeek#</b></td></tr>
              --->
							<tr><td>Sub Total:</td><td><b>#dollarformat(form.SUBTOTAL)#</b></td></tr>
              <tr><td>Sales Tax:</td><td><b>#dollarformat(form.SALESTAX)#</b></td></tr>
              <tr><td>Grand Total:</td><td><b>#dollarformat(form.FORMTOTAL)#</b></td></tr>
            </table>
      </cfsavecontent>
    </cfoutput>


    <cfmail subject="Equipment Rental Form from #cgi.http_host#" to="#cfmail.clientEmail#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">

          <p>The follow information has just been submitted on #cgi.server_name#.</p>

          #formcopy#
    </cfmail>

    <cfinclude template="/components/mailchimp.cfm">

    <cflocation url="/thanks" addtoken="false">


    </cfif>


  <cfif isdefined('form.eventbookingform')>

    <cfmail subject="Event form submitted from #cgi.http_host#" to="events@surfsiderealty.com" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">

            <p>The follow information has just been submitted on #cgi.server_name#.</p>
            <p>Name: #form.FIRSTNAME# #form.LASTNAME#</p>
            <p>Address: #form.address#<br>
              #form.city#, #form.state# #form.zip#<br>
              #form.country#
            <p>Email: #form.Email#</p>
            <p>Phone: #form.phone#</p>
            <p>Arrival date: #dateformat(form.arrdate,'mmm d, yyyy')#</p>
            <p>Depart date: #dateformat(form.depdate,'mmm d, yyyy')#</p>
            <p>Event code: #form.eventcode#</p>
            <p>Number in party: #form.partynum#</p>
            <p>Preferred area: #form.prefarea#</p>
            <p>Preferred location: #form.preflocation#</p>
            <p>Type: #form.bldgtype#</p>
          </cfmail>
        <!---  --->
        <cfmail subject="Thank you for your inquiry" to="#form.email#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">

            <p>A representative will contact you soon regarding your request.</p>

            <p>Name: #form.FIRSTNAME# #form.LASTNAME#</p>
            <p>Address: #form.address#<br>
              #form.city#, #form.state# #form.zip#<br>
              #form.country#
            <p>Email: #form.Email#</p>
            <p>Phone: #form.phone#</p>
            <p>Arrival date: #dateformat(form.arrdate,'mmm d, yyyy')#</p>
            <p>Depart date: #dateformat(form.depdate,'mmm d, yyyy')#</p>
            <p>Event code: #form.eventcode#</p>
            <p>Number in party: #form.partynum#</p>
            <p>Preferred area: #form.prefarea#</p>
            <p>Preferred location: #form.preflocation#</p>
            <p>Type: #form.bldgtype#</p>
          </cfmail>

          <cfinclude template="/components/mailchimp.cfm">

        <cflocation url="/thanks" addtoken="false" >

    </cfif>



  <cfif isdefined('form.golfbooking')>


        <!---  --->
    <cfmail subject="Golf booking form submitted from #cgi.http_host#" to="golf@surfsiderealty.com" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">

              <p>The follow information has just been submitted on #cgi.server_name#.</p>
              <p>Name: #form.FIRSTNAME# #form.LASTNAME#</p>
              <p>Address: #form.address#<br>
                #form.city#, #form.state# #form.zip#<br>
                #form.country#
              <p>Email: #form.Email#</p>
              <p>Phone: #form.phone#</p>
              <p>Arrival date: #dateformat(form.arrdate,'mmm d, yyyy')#</p>
              <p>Depart date: #dateformat(form.depdate,'mmm d, yyyy')#</p>
              <p>Number of golfers: #form.numgolfers#</p>
              <p>Number of rounds: #form.numrounds#
              <p>Preferred area: #form.prefarea#</p>
              <p>Preferred location: #form.preflocation#</p>
              <p>Golf courses: #form.golfcourses#</p>
            </cfmail>
          <!---  --->

        <cfmail subject="Thank you for your inquiry" to="#form.email#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">

              <p>A representative will contact you soon regarding your request.</p>


              <p>Name: #form.FIRSTNAME# #form.LASTNAME#</p>
              <p>Address: #form.address#<br>
                #form.city#, #form.state# #form.zip#<br>
                #form.country#
              <p>Email: #form.Email#</p>
              <p>Phone: #form.phone#</p>
              <p>Arrival date: #dateformat(form.arrdate,'mmm d, yyyy')#</p>
              <p>Depart date: #dateformat(form.depdate,'mmm d, yyyy')#</p>
              <p>Number of golfers: #form.numgolfers#</p>
              <p>Number of rounds: #form.numrounds#
              <p>Preferred area: #form.prefarea#</p>
              <p>Preferred location: #form.preflocation#</p>
              <p>Golf courses: #form.golfcourses#</p>
            </cfmail>

        <cfinclude template="/components/mailchimp.cfm">

        <cflocation url="/thanks" addtoken="false" >

    </cfif>



  <cfif isdefined('form.longterminquire')>

      <cfsavecontent variable="emailbody">
        <cfoutput>
          <p>The following information has just been submitted on #cgi.server_name#.</p>
          <p>Name: #form.name#</p>
          <p>Phone: #form.phone#</p>
          <p>Email: #form.Email#</p>
          <p>Property Address: #form.PROPADDR#</p>
          <p>Comments:<br><br>#form.longterm_comments#</p>
    
        </cfoutput>
      </cfsavecontent>
    
      <cfset sendEmail("longterm@surfsiderealty.com",emailbody,"Long Term Booking Inquiry from #cgi.http_host#")>
    
     

    <cfif len(form.email)>
      <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
    <cfelse>
      <cfset variables.encEmail = ''>
    </cfif>
    <cfif len(form.phone)>
      <cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
    <cfelse>
      <cfset variables.encPhone = ''>
    </cfif>

    <cfquery dataSource="#settings.dsn#">
      insert into cms_contacts (lastname, email, phone, comments, camefrom, propaddress) values (
         <cfqueryparam value="#form.NAME#" cfsqltype="cf_sql_varchar">,
         <cfqueryparam value="#variables.encEmail#" cfsqltype="cf_sql_varchar">,
         <cfqueryparam value="#variables.encPhone#" cfsqltype="cf_sql_varchar">,
         <cfqueryparam value="#form.longterm_comments#" cfsqltype="cf_sql_varchar">,
         <cfqueryparam value="Long Term Rental Inquiry" cfsqltype="cf_sql_varchar">,
         <cfqueryparam value="#form.PROPADDR#" cfsqltype="cf_sql_varchar">
        )
    </cfquery>

    <cfinclude template="/components/mailchimp.cfm">

    <cflocation url="/thanks" addtoken="false" >

  </cfif>

  <cfif isdefined('form.propertymanagementinquire')>

  <!--- reCaptcha ---->
    <cfset recaptcha = "">
        <cfif structKeyExists(FORM,"g-recaptcha-response")>
            <cfset recaptcha = FORM["g-recaptcha-response"]>
        </cfif>
        <cfset isHuman = true>

<!---
        <cfif len(recaptcha)>

            <!--- POST to google and verify submission --->
            <cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
            <cfset secret = settings.google_recaptcha_secretkey>
            <cfset ipaddr = CGI.REMOTE_ADDR>
            <cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>

            <cfhttp url="#request_url#" method="get" timeout="10">

            <cfset response = deserializeJSON(cfhttp.filecontent)>
            <cfif response.success eq "true">
                <cfset isHuman = true>
            </cfif>
        </cfif>
				--->

        <cfif isHuman is true>

          <cfsavecontent variable="emailbody">
            <cfoutput>
                    <p>The follow information has just been submitted on #cgi.server_name#.</p>
                    <p>Name: #form.name#</p>
                    <p>Phone: #form.phone#</p>
                    <p>Email: #form.Email#</p>
                    <p>Property Address: #form.PROPADDR#</p>
                    <p>Comments:<br><br>#propmgmt_comments#</p>
            </cfoutput>
          </cfsavecontent>
        
          <cfset sendEmail("longterm@surfsiderealty.com",emailbody,"Long Term Property Management Inquiry from #cgi.http_host#")>
        
          <cfif len(form.email)>
            <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
          <cfelse>
            <cfset variables.encEmail = ''>
          </cfif>
          <cfif len(form.phone)>
            <cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
          <cfelse>
            <cfset variables.encPhone = ''>
          </cfif>

          <cfquery dataSource="#settings.dsn#">
            insert into cms_contacts (lastname, email, phone, comments, camefrom, propaddress) values (
               <cfqueryparam value="#form.NAME#" cfsqltype="cf_sql_varchar">,
               <cfqueryparam value="#variables.encEmail#" cfsqltype="cf_sql_varchar">,
               <cfqueryparam value="#variables.encPhone#" cfsqltype="cf_sql_varchar">,
               <cfqueryparam value="#form.propmgmt_comments#" cfsqltype="cf_sql_varchar">,
               <cfqueryparam value="Property Management Inquiry" cfsqltype="cf_sql_varchar">,
               <cfqueryparam value="#form.PROPADDR#" cfsqltype="cf_sql_varchar">
              )
          </cfquery>

          <cfinclude template="/components/mailchimp.cfm">

          <cflocation url="/thanks" addtoken="false" >

        <cfelse>

          <cflocation url="/bad-captcha" addtoken="false" >

        </cfif>

  </cfif>

  <cfif isDefined('form.newsletterModalForm')>
    <cfif cgi.remote_host eq '75.87.66.209' or cgi.remote_host eq '99.1.177.220'>
      <cfset SendToEmail = '' />
    <cfelse>
      <cfset SendToEmail = cfmail.clientEmail />
    </cfif>

      <cfmail subject="Newsletter Signup from #cgi.http_host#" to="#SendToEmail#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.email#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">
        <cfinclude template="/components/email-template-top.cfm">
        <p>Email: #email#</p>
        <cfinclude template="/components/email-template-bottom.cfm">
      </cfmail>

      <cfif len(form.email)>
        <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
      <cfelse>
        <cfset variables.encEmail = ''>
      </cfif>

      <cfquery dataSource="#settings.dsn#">
      insert into cms_contacts(email,camefrom)
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="Popup Sign Up Form">
      )
      </cfquery>

    <cflocation addToken="no" url="/thanks">
  </cfif>

  <cfif isDefined('form.customNewsletterModalName')>
    <!--- reCaptcha ---->
    <cfset recaptcha = "">
        <cfif structKeyExists(FORM,"g-recaptcha-response")>
            <cfset recaptcha = FORM["g-recaptcha-response"]>
        </cfif>
        <cfset isHuman = false>

        <cfif len(recaptcha)>

            <!--- POST to google and verify submission --->
            <cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
            <cfset secret = settings.google_recaptcha_secretkey>
            <cfset ipaddr = CGI.REMOTE_ADDR>
            <cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>

            <cfhttp url="#request_url#" method="get" timeout="10">

            <cfset response = deserializeJSON(cfhttp.filecontent)>
            <cfif response.success eq "true">
                <cfset isHuman = true>
            </cfif>
        </cfif>

        <cfif isHuman is true>
          <cfif cgi.remote_host eq '75.87.66.209'>
            <cfset SendToEmail = 'cbarksdale@icoastalnet.com' />
          <cfelse>
            <cfset SendToEmail = cfmail.clientEmail />
          </cfif>

          <!---<cfmail subject="Popup Newsletter Form Signup from #cgi.http_host#" to="#SendToEmail#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.customNewsletterModalEmailAddress#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="#cfmail.bcc#" cc="#cfmail.cc#">--->
          <cfmail subject="Popup Newsletter Form Signup from #cgi.http_host#" to="#SendToEmail#" from="#cfmail.company# <#cfmail.username#>" replyto="#form.customNewsletterModalEmailAddress#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML">
            <cfinclude template="/components/email-template-top.cfm">
            <p>Name: #form.customNewsletterModalName#</p>
            <p>Email: #form.customNewsletterModalEmailAddress#</p>
            <cfinclude template="/components/email-template-bottom.cfm">
          </cfmail>
          <!---
            Gotta divide customNewsletterModalName into first and last name
          --->
          <cfset variables.firstnme = listFirst( form.customNewsletterModalName, ' ' ) />
          <cfset variables.lastname = listLast( form.customNewsletterModalName, ' ' ) />

          <cfif len(form.customNewsletterModalEmailAddress)>
            <cfset variables.encEmail = encrypt(form.customNewsletterModalEmailAddress, application.contactInfoEncryptKey, 'AES')>
          <cfelse>
            <cfset variables.encEmail = ''>
          </cfif>
          
          <cfquery datasource="#settings.dsn#">
          insert into cms_contacts(firstname,lastname,email,camefrom)
          values(
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.firstnme#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.lastname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.encemail#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="Popup Newsletter Form">
          )
          </cfquery>

          <!--- mailchimp needs 'email' instead of 'form.customNewsletterModalEmailAddress' --->
          <cfset email = form.customNewsletterModalEmailAddress />
          <cfinclude template="/components/mailchimp.cfm">

          success
        </cfif>
  </cfif>
</cfif>
<!--- add form processing for blog footer form here --->