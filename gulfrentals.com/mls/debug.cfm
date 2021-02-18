<cftry>

<!--- Use Get Meta data to grab the info for the query instead of the result

http://www.silverwareconsulting.com/index.cfm/2009/1/20/Capturing-the-SQL-Generated-by-CFQUERY
--->

<cfquery name="qAreas" datasource="mlsv30master">
   select mlsid,wsid,mlsnumber,city from mastertable where
   mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
   and wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="1" >
   and city rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="Shallotte">
   limit 1
</cfquery>

<cfquery name="qAreas1" datasource="mlsv30master">
   select mlsid,wsid,mlsnumber,city from mastertable
   limit 1
</cfquery>

<cfquery name="qAreas2" datasource="mlsv30master" cachedWithin="#Createtimespan(1,0,0,0)#">
   select mlsid,wsid,mlsnumber,city from mastertable limit 5

</cfquery>

<!---
<cfdump var="#qAreas2.getMetaData().getExtendedMetaData()#">
--->
<!--- listFind(list, value [, delimiters, includeEmptyValues])--->
<cfif listFind("68.80.62.233",cgi.remote_addr)>

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

   <h3>Settings:</h3>
   <cfif isDefined("settings")>
      <!---<cfdump var="#settings#">--->
   </cfif>

   <cfoutput>111111(#isQuery(qAreas1)#)</cfoutput>

   <h3> Variables Structure List</h3>
   <cfoutput>#ucase(replace(listSort(structkeylist(variables),"textnocase"),",","<br>","all"))#</cfoutput>
   <!---<h1>breaker 1 9</h1>
   <cfoutput>
      <cfloop list="#ucase(listSort(structkeylist(variables),'textnocase'))#" index="v">
         #v#: <cfdump var="#getMetadata(evaluate(v))#"><br>
      </cfloop>
   </cfoutput>--->



   <h3> SQL Statements</h3>
   <cfloop list="#structkeylist(variables)#" index="v">
      <cfif isQuery(evaluate(v))>
         <cfset MetaData = evaluate(v).getMetaData().getExtendedMetaData()/>
         <cfoutput>
         <code><b>#ucase(v)#</b> (Datasource=??, Time=#Max(metadata.executionTime, 0)#ms , Records=#Max(metadata.recordcount, 0)# Cached Query: #metadata.cached#) in FileName @ #TimeFormat(now(), "HH:mm:ss.SSS")#</code><br />
			<pre>#trim(outputsql(evaluate(v)))#</pre>
         </cfoutput>

         <cfif structKeyExists(MetaData,"SQLParameters")>

         </cfif>
         <hr>
      </cfif>
   </cfloop>


</cfif>




<cffunction name="outputsql" output="true">
  <cfargument name="qry" required="true" type="query">

  <cfset var i = 0/>
  <cfset var MetaData = arguments.qry.getMetaData().getExtendedMetaData()/>
  <cfset var arrQuestionMarks = FindAllDebug("?",MetaData.sql)/>
  <cfset var temp_sql = MetaData.sql/>

  <cfif structKeyExists(MetaData,"SQLParameters")>

    <cfloop from="1" to="#arraylen(arrQuestionMarks)#" index="i">

      <cfset temp_sql = ReplaceAtNoCaseDebug(temp_sql, "?", MetaData.SQLParameters[i], arrQuestionMarks[i])/>

    </cfloop>

    <cfreturn temp_sql>

   <cfelse>

      <cfreturn MetaData.sql/>

    </cfif>


  </cffunction>


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
function findALLDebug(substring,string) {
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


/**
 * Replaces oldSubString with newSubString from a specified starting position while ignoring case.
 *
 * @param theString 	 The string to modify. (Required)
 * @param oldSubString 	  The substring to replace. (Required)
 * @param newSubString 	 The substring to use as a replacement. (Required)
 * @param startIndex 	 Where to start replacing in the string. (Required)
 * @param theScope 	  Number of replacements to make. Default is "ONE". Value can be "ONE" or "ALL." (Optional)
 * @return Returns a string.
 * @author Shawn Seley (shawnse@aol.com)
 * @version 1, June 26, 2002
 */
function ReplaceAtNoCaseDebug(theString, oldSubString, newSubString, startIndex){
	var targetString  = "";
	var preString     = "";

	var theScope      = "ONE";
	if(ArrayLen(Arguments) GTE 5) theScope    = Arguments[5];

	if (startIndex LTE Len(theString)) {
		targetString = Right(theString, Len(theString)-startIndex+1);
		if (startIndex GT 1) preString = Left(theString, startIndex-1);
		return preString & ReplaceNoCase(targetString, oldSubString, newSubString, theScope);
	} else {
		return theString;
	}
}
</cfscript>

<cfcatch><cfdump var="#cfcatch#"></cfcatch></cftry>