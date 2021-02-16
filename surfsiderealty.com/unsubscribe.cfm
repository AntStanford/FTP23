<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha256-916EbMg70RQy9LHiGkXzG8hSg9EdNy97GazNG/aiY1w=" crossorigin="anonymous" />
<link href="/stylesheets/styles.css" rel="stylesheet" type="text/css" media="screen, projection">
<link href="/stylesheets/fonts/fonts.css" rel="stylesheet">

<style>
.unsubscribe-wrap { margin: 25px auto; max-width: 600px; }
</style>

<div class="unsubscribe-wrap">
  <div class="well">

  <cftry>
  	<!--- FOR TESTING - REMOVE WHEN DONE --->
  	<cfparam name="url.e" default="" />
  	<!---
  		When a guest hits unsubscribe in their email, they come here
  		We store their email, the site ID and a time stamp in booking_clients->unsubscribe
  	--->
  	<cfif structKeyExists( url, "e" )>
  		<cfif len( e ) gt 0 and isValid( 'email', url.e )>
  			<cfif structKeyExists( form, "unsub" )>
  				<cfset resp = application.unsubobj.setUnsubscribe( form.guestemail, settings.id ) />
  				<cfif resp>
    				<div class="alert alert-success">
    					You have been unsubscribed
    				</div>
  				<cfelse>
  				  <div class="alert alert-danger">
    					There was a problem unsubscribing you
  				  </div>
  				</cfif>
  			<cfelse>
  				<cfset unsubCheck = application.unsubobj.isUnsubscribed( url.e, settings.id ) />
  				<cfif unsubCheck>
    				<div class="alert alert-info">
    					Looks like you've already unsubscribed<br>
    					If you are still receiving email, please contact us at
    				</div>
  				<cfelse>
  					<h1 class="text-center">We're sorry to see you go!</h1>
  					<cfoutput>
  						<form action="unsubscribe.cfm?e=#url.e#" method="post" name="unsubform" id="unsubform">
                <div class="form-group">
      						<label for="guestemail">Email Address</label>
    							<input type="text" name="guestemail" id="guestemail" value="#url.e#" class="form-control" />
                </div>
                <div class="form-group">
                  <input type="submit" name="unsub" id="unsub" value="Unsubscribe" class="btn btn-primary site-color-1-bg site-color-1-bg-hover text-white btn-red" />
                </div>
  						</form>
  					</cfoutput>
  				</cfif>
  			</cfif>
  		</cfif>
  	<cfelse>
  	  <div class="alert alert-danger">
    		Sorry there was a problem getting your information.
  	  </div>
  	</cfif>
  	<cfcatch>
  		<cfdump var="#cfcatch#" abort="true" />
  	</cfcatch>
  </cftry>

  </div>
</div>