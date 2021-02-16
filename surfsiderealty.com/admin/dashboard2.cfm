<cfset page.title ="Dashboard">

<cfquery name="totalContacts" dataSource="#settings.dsn#">
  select `id` from cms_contacts
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfoutput>
  	
    <div class="alert alert-info">
      Welcome to your website's control panel. Use the navigation on the left to access each module.  Use the top right buttons to update your profile
      or manage your site's contact information.
      <a hreflang="en" href="##" data-dismiss="alert" class="close">&times;</a>
    </div>
						 		
  	<div class="row-fluid">
  		<div class="span12">  			
  			<div class="widget-box">
  			   
  			  
						 
  				<div class="widget-title"><span class="icon"><i class="icon-signal"></i></span><h5>Google Analytics</h5><div class="buttons"><a hreflang="en" href="javascript:;" onclick="window.location.reload();" class="btn btn-mini" id="fetchSeries"><i class="icon-refresh"></i> Update stats</a></div></div>
  				<div class="widget-content">
  					<div class="row-fluid">
  						<cfinclude template="_ga-charts.cfm">  						
  					</div>							
  				</div>
  			</div>					
  		</div>
  	</div>
  	</cfoutput> 

  
<cfinclude template="components/footer.cfm">
