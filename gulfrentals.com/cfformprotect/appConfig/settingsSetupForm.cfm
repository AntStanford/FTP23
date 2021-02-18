<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="author" content="ICND - 2019">   
  <title>Settings Setup</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
  <link href="/assests/stylesheets/starter-template.css" rel="stylesheet">   
</head>

<body>
  <div class="container">
    <div class="starter-template">
      <h1>Settings Setup</h1>
      <p class="lead">
      	The booking_clients.settings and booking_clients.clients records are not yet setup. Use this form to populate the needed data.
      </p>
      
      <form role="form" method="post" id="submitForm" action="">
      <input type="hidden" name="siteSettingsSubmit" value="1">
      
      <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="devEmail">What is your email?</label>
            <input type="text" name="devEmail" class="form-control required">
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="appName">Application Name</label>
            <input type="text" name="appName" disabled value="<cfoutput>#application.applicationName#</cfoutput>" class="form-control" >
          </div>
        </div>
        
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="dsn">DSN</label>
            <input type="text" name="dsn" disabled value="<cfoutput>#request.appConfigData.clientsDSN#</cfoutput>" class="form-control" >
          </div>
        </div>
        
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="pms">PMS</label>
            <input type="text" name="pms" disabled value="<cfoutput>#request.appConfigData.pms#</cfoutput>" class="form-control" >
          </div>
        </div>
      </div>
        
      <div class="row">
       <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="companyName">Company Name</label>
            <input type="text" name="companyName" value="" class="form-control required">
          </div>
        </div>
        
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="prodURL">Production URL</label>
            <input type="text" name="prodURL" class="form-control required">
            <div class="help-block">This is the live domain, not the test domain.  Should NOT include http:// but SHOULD include www.</div>
          </div>
        </div>

        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="devURL">Development URL</label>
            <input type="text" name="devURL" value="<cfoutput>#cgi.server_name#</cfoutput>" class="form-control required">
          </div>
        </div>
      </div>
  
      <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="googleReCaptchaSiteKey">Google ReCaptcha Site Key</label>
            <input type="text" name="googleReCaptchaSiteKey"  class="form-control">
            <div class="help-block">(<a href="http://wiki.icnd.net/doku.php?id=add_recaptcha_to_form" target="_blank">Click here</a> for instructions on how to obtain this)</div>
          </div>
        </div>

        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="googleReCaptchaSecretKey">Google ReCaptcha Secret Key</label>
            <input type="text" name="googleReCaptchaSecretKey"  class="form-control">
          </div>
        </div>
        
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="wpBlogDSN">WP Blog Datasource</label>
            <input type="text" name="wpBlogDSN" class="form-control">
          </div>
        </div>
      </div>

			<cfif request.appConfigData.PMS EQ "365 villas">
        <div class="row">
        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="365VillasAPIAccountNumber">365 Villas API Account Number</label>
              <input type="text" name="365VillasAPIAccountNumber" class="form-control required">
            </div>
          </div>
        </div>
			<cfelseif request.appConfigData.PMS EQ "Barefoot">
        <div class="row">
        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="barefootApiUsername">Barefoot API Username</label>
              <input type="text" name="barefootApiUsername" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="barefootApiPassword">Barefoot API Password</label>
              <input type="text" name="barefootApiPassword" class="form-control required">
            </div>
          </div>
        </div>

        <div class="row">
        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="barefootApiAccountNumber">Barefoot API Account Number</label>
              <input type="text" name="barefootApiAccountNumber" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="barefootApiRezTypeId">Barefoot API Rez Type ID</label>
              <input type="text" name="barefootApiRezTypeId" class="form-control required">
            </div>
          </div> 
        </div>
 			<cfelseif request.appConfigData.PMS EQ "Ciirus">
        <div class="row">
        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="ciirusApiUsername">Ciirus API Username</label>
              <input type="text" name="ciirusApiUsername" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="ciirusApiPassword">Ciirus API Password</label>
              <input type="text" name="ciirusApiPassword" class="form-control required">
            </div>
          </div>
        </div>
			<cfelseif request.appConfigData.PMS EQ "Escapia" >
        <div class="row">
        	<div class="col-lg-4 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="escapiaApiUsername">Escapia API Username</label>
              <input type="text" name="escapiaApiUsername" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="escapiaApiPassword">Escapia API Password</label>
              <input type="text" name="escapiaApiPassword" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="escapiaClientState">Client State</label>
              <input type="text" name="escapiaClientState" class="form-control required">
            </div>
          </div>
        </div>
 			<cfelseif request.appConfigData.PMS EQ "Homeaway">
        <div class="row">
        	<div class="col-lg-4 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="homeawayCOID">COID</label>
              <input type="text" name="homeawayCOID" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="homeawayV12">v12 customer?</label>
              <select name="homeawayV12" class="form-control" style="width:200px">
                <option>No</option>
                <option>Yes</option>
              </select>
            </div>
          </div>
        </div>
 			<cfelseif request.appConfigData.PMS EQ "Homhero">
        <div class="row">
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="homheroApiUsername">Homhero API Username</label>
              <input type="text" name="homheroApiUsername" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="homheroApiPassword">Homhero API Password</label>
              <input type="text" name="homheroApiPassword" class="form-control required">
            </div>
          </div>
          
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="homheroApiAccountNumber">Homhero API Account Number</label>
              <input type="text" name="homheroApiAccountNumber" class="form-control required">
            </div>
          </div>
        </div>
			<cfelseif request.appConfigData.PMS EQ "Real Time Rentals">
        <div class="row">
        	<div class="col-lg-4 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="rtrAPIKey">Real Time Rentals API Key</label>
              <input type="text" name="rtrAPIKey" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="rtrScriptsVersion">Scripts Version</label>
              <select name="rtrScriptsVersion" class="form-control" style="width:200px">
                <option>v3</option>
                <option>v2</option>
                <option>v1</option>
              </select>
            </div>
          </div>
        </div>
      <cfelseif request.appConfigData.PMS EQ "RMS">
        <div class="row">
        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="rmsApiUsername">RMS API Username</label>
              <input type="text" name="rmsApiUsername" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="rmsApiPassword">RMS API Password</label>
              <input type="text" name="rmsApiPassword" class="form-control required">
            </div>
          </div>
        </div>
      <cfelseif request.appConfigData.PMS EQ "RNS">
        <div class="row">
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="rnsEndPoint">RNS End Point</label>
              <input type="text" name="rnsEndPoint" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="rnsAccessKey">RNS Access Key</label>
              <input type="text" name="rnsAccessKey" class="form-control required">
            </div>
          </div>
          
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="rnsCompanyID">RNS Company ID (integer)</label>
              <input type="text" name="rnsCompanyID" class="form-control required">
            </div>
          </div>
        </div>
			<cfelseif request.appConfigData.PMS EQ "Streamline">
        <div class="row">
        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="streamlineTokenKey">Streamline Token Key</label>
              <input type="text" name="streamlineTokenKey" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="streamlineTokenSecret">Streamline Token Secret</label>
              <input type="text" name="streamlineTokenSecret" class="form-control required">
            </div>
          </div>
        </div>

        <div class="row">
        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="streamlinetokenExpDate">Streamline Token Expire Date</label>
              <input type="text" name="streamlinetokenExpDate" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-6 col-md-6 col-sm-6">
            <div class="form-group">
              <label for="streamlineEndPoint">Streamline End Point</label>
              <input type="text" name="streamlineEndPoint" class="form-control required">
            </div>
          </div>
        </div>
      <cfelseif request.appConfigData.PMS EQ "Track">
        <div class="row">
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="trackApiUsername">Track API Username</label>
              <input type="text" name="trackApiUsername" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="trackApiPassword">Track API Password</label>
              <input type="text" name="trackApiPassword" class="form-control required">
            </div>
          </div>
          
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="trackApiEndPoint">Track API End Point</label>
              <input type="text" name="trackApiEndPoint" class="form-control required">
            </div>
          </div>
        </div>
      <cfelseif request.appConfigData.PMS EQ "Vreasy">
        <div class="row">
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="vreasyApiKey">Vreasy API Key</label>
              <input type="text" name="vreasyApiKey" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="vreasyApiUserID">Vreasy API User ID (integer)</label>
              <input type="text" name="vreasyApiUserID" class="form-control required">
            </div>
          </div>
          
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="vreasyParseEmail">Vreasy Parse Email</label>
              <input type="text" name="vreasyParseEmail" class="form-control required">
            </div>
          </div>
        </div>
      <cfelseif request.appConfigData.PMS EQ "VRM">
        <div class="row">
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="vrmEndPoint">VRM End Point</label>
              <input type="text" name="vrmEndPoint" class="form-control required">
            </div>
          </div>

        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="vrmImagePath">VRM Image Path</label>
              <input type="text" name="vrmImagePath" class="form-control required">
            </div>
          </div>
          
        	<div class="col-lg-4 col-md-4 col-sm-4">
            <div class="form-group">
              <label for="vrmAPIKey">VRM API Key</label>
              <input type="text" name="vrmAPIKey" class="form-control required">
            </div>
          </div>
        </div>
      </cfif>
      
      <div class="row" align="center">
        <button type="submit" class="btn btn-info" style="margin-top:50px">Submit</button>
      </div>

      </form>
         
         <div id="loader" style="display:none" style="margin-top:25px"><img src="loader.GIF"></div>
         <div id="response" style="margin-top:15px"></div>

      </div>

    </div><!-- /.container -->

		<br><br><br>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    
    <script type="text/javascript">
    	$(document).ready(function(){    		
    		$('#submitForm').validate();
      }); 		
    </script>
    
  </body>
</html>
<cfabort>
