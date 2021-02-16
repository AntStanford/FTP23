<cfset page.title ="Popup">
<cfset page.module = 'popup'>
<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.id') and LEN(url.id)>
  <cfquery name="getPopup" dataSource="#settings.dsn#">
    select * from cms_popups where id = <cfqueryparam value="#url.id#" cfsqltype="integer">
  </cfquery>
</cfif>

<!--- Client no longer wants additional fields option MCrouch 3/23/20 ---> 
<!--- <cfif getPopup.recordcount gt 0>
  <cfquery name="getPopupFields" dataSource="#settings.booking.dsn#">
    select * from cms_popups_formfields where id = <cfqueryparam value="#getPopup.id#" cfsqltype="integer">
  </cfquery>
</cfif> --->

<cfoutput>
  
  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Update successful!</strong> Continue editing this #page.module# or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Success!</strong> Add another #page.module# or <a href="index.cfm">go back.</a>
    </div>
  </cfif>

  <p><a href="index.cfm" class="btn btn-primary">Back to List</a></p>

  <div class="widget-box">
    <div class="widget-title">
      <span class="icon">
        <i class="icon-th"></i>
      </span>
      <h5>Edit Email Popup Text</h5>
    </div>
    <div class="widget-content nopadding">
  
      <form method="post" action="submit.cfm" class="form-horizontal" enctype="multipart/form-data">   
        <cfif parameterExists(id)><input type="hidden" name="id" value="#url.id#"></cfif>
        <div class="control-group">
          <label class="control-label">Title</label>
          <div class="controls">
            <input type="text" name="title" <cfif parameterExists(id)>value="#getPopup.title#"</cfif> maxlength="255"/>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label">Message</label>
          <div class="controls">
            <input type="text" name="message" <cfif parameterExists(id)>value="#getPopup.message#"</cfif> maxlength="255"/>
          </div>
        </div>

          <div class="control-group">
            <label class="control-label">Active?</label>
            <div class="controls">
              <select name="isActive" style="width:200px">
               <option value="No" <cfif parameterexists(id) and getPopup.isActive eq '0'>selected="selected"</cfif>>No</option>
               <option value="Yes" <cfif parameterexists(id) and getPopup.isActive eq '1'>selected="selected"</cfif>>Yes</option>
              </select>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label">Capture Email?</label>
            <div class="controls">
              <select name="captureEmail" style="width:200px">
                <option value="No" <cfif parameterexists(id) and getPopup.captureEmail eq '0'>selected="selected"</cfif>>No</option>
                <option value="Yes" <cfif parameterexists(id) and getPopup.captureEmail eq '1'>selected="selected"</cfif>>Yes</option>
              </select>
            </div>
          </div>
          <!---
          <div class="control-group">
            <label class="control-label">Display Company Info Box?</label>
            <div class="controls">
             <select name="showCompanyBox">
            <option value="1" <cfif parameterexists(id) and getPopup.showCompanyBox is "1">SELECTED</cfif>>Yes</option>
            <option value="0" <cfif parameterexists(id) and getPopup.showCompanyBox is "0">SELECTED</cfif>>No</option>
            </select>
            </div>
          </div>   
          --->
        <div class="control-group">
          <label class="control-label">Link (optional)</label>
          <div class="controls">
            <input type="text" name="link" <cfif parameterExists(id)>value="#getPopup.link#"</cfif> maxlength="255"/>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label">Link Button Text (optional)</label>
          <div class="controls">
            <input type="text" name="linkText" <cfif parameterExists(id)>value="#getPopup.linkText#"</cfif> maxlength="255"/>
          </div>
        </div>

        <div class="control-group">
          <label class="control-label">Image</label>
          <div class="controls">
            <div class="uploader" id="uniform-undefined">
              <input type="file" size="19" name="photo" style="opacity:0;">
              <span class="filename">No file selected</span>
              <span class="action">Choose File</span>
            </div>
            <cfif parameterexists(id) and len(getPopup.photo)>
              <a href="/images/popups/#getPopup.photo#" target="_blank" class="btn btn-mini btn-info"><i class="icon-eye-open icon-white"></i> View Image</a>
              <a href="submit.cfm?removePhoto=#getPopup.id#" class="btn btn-mini btn-danger"><i class="icon-minus icon-white"></i> Remove Photo</a>
            </cfif>
          </div>
        </div>


				  <div class="form-actions">
					<input type="submit" value="Submit" class="btn btn-primary" name="btnSubmit">
			   </div> 

<!--- Client no longer wants additional fields option MCrouch 3/23/20 --->       
<!---         <div class="control-group">
          <label class="control-label">Add Checkbox Option:</label>
          <div class="controls">
            <input type="text" name="description" maxlength="255" />
            <button type="button" id="addField" class="btn btn-success"><i class="icon-plus icon-white"></i> Add</button>
          </div>
        </div>

        <cfif isdefined('getPopupFields') and getPopupFields.recordcount gt 0>
          
          <cfloop query="getPopupFields">

              <div class="control-group">
                <label class="control-label">Checkbox Text</label>
                <div class="controls">
                  <input type="text" name="description" value="#getPopupFields.description#" maxlength="255" />
                  <button type="button" id="updateField" data-id="#getPopupFields.id#" class="btn btn-success"><i class="icon-plus icon-check"></i> Update</button>
                  <button type="button" id="removeField" data-id="#getPopupFields.id#" class="btn btn-danger"><i class="icon-minus icon-white"></i> Delete</button>
                </div>
              </div>

          </cfloop>

        </cfif> --->


		</form>
				
				
    </div>
  </div>
  
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">