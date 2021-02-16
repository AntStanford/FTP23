
<script type="text/javascript">
	$(document).ready(function() {
		$(".fancybox").fancybox();
	});
</script>

<cfquery name="GetStaffCats" datasource="#settings.dsn#">
	SELECT category as TheCategories
	FROM cms_staff_categories
	<cfif page.slug eq 'sales/our-staff'>
		where category = 'Real Estate Sales'
	</cfif>
	order by sort
</cfquery>

<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">

			<cfoutput>#page.body#</cfoutput>

			<div class="staff-detail">

  			<cfloop query="GetStaffCats">

  				<h4><cfoutput>#TheCategories#</cfoutput></h4>

  				<cfquery name="GetStaffers" datasource="#settings.dsn#">
  					SELECT *
  					FROM cms_staff
  					where category = <cfqueryparam value="#GetStaffCats.TheCategories#" cfsqltype="cf_sql_varchar">
  					order by sort, name
  				</cfquery>

  				<cfoutput query="GetStaffers">
  					<Cfset seoname = lcase(replace(name,' ', '', 'all'))>
  					<div>
  						<a hreflang="en" href="/staff-bio/#GetStaffers.id#/#seoname#"><cfif LEN(GetStaffers.photo)><img border="0" src="/images/staff/#photo#"><cfelse><img border="0" src="http://placehold.it/200x150&text=Placeholder"></cfif></a>
  						<strong>#name#</strong>
  						<em>#title#</em>
  						<cfif LEN(GetStaffers.email)><a hreflang="en" href="mailto:#email#" class="nobox">Email</a></cfif>
  						<span><cfif len(phone) lte 4>Ext. </cfif>#phone#</span>
  					</div>
  				</cfoutput>

  			</cfloop>

			</div>

		</div>
	</div>
</div>
