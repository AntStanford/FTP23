<CFQUERY NAME="getinfo" DATASOURCE="#settings.dsn#" >
SELECT *
FROM CL_pagetext
where id = '80'
</CFQUERY>

<cfinclude template="/sales/components/header.cfm">
<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">

			<!-- START OF THE PLAYER EMBEDDING TO COPY-PASTE -->
			<div id="player" style="width: 100% !important;">Loading the player...</div>
			<script type="text/javascript">
			   // <![CDATA[
			   jwplayer("player").setup({
				   sources: [{
				      file: "rtmp://thundera.ddns.net:1935/13th/mp4:camera.stream"
				   }, {
				      file: "http://thundera.ddns.net:1935/13th/camera.stream/playlist.m3u8"
				   }],
				   rtmp: {
				      bufferlength: 3
				   },
				   image: '/jwplayer/play.png',
				   title: 'Surfoff Cam',
				   width: '100%',
				   aspectratio: '16:9',
				   controls: 'false',
				   fallback: 'false',
				   autostart: 'true'
			   });
			   // ]]>
			</script>
			<!-- END OF THE PLAYER EMBEDDING -->

			<cfoutput>#getinfo.pagetext#</cfoutput>

			<a hreflang="en" href="http://www.magazooms.com/HTML5/Beach-Favorites-2015" target="_blank"><img src="/images/layout/beach-favs2015.jpg"></a>

		</div>
	</div>
</div>
<cfinclude template="/sales/components/footer.cfm">