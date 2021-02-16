 <script type="text/javascript">
$(document).ready(function()
	{

		//Handles Create Account form
		$("#mlsformCreate").submit(function(e)
		{

		    var postData = $(this).serializeArray();
		    $.ajax(
		    {
		        url : "/sales/lightboxes/create-account.cfm?processform=",
		        type: "POST",
		        data : postData,
		        success: function(data)
		        {
		        	$("#mlsformCreate")[0].reset();
		         	$("#mlsCreateTable").hide();
		         	$("#success-msg").html(data)

		        },
		        error: function(errorThrown)
		        {
		             alert();
		             //if fails
		        }
		    });
		    e.preventDefault(); //STOP default action
		    // e.unbind(); //unbind. to stop multiple form submit.
		});


		//Handles Login form
		$("#mlsformLogin").submit(function(e)
		{

		    var postData = $(this).serializeArray();
		    $.ajax(
		    {
		        url : "/sales/lightboxes/login.cfm?processLogin=",
		        type: "POST",
		        data : postData,
		        success: function(data)
		        {
		         	$("#mlsLoginTable").hide();
		         	$("#success-login").html(data)

		        },
		        error: function(errorThrown)
		        {
		             alert();
		             //if fails
		        }
		    });
		    e.preventDefault(); //STOP default action
		    // e.unbind(); //unbind. to stop multiple form submit.
		});

		$( "#ClearCreate" ).click(function() {
			// $("#mlsModalCreate").removeData();
			// $("#mlsformCreate")[0].reset();
			// $("#mlsCreateTable").show();
			// $("#success-msg").remove();
		});


		// Clears Send to a Friend when closed
	   $('#mlsModalSTAF').on('hidden.bs.modal', function(e)
	    {
	        $("#mlsModalSTAF").removeData();
	        $("#success-staf").hide();
	        $("#mlsSTAFTable").show();
	        $("#submitMlsSTAF").show();
	    }) ;

			// Clears Request More Info when closed
		   $('#mlsModalMoreInfo').on('hidden.bs.modal', function(e)
		    {
		        $("#mlsModalMoreInfo").removeData();
		        $("#success-moreinfo").hide();
		        $("#mlsMoreInfoTable").show();
		        $("#submitMlsMoreInfo").show();
                $("#agentidSelectionDiv").show();
		    }) ;

		//triggered when modal is about to be shown
		$('#mlsModalSTAF').on('show.bs.modal', function(e) {

		    //get data-id attribute of the clicked element
		    var mlsnum = $(e.relatedTarget).data('mlsnum');
		    var mlsid = $(e.relatedTarget).data('mlsid');
		    var wsid = $(e.relatedTarget).data('wsid');
		    var msg = $(e.relatedTarget).data('msg');

		    //populate the textbox
		    $(e.currentTarget).find('input[name="SendToAFriendmlsNumber"]').val(mlsnum);
		    $(e.currentTarget).find('input[name="SendToAFriendmlsID"]').val(mlsid);
		    $(e.currentTarget).find('input[name="SendToAFriendwsid"]').val(wsid);
		    $(e.currentTarget).find('textarea[name="comments"]').val(msg);
	});

		//triggered when modal is about to be shown
		$('#mlsModalMoreInfo').on('show.bs.modal', function(e) {

		    //get data-id attribute of the clicked element
		    var mlsnum = $(e.relatedTarget).data('mlsnum');
		    var mlsid = $(e.relatedTarget).data('mlsid');
		    var wsid = $(e.relatedTarget).data('wsid');
		    var msg = $(e.relatedTarget).data('msg');

		    //populate the textbox
		    $(e.currentTarget).find('input[name="MoreInfomlsNumber"]').val(mlsnum);
		    $(e.currentTarget).find('input[name="MoreInfomlsID"]').val(mlsid);
		    $(e.currentTarget).find('input[name="MoreInfowsid"]').val(wsid);
		    // $(e.currentTarget).find('#moreinfoheader').val(msg);
		    $("#moreinfoheader").html(msg)
	});


		//Handles Send to a Friend Form
		$("#mlsformSTAF").submit(function(e)
		{

		    var postData = $(this).serializeArray();
		    $.ajax(
		    {
		        url : "/sales/lightboxes/send-to-a-friend.cfm?processform=",
		        type: "POST",
		        data : postData,
		        success: function(data)
		        {
		         	$("#mlsSTAFTable").hide();
		         	$("#success-staf").html(data)

		        },
		        error: function(errorThrown)
		        {
		             alert();
		             //if fails
		        }
		    });
		    e.preventDefault(); //STOP default action
		    // e.unbind(); //unbind. to stop multiple form submit.
		});


		//Handles Request More Info
		$("#mlsformMoreInfo").submit(function(e)
		{

		    var postData = $(this).serializeArray();
		    $.ajax(
		    {
		        url : "/sales/lightboxes/request-more-information.cfm?processform=",
		        type: "POST",
		        data : postData,
		        success: function(data)
		        {
		         	$("#mlsMoreInfoTable").hide();
		         	$("#agentidSelectionDiv").hide();
                    $("#submitMlsMoreInfo").hide();
		         	$("#success-moreinfo").html(data)

		        },
		        error: function(errorThrown)
		        {
		             alert();
		             //if fails
		        }
		    });
		    e.preventDefault(); //STOP default action
		    // e.unbind(); //unbind. to stop multiple form submit.
		});



	});
