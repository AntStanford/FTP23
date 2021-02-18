<cfoutput>
  <cfquery name="getcleaningEnhancement" dataSource="#settings.dsn#">
		select cleaning
		from cms_cleaning 
		where id = 1
	</cfquery>
<div id="cleaning" name="cleaning" class="info-wrap cleaning-wrap">
  <div class="info-wrap-heading"><i class="fa fa-align-left" aria-hidden="true"></i> Cleaning</div>
	<div class="info-wrap-body">
  	<div id="cleanBlock" class="clean-block" >#getcleaningEnhancement.cleaning#</div>
  </div><!--- END info-wrap-body --->
</div><!-- END description-wrap -->
</cfoutput>