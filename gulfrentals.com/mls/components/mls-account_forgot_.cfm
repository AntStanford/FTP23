<cftry>
<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
<cfif isdefined('processRetrieval')>
<cfif Cffp.testSubmission(form)>
  <!---has an account already been created with this email address--->
  <cfquery datasource="#application.settings.dsn#" name="Check">
    SELECT *
    FROM cl_accounts
    where
    <!--- siteID=<cfqueryparam cfsqltype="cf_sql_integer" value="#settings.id#">
    and --->
    email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">
  </cfquery>
  <cfif check.recordcount lte 0>
    <div class="notice">
      <h3>Our system shows that you don't have an account created with that email address. Please <a href="javascript:history.back()">try again.</a></h3>
    </div>
    <cfabort>
  </cfif>
  <div class="alert alert-success">
    <p>Thank you!</p>
    <p>Your password has been found and has been emailed to the address on file.  Check your email, the account information should arrive in less then 5 minutes.</p>
  </div>

    <cfmail
      to="#form.email#"
      from="#settings.cfmailUsername# <#settings.cfmailUsername#>"
      subject="#settings.company# - Password Retrieval"
      type="HTML" server="#settings.cfmailServer#"
      username="#settings.cfmailUsername#"
      password="#settings.cfmailPassword#"
      port="#settings.cfmailPort#"
      useSSL="#settings.cfmailSSL#"
      cc="#settings.cfmailCC#"
      bcc="#settings.cfmailBCC#"
      >
    <cfinclude template="/components/email-template-top.cfm">
      <p>Hello #check.firstname#,</p>
      <p>Below is the information needed to access you account.</p>
      <p>
        Login at <a href="http://#SERVER_NAME#/#settings.mls.dir#/components/mls-account.cfm?action=login">http://#SERVER_NAME#</a><br>
        Email: #Check.email#<Br>
        Password: #Check.password#
      </p>
      <p>Please login and enjoy using our site.</p>
      <p>Thank you!<br>#settings.company#</p>
    <cfinclude template="/components/email-template-bottom.cfm">
  </cfmail>
<!--- <cfelse>
  Spam Bot
  <cfabort> --->
</cfif>
</cfif>

<cfcatch><cfdump var="#cfcatch#" abort="true"></cfcatch></cftry>