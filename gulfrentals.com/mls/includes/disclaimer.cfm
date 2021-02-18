<!---
<cfquery name="qlastUpdate" datasource="#settings.mls.propertydsn#">
	select max(mastertable.updatedat) AS lastupdate from mastertable where mastertable.MLSID = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.MLSID#">
</cfquery>
--->

<cfoutput>
	<div class="mls-discalaimer">Copyright #dateformat(now(),'yyyy')# MRIS MLS. All rights reserved. Information deemed reliable but is not guaranteed. The data relating to real estate for sale on this web site comes in part from the Internet Data Exchange Program of MRIS MLS. Information provided is for consumer's personal, non-commercial use and may not be used for any purpose other than to identify prospective properties consumers may be interested in purchasing. This site will be monitored for 'scraping' and any use of search facilities of data on the site other than by a consumer looking to purchase real estate is prohibited. Listing broker has attempted to offer accurate data, but buyers are advised to confirm all items.<!--- Information last updated on  #datetimeformat(qlastupdate.lastupdate,'long')# ---></div>
</cfoutput>