<cfset page.title ="Terms">

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('form.submit')>
  <cfquery name="Update" datasource="#settings.dsn#">
    Update cms_terms
    set terms = <cfqueryparam cfsqltype="cf_sql_clob" value="#form.terms#">
  </cfquery>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Record updated!</strong>
  </div>
</cfif>

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_terms
</cfquery>


<div class="widget-box">
  <div class="widget-content nopadding">
    <div class="tab-pane active">
      <form action="index.cfm" method="post" class="form-horizontal" enctype="multipart/form-data">
        <div class="tab-content">
          <div class="control-group">
            <div class="controls">
              <textarea name="terms"><cfoutput>#getinfo.terms#</cfoutput></textarea>
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