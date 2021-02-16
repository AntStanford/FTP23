<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>

<cfparam name="wsid" default="">

<link href="/stylesheets/screen.css" media="screen, projection" rel="stylesheet" type="text/css">
<link href="/mls/stylesheets/mls.css" rel="stylesheet" type="text/css">
<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">


<div id="boxbody">



<div id="mls-wrapper">
<div id="content" class="full-width">
  <div class="mls-advanced-search">

<!--- Process form --->
<cfif cgi.request_method eq "post">
 <cfinclude template="saved-search_.cfm">
</cfif>

    <form class="mls-search-form enhanced-form" method="POST" id="advancedsearchform">
		<cfoutput>
			<input type="hidden" value="#url.id#" name="clientid">
			<input type="hidden" value="#mls.mlsid#" name="mlsid"/>
		</cfoutput>

     <script type="text/javascript">
        var isChecked = false;

       function SelectAllAreas() 
        {
            // this line is for toggle the check
            isChecked = !isChecked;
            //below line refers to 'jpCheckbox' class
            $('input:checkbox.AllHHI').attr('checked',isChecked);
            $('input:checkbox.AllBluff').attr('checked',isChecked);
            $('input:checkbox.AllOther').attr('checked',isChecked);
        }


        function SelectAllHHI() 
        {
            // this line is for toggle the check
            isChecked = !isChecked;
            //below line refers to 'jpCheckbox' class
            $('input:checkbox.AllHHI').attr('checked',isChecked);
        }

                var isChecked = false;
        function SelectAllBluff() 
        {
            // this line is for toggle the check
            isChecked = !isChecked;
            //below line refers to 'jpCheckbox' class
            $('input:checkbox.AllBluff').attr('checked',isChecked);
        }
    </script>
      
      <div class="area-selection">     
        <h3>Area Selections</h3>        
        
        <table width="100%">
          <tr>
            <td><input type="checkbox" name="AllArea" onclick="SelectAllAreas()"> <label>All Areas</label></td>
            <td><input type="checkbox" name="area" class="AllBluff" value="333" > <label for="333">Belfair Plantation</td>
            <td><input type="checkbox" name="area" class="AllBluff" value="341"> <label for="341">Hampton Hall </td>
            <td><input type="checkbox" name="area" class="AllHHI" value="330"> <label for="330">Palmetto Hall</td>
          </tr>
          <tr><!--- 999999,314,329,321,327,324,342,346,328,347,330,315,331,316,317 --->
            <td><input type="checkbox" name="AllHHI" class="AllHHI" onclick="SelectAllHHI()"> <label>Hilton Head Only</label></td>
            <td><input type="checkbox" name="area" class="AllBluff" value="335"> <label for="335">Berkeley Hall</td>
            <td><input type="checkbox" name="area" class="AllHHI" value="317" > <label for="317">HH / Off Plantation</td>
            <td><input type="checkbox" name="area" class="AllHHI" value="347"> <label for="347">Port Royal</td>
          </tr>
          <tr><!--- 999999,333,335,319,322,332,325,318,341,1630,1632,320,338,336,334,339,337 --->
            <td><input type="checkbox" name="AllBluff" class="AllBluff" onclick="SelectAllBluff()"> <label>Bluffton - Mainland Only</label></td>
            <td><input type="checkbox" name="area" class="AllBluff" value="319"> <label for="319">Bluffton / Off Plantation </td>
            <td><input type="checkbox" name="area" class="AllHHI" value="329"> <label for="329">Hilton Head Plantation</td>
            <td><input type="checkbox" name="area" class="AllBluff" value="334" > <label for="334">Rose Hill</td>
          </tr>
          <tr>
            <td></td>
            <td><input type="checkbox" name="area" class="AllOther" value="29"> <label for="29">Brays Island</td>
            <td><input type="checkbox" name="area" class="AllHHI" value="315" > <label for="315">Indigo Run</td>
            <td><input type="checkbox" name="area" class="AllHHI" value="314"> <label for="314">Sea Pines</td>
          </tr>
          <tr>
            <td></td>
            <td><input type="checkbox" name="area" class="AllBluff" value="322"> <label for="322">Callawassie Island</td>
            <td><input type="checkbox" name="area" class="AllOther" value="343"> <label for="343">Jasper County </td>
            <td><input type="checkbox" name="area" class="AllHHI" value="324"> <label for="324">Shipyard Plantation</td>
          </tr>
          <tr>
            <td></td>
            <td><input type="checkbox" name="area" class="AllBluff" value="332"> <label for="332">Colleton River </td>
            <td><input type="checkbox" name="area" class="AllHHI" value="346"> <label for="346">Long Cove</td>
            <td><input type="checkbox" name="area" class="AllHHI" value="331"> <label for="331">Spanish Wells</td>
          </tr>
          <tr>
            <td></td>
            <td><input type="checkbox" name="area" class="AllBluff" value="325"> <label for="325">Dataw Island</td>
            <td><input type="checkbox" name="area" class="AllBluff" value="320"> <label for="320">Moss Creek Plantation</td>
            <td><input type="checkbox" name="area" class="AllBluff" value="339"> <label for="339">Spring Island</td>
          </tr>
          <tr>
            <td></td>
            <td><input type="checkbox" name="area" class="AllBluff" value="318"> <label for="318">Daufuskie Island</td>
            <td><input type="checkbox" name="area" class="AllBluff" value="338"> <label for="338">Oldfield Plantation</td>
            <td><input type="checkbox" name="area" class="AllBluff" value="337"> <label for="337">Sun City Hilton Head </td>
          </tr>
          <tr>
            <td></td>
            <td><input type="checkbox" name="area" class="AllHHI" value="328"> <label for="328">Folly Field </td>
            <td><input type="checkbox" name="area" class="AllBluff" value="336"> <label for="336">Palmetto Bluff</td>
            <td><input type="checkbox" name="area" class="AllHHI" value="342"> <label for="342">Wexford </td>
          </tr>
          <tr>
            <td></td>
            <td><input type="checkbox" name="area" class="AllHHI" value="321"> <label for="321">Forest Beach </td>
            <td><input type="checkbox" name="area" class="AllHHI" value="327"> <label for="327">Palmetto Dunes / Shelter Cove</td>
            <td><input type="checkbox" name="area" class="AllHHI" value="316"> <label for="316">Windmill Harbour </td>
          </tr>
          
        </table>

      </div>

      <div style="width:49%;margin:0 1% 0 0;float:left;text-align: left;">
      
          <div class="area-selection property-type" style="clear:none;">
            <cfquery name="getmlscoinfo" datasource="#DSNMLS#">
              SELECT *
              FROM mlsfeeds
              where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
            </cfquery>
            <h3>Property Type</h3>
            <ul class="property-type">
              <cfloop index="i" list="#mls.property_type_order#"><!--- #getmlscoinfo.wsid# --->
                <cfoutput>
                  <li><input type="checkbox" name="wsid" id="wsid" value="#listgetat(i,'1','~')#" <cfif isdefined('form.wsid') and form.WSID is "#listgetat(i,'1','~')#">checked</cfif>> <label for="#listgetat(i,'2','~')#">#listgetat(i,'2','~')#</label></li>
                </cfoutput>
              </cfloop>          
              <li><input id="stipulation-foreclosure" name="foreclosure" type="checkbox" value="foreclosure"/> <label for="stipulation-foreclosure">Foreclosures</label></li>
              <li><input id="stipulation-short-sale" name="shortsale" type="checkbox" value="shortsale"/> <label for="stipulation-short-sale">Short Sales</label></li>
              <li></li>
            </ul>
            
            
        <h3>View Options</h3>        
                
        <ul class="view-options">
          <li><input type="checkbox" name="lot_description" value="Ocean Front" <cfif isdefined('form.lot_description') and form.lot_description contains "Ocean Front">checked</cfif>> <label>Ocean Front</label></li>
          <li><input type="checkbox" name="lot_description" value="Ocean View" <cfif isdefined('form.lot_description') and form.lot_description contains "Ocean View">checked</cfif>> <label>Ocean View</label></li>
          <li><input type="checkbox" name="lot_description" value="2nd-12th Row" <cfif isdefined('form.lot_description') and form.lot_description contains "2nd-12th Row">checked</cfif>> <label>Near Beach</label></li>
          <li><input type="checkbox" name="lot_description" value="Creek/River" <cfif isdefined('form.lot_description') and form.lot_description contains "Creek/River">checked</cfif>> <label>Creek/River</label></li>
          <li><input type="checkbox" name="lot_description" value="Deep Water" <cfif isdefined('form.lot_description') and form.lot_description contains "Deep Water">checked</cfif>> <label>Deep Water</label></li>
          <li><input type="checkbox" name="lot_description" value="Golf" <cfif isdefined('form.lot_description') and form.lot_description contains "Golf">checked</cfif>> <label>Golf</label></li>
          <li><input type="checkbox" name="lot_description" value="Harbor" <cfif isdefined('form.lot_description') and form.lot_description contains "Harbor">checked</cfif>> <label>Harbor</label></li>
          <li><input type="checkbox" name="lot_description" value="Lagoon" <cfif isdefined('form.lot_description') and form.lot_description contains "Lagoon">checked</cfif>> <label>Lagoon</label></li>
          <li><input type="checkbox" name="lot_description" value="Lake" <cfif isdefined('form.lot_description') and form.lot_description contains "Lake">checked</cfif>> <label>Lake</label></li>
          <li><input type="checkbox" name="lot_description" value="Landscape" <cfif isdefined('form.lot_description') and form.lot_description contains "Landscape">checked</cfif>> <label>Landscape</label></li>
          <li><input type="checkbox" name="lot_description" value="Marsh" <cfif isdefined('form.lot_description') and form.lot_description contains "Marsh">checked</cfif>> <label>Marsh</label></li>          
          <li><input type="checkbox" name="lot_description" value="Pool" <cfif isdefined('form.lot_description') and form.lot_description contains "Pool">checked</cfif>> <label>Pool View</label></li>
          <li><input type="checkbox" name="lot_description" value="Sound" <cfif isdefined('form.lot_description') and form.lot_description contains "Sound">checked</cfif>> <label>Sound</label></li>
        </ul> 
        
          </div>
 
      </div>
      
     
      <div class="area-selection nolo" style="width:50%;float:left;clear:none;">
        <h3>Property Features</h3>
        <span class="grphead">Price Range</span>
        <div class="form-field">
          <label for="pmin">Minimum Price
          <select id="pmin" name="pmin">
            <option value="0" <cfif isdefined('PMIN') is "No">selected</cfif>>No Min</option>
            <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
              <cfoutput>
                <option value="#i#" <cfif isdefined('form.PMIN') and form.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#" <cfif isdefined('form.PMIN') and form.pmin is "#i#">selected</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                </cfloop>
                <cfbreak>
              </cfif>
            </cfloop>
          </select></label>
        </div>
        <div class="form-field">
          <label for="pmax">Maximum Price
          <select id="pmax" name="pmax">
             <option value="999999999" <cfif isdefined('form.PMAX') is "No" or form.PMAX eq "999999999">selected="selected"</cfif>>No Max</option>
            <cfloop index="i" from="#mls.pricerangemin#" to="#mls.pricerangemax#" step="#mls.incrementpricerange#">
              <cfoutput>
                <option value="#i#" <cfif isdefined('form.PMAX') and form.pmax is "#i#">selected="selected"</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
              </cfoutput>
              <cfif #i# eq "1000000">
                <cfloop index="i" from="1500000" to="#mls.pricerangemax#" step="#mls.incrementpricerangemillion#">
                  <cfoutput>
                    <option value="#i#" <cfif isdefined('form.PMAX') and form.pmax is "#i#">selected="selected"</cfif>>$#trim(numberformat(i,'__,___,___'))#</option>
                  </cfoutput>
                </cfloop>
                <cfbreak>
              </cfif>
            </cfloop>
           
          </select></label>
        </div>
        <span class="grphead">Bedrooms</span>
        <div class="form-field">
          <label for="bedrooms">Bedrooms
          <select data-wsid="1" id="bedrooms" name="bedrooms">
            <option selected="selected" value="">No Preference</option>
            <option value="1" <cfif isdefined('form.bedrooms') and form.bedrooms is "1">selected="selected"</cfif>>1 Bedroom(s)</option>
              <option value="2" <cfif isdefined('form.bedrooms') and form.bedrooms is "2">selected="selected"</cfif>>2 Bedroom(s)</option>
              <option value="3" <cfif isdefined('form.bedrooms') and form.bedrooms is "3">selected="selected"</cfif>>3 Bedroom(s)</option>
        <option value="3+" <cfif isdefined('form.bedrooms') and form.bedrooms is "3+">selected="selected"</cfif>>3+ Bedroom(s)</option>
              <option value="4" <cfif isdefined('form.bedrooms') and form.bedrooms is "4">selected="selected"</cfif>>4 Bedroom(s)</option>
        <option value="4+" <cfif isdefined('form.bedrooms') and form.bedrooms is "4+">selected="selected"</cfif>>4+ Bedroom(s)</option>
              <option value="5" <cfif isdefined('form.bedrooms') and form.bedrooms is "5">selected="selected"</cfif>>5 Bedroom(s)</option>
        <option value="5+" <cfif isdefined('form.bedrooms') and form.bedrooms is "5+">selected="selected"</cfif>>5+ Bedroom(s)</option>
              <option value="6" <cfif isdefined('form.bedrooms') and form.bedrooms is "6">selected="selected"</cfif>>6 Bedroom(s)</option>
        <option value="6+" <cfif isdefined('form.bedrooms') and form.bedrooms is "6+">selected="selected"</cfif>>6+ Bedroom(s)</option>
          </select></label>
        </div>
        <div class="form-field">
          <label for="baths_full">Bathrooms
          <select data-wsid="1" id="baths_full" name="baths_full">
            <option selected="selected" value="">No Preference</option>
            <option value="1" <cfif isdefined('form.baths_full') and form.baths_full is "1">selected="selected"</cfif>>1 Bathroom(s)</option>
              <option value="2" <cfif isdefined('form.baths_full') and form.baths_full is "2">selected="selected"</cfif>>2 Bathroom(s)</option>
              <option value="3" <cfif isdefined('form.baths_full') and form.baths_full is "3">selected="selected"</cfif>>3 Bathroom(s)</option>
              <option value="4" <cfif isdefined('form.baths_full') and form.baths_full is "4">selected="selected"</cfif>>4 Bathroom(s)</option>
              <option value="5" <cfif isdefined('form.baths_full') and form.baths_full is "5">selected="selected"</cfif>>5 Bathroom(s)</option>
          </select></label>
        </div>
        <span class="grphead">Days on Market</span>
        <div class="form-field">
          <label for="DaysOnMarket" style="width:98%">Days
          <select id="DaysOnMarket" name="DaysOnMarket">
            <option selected="selected" value="">All Days</option>
            <option value="-1" <cfif isdefined('form.numericaldaysonmarket') and form.numericaldaysonmarket is "-1">selected</cfif>>Since Yesterday</option>
            <option value="-3" <cfif isdefined('form.numericaldaysonmarket') and form.numericaldaysonmarket is "-3">selected</cfif>>Less than 3 Days</option>
            <option value="-7" <cfif isdefined('form.numericaldaysonmarket') and form.numericaldaysonmarket is "-7">selected</cfif>>Less than 7 days</option>
            <option value="-14" <cfif isdefined('form.numericaldaysonmarket') and form.numericaldaysonmarket is "-14">selected</cfif>>Less than 14 days</option>
            <option value="-30" <cfif isdefined('form.numericaldaysonmarket') and form.numericaldaysonmarket is "-30">selected</cfif>>Less than 30 days</option>
            <option value="-60" <cfif isdefined('form.numericaldaysonmarket') and form.numericaldaysonmarket is "-60">selected</cfif>>Less than 60 days</option>
          </select></label>
        </div>
        <span class="grphead">Sq. Footage</span>
        <div class="form-field">
          <label for="SQFtMin">Sq. Footage
          <select id="SQFtMin" name="SQFtMin">
            <option selected="selected" value="0">Min</option>
            <cfloop index="i" from="500" to="5000" step="500">
              <cfoutput>
                <option value="#i#" <cfif isdefined('form.SQFtMin') and form.SQFtMin is "#i#">selected</cfif>>#i#</option>
              </cfoutput>
            </cfloop>
            <option value="999999" <cfif isdefined('form.SQFtMin') and form.SQFtMin is "999999">selected</cfif>>5000+</option>
          </select></label>
        </div>
        <div class="form-field">
          <label for="SQFtMax">Sq. Footage
          <select id="SQFtMax" name="SQFtMax">
            <option selected="selected" value="999999999">Max</option>
            <cfloop index="i" from="500" to="5000" step="500">
              <cfoutput>
                <option value="#i#" <cfif isdefined('form.SQFtMax') and form.SQFtMax is "#i#">selected</cfif>>#i#</option>
              </cfoutput>
            </cfloop>
            <option value="999999" <cfif isdefined('form.SQFtMax') and form.SQFtMax is "999999">selected</cfif>>5000+</option>
          </select></label>
        </div>  
        <span class="grphead">Other</span>
        <div class="ticks">
          <input type="checkbox" name="lot_description" value="garage" <cfif isdefined('form.lot_description') and form.lot_description contains "garage">checked</cfif>> <label>Garage</label>
          <input type="checkbox" name="lot_description" value="pool" <cfif isdefined('form.lot_description') and form.lot_description contains "pool">checked</cfif>> <label>Pool</label>
          <input type="checkbox" name="lot_description" value="gated community" <cfif isdefined('form.lot_description') and form.lot_description contains "gated community">checked</cfif>> <label>Gated Community</label>     
        </div>
        <span class="grphead">Sort By</span>
                   <select id="sortby" name="sortby">
                <option value="list_price DESC" <cfif isdefined('form.sortby') and form.sortby is "list_price DESC">selected</cfif>>Price (High to Low)</option>
                <option value="list_price ASC" <cfif isdefined('form.sortby') and form.sortby is "list_price ASC">selected</cfif>>Price (Low to High)</option>
                <option value="bedrooms DESC" <cfif isdefined('form.sortby') and form.sortby is "bedrooms DESC">selected</cfif>>Bedrooms</option>
                <option value="baths_full DESC" <cfif isdefined('form.sortby') and form.sortby is "baths_full DESC">selected</cfif>>Bathrooms</option>
                <option value="created_at DESC" <cfif isdefined('form.sortby') and form.sortby is "created_at DESC">selected</cfif>>Listing Date (Old to New)</option>
                <option value="created_at ASC" <cfif isdefined('form.sortby') and form.sortby is "created_at ASC">selected</cfif>>Listing Date (New to Old)</option>
              </select>
      </div>
        
      <div style="clear:both"></div>

		<div style="width:100%;">
		      <div class="area-selection nolo sort-by" style="clear:none;width:100%;">      
				<h3>Notification Settings</h3>
		      
			        <div class="save-search-box" style="width: 60%;position: relative;left: 22%;">
				          <div style="float:left;width:49%;">
				            <input type="text" value="Search Title" name="searchname" id="savesearchname">
				          </div>

						 <div class="how-often-box">
							<select name="HowOften"  id="savesearchselect">
							<option value="0">No Email</option>
							<option value="1">Daily Updates</option>     
							<option value="7" selected>Weekly</option>
							<option value="14">Bi-Weekly</option>
							<option value="30">Monthly</option>
							</select>
						</div>

			       </div>
			   </div>       
		</div>

     <div style="clear:both"></div>

      <div class="run-search">
        
        <h3>Finish </h3>
        
        <div class="search-reset" style="position: relative;left:25%;width:50%;">
          <input type="reset" class="button light" style="height:35px;padding:8px 8px 7px;border:none;" value="Reset Search">
        <input type="submit" value="Save Search" class="button" style="height:40px;font-size:14px;">

        </div>


        </div>
        
        <style>
        #savesearchselect_chzn{position:relative;height:37px}
        #savesearchselect_chzn a.chzn-single{height:35px}
        #savesearchselect_chzn a.chzn-single span{position:relative;top:5px;left:3px}
        #savesearchselect_chzn a.chzn-single div b{position:relative;top:5px}
        </style>
  
     </div>
        
    </form>
  </div>
</div>
</div><!--- mls-wrapper--->


</div> <!--- boxbody --->