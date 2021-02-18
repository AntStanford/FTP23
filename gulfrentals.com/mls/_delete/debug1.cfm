<cftry>

<cfquery name="qAreas" datasource="mlsv30master" result="getAreasResult">
   select mlsid,wsid,mlsnumber,city from mastertable where
   mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
   and wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="1" >
   and city rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="Shallotte">
   limit 1
</cfquery>

<cfquery name="qAreas1" datasource="mlsv30master" result="getAreasResult1">
   select mlsid,wsid,mlsnumber,city from mastertable
   limit 1
</cfquery>



<cfdump var=#getAreasResult#>




<cfoutput>
#outputsql(getAreasResult)# <br>
#outputsql(getAreasResult1)# <br>
</cfoutput>


<cffunction name="outputsql" output="true">
   <cfargument name="qResult" required="true">

   <cfset var temp_sql = arguments.qResult.sql>
   <cfset var index="i">

   <cfset var arrQuestionMarks = findAll("?",arguments.qResult.sql)>

   <cfif structKeyExists(arguments.qResult,"SQLParameters")>
      <cfloop from="1" to="#arrayLen(arrQuestionMarks)#" index="i">
         <cfset temp_sql = ReplaceAtNoCase(temp_sql, "?", "'" & arguments.qResult.sqlParameters[i] & "'", arrQuestionMarks[i])>
      </cfloop>

      <cfreturn temp_sql>

   <cfelse>
      <cfreturn arguments.qResult.sql>
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
function ReplaceAtNoCase(theString, oldSubString, newSubString, startIndex){
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