<cfset page.title ="Display Next Year's Rates">

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('form.submit')>
  <cfquery name="Update" datasource="#settings.dsn#">
  UPDATE cms_nextyear
  SET displayRatesAfterYear = <cfqueryparam value="12/31/#form.displayYear#" cfsqltype="cf_sql_date">
  WHERE id = 1
  </cfquery>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Record updated!</strong>
  </div>
</cfif>

<cfquery name="getinfo" dataSource="#settings.dsn#">
SELECT displayRatesAfterYear
FROM cms_nextyear
WHERE id = 1
</cfquery>


<div class="widget-box">
  <div class="widget-content nopadding">
    <div class="tab-pane active">
      <form action="index.cfm" method="post" class="form-horizontal">
        <div class="tab-content">

          <div class="control-group">
            <label class="control-label">Next Years Rates</label>
            <div class="controls">
              <cfoutput>
              <select name="displayYear" style="width:200px" id="parentID">
               <option value="#Year(DateAdd('yyyy',1,Now()))#" <cfif Year(getinfo.displayRatesAfterYear) GT Year(Now())>selected="selected"</cfif>>Display</option>
               <option value="#Year(Now())#" <cfif Year(getinfo.displayRatesAfterYear) EQ Year(Now())>selected="selected"</cfif>>Hide</option>
              </select>
							</cfoutput>
            </div>
          </div>
          <div class="form-actions">
            <input type="submit" value="Submit" name="submit" id="btnSave" class="btn btn-primary" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<cfinclude template="/admin/components/footer.cfm">