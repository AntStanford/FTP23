<cfscript>
/**
 * Removes HTML from the string.
 * v2 - Mod by Steve Bryant to find trailing, half done HTML.
 * v4 mod by James Moberg - empties out script/style blocks
 *
 * @param string      String to be modified. (Required)
 * @return Returns a string.
 * @author Raymond Camden (ray@camdenfamily.com)
 * @version 4, October 4, 2010
 */

 if (structKeyExists(variables,"stripHTML") is "No") {

   function stripHTML(str) {
       str = reReplaceNoCase(str, "<*style.*?>(.*?)</style>","","all");
       str = reReplaceNoCase(str, "<*script.*?>(.*?)</script>","","all");

       str = reReplaceNoCase(str, "<.*?>","","all");
       //get partial html in front
       str = reReplaceNoCase(str, "^.*?>","");
       //get partial html at end
       str = reReplaceNoCase(str, "<.*$","");
       return trim(str);
   }

 }


</cfscript>

<cfscript>
/**
 * Makes a row of a query into a structure.
 *
 * @param query 	 The query to work with.
 * @param row 	 Row number to check. Defaults to row 1.
 * @return Returns a structure.
 * @author Nathan Dintenfass (nathan@changemedia.com)
 * @version 1, December 11, 2001
 */
function queryRowToStruct(query){
	//by default, do this to the first row of the query
	var row = 1;
	//a var for looping
	var ii = 1;
	//the cols to loop over
	var cols = listToArray(query.columnList);
	//the struct to return
	var stReturn = structnew();
	//if there is a second argument, use that for the row number
	if(arrayLen(arguments) GT 1)
		row = arguments[2];
	//loop over the cols and build the struct from the query row
	for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
		stReturn[cols[ii]] = query[cols[ii]][row];
	}
	//return the struct
	return stReturn;
}
</cfscript>

<cfscript>
/**
* Returns the substring of a string. It mimics the behaviour of the homonymous php function so it permits negative indexes too.
*
* @param buf The string to parse. (Required)
* @param start The start position index. If negative, counts from the right side. (Required)
* @param length Number of characters to return. If not passed, returns from start to end (if positive start value). (Optional)
* @return Returns a string.
* @author Rudi Roselli Pettazzi (&#114;&#104;&#111;&#100;&#105;&#111;&#110;&#64;&#116;&#105;&#115;&#99;&#97;&#108;&#105;&#110;&#101;&#116;&#46;&#105;&#116;)
* @version 2, July 2, 2002
*/
function SubStr(buf, start) {
// third argument (optional)
var length = 0;
var sz = 0;

sz = len(buf);

if (arrayLen(arguments) EQ 2) {

if (start GT 0) {
length = sz;
} else if (start LT 0) {
length = sz + start;
start = 1;
}

} else {

length = Arguments[3];
if (start GT 0) {
if (length LT 0) length = 1+sz+length-start;
} else if (start LT 0) {
if (length LT 0) length = length-start;
start = 1+sz+start;

}
}

if (isNumeric(start) AND isNumeric(length) AND start GT 0 AND length GT 0) return mid(buf, start, length);
else return "";
}
</cfscript>

<cfscript>

/**
 * Converts a structure to a URL query string.
 *
 * @param struct 	 Structure of key/value pairs you want converted to URL parameters
 * @param keyValueDelim 	 Delimiter for the keys/values.  Default is the equal sign (=).
 * @param queryStrDelim 	 Delimiter separating url parameters.  Default is the ampersand (&).
 * @return Returns a string.
 * @author Erki Esken (erki@dreamdrummer.com)
 * @version 1, December 17, 2001
 */
function StructToQueryString(struct) {
  var qstr = "";
  var delim1 = "=";
  var delim2 = "&";

  switch (ArrayLen(Arguments)) {
    case "3":
      delim2 = Arguments[3];
    case "2":
      delim1 = Arguments[2];
  }

  for (key in struct) {
    qstr = ListAppend(qstr, URLEncodedFormat(LCase(key)) & delim1 & URLEncodedFormat(struct[key]), delim2);
  }
  return qstr;
}


/**
 * Returns the substring of a string. It mimics the behaviour of the homonymous php function so it permits negative indexes too.
 *
 * @param buf 	 The string to parse. (Required)
 * @param start 	 The start position index. If negative, counts from the right side. (Required)
 * @param length 	 Number of characters to return. If not passed, returns from start to end (if positive start value). (Optional)
 * @return Returns a string.
 * @author Rudi Roselli Pettazzi (&#114;&#104;&#111;&#100;&#105;&#111;&#110;&#64;&#116;&#105;&#115;&#99;&#97;&#108;&#105;&#110;&#101;&#116;&#46;&#105;&#116;)
 * @version 2, July 2, 2002
 */
function SubStr(buf, start) {
    // third argument (optional)
    var length = 0;
    var sz = 0;

    sz = len(buf);

    if (arrayLen(arguments) EQ 2) {

		if (start GT 0) {
		    length = sz;
		} else if (start LT 0) {
		    length = sz + start;
		    start = 1;
		}

    } else {

		length = Arguments[3];
		if (start GT 0) {
		    if (length LT 0)   length = 1+sz+length-start;
		} else if (start LT 0) {
		    if (length LT 0) length = length-start;
		    start = 1+sz+start;

		}
    }

    if (isNumeric(start) AND isNumeric(length) AND start GT 0 AND length GT 0) return mid(buf, start, length);
    else return "";
}
</cfscript>
