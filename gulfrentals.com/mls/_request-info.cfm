<div id="inquire" name="inquire" class="info-wrap inquire-wrap">
  <div class="info-wrap-heading"><i class="fa fa-question-circle" aria-hidden="true"></i> Inquire</div>
  <div class="info-wrap-body">
    <em>Want To Know More About This Listing?</em>
    <div id="propertyContactFormMSG"></div>
    <form role="form" id="propertyContactForm" class="contact-form validate" method="post">
      <cfinclude template="/cfformprotect/cffp.cfm">
      <cfoutput>
      <input type="hidden" name="requestMoreInfoForm">
      <input type="hidden" name="processform" value="Request More Info">
      <input id="mlsNumber" name="mlsNumber" type="hidden" value="#property.MLSNUMBER#"/>
      <input id="mlsID" name="mlsID" type="hidden" value="#property.mlsid#"/>
      <input id="wsid" name="wsid" type="hidden" value="#property.wsid#"/>
      </cfoutput>
      <fieldset class="row">
        <div class="form-group col-xs-12 col-sm-6">
          <label>First Name</label>
          <input type="text" id="firstName" name="firstName" placeholder="First Name" class="required">
        </div>
        <div class="form-group col-xs-12 col-sm-6">
          <label>Last Name</label>
          <input type="text" id="lastname" name="lastname" placeholder="Last Name" class="required">
        </div>
        <div class="form-group col-xs-12">
          <label>Phone Number</label>
          <input type="text" id="phone" name="phone" placeholder="Phone Number" class="required">
        </div>
        <div class="form-group col-xs-12">
          <label>Email Address</label>
          <input type="email" id="email" name="email" placeholder="Email" class="required">
        </div>
        <div class="form-group col-xs-12">
          <label>Comments/Questions</label>
          <textarea id="" name="comments" placeholder="Comments..."></textarea>
        </div>
        <div class="form-group col-xs-12">
          <cfif isdefined('cookie.loggedin')>

            <cfquery datasource="#application.settings.dsn#" name="GetAgentID">
              SELECT *
              FROM cl_accounts
              where id = '#cookie.loggedin#'
            </cfquery>

            <cfoutput>
              <input type="hidden" name="agentid" value="#GetAgentID.agentid#">
            </cfoutput>

          <cfelseif application.settings.mls.EnableRoundRobin is "Yes">
            <!---<div class="form-field largest">
              <cfquery datasource="#application.settings.dsn#" name="GetAgents">
                SELECT *
                FROM cl_agents
                where roundrobin = 'Yes'
              </cfquery>
              <label>Are you working with an existing agent?</label>
              <select name="agentid" class="selectpicker">
                <option value="No" SELECTED>No</option>
                <cfoutput query="GetAgents">
                  <option value="#id#">Yes - #firstname# #lastname#</option>
                </cfoutput>
              </select>
            </div>--->
            <input type="hidden" name="agentid" value="No">
          <cfelse>
            <input type="hidden" name="agentid" value="No">
          </cfif>
        </div>
        <div class="form-group col-xs-12">
          <div id="propertyContactCaptcha"></div>
          <div class="g-recaptcha-error"></div>
        </div>
        <div class="form-group col-xs-12">
          <input type="submit" id="" name="propertyContactForm" class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" value="Request Info">
        </div>

      </fieldset>
    </form>
    <!---
    <div id="requiredFormMSG"></div>
    --->
  </div><!-- END info-wrap-body -->
</div><!-- END inquire-wrap -->
