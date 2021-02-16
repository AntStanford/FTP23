<cfinclude template="/sales/lightboxes/_header.cfm">

<div class="box">
	<h1>Mortgage Calculator</h1>
	<iframe title="Mortgage Calculator" frameborder="0" height="470px" scrolling="no" width="176" src="http://www.zillow.com/mortgage/SmallMortgageLoanCalculatorWidget.htm?price=<cfoutput>#URL.ListingPrice#</cfoutput>&wtype=spc&rid=102001&wsize=small&textcolor=736c5f&backgroundColor=f7f5f4&advTabColor=969086&bgcolor=e2e0dc&bgtextcolor=736c5f&headerTextShadow=fff"> 
		Your browser doesn't support frames. Visit 
		<a hreflang="en" href="http://www.zillow.com/mortgage-calculator/#{scid=mor-wid-calc}" target="_blank">Zillow Mortgage Calculators</a> to see this content. 
	</iframe>
</div>

<cfinclude template="/sales/lightboxes/_footer.cfm">