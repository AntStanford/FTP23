<cfinclude template="/sales/lightboxes/_header.cfm">
<link href="/sales/stylesheets/mls.css?v=2" rel="stylesheet" type="text/css">

<style>
.padformfield {padding:10px 0 0 0;}
</style>

<div id="mls-wrapper">

<table height="400" width="350"><tr><td> 
<!---                   <cfif isdefined('action') and action is "addtofavorites">
                    <p><b>To Save Your Favorites</b></p>
                  <cfelse>
                    <p>Enjoy all the great features <cfoutput>#mls.companyname#'s</cfoutput> website offers by filling out the form below.</p>
                  </cfif> --->
  


<div class="form-field"><label>First Name:</label><input type="Text" name="firstname"></div>
<div class="form-field"><label>Last Name:</label><input type="Text" name="lastname"></div>
<div class="form-fields padformfield"><label>Phone:</label><br><input type="text" name="Phone" maxlength="15"></div>
<div class="form-fields padformfield"><label>Email:</label><br><input type="Text" name="email"></div>
<div class="form-fields padformfield"><label>Password:</label><br><input type="password" name="thepassword"></div>


     
<cfif mls.EnableRoundRobin is "Yes">

    <cfif isdefined('session.useremail') and session.useremail is not "">
      <cfquery datasource="#mls.dsn#" name="CheckExists">
      SELECT * 
      FROM cl_accounts
      where email = <cfqueryparam value="#session.useremail#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>

      <cfoutput><input type="hidden" name="agentid" value="#CheckExists.agentid#"></cfoutput>

    <cfelse>

      <cfquery datasource="#mls.dsn#" name="GetAgents">
      SELECT * 
      FROM cl_agents
      where roundrobin = 'Yes'
      </cfquery>

      <div class="form-fields padformfield"><label>Working with one of our agents?</label>

        <select name="agentid">
          <option value="No" SELECTED>No</option>
          <cfoutput query="GetAgents">
          <option value="#id#">Yes - #firstname# #lastname#</option>
          </cfoutput>
        </select>

      </div>

   </cfif> 

<cfelse>
   <input type="hidden" name="agentid" value="No">
</cfif>  
				  
<div class="form-fields padformfield"><label>Already have an account? <a hreflang="en" href="">Click here to sign in</a>.</label></div>

<div class="form-fields padformfield"><label><a hreflang="en" href="">Click here to continue without registering</a>.</label></div>
				                 
       

<!--- <cfinput type="submit" name="SubmitForm" value="Create An Account" class="button">
<a hreflang="en" href="login.cfm<cfif isdefined('url.nomoreviewsallowed')>?nomoreviewsallowed=<cfelseif isdefined('action') and action is "addtofavorites">?#cgi.query_string#</cfif>" class="fb_dynamic button">Login</a>
<cfif isdefined('url.nomoreviewsallowed')><a hreflang="en" href="../search-results.cfm" target="_parent" class="button" style="float:right;">Continue without signing up</a></cfif>
 --->


<td></tr></table>

</div>