</script>

<!-- START: Request More Info -->
<div id="mlsModalMoreInfo" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Request More Information <div id="moreinfoheader"></div></h4>

      </div>
		<form id="mlsformMoreInfo">
		<input id="MoreInfomlsNumber" name="MoreInfomlsNumber" type="hidden"/>
          <input id="MoreInfomlsID" name="MoreInfomlsID" type="hidden" />
          <input id="MoreInfowsid" name="MoreInfowsid" type="hidden" />
			<cfinclude template="/cfformprotect/cffp.cfm">
		      <div class="modal-body">
		      	<cfoutput>
		           <table id="mlsMoreInfoTable" width="100%">
		              <tr>
		                <td>First Name:<br><input type="Text" name="firstname" required style="width:80%;" <cfif isdefined('cookie.USERFirstName')>value="#cookie.USERFirstName#"></cfif></td>
		                <td>Last Name:<br><input type="Text" name="lastname" required style="width:80%;" <cfif isdefined('cookie.USERLastName')>value="#cookie.USERLastName#"></cfif></td>
		              </tr>
		              <tr>
		                <td>Phone:<br><input type="text" name="Phone" required style="width:80%;" <cfif isdefined('cookie.USERPhone')>value="#cookie.USERPhone#"></cfif></td>
		                <td>Email:<br><input type="Text" name="email" required style="width:80%;" <cfif isdefined('cookie.USEREmail')>value="#cookie.USEREmail#"></cfif></td>
		              </tr>
		              <tr>
		                <td colspan="2">Best Time to Call:<br><input type="text" name="bestcontact" style="width:80%;"></td>
		              </tr>
		              <tr>
		                <td colspan="2">Comments/Questions:<br><textarea name="comments" style="width:80%;height:200px;"></textarea></td>
		              </tr>
		      	</table>
				</cfoutput>
				<cfif isdefined('cookie.loggedin')>

						<cfquery datasource="#mls.dsn#" name="GetAgentID">
				            SELECT *
				            FROM cl_accounts
				            where id = <cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_varchar">
				        </cfquery>

					<cfoutput>
						<input type="hidden" name="agentid" value="#GetAgentID.agentid#">
					</cfoutput>

				<cfelseif mls.EnableRoundRobin is "Yes">
					<div class="form-field largest" style="width:74%">

                        <cfquery name="GetAgents" datasource="#settings.dsn#">
                            SELECT *
                            FROM cms_staff
                            where 1=1
                            and category = 'Real Estate Sales'
                            order by sort, name
                        </cfquery>

                        <div id="agentidSelectionDiv">
					    <label>Are you working with an existing agent?</label>
					    <select id="agentidSelection" name="existingAgentName" style="width:100%">
					      <option value="No" SELECTED>No</option>
					      <cfoutput query="GetAgents">
					        <option value="#name#">Yes - #name#</option>
					      </cfoutput>
					    </select>
                        </div>
					</div>

				<cfelse>
				     <input type="hidden" name="agentid" value="No">
				</cfif>


		      	<div id="success-moreinfo"></div>

		      </div>
		      <div class="modal-footer">
		      	<input type="submit" name="submit" value="Submit Inquiry" id="submitMlsMoreInfo" class="btn btn-default" data-backdrop="static" onClick="ga('send', 'event', { eventCategory: 'lead', eventAction: 'submitted', eventLabel: 'real-estate-request-more-info'});">
		        <button type="button" id="closeMoreInfo" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		</form>
  </div>
