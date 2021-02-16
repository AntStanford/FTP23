<cfset email = "matt.crouch@gmail.com">

<cfset accesskey = EncryptEmail(email)>

<cfmail to="#email#" from="icnderrors@gmail.com <#cfmail.username#>" replyto=""
subject="Autologin test" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">

	<a href="http://mls3d.icnd.net/index.cfm?subscriber=#email#&accesskey=#accesskey#">Login via Homepage</a>

	<a href="http://mls3d.icnd.net/mls/search-results.cfm?subscriber=#email#&accesskey=#accesskey#">Login via Search Results page </a>

<a href="http://mls3d.icnd.net/mls/property-details.cfm?mlsnumber=1001441&mlsid=3&wsid=1&subscriber=#email#&accesskey=#accesskey#">Login via Property Detail page </a>



</cfmail>

sent.