<CFQUERY NAME="getinfo" DATASOURCE="#settings.dsn#" >
SELECT *
FROM CL_pagetext
where id = '18'
</CFQUERY>

<cfinclude template="/components/header.cfm">
<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">

			<cfoutput>#getinfo.pagetext#</cfoutput>
			<!--- <iframe width="400" scrolling="no" height="1000" frameborder="0" src="http://rss.vdsys.com/feedoutput.html?CID=15"></iframe> --->
			<div style='width: 500px; height: 440px; background-image: url( http://vortex.accuweather.com/adcbin/netweather_v2/backgrounds/summer2_500x440_bg.jpg ); background-repeat: no-repeat; background-color: #D0ADAA;' ><div id='NetweatherContainer' style='height: 420px;' ><script src='http://netweather.accuweather.com/adcbin/netweather_v2/netweatherV2ex.asp?partner=netweather&tStyle=normal&logo=1&zipcode=29575&lang=eng&size=13&theme=summer2&metric=0&target=_self'></script></div><div style='text-align: center; font-family: arial, helvetica, verdana, sans-serif; font-size: 12px; line-height: 20px; color: #0000FF;' ><a style='color: #0000FF' href='http://www.accuweather.com/us/sc/myrtle-beach/29575/city-weather-forecast.asp?partner=accuweather' >Weather Forecast</a> | <a style='color: #0000FF' href='http://www.accuweather.com/maps-satellite.asp' >Weather Maps</a> | <a style='color: #0000FF' href='http://www.accuweather.com/index-radar.asp?partner=accuweather&zipcode=29575' >Weather Radar</a> | <a style='color: #0000FF' href='http://hurricane.accuweather.com/hurricane/index.asp' >Hurricane Center</a></div></div>

		</div>
	</div>
</div>
<cfinclude template="/components/footer.cfm">