<cfinclude template="/sales/lightboxes/_header.cfm">

<div id="mls-wrapper">
<!---   <div align="right">
    <cfoutput>
      <a hreflang="en" href="#session.RememberMePage#" target="_parent" id="fancybox-close">X</a>
    </cfoutput>
  </div> --->
  <h2>Save Your Search</h2>
  <cfif isdefined('cookie.loggedin') is "No">
    <cfparam name="propertycount" default="">
    <cflocation url="/sales/lightboxes/create-account.cfm?action=#action#&propertycount=#propertycount#" addtoken="No">
  <cfelse>
    <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
    <cfif isdefined('processform')>
      


      <!---START: PROCESSING FORM--->
      <cfif Cffp.testSubmission(form)>
        


        <!---START: CHECK TO SEE IF THIS name ALREADY EXISTS--->
        <cfquery datasource="#mls.dsn#" name="Checkname">
          SELECT *
          FROM cl_saved_searches
          where clientid = <cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric"> 
          and searchname = <cfqueryparam value="#searchname#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif Checkname.recordcount gt 0>
          <div class="notice">
            <P>Please <a hreflang="en" href="javascript:history.back()">go back </a>and change your search name.</P>
            <p>You already have saved a search with this name.</p>
          </div>
          <cfinclude template="/sales/lightboxes/_footer.cfm">
          <cfabort>
        </cfif>
        <!---END: CHECK TO SEE IF THIS name ALREADY EXISTS--->
        
        
        
        <cfinclude template="/sales/lightboxes/save-search_.cfm">
      <cfelse>
        Spam Bot
        <cfabort>
      </cfif>
      <div class="notice">
        <h3>This search has been successfully saved.<br><cfoutput>Close this window and continue browsing.</cfoutput></h3>
      </div>
    <cfelse>
      <p>Save your search and receive daily, weekly, or monthly updates for the search you performed.</p>
      <cfform action="#script_name#" class="form-horizontal" method="post">
        <cfinclude template="/cfformprotect/cffp.cfm">
        <input type="hidden" name="processform" value="">
        <cfoutput>
          <input type="hidden" name="propertycount" value="#propertycount#">
        </cfoutput>
        <div class="form-field">
          <label for="full_name">Name This Search</label>
          <cfinput type="Text" name="searchname" message="You must enter a name for this search!" required="Yes" id="full_name">
        </div>
        <div class="form-field">
          <label for="Notification">Notification Frequency:</label>
          <select name="HowOften">
            <option value="0">Never</option>
            <option value="1">Daily</option>
            <option value="7">Weekly</option>
            <option value="14">Bi-Weekly</option>
            <option value="30">Monthly</option>
          </select>
        </div><br><br><br>
        <cfinput type="submit" name="submit" value="Save Search" class="button">
      </cfform>
    </cfif>
  </cfif>
</div>

