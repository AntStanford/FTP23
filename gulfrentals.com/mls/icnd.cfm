<!---Debugging Dashboard --->

<!--- DO NOT DELETE.  THIS IS A RANDY PET PROJECT, TO GIVE US A DEBUGGING TEMPLATE WITHOUT HAVING DEBUGGING TURNED ON. --->
<textarea><cfoutput>#createtimespan(0,0,2,0)#</cfoutput></textarea>

<cfif listFind("68.80.62.233",cgi.remote_addr)>
  <cfoutput>#settings.mls.mlsid#</cfoutput>
  <cfdump var="#application.settings.mls.minmaxes#">
  <cfdump var="#settings.mls.getmlscoinfo#">

  <cfif isDefined("FORM.FieldNames")>
    <cfoutput>
    <table class="table .table-striped" style="width:800px;">
      <tbody>
        <th><td colspan="2">FORM VARIABLES</td></th>
        <cfloop index="i" list="#Form.FieldNames#" delimiters=",">
          <tr><td>#i#</td><td>#Form[i]#</td></tr>
        </cfloop>
      </tbody>
    </table>
    </cfoutput>
  </cfif>

  <cfif isDefined("URL")>
    <cfoutput>
    <table class="table .table-striped" style="width:800px;">
      <tbody>
        <th><td colspan="2">URL VARIABLES</td></th>
        <cfloop item="key" collection="#URL#">
          <tr><td>#key#</td> <td>#URL[key]#</td></tr>
        </cfloop>
      </tbody>
    </table>
    </cfoutput>
  </cfif>

  <h3>Session<h3>
  <cfif isDefined("session")>
    <cfdump var="#session#" label="session">
  </cfif>

  <h3>Settings:</h3>
  <cfif isDefined("settings")>
    <cfdump var="#settings#">
  </cfif>

  <h3>Variables Structure List</h3>
  <cfoutput>#replace(structkeylist(variables),",","<br>","all")#</cfoutput>
  
  <cfloop list="#structkeylist(variables)#" index="v">
    <cfif isQuery(evaluate(v)) or isStruct(evaluate(v))>
      <cfdump var="#evaluate(v)#" label="#v#">
    </cfif>
  </cfloop>
</cfif>

<cfscript>
/**
 * Finds all occurrences of a substring in a string.
 * Fix by RCamden to make start optional.
 *
 * @param substring 	 String to search for. (Required)
 * @param string 	 String to parse. (Required)
 * @param start 	 Starting position. Defaults to 1. (Optional)
 * @return Returns an array.
 * @author Jeremy Rottman (rottmanj@hsmove.com)
 * @version 2, July 29, 2008
 */
function findALL(substring,string) {
	var findArray = arrayNew(1);
	var start = 1;
	var posStart = "";
	var i = 1;
	var newPos = "";

	if(arrayLen(arguments) gte 3) start = arguments[3];

	posStart = find(substring,string,start);

	if(posStart GT 0){
		findArray[i] = posStart;
		while(posStart gt 0 ){
			posStart = posStart + 1;
			newPos = find(substring,string,posStart);
			if(newPos gt 0){
				i = i + 1;
				findArray[i] = newPos;
				posStart = newPos;
			}else{
				posStart = 0;
			}
		}
	}else{
		return 0;
	}
	return findArray;
}
</cfscript>