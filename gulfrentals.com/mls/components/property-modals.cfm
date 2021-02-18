<!-- Mortgage Calculator Modal -->
<div class="modal fade mortgage-modal" id="mortgageModal" tabindex="-1" role="dialog" aria-labelledby="mortgageModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header site-color-2-bg text-white">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="mortgageModalLabel"><i class="fa fa-home"></i> Mortgage Calculator</h4>
      </div>
      <div class="modal-body">
        <form class="mortgage-calculator-form" id="calc" name="calc" method="post" action="">
          <fieldset class="row">
            <div class="form-group col-xs-12 col-sm-6">
              <label>Home value:</label>
              <input name="homevalue" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="<cfoutput>#property.List_Price#</cfoutput>" style="" onfocus="this.value = this.value=='300000'?'':this.value;" onblur="this.value = this.value==''?'300000':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Mortgage loan amount:</label>
              <cfset principalamount = (property.list_price*85)/100>
              <input name="principal" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="<cfoutput>#principalamount#</cfoutput>" style="" onfocus="this.value = this.value=='250000'?'':this.value;" onblur="this.value = this.value==''?'250000':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> APR (in %):</label>
              <input name="intRate" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="6" style="" onfocus="this.value = this.value=='6'?'':this.value;" onblur="this.value = this.value==''?'6':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Loan term (# years):</label>
              <input name="numYears" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="30" style="" onfocus="this.value = this.value=='30'?'':this.value;" onblur="this.value = this.value==''?'30':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Real estate taxes (%):</label>
              <input name="annualTax" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="1.38" style="" onfocus="this.value = this.value=='1.38'?'':this.value;" onblur="this.value = this.value==''?'1.38':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Homeowners insurance (%):</label>
              <input name="annualInsurance" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="0.5" style="" onfocus="this.value = this.value=='0.5'?'':this.value;" onblur="this.value = this.value==''?'0.5':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> PMI (%):</label>
              <input name="monthlyPMI" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="0.5" style="" onfocus="this.value = this.value=='0.5'?'':this.value;" onblur="this.value = this.value==''?'0.5':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Closing costs ($0 if not in loan):</label>
              <input name="closingcosts" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="3700" style="" onfocus="this.value = this.value=='3700'?'':this.value;" onblur="this.value = this.value==''?'3700':this.value;">
            </div>
            <div class="form-group col-xs-12 col-sm-12">
              <div class="btn-group"><input class="btn btn-primary site-color-1-bg site-color-1-lighten-bg-hover text-white" type="button" name="compute" value="Compute Mortgage Payment" onclick="computeForm(this.form)"></div>
            </div>
          </fieldset>
          <hr>
          <fieldset class="row">
            <div class="form-group col-xs-12 col-sm-6">
              <label> Monthly Principal &amp; Interest:</label>
              <input type="text" class="results form-control" name="monthlyPI" style="" readonly="">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Monthly Taxes, Insurance &amp; PMI:</label>
              <input type="text" class="results form-control" name="otherPmts" style="" readonly="">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Total monthly payment:</label>
              <input type="text" class="results form-control" name="monthlyPmt" style="" readonly="">
            </div>
            <div class="form-group col-xs-12 col-sm-6">
              <label> Down Payment (w/o closing cost):</label>
              <input type="text" class="results form-control" name="downpayment" style="" readonly="">
            </div>
            <div class="form-group col-xs-12">
              <div class="btn-group">
                <input class="btn btn-primary site-color-2-bg site-color-2-lighten-bg-hover text-white" type="button" name="sched" value="Print Schedule" onclick="monthlyAmortSched(this.form)">
                <input class="btn btn-primary site-color-4-bg site-color-4-lighten-bg-hover text-white" type="reset" value="Clear">
              </div>
            </div>
          </fieldset>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<cfif len(variables.virtualTourLink) and lcase(left(variables.virtualTourLink, 4)) is 'http'>

  <!-- Virtual Tour Modal -->
  <div class="modal fade virtual-tour-modal" id="virtualTourModal" tabindex="-1" role="dialog" aria-labelledby="virtualTourModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header site-color-2-bg text-white">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="virtualTourModalLabel"><i class="fa fa-hand-paper-o"></i> Virtual Tour</h4>
        </div>
        <div class="modal-body">
          <cfoutput><iframe src="#variables.virtualTourLink# " frameborder="0" width="100%" height="500"></iframe></cfoutput>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</cfif>