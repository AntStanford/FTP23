<!--- Chosen Plugin (For Select Box Styling) --->
<link href="/sales/javascripts/_plugins/chosen/chosen.css" rel="stylesheet" type="text/css">
<script src="/sales/javascripts/_plugins/chosen/chosen.js" type="text/javascript"></script>

<!--- Shareit Plugin (Propert Detail Page) --->
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">stLight.options({publisher:"1801a076-7d22-4d31-a9db-e14906faa3a4"});</script>

<!--- Modernizer Plugin (Helps Execute Google Maps) --->
<script src="/sales/javascripts/_plugins/modernizer/modernizr.js" type="text/javascript"></script>

<!--- Google Map Plugin (Cluster Map for Advanced Search Page) --->
<cfif cgi.script_name neq '/sales/search-results.cfm'>
	<script src="/sales/javascripts/_plugins/google-maps/map-call.js" type="text/javascript"></script>
	<cfif cgi.script_name does not contain 'property-details.cfm'><cfoutput><script src="http://maps.googleapis.com/maps/api/js?sensor=false&key=#settings.googleMapsAPIKey#" type="text/javascript"></script></cfoutput></cfif>
</cfif>

<!------------------------------------------------------------
------------ Do NOT add anything BELOW this line -------------
------------------------------------------------------------->

<!--- MLS Styles & Scripts (Global.js Activates all Plugins Above) --->
<script src="/sales/javascripts/global.js" type="text/javascript"></script>