<cfinclude template="/rentals/components/header.cfm">

<div class="i-content">
  <div class="container">
  	<div class="row">
  		<div class="col-lg-12">
       	<h2>Whoops!</h2>
       	<p>There was a problem with your request.</p>
       	<cfif isdefined('session.errorMessage')>
       	<p><cfoutput>#session.errorMessage#</cfoutput></p>
       	</cfif>       
  		</div>
  	</div>
  </div>
</div>

<cfinclude template="/rentals/components/footer.cfm">