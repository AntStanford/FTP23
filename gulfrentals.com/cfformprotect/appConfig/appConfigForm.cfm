<cfset variables.pmsList = "None,356 Villas,Barefoot,Ciirus,Escapia,Homeaway,Homhero,ICND,Real Time Rentals,RNS,RMS,Streamline,Track,Vreasy,VRM">
 
<!DOCTYPE html> 
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="author" content="ICND - 2019">   
  <title>AppConfig Setup</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
  <link href="/assests/stylesheets/starter-template.css" rel="stylesheet">   
</head>

<body>
  <div class="container">
    <div class="starter-template">
      <h1>AppConfig Setup</h1>
      <p class="lead">
      	Before you can continue, you must enter the AppConfig data. This will ensure the Application Name is unique on the Server and the DSN is correct so that you do not interfere with another site.
      </p>
			<cfoutput>
      <form role="form" method="post" id="submitForm" action="">
      <input type="hidden" name="appConfigSubmit" value="1">
      <input type="hidden" name="rootFolder" value="#request.rootFolder#">
      
      <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="appName">Application Name</label>
            <input type="text" name="appName" value="#ReplaceNoCase(ReplaceNoCase(request.rootFolder,'-','','All'),'.','','All')#" class="form-control required">
          </div>
        </div>
  
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="dsn">DSN</label>
            <input type="text" name="dsn"  class="form-control required">
          </div>
        </div>
        
      </div>
      
      <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="bookingDir">Booking Directory</label>
            <input type="text" name="bookingDir" value="#request.appConfigData.bookingDir#" class="form-control required">
          </div>
        </div>
        
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="form-group">
            <label for="pms">PMS</label>
            <select name="pms" class="form-control required">
              <cfloop list="#variables.pmsList#" index="i">
                <option value="#i#" <cfif i EQ request.appConfigData.PMS>selected</cfif>>#i#</option>
              </cfloop>
            </select>
          </div>
        </div>
      </div>
      
      <div class="row" align="center">
        <button type="submit" class="btn btn-info" style="margin-top:50px">Submit</button>
      </div>

      </form>
			</cfoutput>    
     
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
