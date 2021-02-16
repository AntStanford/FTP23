<cfinclude template="/#settings.booking.dir#/components/header.cfm">

<cfquery dataSource="#settings.dsn#">
  update cms_price_alerts_signups
	set
    active = 'No'
  where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.ratealertid#">
</cfquery>

<br>
<div class="i-content int">
  <div class="container">
  	<div class="row">
  		<div class="col text-center">
    		<div class="alert alert-info text-left" style="width:auto;margin:auto;display:inline-block;margin-bottom:25px;">
          <div class="h6" style="margin:0 0 10px;">We have removed you from the Price Alert Signup for this property.</div>
          <p style="margin:0 0 10px;">We hope you plan your next vacation with us!</p>
          <p class="nomargin"><em>Thank you!</em></p>
    		</div>
  		</div>
  	</div>
  </div>
</div><!--- END i-content --->

<cfinclude template="/#settings.booking.dir#/components/footer.cfm">