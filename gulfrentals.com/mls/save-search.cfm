<div id="mls-wrapper">
<cf_htmlfoot>
<script>
  function refreshPage() {
     var url = window.location.href;
     var u = url.replace("savesearch=","");
     window.location=u;
  }
  $('#howOften').selectpicker('refresh');
</script>
</cf_htmlfoot>
<!---   <div align="right">
    <cfoutput>
      <a href="#session.RememberMePage#" target="_parent" id="fancybox-close">X</a>
    </cfoutput>
  </div> --->

  <!--- THIS IS THE MODAL HEADER - INSERTED VIA JS --->
  <div class="modal-header site-color-2-bg text-white">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="saveSearchModalLabel"><i class="fa fa-floppy-o"></i> Save Search</h4>
  </div>

  <cfif isdefined('cookie.loggedin') is "No">
    <cfparam name="propertycount" default="">
    <cfinclude template = "/mls/ajax/create-account.cfm">
    <cfabort>
  <cfelse>
    <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
    <cfif isdefined('processform')>


      <!---START: PROCESSING FORM--->
      <cfif Cffp.testSubmission(form)>

        <!---START: CHECK TO SEE IF THIS name ALREADY EXISTS--->
        <cfquery datasource="#application.settings.dsn#" name="Checkname">
          SELECT *
          FROM cl_saved_searches
          where
          clientid = '#cookie.loggedin#'
          and searchname = <cfqueryparam value="#searchname#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfif Checkname.recordcount gt 0>
          <div class="notice">
            <p>Please change your search name - you already have saved a search with this name.</p>
              <form action="<cfoutput>#script_name#</cfoutput>" class="form-horizontal" method="post" id="savesearchform">
                <cfinclude template="/cfformprotect/cffp.cfm">
                <input type="hidden" name="processform" value="">
                <cfoutput>
                  <input type="hidden" name="propertycount" value="#propertycount#">
                </cfoutput>
                <div class="form-field">
                  <label for="full_name">Name This Search</label>
                  <input type="Text" name="searchname" message="You must enter a name for this search!" required="Yes" id="full_name">
                </div>
                <br>
                <div class="form-field">
                  <label for="Notification">Notification Frequency:</label>
                  <select name="HowOften" id="howOften" class="selectpicker">
                    <option value="0">Never</option>
                    <option value="1">Daily</option>
                    <option value="7">Weekly</option>
                    <option value="14">Bi-Weekly</option>
                    <option value="30">Monthly</option>
                  </select>
                </div><br>
                <input type="submit" name="submit" value="Save Search" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white">
              </form>
          </div>
          <cfabort>
        </cfif>
        <!---END: CHECK TO SEE IF THIS name ALREADY EXISTS--->

        <cfinclude template="save-search_.cfm">
      <cfelse>
        Spam Bot
        <cfabort>
      </cfif>
      <div class="modal-body">
        <p>This search has been successfully saved. Close this window and continue browsing. <br /><br /><button type="button" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" data-dismiss="modal">Close</button></p>
      </div>
    <cfelse>
      <div class="modal-body">
        <p>Save your search and receive daily, weekly, or monthly updates for the search you performed.</p>
        <form action="<cfoutput>#script_name#</cfoutput>" class="form-horizontal" method="post" id="savesearchform">
          <cfinclude template="/cfformprotect/cffp.cfm">
          <input type="hidden" name="processform" value="">
          <cfoutput>
            <input type="hidden" name="propertycount" value="#propertycount#">
          </cfoutput>
          <div class="form-field">
            <label for="full_name">Name This Search</label>
            <input type="Text" name="searchname" message="You must enter a name for this search!" required="Yes" id="full_name">
          </div>
          <br>
          <div class="form-field">
            <label for="Notification">Notification Frequency:</label>
            <select name="HowOften" id="howOften" class="selectpicker">
              <option value="0">Never</option>
              <option value="1">Daily</option>
              <option value="7">Weekly</option>
              <option value="14">Bi-Weekly</option>
              <option value="30">Monthly</option>
            </select>
          </div><br>
          <input type="submit" name="submit" value="Save Search" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white">
        </form>
      </div>
    </cfif>
  </cfif>
</div>

