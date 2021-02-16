<cfprocessingdirective pageencoding="utf-8">

<cfset FC_ClientNotificationEmail = "rentals@surfsiderealty.com">
<cfset FC_CFMailUserName = "mailer@mg.surfsiderealty.com">
<cfset FC_CFMailPassword = "PASS0215word!">
<cfset FC_CFMailClientServer = "smtp.mailgun.org"> <!---This is always smtp.THECLIENTDOMAIN.com --->
<cfset FC_CFMailPort = "465">
<cfset FC_CFMailUseSSL = "true">
<cfset FC_CFMailBCC = "">

<cfset dsn = "surfsiderealty2018">
<cfquery name="getBookingInfo" dataSource="propertyplus">
   select strUserID,strPassword,strCOID from clients where dsn = '#dsn#'
</cfquery>

<cfquery name="getAreas" dataSource="#dsn#">
  select distinct strArea from pp_propertyinfo order by strArea
</cfquery>

<cfquery name="getTypes" dataSource="#dsn#">
   select distinct strType from pp_propertyinfo order by strType
</cfquery>

<cfquery name="getMinMaxBeds" dataSource="#dsn#">
   select min(dblbeds) as minbed, max(dblbeds) as maxbed from pp_propertyinfo
</cfquery>

<cfset application.minBed = getMinMaxBeds.minbed>
<cfset application.maxBed = getMinMaxBeds.maxbed>

<cfquery name="getMinMaxBath" dataSource="#dsn#">
   select min(dblbaths) as minbath, max(dblbaths) as maxbath from pp_propertyinfo
</cfquery>

<cfset application.minBath = getMinMaxBath.minbath>
<cfset application.maxBath = getMinMaxBath.maxbath>

<cfquery name="getMinMaxSleeps" dataSource="#dsn#">
   select min(intoccu) as minsleeps, max(intoccu) as maxsleeps from pp_propertyinfo
</cfquery>

<cfset application.minsleeps = getMinMaxSleeps.minsleeps>
<cfset application.maxsleeps = getMinMaxSleeps.maxsleeps>

<cfquery name="getMinMax" datasource="#dsn#">
	SELECT
		max(dblrate) as maxPrice,
		min(dblrate) as minPrice
	FROM
		pp_season_rates
	WHERE
		dtBeginDate >= '#DateFormat(now(),"YYYY")#-01-01'
   AND
      strChargeBasis = 'Weekly'
</cfquery>

<cfset application.minWeekly = getMinMax.minPrice>
<cfset application.maxWeekly = getMinMax.maxPrice>


<cfif thisTag.executionMode is "start">

<cfif isDefined("attributes.title")>
	<cfset additionalTitle = "" & attributes.title>
<cfelse>
	<cfset additionalTitle = "">
	<cfif isDefined("url.mode") and url.mode is "cat">
		<!--- can be a list --->
		<cfset additionalTitle = "">
		<cfloop index="cat" list="#url.catid#">
		<cftry>
			<cfset additionalTitle = additionalTitle & " " & application.blog.getCategory(cat).categoryname>
			<cfcatch></cfcatch>
		</cftry>
		</cfloop>

	<cfelseif isDefined("url.mode") and url.mode is "entry">
		<cftry>
			<!---
			Should I add one to views? Only if the user hasn't seen it.
			--->
			<cfset dontLog = false>
			<cfif structKeyExists(session.viewedpages, url.entry)>
				<cfset dontLog = true>
			<cfelse>
				<cfset session.viewedpages[url.entry] = 1>
			</cfif>
			<cfset entry = application.blog.getEntry(url.entry,dontLog)>
			<cfset additionalTitle = "#entry.title#">
			<cfcatch></cfcatch>
		</cftry>
	</cfif>
</cfif>

<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title><cfif additionalTitle is not "">#additionalTitle#: </cfif>#htmlEditFormat(application.blog.getProperty("blogTitle"))#</title>

	<meta name="robots" content="index,follow" />

		<meta name="title" content="<cfif additionalTitle is not "">#additionalTitle#: </cfif>#application.blog.getProperty("blogTitle")#" />
		<meta content="text/html; charset=UTF-8" http-equiv="content-type" />
		<meta name="description" content="<cfif additionalTitle is not "">#additionalTitle#- </cfif>#application.blog.getProperty("blogDescription")#" />
		<!--- <meta name="keywords" content="<cfif additionalTitle is not "">#additionalTitle#, </cfif>#application.blog.getProperty("blogKeywords")#" /> --->

