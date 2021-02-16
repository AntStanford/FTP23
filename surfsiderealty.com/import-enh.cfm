
<cfquery name="GetEnh" datasource="surfsiderealty">
	Select * from featured_properties
</cfquery>

<cfoutput query="GetEnh">
	<cfquery name="AddEnh" datasource="surfsiderealty2018">
		Insert into cms_property_enhancements (strpropid,featured)
		values ('#strpropid#',1)
	</cfquery>
</cfoutput>
