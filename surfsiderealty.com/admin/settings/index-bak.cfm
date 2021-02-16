<cfset page.title ="Settings">
<cfinclude template="/admin/components/header.cfm">
<cfset rootPath = ExpandPath( "../../" ) />

<cfquery name="getBookingSettings" dataSource="#settings.bcDSN#">
  select * from clients where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.booking.id#">
</cfquery>

<cfquery name="getSettings" dataSource="#settings.bcDSN#">
  select * from settings where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
</cfquery>

<cfquery name="getStates" dataSource="#settings.bcDSN#">
  select * from states order by name_long
</cfquery>

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Success!</strong> Your changes have been saved.
  </div>
</cfif>

<cfoutput>
  <div class="widget-box">
    <div class="widget-content nopadding">
      <form action="submit.cfm" method="post" class="form-horizontal">
        <input type="hidden" name="clientid" value="#settings.booking.id#">
        <div class="widget-title">
          <span class="icon">
            <i class="icon-th"></i>
          </span>
          <h5>Homepage Options for the Pre-Footer (choose one for the left column and one for the right column)</h5>
        </div>
        <div class="row-fluid" style="padding:0 20px;box-sizing:border-box;">
          <div class="span6">
            <h4 style="text-align:center;">Left Column</h4>
            <div class="well">
              <cfif FileExists('#adminPath#\testimonials\index.cfm')>	
	              <div class="control-group">
	                <label class="control-label">Random Testimony</label>
	                <div class="controls">
	                  <select name="lc_testimony">
	                    <cfif getSettings.prefooter_left eq 'lc_testimony'>	
	                    		<option value="No">No</option>
	                    		<option value="Yes" selected="selected">Yes</option>
	                    <cfelse>
	                    		<option value="No">No</option>
	                    		<option value="Yes">Yes</option>
	                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
              <cfif FileExists('#adminPath#\events\index.cfm')>
	              <div class="control-group">
	                <label class="control-label">Most Recent Event</label>
	                <div class="controls">
	                  <select name="lc_event">
	                    <cfif getSettings.prefooter_left eq 'lc_event'>	
	                    		<option value="No">No</option>
	                    		<option value="Yes" selected="selected">Yes</option>
	                    <cfelse>
	                    		<option value="No">No</option>
	                    		<option value="Yes">Yes</option>
	                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
              <cfif FileExists('#rootPath#\blog')>
	              <div class="control-group">
	                <label class="control-label">Most Recent Blog Post</label>
	                <div class="controls">
	                  <select name="lc_blog">
	                    <cfif getSettings.prefooter_left eq 'lc_blog'>	
	                    		<option value="No">No</option>
	                    		<option value="Yes" selected="selected">Yes</option>
	                    <cfelse>
	                    		<option value="No">No</option>
	                    		<option value="Yes">Yes</option>
	                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
              <cfif len(settings.twitterURL)>
	              <div class="control-group">
	                <label class="control-label">Most Recent Tweet</label>
	                <div class="controls">	                  
	                   <select name="lc_tweeter">
		                    <cfif getSettings.prefooter_left eq 'lc_tweeter'>	
		                    		<option value="No">No</option>
		                    		<option value="Yes" selected="selected">Yes</option>
		                    <cfelse>
		                    		<option value="No">No</option>
		                    		<option value="Yes">Yes</option>
		                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
            </div>
          </div>
          <div class="span6">
            <h4 style="text-align:center;">Right Column</h4>
            <div class="well">
              <cfif FileExists('#adminPath#\testimonials\index.cfm')>	
	              <div class="control-group">
	                <label class="control-label">Random Testimony</label>
	                <div class="controls">
	                  <select name="rc_testimony">
	                    <cfif getSettings.prefooter_right eq 'rc_testimony'>	
	                    		<option value="No">No</option>
	                    		<option value="Yes" selected="selected">Yes</option>
	                    <cfelse>
	                    		<option value="No">No</option>
	                    		<option value="Yes">Yes</option>
	                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
              <cfif FileExists('#adminPath#\events\index.cfm')>
	              <div class="control-group">
	                <label class="control-label">Most Recent Event</label>
	                <div class="controls">
	                  <select name="rc_event">
	                    <cfif getSettings.prefooter_right eq 'rc_event'>	
	                    		<option value="No">No</option>
	                    		<option value="Yes" selected="selected">Yes</option>
	                    <cfelse>
	                    		<option value="No">No</option>
	                    		<option value="Yes">Yes</option>
	                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
              <cfif FileExists('#rootPath#\blog')>
	              <div class="control-group">
	                <label class="control-label">Most Recent Blog Post</label>
	                <div class="controls">
	                  <select name="rc_blog">
	                    <cfif getSettings.prefooter_right eq 'rc_blog'>	
	                    		<option value="No">No</option>
	                    		<option value="Yes" selected="selected">Yes</option>
	                    <cfelse>
	                    		<option value="No">No</option>
	                    		<option value="Yes">Yes</option>
	                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
              <cfif len(settings.twitterURL)>
	              <div class="control-group">
	                <label class="control-label">Most Recent Tweet</label>
	                <div class="controls">	                  
	                  <select name="rc_tweeter">
	                    <cfif getSettings.prefooter_right eq 'rc_tweeter'>	
	                    		<option value="No">No</option>
	                    		<option value="Yes" selected="selected">Yes</option>
	                    <cfelse>
	                    		<option value="No">No</option>
	                    		<option value="Yes">Yes</option>
	                    </cfif>
	                  </select>
	                </div>
	              </div>
              </cfif>
            </div>
          </div>
        </div>
        <!--- Only give this option to PP+ users - their PMS allows them to pass an override amount --->
        <cfif settings.booking.pms eq 'Homeaway'>
          <div class="widget-title">
            <span class="icon">
              <i class="icon-th"></i>
            </span>
            <h5>Booking Engine</h5>
          </div>
          <div class="control-group">
            <label class="control-label">Future Rez Fee</label>
            <div class="controls">
              <div class="input-prepend">
                <span class="add-on">$</span>
                <input data-type="company" name="future_rez_fee" type="text" value="#getBookingSettings.future_rez_fee#" />
              </div>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">Future Rez Year</label>
            <div class="controls">
              <input data-type="company" name="future_rez_year" type="text" value="#getBookingSettings.future_rez_year#" />
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">Future Rez Fee Status</label>
            <div class="controls">
              <select name="future_rez_status">
                <option <cfif getBookingSettings.future_rez_status eq 'OFF'>selected</cfif>>OFF</option>
                <option <cfif getBookingSettings.future_rez_status eq 'ON'>selected</cfif>>ON</option>
              </select>
            </div>
          </div>
        </cfif>
        <div class="widget-title">
          <span class="icon">
            <i class="icon-th"></i>
          </span>
          <h5>Physical Address</h5>
        </div>
        <div class="control-group">
          <label class="control-label">Street Address</label>
          <div class="controls">
            <input id="settings-streetAddress" name="address" type="text" value="#getSettings.address#" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Street Address 2</label>
          <div class="controls">
            <input id="settings-streetAddress2" name="address2" type="text" value="#getSettings.address2#" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">City</label>
          <div class="controls">
            <input id="settings-city" name="city" type="text" value="#getSettings.city#" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">State</label>
          <div class="controls">
            <select id="settings-state" name="state" style="width:200px">
              <cfloop query="getStates">
                <option value="#name_short#" <cfif getSettings.state eq #name_short#>selected="selected"</cfif>>#name_long#</option>
              </cfloop>
            </select>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Zip Code</label>
          <div class="controls">
            <input data-type="zipcode" id="settings-zip" name="zip" type="text" value="#getSettings.zip#" />
          </div>
        </div>
        <div class="widget-title">
          <span class="icon">
            <i class="icon-th"></i>
          </span>
          <h5>Phone Numbers</h5>
        </div>
        <div class="control-group">
          <label class="control-label">Primary Telephone</label>
          <div class="controls">
            <input data-type="telephone" id="settings-contactPhone" name="phone" type="text" value="#getSettings.phone#" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Fax Number</label>
          <div class="controls">
            <input data-type="telephone" id="settings-contactFax" name="fax" type="text" value="#getSettings.fax#" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Toll Free Number</label>
          <div class="controls">
            <input data-type="telephone" id="settings-contactTollFree" name="tollFree" type="text" value="#getSettings.tollFree#" />
          </div>
        </div>
        <div class="widget-title">
          <span class="icon">
            <i class="icon-th"></i>
          </span>
          <h5>SEO Meta Defaults</h5>
        </div>
        <div class="control-group">
          <label class="control-label">Meta Title</label>
          <div class="controls">
            <input id="settings-pageTitleDefault" name="metaTitle" type="text" value="#getSettings.metaTitle#" size="50" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Meta Description</label>
          <div class="controls">
            <input id="settings-pageTitleDefault" name="metaDescription" type="text" value="#getSettings.metaDescription#" size="50" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Meta Keywords</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="metaKeywords" type="text" value="#getSettings.metaKeywords#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Google Analytics</label>
          <div class="controls">
            <textarea class="mceNoEditor" id="settings-googleAnalytics" name="googleAnalytics" style="width:450px">#getSettings.googleAnalytics#</textarea>
          </div>
        </div>
        <div class="widget-title">
          <span class="icon">
            <i class="icon-th"></i>
          </span>
          <h5>Social Media URLs</h5>
        </div>
        <div class="control-group">
          <label class="control-label">Facebook</label>
          <div class="controls">
            <input id="settings-pageTitleDefault" name="facebookURL" type="text" value="#getSettings.facebookURL#" size="50" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Twitter</label>
          <div class="controls">
            <input id="settings-pageTitleDefault" name="twitterURL" type="text" value="#getSettings.twitterURL#" size="50" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Pinterest</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="pinterestURL" type="text" value="#getSettings.pinterestURL#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Youtube</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="youtubeURL" type="text" value="#getSettings.youtubeURL#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">LinkedIn</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="linkedInURL" type="text" value="#getSettings.linkedInURL#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Instagram</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="instagramURL" type="text" value="#getSettings.instagramURL#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Google+</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="googlePlusURL" type="text" value="#getSettings.googlePlusURL#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Yelp</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="yelpURL" type="text" value="#getSettings.yelpURL#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Blog</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="blogURL" type="text" value="#getSettings.blogURL#" size="75" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label">Flickr</label>
          <div class="controls">
            <input id="settings-pageKeywordsDefault" name="flickrURL" type="text" value="#getSettings.flickrURL#" size="75" />
          </div>
        </div>
        <div class="form-actions">
          <input type="submit" value="Save Settings" name="submit" class="btn btn-primary">
        </div>
      </form>
    </div>
  </div>
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">