<cfquery name="GetSendingEmails" datasource="#settings.dsn#">
  Select strpropid,stremail,strfirstname,dtCheckinDate,dtCheckoutDate
  from pp_guestreservationinfo,cms_key_codes
  where cms_key_codes.intquotenum = pp_guestreservationinfo.intquotenum
  and cms_key_codes.emailsent is NULL
</cfquery>

<cfoutput query="GetSendingEmails">

<!---<cfmail from="rentals@surfsiderealty.com" to="programmers@icoastalnet.com" subject="Hey here's your codes yo" server="smtp.mailgun.org" username="mailer@mg.surfsiderealty.com" password="PASS0215word!" port="465" useSSL="true" type="HTML">
  <p>to="#stremail#"</p>
  <cfinclude template="/components/email-template-top.cfm">


  <cfinclude template="/components/email-template-bottom.cfm">
</cfmail>--->

</cfoutput>