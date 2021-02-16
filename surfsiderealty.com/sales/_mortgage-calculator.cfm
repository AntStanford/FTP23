<a id="mortgage" class="btn btn-primary"  data-toggle="modal" data-target="#mortgagecalc">Mortgage Calculator</a>

<cf_htmlfoot>
  <div id="mortgagecalc" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Mortgage Calculator</h4>
        </div>
        <div class="modal-body" align="center">
          <form name="calc" method="post" action="#">
            <table border="0" cellpadding="4" cellspacing="0">
              <tbody>
                <tr>
                  <td nowrap="">Home value:</td>
                  <td align="center"><input name="homevalue" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="<cfoutput>#List_Price#</cfoutput>" style="" onfocus="this.value = this.value=='300000'?'':this.value;" onblur="this.value = this.value==''?'300000':this.value;"></td>
                </tr>
                <tr>
                  <td nowrap=""> Mortgage loan amount: </td>
                  <cfset principalamount = (List_Price*85)/100>
                  <td align="center"><input name="principal" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="<cfoutput>#principalamount#</cfoutput>" style="" onfocus="this.value = this.value=='250000'?'':this.value;" onblur="this.value = this.value==''?'250000':this.value;"></td>
                </tr>
                <tr>
                  <td nowrap=""> APR (in %): </td>
                  <td align="center"><input name="intRate" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="6" style="" onfocus="this.value = this.value=='6'?'':this.value;" onblur="this.value = this.value==''?'6':this.value;"></td>
                </tr>
                <tr>
                  <td nowrap=""> Loan term (# years): </td>
                  <td align="center"><input name="numYears" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="30" style="" onfocus="this.value = this.value=='30'?'':this.value;" onblur="this.value = this.value==''?'30':this.value;"></td>
                </tr>
                <tr>
                  <td nowrap=""> Real estate taxes (%): </td>
                  <td align="center"><input name="annualTax" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="1.38" style="" onfocus="this.value = this.value=='1.38'?'':this.value;" onblur="this.value = this.value==''?'1.38':this.value;"></td>
                </tr>
                <tr>
                  <td nowrap=""> Homeowners insurance (%): </td>
                  <td align="center"><input name="annualInsurance" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="0.5" style="" onfocus="this.value = this.value=='0.5'?'':this.value;" onblur="this.value = this.value==''?'0.5':this.value;"></td>
                </tr>
                <tr>
                  <td nowrap=""> PMI (%): </td>
                  <td align="center"><input name="monthlyPMI" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="0.5" style="" onfocus="this.value = this.value=='0.5'?'':this.value;" onblur="this.value = this.value==''?'0.5':this.value;"></td>
                </tr>
                <tr>
                  <td nowrap=""> Closing costs ($0 if not in loan): </td>
                  <td align="center"><input name="closingcosts" type="number" step="any" class="form-control" onkeyup="clear_results(this.form);computeForm(this.form)" value="3700" style="" onfocus="this.value = this.value=='3700'?'':this.value;" onblur="this.value = this.value==''?'3700':this.value;"></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><input class="btn btn-primary site-color-1-bg site-color-1-lighten-bg-hover text-white" type="button" name="compute" value="Compute Mortgage Payment" onclick="computeForm(this.form)"></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><hr></td>
                </tr>
                <tr>
                  <td nowrap=""> Monthly Principal &amp; Interest: </td>
                  <td align="center"><input type="text" class="results form-control" name="monthlyPI" style="" readonly=""></td>
                </tr>
                <tr>
                  <td nowrap=""> Monthly Taxes, Insurance &amp; PMI: </td>
                  <td align="center"><input type="text" class="results form-control" name="otherPmts" style="" readonly=""></td>
                </tr>
                <tr>
                  <td nowrap=""> Total monthly payment: </td>
                  <td align="center"><input type="text" class="results form-control" name="monthlyPmt" style="" readonly=""></td>
                </tr>
                <tr>
                  <td nowrap=""> Down Payment (w/o closing cost): </td>
                  <td align="center"><input type="text" class="results form-control" name="downpayment" style="" readonly=""></td>
                </tr>
                <tr>
                  <td align="center"><input class="btn btn-primary site-color-1-bg site-color-1-lighten-bg-hover text-white" type="button" name="sched" value="Print Schedule" onclick="monthlyAmortSched(this.form)"></td>
                  <td align="center"><input class="btn btn-primary site-color-1-bg site-color-1-lighten-bg-hover text-white" type="reset" value="Clear"></td>
                </tr>
              </tbody>
            </table>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
  <!-- /.modal -->
  <cfoutput>
	<script src="/mls/javascripts/mortgage-calc.js"></script>
  </cfoutput>
</cf_htmlfoot>
