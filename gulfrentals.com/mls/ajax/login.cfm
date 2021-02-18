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

  <cfif CheckLogin.recordcount is 0>
    <!--- No user account --->
    <cfoutput>noaccount</cfoutput>
  <cfelse>

    <!--- Step 1: Get the key from text file; we will use this to decrypt the encryptedSalt from the db --->
    <cfset authKeyLocation = expandpath('../../../auth/key.txt')>
    <cffile action="read" file="#authKeyLocation#" variable="authkey">    
    
    <!--- Step 2: Decrypt the encrypted salt from the db --->
    <cfset decryptedSalt = decrypt(CheckLogin.encryptedSalt, authKey, 'AES','Base64')>    
    
    <!--- Step 3: Hash the password from the user using the decrypted salt --->
    <cfset passwordHashFromUser = Hash(form.password & decryptedSalt, 'SHA-512') /> 
                
    <!--- If we found a user and the hashed password from the db matches the hashed password from the user, log them in --->
    <cfif CheckLogin.recordcount gt 0 and passwordHashFromUser eq CheckLogin.password>
      <!--- good login --->
      <cfset session.USERFirstName = "#CheckLogin.firstname#">
      <cfcookie name="USERFirstName" value="#CheckLogin.firstname#" expires="#LoginCookiePersist#">
      <cfset session.USERLastName = "#CheckLogin.lastname#">
      <cfcookie name="USERLastName" value="#CheckLogin.lastname#" expires="#LoginCookiePersist#">
      <cfset session.USEREmail = "#CheckLogin.email#">
      <cfcookie name="USEREmail" value="#CheckLogin.email#" expires="#LoginCookiePersist#">
      <cfset session.USERPhone = "#CheckLogin.phone#">
      <cfcookie name="USERPhone" value="#CheckLogin.phone#" expires="#LoginCookiePersist#">
      <cfset session.LoggedIn = "#CheckLogin.id#">
      <cfcookie name="loggedin" value="#CheckLogin.id#" expires="#LoginCookiePersist#">
      <!--- is this a contactually client? --->
      <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes'>
        <!--- Check for ContactuallyID - add the user if needed --->
        <cfif len(trim(CheckLogin.contactuallyId))>
          <cfset contactuallyId = CheckLogin.contactuallyId />
          <cfset session.LoggedInc = "#CheckLogin.contactuallyId#">
          <cfcookie name="loggedinc" value="#CheckLogin.contactuallyId#" expires="#LoginCookiePersist#">
        <cfelse>         
          <!--- call contactually addContact (for insert / update) --->
          <cfset contactuallyId = '' />   
          <cfset variables.argStruct = structNew() />
          <cfset variables.argStruct.email = CheckLogin.email />
          <cfset variables.argStruct.firstName = CheckLogin.firstname />
          <cfset variables.argStruct.lastName = CheckLogin.lastname />
          <cfset variables.argStruct.phone = CheckLogin.phone />
          <cfset variables.argStruct.externalID = CheckLogin.id />  

          <!--- get agent ID --->
          <cfquery datasource="#settings.dsn#" name="CheckAgent">
            SELECT contactually_id FROM cl_agents WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#CheckLogin.agentid#">
          </cfquery>
          <cfif len(trim(CheckAgent.contactually_id))>
            <cfset variables.argStruct.assignedTo = CheckAgent.contactually_id />
          <cfelse><!--- use the default if no id exists for the agent --->
            <cfset variables.argStruct.assignedTo = application.contactually.defaultUserId />
          </cfif>
          <cfset variables.cResponse = application.contactually.addUpdateContact(argumentCollection = variables.argStruct) />

          <cfif isdefined('variables.cResponse.status') and variables.cResponse.status is 'SUCCESS'>
            <cfif isDefined('variables.cResponse.data.data.id')>
              <cfset contactuallyId = variables.cResponse.data.data.id />
              <cfquery datasource="#settings.dsn#" name="UpdateLogin">
                UPDATE  cl_accounts 
                SET     contactuallyId = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contactuallyId#">
                WHERE   id = <cfqueryparam cfsqltype="cf_sql_integer" value="#CheckLogin.id#">
              </cfquery>

              <cfset session.LoggedInc = contactuallyId>
              <cfcookie name="loggedinc" value="#contactuallyId#" expires="#LoginCookiePersist#">

            </cfif>
          </cfif>
        </cfif>
        <!--- end contactually addContact (for insert / update) --->

        <!--- call contactually addNote - login ---> 
        <cfset variables.argStruct = structNew() />
        <cfset variables.argStruct.contactId = contactuallyid />
        <cfset variables.argStruct.note = 'LOGIN - returning guest' />
        <cfset variables.cResponse = application.contactually.addNote(argumentCollection = variables.argStruct) />
        <!--- end contactually addNote - login --->
      </cfif><!--- end contactually client if --->

      <!---START: LOG THIS LOGIN--->
      <cfquery datasource="#settings.dsn#">
        INSERT INTO cl_activity (clientid, RefferingSite, Action)
        VALUES (
                  <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">,
                  <cfif isdefined('session.referringsite')>
                    <cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR">,
                  <cfelse>
                    'N/A',
                  </cfif>
                  'LOGIN'
                )
      </cfquery>
      <!---END: LOG THIS LOGIN--->
      <!---START: UPDATE PROPERTY VIEWS AND PROPERTY REQUESTS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
<!--- need a process to send all the historical notes to contactually --->         
      <cfquery name="UpdateQuery" datasource="#settings.dsn#">
        UPDATE  cl_properties_viewed 
        SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#CheckLogin.id#">
        WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
        AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#settings.dsn#">
        UPDATE  cl_leadtracker_response
        SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#CheckLogin.id#">
        WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
        AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#settings.dsn#">
        UPDATE  cl_saved_searches
        SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#CheckLogin.id#">
        WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
        AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#settings.dsn#">
        UPDATE  cl_activity
        SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#CheckLogin.id#">
        WHERE   TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
        AND     TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#settings.dsn#">
        UPDATE  cl_favorites
        SET     clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#CheckLogin.id#">
        WHERE   clientCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
        AND     clientCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
      </cfquery>
      <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
      <cfoutput>yes</cfoutput>
    <cfelse><!--- password match if --->
      <cfoutput>forgotpassword</cfoutput>
    </cfif>
  </cfif><!--- check login count else --->

<cfelse><!--- cfformprotect if --->
  <cfoutput>formprotectfail</cfoutput>
</cfif>
</cfprocessingdirective>