<!---
	<link rel="stylesheet" href="#application.rooturl#/includes/layout.css" type="text/css" />
	<link rel="stylesheet" href="#application.rooturl#/includes/style.css" type="text/css" />
--->


	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/smoothness/jquery-ui.css" />
<!---
 	<link rel="stylesheet" href="/styles/template.css" type="text/css" charset="utf-8" />
	<link rel="stylesheet" href="/vacation-rental-blog/includes/layout.css" type="text/css" />
	<link rel="stylesheet" href="/vacation-rental-blog/includes/style.css" type="text/css" />
--->
	<link rel="stylesheet" href="/vacation-rental-blog/includes/style2015.css" type="text/css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<!--- DO NOT UPDATE jQuery UI past this version (1.7.2)! We are exploiting a bug in the tabs framework to make our property-detail-dates-available pages work! :) --->
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js" type="text/javascript" charset="utf-8"></script>

	<!--- For Firefox --->
	<link rel="alternate" type="application/rss+xml" title="RSS" href="#application.rooturl#/rss.cfm?mode=full" />
	<script type="text/javascript" src="#application.rooturl#/includes/jquery.min.js"></script>

	<script type="text/javascript">
	function launchComment(id) {
		cWin = window.open("#application.rooturl#/addcomment.cfm?id="+id,"cWin","width=550,height=700,menubar=yes,personalbar=no,dependent=true,directories=no,status=yes,toolbar=no,scrollbars=yes,resizable=yes");
	}
	function launchCommentSub(id) {
		cWin = window.open("#application.rooturl#/addsub.cfm?id="+id,"cWin","width=550,height=350,menubar=yes,personalbar=no,dependent=true,directories=no,status=yes,toolbar=no,scrollbars=yes,resizable=yes");
	}
	function launchTrackback(id) {
		cWin = window.open("#application.rooturl#/trackbacks.cfm?id="+id,"cWin","width=550,height=500,menubar=yes,personalbar=no,dependent=true,directories=no,status=yes,toolbar=no,scrollbars=yes,resizable=yes");
	}
	<cfif isDefined("url.mode") and url.mode is "entry"	and application.usetweetbacks and structKeyExists(variables, "entry")>
	$(document).ready(function() {
		//set tweetbacks div to loading...
		$("##tbContent").html("<div class='tweetbackBody'><i>Loading Tweetbacks...</i></div>")
		$("##tbContent").load("#application.rooturl#/loadtweetbacks.cfm?id=#entry.id#")
	})
	</cfif>
	</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-15116429-1', 'auto');
  ga('send', 'pageview');
</script>

<!--- Facebook Connect code --->
<!--- removed 2/6/15 because errors showing up in debug
<script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
 --->

 <meta name="twitter:widgets:csp" content="on">


<!--- start: added for the navigation tabs to work --->
 <script src="/scripts/jquery.cycle.all.js" type="text/javascript" charset="utf-8"></script>
<script src="/scripts/global.js?v=1.3.4" type="text/javascript" charset="utf-8"></script>
<!--- end: added for the navigation tabs to work --->

</head>

<body onload="if(top != self) top.location.replace(self.location.href);">

<cfinclude template="/components/header.cfm">
<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">

			<div id="page">
				<div id="banner"><a href="#application.rootURL#">#htmlEditFormat(application.blog.getProperty("blogTitle"))#</a></div>
				<div id="content">

					<div id="blogText">
					</cfoutput>
					<cfelse>
					<cfoutput>

					</div>
				</div>
				<div id="menu">
					</cfoutput>

					<cfinclude template="getpods.cfm">

					<cfoutput>
				</div>

				<div class="footerHeader"> <!---<a href="http://blogcfc.riaforge.org">BlogCFC</a> was created by <a href="http://www.coldfusionjedi.com">Raymond Camden</a>. This blog is running version #application.blog.getVersion()#. <a href="#application.rooturl#/contact.cfm">Contact Blog Owner</a>---></div>
			</div>

		</div>
	</div>
</div>
<cfinclude template="/components/footer.cfm">

</body>
</html>
</cfoutput>
</cfif>
<cfsetting enablecfoutputonly=false>