</div>
<!-- END: Request More Info -->

<!-- START: Send to a Friend Modal -->
<div id="mlsModalSTAF" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send to a Friend</h4>
      </div>
		<form id="mlsformSTAF">
		<input id="SendToAFriendmlsNumber" name="SendToAFriendmlsNumber" type="hidden"/>
          <input id="SendToAFriendmlsID" name="SendToAFriendmlsID" type="hidden" />
          <input id="SendToAFriendwsid" name="SendToAFriendwsid" type="hidden" />
			<cfinclude template="/cfformprotect/cffp.cfm">
		      <div class="modal-body">

		           <table id="mlsSTAFTable" width="100%">
		              <tr>
		                <td>Friend's First Name:<br><input type="Text" name="firstname" style="width:80%;"></td>
		                <td>Friend's Last Name:<br><input type="Text" name="lastname" style="width:80%;"></td>
		              </tr>
		              <tr>
		                <td colspan="2">Friend's Email:<br><input type="Text" name="email" style="width:80%;"></td>
		              </tr>
		              <tr>
		                <td colspan="2">Comments/Questions:<br><textarea name="comments" style="width:80%;height:200px;"></textarea></td>
		              </tr>
		      	</table>
		      	<div id="success-staf"></div>

		      </div>
		      <div class="modal-footer">
		      	<input type="submit" name="submit" value="Send to a Friend" id="submitMlsSTAF" class="btn btn-default" data-backdrop="static">
		        <button type="button" id="closeSTAF" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		</form>
  </div>
</div>
<!-- END: Send to a Friend Modal -->

<!-- START: MLS Register Modal -->
<div id="mlsModalCreate" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Create an Account</h4>
      </div>
		<form id="mlsformCreate">
			<input type="hidden" name="agentid" value="No">
			<cfinclude template="/cfformprotect/cffp.cfm">
		      <div class="modal-body">

		           <table id="mlsCreateTable">
		               <tr>
		                <td colspan="2">
		                    <p>Enjoy all the great features Surfside Realty Company's website offers by filling out the form below.</p>
		                </td>
		              </tr>
		              <tr>
		                <td>First Name:<br><input type="Text" name="firstname" style="width:80%;"></td>
		                <td>Last Name:<br><input type="Text" name="lastname" style="width:80%;"></td>
		              </tr>
		              <tr>
		                <td>Phone:<br><input type="text" name="Phone" style="width:80%;"></td>
		                <td>Email:<br><input type="Text" name="email" style="width:80%;"></td>
		              </tr>
		              <tr>
		                <td>Password:<br><input type="text" name="thepassword" style="width:80%;"></td>
		                <td></td>
		              </tr>
		      	</table>
		      	<div id="success-msg"></div>

		      </div>
		      <div class="modal-footer">
		      	<input type="submit" name="submit" value="Submit" id="submitMlsCreate" class="btn btn-default" data-backdrop="static">
				<button class="btn btn-default" data-toggle="modal" data-target="#mlsModalLogin" data-dismiss="modal">Login</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		</form>
  </div>
</div>
 <!-- END: MLS Register Modal -->


  <!-- START: MLS Login Modal -->
<div id="mlsModalLogin" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Login</h4>
      </div>
		<form id="mlsformLogin">
		      <div class="modal-body">
		      	<p>If you already have an account, login below. If not, click Create Account.</p>
		        <table id="mlsLoginTable" width="100%">
		              <tr>
		                <td>Email:<br><input type="text" name="Email" style="width:80%;"></td>
		                <td>Password:<br><input type="Text" name="Password" style="width:80%;"></td>
		              </tr>

		      	</table>
		      	<div id="success-login"></div>

		      </div>
		      <div class="modal-footer">
		      	<input type="submit" name="submit" value="Submit" id="submitMlsLogin" class="btn btn-default" data-backdrop="static">
				<button class="btn btn-default" data-toggle="modal" data-target="#mlsModalCreate" data-dismiss="modal" id="ClearCreate" onClick="ga('send', 'event', { eventCategory: 'lead', eventAction: 'submitted', eventLabel: 'real-estate-account-created'});">Create Account</button>
		        <button type="button" id="closeMlsLogin" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		</form>
  </div>
</div>
 <!-- END: MLS Login Modal -->
