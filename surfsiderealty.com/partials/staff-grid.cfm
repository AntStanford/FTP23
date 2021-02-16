<style>
.cms-staff-option-2 {margin-bottom: 15px;}
.cms-staff-option-2 strong, .cms-staff-option-2 em, .cms-staff-option-2 a, .cms-staff-option-2 span {display: block; text-align: center;}
.cms-staff-option-2 h3 {margin-top: 20px; padding-top: 15px; clear: both;}
.cms-staff-option-2 h4:first-child {border: none;}
.cms-staff-option-2 div a {margin-bottom: 10px; padding: 7px; border-radius: 5px; /*box-shadow: 0 0 5px -1px rgba(0,0,0,0.5);*/}
.cms-staff-option-2 div a.nobox {/*box-shadow:0 0 0 0;*/ border-radius:0; margin-bottom:0; padding:0;}
.cms-staff-option-2 div img {width: 100%; max-width: 300px;}
.cms-staff-option-2 div span {font-weight: bold;}
</style>

<cfcache key="cms_staff" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">

	<cfquery name="getinfo" dataSource="#settings.dsn#">
	  select * from cms_staff order by sort
	</cfquery>

	<cfif getinfo.recordcount gt 0>

		<div class="row cms-staff-option-2">

			<cfoutput query="getinfo">
				<div class="col-xs-12 col-sm-3">
					<div>
						<cfset cleanName = replace(name,' ','-','all')>
		            <a hreflang="en" href="/staff/#cleanName#/#id#">
			            <cfif len(photo)>
			              <img src="/images/staff/#photo#" width="100" alt="#name#">
			            <cfelse>
			              <img src="http://www.icoastalnet.com/images/employees/missing-male.jpg" width="100" alt="#name#">
			            </cfif>
		            </a>
						<strong><a hreflang="en" href="/staff/#cleanName#/#id#">#name#</a></strong>
						<em>#title#</em>						
					</div>
				</div>
			</cfoutput>
		</div>

	</cfif>

</cfcache>