<div class="container mainContent">
	<div class="row">
		<h1 class="site-color-1">
			<cfoutput><cfif len(page.h1)>#page.h1#<cfelse>#page.name#</cfif></cfoutput>
		</h1>
		<div class="col-md-7 col-sm-7 col-xs-12">
			<cfoutput>#page.body#</cfoutput>
		</div>
		<div class="col-md-5 col-sm-5 col-xs-12">
			<div class="video-wrap">
				<iframe src="https://player.vimeo.com/video/149761900?color=3573b9&amp;title=0&amp;byline=0&amp;portrait=0" width="100%" height="275" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
			</div>
			<cfset pagename = 'Association Management'>
			<cfinclude template="/components/_contact.cfm">
		</div>
	</div>
</div>
<style>
.banner img { min-height: 56vh; max-height: 65vh; }
.banner-info { bottom: 24%; }
</style>