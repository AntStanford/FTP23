
	<cfset fromEmail = #GetAgent.email#>


	<form action="" enctype="multipart/form-data" method="post" name="LeadTracker" id="LeadTrackerMessage">


	<cfoutput>
		<input type="hidden" name="MessageCenterSend" value="yes">
		<input type="hidden" name="AgentFirstName" value="#GetAgent.Firstname#">
		<input type="hidden" name="AgentLastName" value="#GetAgent.Lastname#">
		<input type="hidden" name="AgentPhone" value="#GetAgent.phone#">
		<input type="hidden" name="AgentCell" value="#GetAgent.cellphone#">
		<input type="hidden" name="AgentWebsite" value="#GetAgent.website#">
		<input type="hidden" name="AgentID" value="#GetAgent.ID#">
		<input type="hidden" name="ContactType" value="Email">
		  <input type="hidden" name="PrivatePublic" value="Public">

		<input type="hidden" name="firstname" value="#getContact.firstname#">
		<input type="hidden" name="lastname" value="#getContact.lastname#">
		<input type="hidden" name="phone" value="#getContact.phone#">
		<input type="hidden" name="cellphone" value="#getContact.cellphone#">
		<input type="hidden" name="officephone" value="#getContact.officephone#">
		<input type="hidden" name="email" value="#getContact.email#">


	</cfoutput>

<table id="CreateMessageTable">

 	 <tr>
    	<td class="col1">From</td>
    	<td class="col2"><input maxlength="255" name="AgentEmail" type="text"  value="<cfoutput>#fromEmail#</cfoutput>"/></td>
  	</tr>
  	
	<tr>
    	<td class="col1">To</td>
    	<td class="col2"><input maxlength="255" name="MessageTo" size="40" type="text"  value="<cfoutput>#getContact.email#</cfoutput>"/></td>
  	</tr>
	
	<tr>
    	<td class="col1">CC</td>
    	<td class="col2"><input maxlength="255" name="MessageCC" size="40" type="text"  /></td>
  	</tr>
	
	<tr>
    	<td class="col1">BCC</td>
    	<td class="col2"><input maxlength="255" name="MessageBCC" size="40" type="text"  /></td>
  	</tr>
	 <tr>
    	<td class="col1">Message Subject</td>
    	<td class="col2"><input maxlength="255" name="MessageSubject" size="40" type="text" value="<cfoutput>Correspondence from #mls.companyname# - #GetAgent.Firstname# #GetAgent.Lastname#</cfoutput>"  /></td>
  	</tr>
  	<tr>
    	<td class="col1">Contact's Name</td>
    	<td class="col2"><cfoutput><b>#getContact.firstname# #getContact.lastname#</b></cfoutput></td>
  	</tr>
   <tr>
    <td class="col1">Message Body</td>
    <td class="col2">	
		<style>
		.content2 .panes div span {margin:1px;}
		</style>

		<script type="text/javascript" src="/admin/ckeditor/ckeditor.js"></script>

		<div class="msgeditor">	
			
		<textarea id="editor1" name="MessageBody"><br><cfoutput>#GetAgent.AgentEmailSignature#<cfif getagent.agentphoto is not ""><img src="http://#server_name#/mls/images/agents/sm_#getagent.agentphoto#"></cfif></cfoutput></textarea>
		<script type="text/javascript">CKEDITOR.replace('editor1', {filebrowserBrowseUrl: '/admin/core5/index.cfm' });CKEDITOR.config.toolbar = 'Full';CKEDITOR.config.width="100%";CKEDITOR.config.height="250";</script>	
		</div>
	</td>
  </tr>



	<tr>
    	<td class="col1">Follow Up Type</td>
    	<td class="col2">
			<select class="selectpicker contact-type" name="followuptype">
				<option value="nofollowup">Select Follow Up Type</option>
				<option>Email</option>
				<option>Phone</option>
				<option>Cell</option>
				<option>Work Phone</option>
			</select>
    	</td>
  	</tr>
  	<cfoutput>
		<tr>
	    	<td class="col1">Follow Up Date</td>
	    	<td class="col2">
			<select class="selectpicker time" name="followupDate">
				<cfloop index="i" from="0"  to="366">
					<option>#dateformat(DateAdd("d", i, now()), 'mm/dd/yyyy')#</option>
				</cfloop>
			</select>
	    	</td>
	  	</tr>
	<tr>
	    	<td class="col1">Follow Up Time</td>
	    	<td class="col2">
			<select class="selectpicker time" name="followupTime">
				<cfloop index="t" from="6:00 AM" to="11:30 PM" step="#CreateTimeSpan(0,0,30,0)#">
					<option>#TimeFormat( t, "hh:mm:ss TT")#</option>
				</cfloop>
			</select>	
	    	</td>
	  	</tr>
  	</cfoutput>
 	<tr>
    	<td class="col1">Follow Up Notes</td>
    	<td class="col2"> <textarea name="followupnotes" type="text" style="width:100%;height:100px;"></textarea></td>
  	</tr>




 
   <tr>
    <td></td>
    <td><input type="submit" value="Click To Send Email" name="submit" style="float:left;"/></td>
  </tr>
</form>
</table>




