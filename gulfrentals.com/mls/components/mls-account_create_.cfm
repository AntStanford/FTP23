<!--- <cfdump var="#form#"> ---><cfif cgi.request_method is "POST">

  <cfif trim(form.firstname) eq ''><cfset variables.e = variables.e & "<li>First Name is a required field</li>"></cfif>
  <cfif trim(form.lastname) eq ''><cfset variables.e = variables.e & "<li>Last Name is a required field</li>"></cfif>
  <cfif trim(form.phone) eq ''><cfset variables.e = variables.e & "<li>Phone is a required field</li>"></cfif>
  <cfif trim(form.email) eq ''><cfset variables.e = variables.e & "<li>Email is a required field</li>"></cfif>
  <cfif trim(form.password) eq ''><cfset variables.e = variables.e & "<li>Password is a required field.</li>"></cfif>
  <cfif len(trim(form.password)) lt 8><cfset variables.e = variables.e & "<li>Password must be at least 8 characters.</li>"></cfif>
  <cfif not isValid("email",trim(form.email))><cfset variables.e = variables.e & "<li>Email is not valid</li>"></cfif>
  <!--- reCaptcha for cental clients that are setup in the DB --->
  <cfif isDefined('settings.mls.reCaptcha_public_key') AND settings.mls.reCaptcha_public_key neq ""
    AND isDefined('settings.mls.reCaptcha_private_key') AND settings.mls.reCaptcha_private_key neq ""
  >
    <!--- reCaptcha ---->
    <cfset recaptcha = "">
    <cfif structKeyExists(FORM,"g-recaptcha-response")>
        <cfset recaptcha = FORM["g-recaptcha-response"]>
    </cfif>

    <cfif len(recaptcha)>
      <!--- POST to google and verify submission --->
      <cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
      <cfset secret = "#settings.mls.reCaptcha_private_key#">
      <cfset ipaddr = CGI.REMOTE_ADDR>
      <cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>

      <cfhttp url="#request_url#" method="get" timeout="10">

      <cfset response = deserializeJSON(cfhttp.filecontent)>
      <cfif response.success neq "true"><!--- recapthca was not true<cfabort> --->
        <cfset variables.e = variables.e & "<li>reCaptcha was not completed sucessfully</li>"><!--- <cfelse>recapthca was true<cfabort> --->
      </cfif>
    <cfelse>
        <cfset variables.e = variables.e & "<li>reCaptcha was not completed sucessfully</li>">
    </cfif>
  </cfif>

  <cfif variables.e eq ''>

    <cfquery datasource="#application.settings.dsn#" name="Check">
      SELECT *
      FROM cl_accounts
      where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">
      and accountcreatedbyviewer = 'Yes'
    </cfquery>

    <cfif check.recordcount gt 0>
      <cfset variables.e = variables.e & "<li>Our system shows that you already have an acccount with #settings.company#.  <a href='/#settings.mls.dir#/components/mls-account.cfm?action=login'>Click Here</a> to try logging in.</li>">
    </cfif>
  </cfif>

  <cfif variables.e is "">

    <!---START: INITIATING ROUND ROBIN IS ENABLED--->
    <cfif settings.mls.EnableRoundRobin is "Yes">
      <cfinclude template="/#settings.mls.dir#/includes/round-robin.cfm">
    <cfelse>
      <!---this is to grab the one agent to get all the leads--->
      <cfquery datasource="#application.settings.dsn#" name="GetPrimaryAgent">
        SELECT *
        FROM cl_agents
        where `primary` = 'Yes'
      </cfquery>
      <cfset AgentID = "#GetPrimaryAgent.id#">
      <cfset AgentEmailAddress = "#GetPrimaryAgent.email#">
      <cfset AgentName= "#GetPrimaryAgent.FirstName# #GetPrimaryAgent.LastName#">
    </cfif>

    <cfquery datasource="#application.settings.dsn#" result="insertResult" >
      Insert
      Into cl_accounts
      SET
        firstname = <cfqueryparam value="#trim(form.firstname)#" cfsqltype="CF_SQL_VARCHAR">,
        lastname = <cfqueryparam value="#trim(form.lastname)#" cfsqltype="CF_SQL_VARCHAR">,
        email = <cfqueryparam value="#trim(form.email)#" cfsqltype="CF_SQL_VARCHAR">,
        phone = <cfqueryparam value="#trim(form.phone)#" cfsqltype="CF_SQL_VARCHAR">,
        camefrom = <cfqueryparam value="#form.processform#" cfsqltype="CF_SQL_VARCHAR">,
        password = <cfqueryparam value="#trim(form.password)#" cfsqltype="CF_SQL_VARCHAR">,
        accountcreatedbyviewer = 'Yes',
        agentid=<cfqueryparam value="#AgentID#" cfsqltype="CF_SQL_VARCHAR">,
        lastrequest=<cfqueryparam value="#now()#" cfsqltype="CF_SQL_DATE">,
        MobileSignUp = <cfif isdefined('session.mobile')>'Yes'<cfelse>'No'</cfif>,
        leadsource = '2'
    </cfquery>

    <cfset theclientid = insertresult.generatedkey>

    <cfquery datasource="#application.settings.dsn#" >
      Insert
      Into cl_activity
        (clientid,RefferingSite,Action)
      Values
        (<cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">,
         <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,
         'Login'
        )
    </cfquery>

    <cfcookie name="loggedin" value="#TheClientID#" expires="#LoginCookiePersist#">
    <cfcookie name="userFirstName" value="#form.firstname#" expires="#LoginCookiePersist#">
    <cfcookie name="userLastName" value="#form.lastname#" expires="#LoginCookiePersist#">

    <cfinclude template="mls-account-update-cfidcftoken_.cfm">

    <!---START NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->
    <cfif AgentEmailAddress neq ''>
    <cfmail to="#application.settings.clientemail#" from="#form.email# <#application.settings.cfmailUsername#>" replyto="#form.email#" subject="#application.settings.company# - Create Account Form" type="HTML" server="#application.settings.cfmailServer#"  username="#application.settings.cfmailUsername#" password="#application.settings.cfmailPassword#" port="#application.settings.cfmailPort#" useSSL="#application.settings.cfmailSSL#" cc="#application.settings.cfmailCC#" bcc="#application.settings.cfmailBCC#"><!--- to was #AgentEmailAddress# --->
      <cfinclude template="/components/email-template-top.cfm">
        <p>First Name: #firstname#</p>
        <p>Last Name: #lastname#</p>
        <p>Email: #email#</p>
        <p>Phone: #phone#</p>
        <p>Login <a href="http://#cgi.HTTP_HOST#/admin/login.cfm?Action=Edit&id=#TheClientID#">http://#cgi.HTTP_HOST#/admin/login.cfm?Action=Edit&id=#TheClientID#</a>.</p>
      <cfinclude template="/components/email-template-bottom.cfm">
    </cfmail>
    </cfif>

    <cfmail to="#form.email#" from="#AgentEmailAddress# <#application.settings.cfmailUsername#>" replyto="#AgentEmailAddress#" subject="#application.settings.company# - Successful Account Creation" type="HTML" server="#application.settings.cfmailServer#"  username="#application.settings.cfmailUsername#" password="#application.settings.cfmailPassword#" port="#application.settings.cfmailPort#" useSSL="#application.settings.cfmailSSL#" cc="#application.settings.cfmailCC#" bcc="#application.settings.cfmailBCC#">
      <cfinclude template="/components/email-template-top.cfm">
        <p>Hello #firstname#,</p>
        <p>Thank you for creating an account with #settings.company#!  </p>
        <p>You can now login to your account anytime at <a href="http://#SERVER_NAME#/#settings.mls.dir#/index.cfm?LinkToLogin=">http://#cgi.HTTP_HOST#/mls</a> using the following:</p>
        <p>Email: #form.email#<br>Password: #form.password#</p>
        <p><b>Don't forget to logout if you are on a public computer.</b></p>
        <p> Thank you,<br>#AgentName#<br>#settings.company#</p>
      <cfinclude template="/components/email-template-bottom.cfm">
    </cfmail>
    <!---END NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->

    <cflocation url="/#application.settings.mls.dir#/my-profile.cfm" addtoken="false">

  </cfif>
</cfif>