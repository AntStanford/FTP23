<cfquery name="getStaff" dataSource="#settings.dsn#">
	select * from cms_staff where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#cgi.query_string#">
</cfquery>
<cfinclude template="/components/header.cfm">
<cfif getStaff.recordcount gt 0>	
		<cfoutput query="getStaff">
		<div class="i-content">
		  <div class="container">
		  	<div class="row">
		  		<div class="col-lg-12">
		        <div class="row">
		          <div class="col-lg-4 col-md-4 col-sm-5">
		            <cfif len(photo)>
		            	<img src="http://cms.icnd.net/images/staff/76B86299-155D-0010-0737DDD6612379F3bsauls.jpg" class="thumbnail" width="100%">
		            <cfelse>
		            	<img src="http://www.icoastalnet.com/images/employees/missing-male.jp">
		            </cfif>
		          </div>
		          <div class="col-lg-8 col-md-8 col-sm-7">
		            <p class="h1 site-color-1 nopadding nomargin">#name#</p>
		            <cfif len(title)><p class="h2 site-color-2">#title#</p></cfif>
		            <p>
		              <cfif len(email)><b>Email:</b> #email#<br></cfif>
		              <cfif len(phone)><b>Phone:</b> #phone#<br></cfif>
		              <cfif len(fax)><b>Fax:</b> #fax#<br></cfif>
		            </p>
		            #description#
		          </div>
		        </div>
		  		</div>
		  	</div>
		  </div>
		</div>
		</cfoutput>
<cfelse>		
	<div class="i-content">
		<div class="container">
			<div class="row">
				<div class="col-lg-9 col-md-8 col-sm-12">
		     		<h1>Record Not Found</h1>
		     		<p>Sorry, that record was not found.</p>
				</div>
				<div class="col-lg-3 col-md-4 col-sm-12">
			 		<div class="i-sidebar">
			 			<cfinclude template="/components/callouts.cfm">
			 		</div>
				</div>
			</div>
		</div>
	</div>	
</cfif>
<cfinclude template="/components/footer.cfm">