<cfsetting enablecfoutputonly="true">
<cfprocessingdirective suppressWhitespace="true">
<!---START: check login--->
<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

<cfif Cffp.testSubmission(form)>

  <!---has an account already been created with this email address--->
  <cfquery datasource="#settings.dsn#" name="CheckLogin">
    SELECT  *
    FROM    cl_accounts
    WHERE   email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#"> 
    AND     accountcreatedbyviewer = 'Yes'
  </cfquery>

  <cfif CheckLogin.recordcount is not 0>
    <!--- account exists --->
    <cfoutput>accountexists</cfoutput>
  <cfelse>

    <!---START: INITIATING ROUND ROBIN IS ENABLED--->
    <cfif settings.mls.EnableRoundRobin is "Yes">
      <cfinclude template="/mls/includes/round-robin.cfm">
    <cfelse>
      <!---this is to grab the one agent to get all the leads--->
      <cfquery datasource="#settings.mls.propertydsn#" name="GetPrimaryAgent">
        SELECT  *
        FROM    cl_agents
        WHERE   `primary` = 'Yes'
      </cfquery>
      <cfset AgentID="#GetPrimaryAgent.id#">
      <cfset AgentEmailAddress="#GetPrimaryAgent.email#">
      <cfset AgentName= "#GetPrimaryAgent.FirstName# #GetPrimaryAgent.LastName#">
      <!--- is this a contactually client? --->
      <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes'>
        <cfif isdefined('GetNextRR.contactuallyid') and len(GetNextRR.contactuallyid)>
          <cfset AgentContactuallyID = GetNextRR.contactuallyid>
        <cfelseif isDefined('application.contactually.defaultUserId')>
          <cfset AgentContactuallyID = application.contactually.defaultUserId />
        <cfelse>
          <cfset AgentContactuallyID = '' />
        </cfif>
      </cfif>
    </cfif>
    <!---END: INITIATING ROUND ROBIN IS ENABLED--->

    <!--- Get the key from text file; we will use this to decrypt the encryptedSalt from the db --->
    <cfset authKeyLocation = expandpath('../../../auth/key.txt')>
    <cffile action="read" file="#authKeyLocation#" variable="authkey">    
    
    <!--- Generate a salt --->
    <cfset theSalt = createUUID() />

    <!--- Hash the password with the salt in it's plain form--->
    <cfset passwordHash = Hash(form.thepassword & theSalt, 'SHA-512') />

    <!--- The encrypted salt to store in the database, using the authKey--->
    <cfset encryptedSalt = encrypt(theSalt, authKey, 'AES','Base64')>

    <!--- is this a contactually client? --->
    <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes'>
      <!--- call contactually addContact (for insert / update) ---> 
      <cfset contactuallyId = '' />
      <cfset variables.argStruct = structNew() />
      <cfset variables.argStruct.email = form.email />
      <cfset variables.argStruct.firstName = form.firstname />
      <cfset variables.argStruct.lastName = form.lastname />
      <cfset variables.argStruct.phone = form.phone />
      <!--- <cfset variables.argStruct.externalID = TheClientID /> --->
      <cfset variables.argStruct.assignedTo = AgentContactuallyID />
      <cfset variables.cResponse = application.contactually.addUpdateContact(argumentCollection = variables.argStruct) />
      <cfif isdefined('variables.cResponse.status') and variables.cResponse.status is 'SUCCESS'>
        <cfif isDefined('variables.cResponse.data.data.id')>
          <cfset contactuallyId = variables.cResponse.data.data.id />
        </cfif>
      </cfif>
      <!--- end contactually addContact (for insert / update) --->
      <!--- call contactually addNote - login ---> 
      <cfset variables.argStruct = structNew() />
      <cfset variables.argStruct.contactId = contactuallyid />
      <cfset variables.argStruct.note = 'LOGIN - New Account' />
      <cfset variables.cResponse = application.contactually.addNote(argumentCollection = variables.argStruct) />
      <!--- end contactually addNote - login --->

      <cfset session.LoggedInc = contactuallyId>
      <cfcookie name="loggedinc" value="#contactuallyId#" expires="#LoginCookiePersist#">

    <cfelse>
      <cfset contactuallyId = '' />
    </cfif>  

    <cfquery datasource="#application.settings.dsn#" result="insResult">
      INSERT INTO cl_accounts (
              firstname, lastname, email, phone, camefrom, password, encryptedsalt, accountcreatedbyviewer,
              agentid, lastrequest, MobileSignUp, leadsource, AgentOpened, contactuallyid 
            ) VALUES (  
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstname#">,
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastname#">,
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
              <cfif isDefined('form.phone')><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#"><cfelse>Null</cfif>,
              'website account form',
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#passwordHash#">,
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#encryptedSalt#">,
              'Yes',
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#AgentID#">,
              <cfqueryparam value="#now()#" cfsqltype="cf_sql_date">,
              <cfif isdefined('session.mobile')>'Yes'<cfelse>'No'</cfif>,
              '2',
              'No',
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#contactuallyId#">
            )
    </cfquery>

    <cfset variables.newAccountID = insResult.generatedkey />

    <cfset session.USERFirstName = "#form.firstname#">
    <cfcookie name="USERFirstName" value="#form.firstname#" expires="#LoginCookiePersist#">
    <cfset session.USERLastName = "#form.lastname#">
    <cfcookie name="USERLastName" value="#form.lastname#" expires="#LoginCookiePersist#">
    <cfset session.USEREmail = "#form.email#">
    <cfcookie name="USEREmail" value="#form.email#" expires="#LoginCookiePersist#">
    <cfif isDefined('form.phone')>
      <cfset session.USERPhone = "#form.phone#">
      <cfcookie name="USERPhone" value="#form.phone#" expires="#LoginCookiePersist#">
    <cfelse>
      <cfset session.USERPhone = "">
      <cfcookie name="USERPhone" value="" expires="#LoginCookiePersist#">
    </cfif>
    
    <cfset session.LoggedIn = "#variables.newAccountID#">
    <cfcookie name="loggedin" value="#variables.newAccountID#" expires="#LoginCookiePersist#">

    <!---START: LOG THIS LOGIN--->
    <cfquery datasource="#settings.dsn#">
      INSERT INTO cl_activity (clientid, RefferingSite, Action)
      VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.newAccountID#">,
                <cfif isdefined('session.referringsite')>
                  <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#session.referringsite#">,
                <cfelse>
                  'N/A',
                </cfif>
                'LOGIN - Account Created'
              )
    </cfquery>
    <!---END: LOG THIS LOGIN--->
    <!---START: UPDATE PROPERTY VIEWS AND PROPERTY REQUESTS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
<!--- need a process to send all the historical notes to contactually --->         
    <cfquery name="UpdateQuery" datasource="#settings.dsn#">
      UPDATE  cl_properties_viewed 
      SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.newAccountID#">
      WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#settings.dsn#">
      UPDATE  cl_leadtracker_response
      SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.newAccountID#">
      WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#settings.dsn#">
      UPDATE  cl_saved_searches
      SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.newAccountID#">
      WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#settings.dsn#">
      UPDATE  cl_activity
      SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.newAccountID#">
      WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#settings.dsn#">
      UPDATE  cl_favorites
      SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.newAccountID#">
      WHERE   clientCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      AND     clientCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>
    <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
    <cfoutput>yes</cfoutput>
  </cfif><!--- account exists else --->

<cfelse><!--- cfformprotect if --->
  <cfoutput>formprotectfail</cfoutput>
</cfif>
</cfprocessingdirective>