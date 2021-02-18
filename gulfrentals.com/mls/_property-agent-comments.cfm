<!--- This is in place for sales reps demo --->
<div class="property-agent-comments">
  <div class="property-agent-comment">
    <p class="h3">Agent's Comments</p>
    
    <cfoutput query="property">
    <cfif isdefined('checkEnhanced.showonwebsite') and isdefined('checkEnhanced.alternatedescription') and checkEnhanced.showonwebsite eq 'Yes' and LEN(checkEnhanced.alternatedescription)>
      <p>#checkEnhanced.alternatedescription#</p>
    <cfelse>
      <p>#remarks#</p>
    </cfif>
    </cfoutput>
    
    <small><i>*Listing provided courtesy of the MLS.</i></small>
  </div>
</div>
