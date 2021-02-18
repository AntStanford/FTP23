<!--- <cfoutput>
	<script src="http://maps.google.com/maps?file=api&v=2&key=#mls.googleAPIKey#&sensor=false" type="text/javascript"></script>
</cfoutput>
   --->
<!--- <div id="map_canvas" style="width:600px;height:450px"></div> --->

<div id="map" style="width:600px;height:450px"></div>
<div id="propertyscroller">
  <p><b>Click on the link below to view the property.</b></p>
  <ol>
    <cfset cnt=0>
    <cfloop query="GetListings">
      <cfset #cnt# = #cnt# + 1>
      <cfoutput>
        <!--- <li><a href="javascript:showPropDetails(prop#cnt#,prop#cnt#Detail);">#Street_Number# #Street_Name# <cfif LEN(unit_number)>#FormatUnit(unit_number)#</cfif>, #city# - $#trim(numberformat(list_price,'999,999,999'))#</a></li> --->
        <li><a id="locationid#currentrow#">#Street_Number# #Street_Name# <cfif LEN(unit_number)>#FormatUnit(unit_number)#</cfif>, #city# - $#trim(numberformat(list_price,'999,999,999'))#</a></li>
      </cfoutput>
    </cfloop>
  </ol>
</div>