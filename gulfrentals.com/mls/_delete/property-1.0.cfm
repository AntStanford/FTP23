<!---
<cfparam name="session.promocode" default="">
<cfparam name="url.promo" type="string" default="">
<cfif isDefined("url.promo") and url.promo neq ''>
	<cfset session.promocode="#url.promo#">
</cfif>--->

<cfinclude template="property_.cfm"> <!--- RANDY - THIS IS FOR DATA SOURCES/COOKIES/ETC. NOT SURE HOW WE WANT TO APPROACH THIS FOR MLS--->

<cfset page.metatitle = "#property.street_number# #property.street_name# #application.ohelpers.capFirst(property.city)# | #mlsnumber# | #Settings.company#">

<cfif len(property.remarks) gt 155>
  <cfset page.metadescription=left(property.remarks,155)>
<cfelse>
  <cfset page.metadescription = property.remarks>
</cfif>

<cfinclude template="/#application.settings.mls.dir#/components/header.cfm">
<!--- <cfinclude template="/#settings.mls.dir#/components/login.cfm"> --->

<div class="property-banner">
  <div style="background: url('/<cfoutput>#application.settings.mls.dir#</cfoutput>/images/property-banner.jpg') no-repeat;"></div>
</div>

<!--- <div class="mls booking container bdetails" id="<!--- <cfoutput>#property.seopropertyname#</cfoutput> --->"> --->
<div class="property-wrap" id="<!--- <cfoutput>#property.seopropertyname#</cfoutput> --->">
  <div class="container">
  	<!--- <div class="row property-btns">
  		<div class="col-xs-12">
    		<cfset backtoURL = "/#settings.mls.dir#/results.cfm">
    		<cfset backtoTxt="Back to Search Results">
    		<cfif reFindNoCase('real-estate/sold-properties/sold-by-homestead',cgi.http_referer)>
    			<cfset backtoURL="/real-estate/sold-properties/sold-by-homestead">
    			<cfset backtoTxt="Back to Sold Properties">
    		</cfif>
  
    		<cfif structKeyExists(url, "from")>
    			<cfset backtoURL="#url.from#">
          <cfif structKeyExists(url,"nm") AND nm NEQ ''>
            <cfset backtoTxt="Back to #url.nm#">
          <cfelse>
            <cfset backtoTxt="Back to Previous Page">
          </cfif>
    		</cfif>

        <!--- <cfoutput>
        <a href="#backtoURL#" class="btn btn-back site-color-2-bg site-color-2-lighten-bg-hover text-white pull-left">#backtoTxt#</a>
        </cfoutput> ---><!---CHANGE LINK--->

  			<div class="pull-right">
  				<cfif property.status neq '6'>
    				<cfif application.oFields.showOnPDP(23)>
    					<a href="javascript:;" class="btn btn-favorite bfavorites"><span class="glyphicon glyphicon-heart"></span> Favorites (<cfif structKeyExists(cookie,'mlsfavorites') and ListLen(cookie.mlsfavorites) and cookie.mlsfavorites neq '[]' and cookie.mlsfavorites neq '[null]'><cfoutput>#listlen(cookie.mlsfavorites)#</cfoutput><cfelse>0</cfif>)</a>
    				</cfif>
  				</cfif>
  				<cfif application.oFields.showOnPDP(11)>
    				<a href="javascript:;" class="btn btn-recent brecent"><span class="glyphicon glyphicon-eye-open"></span> Recently Viewed</a>
  				</cfif>
  				<cfif application.oFields.showOnPDP(23)>
    				<cfinclude template="_favoriteslist.cfm">
  				</cfif>
  				<cfif application.oFields.showOnPDP(11)>
    				<cfinclude template="_recentlist.cfm">
  				</cfif>
  			</div>
  		</div>
    </div> --->
  	
  	<a name="prop-link" class="prop-link"></a>
  	
  	<cfinclude template="_property-info.cfm">

  	<div class="row property-details">
  		<div class="col-sm-8 col-md-9">
  			<ul class="nav nav-tabs nav-justified">
  				<li class="active"><a href="#t-overview" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" data-toggle="tab"><span class="glyphicon glyphicon-cloud"></span> Overview</a></li>
  				<li><a href="#t-map" class="btn site-color-5-bg site-color-5-lighten-bg-hover text-black t-map" data-toggle="tab"><span class="glyphicon glyphicon-map-marker"></span> Map</a></li>
  			</ul>
  			<div class="tab-content">
  				<div class="tab-pane active" id="t-overview">
  					<cfinclude template="_overview-tab.cfm">
  				</div>
  				<div class="tab-pane" id="t-map">
  					<cfinclude template="_map-tab.cfm">
  				</div>
  			</div><!-- END tab-content -->

        <cfinclude template="_amenities.cfm">

        <cfinclude template="_area-specialist.cfm">

        <cfoutput>
        <cfif application.settings.mls.pdpdisclaimer neq ''>
          <div class="well">#settings.mls.pdpDisclaimer#</div>
        </cfif>
        </cfoutput>
  		</div><!-- END col- -->

  		<div class="col-sm-4 col-md-3 property-sidebar">
  			<cfif application.oFields.showOnPDP(10) or application.oFields.showOnPDP(24)>
  				<cfif property.status neq '6'>
  					<cfinclude template="_share.cfm">
  				</cfif>
  			</cfif>

				<!--- <cfinclude template="_distances.cfm"> --->

  			<cfif application.oFields.showOnPDP(22)>
    			<cfinclude template="_request-info.cfm">
  			</cfif>
  			<cfinclude template="_additional-info.cfm">

  			<cfif CGI.REMOTE_ADDR eq "216.99.119.254">
          <div class="panel-group open-house-availability" id="accordion-3" role="tablist" aria-multiselectable="true">
            <div class="panel panel-default">
              <div class="panel-heading" role="tab">
                <div class="h4 nomargin text-upper">Open House</div>
              </div>
              <div class="panel-body">
                <p><strong>07/03/2016</strong> 03:00 PM - 05:00 PM<br>
                <strong>07/10/2016</strong> 03:00 PM - 05:00 PM</p>
              </div>
            </div>
          </div>
  			</cfif><!---END IP BLOCK - RANDY PLEASE CHECK THIS OUT FOR OPEN HOUSE ADDITIONS--->

  		</div><!-- END property-sidebar -->
  	</div><!-- END property-details -->
	</div>
</div><!-- END property-wrap -->

<button id="returnToTop" class="btn site-color-1-lighten-bg site-color-1-bg-hover text-white" type="button"><i class="fa fa-chevron-up" aria-hidden="true"></i></button>

<cfinclude template="/#settings.mls.dir#/components/property-modals.cfm">


 <cfif len(variables.virtualTourLink) and lcase(left(variables.virtualTourLink, 4)) is 'http'>

  <!-- Virtual Tour Modal -->
  <div class="modal fade virtual-tour-modal" id="virtualTourModal" tabindex="-1" role="dialog" aria-labelledby="virtualTourModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header site-color-2-bg text-white">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="virtualTourModalLabel"><i class="fa fa-hand-paper-o"></i> Virtual Tour</h4>
        </div>
        <div class="modal-body">
          <cfoutput><iframe src="#variables.virtualTourLink# " frameborder="0" width="100%" height="500"></iframe></cfoutput>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</cfif>

<cfinclude template="/#settings.mls.dir#/components/footer.cfm">