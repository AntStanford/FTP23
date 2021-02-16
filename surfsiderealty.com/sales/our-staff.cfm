<CFQUERY NAME="getinfo" DATASOURCE="#settings.dsn#" >
SELECT *
FROM CL_pagetext
where id = '12'
</CFQUERY>

<cfinclude template="/sales/components/header.cfm">

<script type="text/javascript">
	$(document).ready(function() {
		$(".fancybox").fancybox();
	});
</script>

<CFQUERY NAME="GetStaffCats" DATASOURCE="#settings.dsn#">
	SELECT distinct category as TheCategories
	FROM cl_staff
	where category='Real Estate Sales'
	order by field(category,'Beach Vacations','Real Estate Sales','Association Management','Accounting','Home Services & Maintenance','Pools & Landscaping')

</CFQUERY>

<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">

			<cfoutput>#getinfo.pagetext#</cfoutput>

			<div class="staff-detail">

			<cfloop query="GetStaffCats">

				<h4><cfoutput>#TheCategories#</cfoutput></h4>

				<CFQUERY NAME="GetStaffers" DATASOURCE="#settings.dsn#">
					SELECT *
					FROM cl_staff
					where category = 'Real Estate Sales'
					order by stafflastname,staffname
				</CFQUERY>

				<cfoutput query="GetStaffers">
					<div>
						<a hreflang="en" href="/bio.cfm?id=#GetStaffers.id#"><cfif LEN(GetStaffers.staffphoto)><img border="0" src="/images/staff/#staffphoto#"><cfelse><img border="0" src="http://placehold.it/200x150&text=Placeholder"></cfif></a>
						<strong>#staffname# #stafflastname#</strong>
						<em>#stafftitle#</em>
						<cfif LEN(GetStaffers.staffemail)><a hreflang="en" href="mailto:#staffemail#" class="nobox">Email</a></cfif>
						<span><cfif len(staffphone) lte 4>Ext. </cfif>#staffphone#</span>
					</div>
				</cfoutput>

			</cfloop>

			</div>

		</div>
	</div>
</div>

<cfinclude template="/sales/components/footer.cfm">