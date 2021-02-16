<cfinclude template="/sales/lightboxes/_header.cfm">

<div id="mls-wrapper">
<!---   <div align="right">
    <cfoutput>
      <strong>
        <a hreflang="en" href="#session.RememberMePage#" target="_parent" id="fancybox-close">X</a>
      </strong>
    </cfoutput>
  </div> --->
  <h1>Password Retrieval</h1>
  <div class="pass-retrieval">
    <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
    <cfif isdefined('processRetrieval')>
      <cfif Cffp.testSubmission(form)>
        <!---has an account already been created with this email address--->
        <cfquery datasource="#mls.dsn#" name="Check">
          SELECT * 
          FROM cl_accounts
          where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif check.recordcount lte 0>
          <div class="notice">
            <h3>Our system shows that you don't have an account created with that email address.  Please <a hreflang="en" href="javascript:history.back()">try again.</a></h3>
          </div>
          <cfinclude template="/sales/lightboxes/_footer.cfm">
          <cfabort>
        </cfif>
        <div class="notice">
          <p>Thank you!</p>
          <p>Your password has been found and has been emailed to the address on file.  Check your email, the account information should arrive in less then 5 minutes.</p>
        </div>
        <p><cfoutput>Close this window and please continue to browse our site.</cfoutput></p>
        <p>Thank you!<br><cfoutput>#mls.companyname#</cfoutput></p>

          <cfmail to="#form.email#" from="#mls.adminemail# <#cfmail.username#>" replyto="#mls.adminemail#"
          subject="#mls.companyname# - Password Retrieval" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
          port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
          <cfinclude template="/sales/emails/_header.cfm">
            <p>Hello #check.firstname#,</p>
            <p>Below is the information needed to access you account.</p>
            <p>
              Login at <a hreflang="en" href="http://#SERVER_NAME#/sales/index.cfm?LinkToLogin=">http://#SERVER_NAME#</a><br>
              Email: #Check.email#<Br>
              Password: #Check.password#
            </p>
            <p>Please login and enjoy using our site.</p>
            <p>Thank you!<br>#mls.companyname#</p>
          <cfinclude template="/sales/emails/_footer.cfm">
        </cfmail>
      <cfelse>
        Spam Bot
        <cfabort>
      </cfif> 
    <cfelse>
      <p>Enter your email address below and we will email you your account information to login.</p>
      <div>
        <cfform action="#script_name#" method="post"> 
          <cfinclude template="/cfformprotect/cffp.cfm">
          <cfinput type="hidden" name="processRetrieval" value="Retrieval Password - #script_name#">
          <table width="100%">
          <tr>
            <td class="ContactForm">Email:<br><cfinput type="Text" name="email" message="Please Enter a Valid Email!" validate="email" required="Yes"></td>
          </tr>
          <tr>
            <td class="ContactForm" colspan="2"><br><cfinput type="submit" name="SubmitForm" value="Retrieve Password" class="button"></td>
          </tr>
          </table>
        </cfform>
      </div>
    </cfif>
  </div>
</div>

<cfinclude template="/sales/lightboxes/_footer.cfm">