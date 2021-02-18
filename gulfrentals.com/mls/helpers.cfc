<cfcomponent>
   <cffunction name="init" access="public" output="no">
      <cfreturn this>
   </cffunction>

   <cffunction name="isAjax" output="false" returntype="boolean" access="public">
    <cfset var headers = getHttpRequestData().headers />
    <cfreturn structKeyExists(headers, "X-Requested-With") and (headers["X-Requested-With"] eq "XMLHttpRequest") />
   </cffunction>


   <cffunction name="isFavorite">
      <cfargument name="mlsnumber">
      <cfargument name="favoritelist">

      <cfif ListFind(arguments.favoritelist,arguments.mlsnumber)>
         <cfreturn "Unfavorite">
      <cfelse>
         <cfreturn "Favorite">
      </cfif>

   </cffunction>

   <!--- <cffunction name="optimizeMyURL" hint="Creates SEO friendly detail page links " output="yes" returnType="string">
     <cfargument name="streetnumber" required="true" type="string">
     <cfargument name="streetname" required="true" type="string">
     <cfargument name="city" required="true" type="string">
     <cfargument name="zipcode" required="true" type="string">
     <cfargument name="mlsnumber" required="true" type="string">
     <cfargument name="mlsid" required="true" type="string">
     <cfargument name="wsid" required="true" type="string">

     <!--- Let's trim the street number  --->
     <cfset trimmedStreetNumber = trim(#streetnumber#)>
    <cfset trimmedStreetNumber = rereplace(trimmedStreetNumber,' ','-','all')>
     <!--- Clean up the street name with trim and replace spaces with hyphens  --->
     <cfset trimmedStreetName = trim(streetname)>
     <cfset cleanStreetName = rereplace(trimmedStreetName,'\)|\(|\,|\+|\##|\.|/.|\/|\&','','all')>
     <cfset cleanStreetName = rereplace(cleanStreetName,' ','-','all')>
     <cfset cleanStreetName = rereplace(cleanStreetName,'--','-','all')>
     <cfset cleanStreetName = rereplace(cleanStreetName,'##','','all')>

     <!--- Clean up the cit name  --->
     <cfset trimmedCity = trim(#city#)>
     <cfset cleanCity = replace(#trimmedCity#," ",'-','all')>
     <cfreturn "/mls/property.cfm?mlsid=#mlsid#&wsid=#wsid#&mlsnumber=#mlsnumber#">
     <cfset returnThis = "/mls/" & trimmedStreetNumber & "-" & lcase(cleanStreetName) & "-" & lcase(cleanCity) & "-" & zipcode & "/" & mlsnumber & "/" & mlsid & "/" & wsid />

      <cfreturn returnThis />
   </cffunction> --->
  <cffunction name="optimizeMyURL" hint="Creates SEO friendly detail page links " output="yes" returnType="string">
     <cfargument name="streetnumber" required="true" type="string">
     <cfargument name="streetname" required="true" type="string">
     <cfargument name="city" required="true" type="string">
     <cfargument name="zipcode" required="true" type="string">
     <cfargument name="mlsnumber" required="true" type="string">
     <cfargument name="mlsid" required="true" type="string">
     <cfargument name="wsid" required="true" type="string">

     <!--- Let's trim the street number  --->
     <cfset trimmedStreetNumber = trim(#streetnumber#)>
     <cfset trimmedStreetNumber = rereplace(trimmedStreetNumber,' ','-','all')>
     <!--- Clean up the street name with trim and replace spaces with hyphens  --->
     <cfset trimmedStreetName = trim(streetname)>
     <cfset cleanStreetName = rereplace(trimmedStreetName,'\)|\(|\,|\+|\##|\.|/.|\/|\&','','all')>
     <cfset cleanStreetName = rereplace(cleanStreetName,' ','-','all')>
     <cfset cleanStreetName = rereplace(cleanStreetName,'--','-','all')>
     <cfset cleanStreetName = rereplace(cleanStreetName,'##','','all')>

     <!--- Clean up the cit name  --->
     <cfset trimmedCity = trim(#city#)>
     <cfset cleanCity = replace(#trimmedCity#," ",'-','all')>
     <!--- <cfreturn "/mls/property.cfm?mlsid=#mlsid#&wsid=#wsid#&mlsnumber=#mlsnumber#"> --->
     <cfset returnThis = "/mls/" & mlsnumber & '-' & wsid & '-' & mlsid & '/' & trimmedStreetNumber & "-" & lcase(cleanStreetName) />

      <cfreturn returnThis />
   </cffunction>


    <!--- START: VIRTUAL TOUR - Checks for HTTP and ? in URL --->
    <cffunction name="optimizeVirtualTour" hint="Creates SEO friendly detail page links " output="yes" returnType="string">
      <cfargument name="virtual_tour" required="true" type="string">

      <cfset virtual_tour = replaceNoCase(arguments.virtual_tour, '&feature=youtu.be', '') />

      <cfset var theVirtualTour = "">

      <!--- Fix For Youtube --->
      <cfif Virtual_Tour contains 'Youtube' and Virtual_tour contains 'embed'>

        <!--- Clean URL of Query String --->
        <!--- <cfif Virtual_Tour contains '?'>
          <cfset vtLEN = LEN(Virtual_Tour)>
          <cfset vtQS = FindNoCase('?', Virtual_Tour) - 1>
          <cfset Virtual_Tour = Left(Virtual_Tour, vtQS)>
        </cfif>

        <!--- Strip Video ID --->
        <cfset vtLEN = LEN(Virtual_Tour)>
        <cfset vtEmbed = FindNoCase('embed/', Virtual_Tour) + 5>
        <cfset vtEmbed = vtLEN - vtEmbed>
        <cfset VideoID = Right(Virtual_Tour, vtEmbed)>

        <!--- Create New URL --->
        <cfset thevirtualtour = 'http://www.youtube.com/watch?v=' & VideoID> --->
        <cfset thevirtualtour = Virtual_tour />

      <cfelseif Virtual_Tour contains 'Youtube' and Virtual_tour contains 'watch'>

        <cfset thevirtualtour = 'https://www.youtube.com/embed/#listlast(Virtual_tour,'v=')#' />

      <cfelseif Virtual_Tour contains 'youtu.be'>

        <cfset thevirtualtour = 'https://www.youtube.com/embed/#listlast(Virtual_tour,'/')#' />

      <cfelseif Virtual_Tour contains 'matterport.com' or 
                Virtual_Tour contains 'real.vision' or 
                Virtual_Tour contains 'livetour.istaging.com' or
                Virtual_Tour contains 'player.vimeo.com' >

        <cfset thevirtualtour = Virtual_Tour>

      </cfif><!--- we only support the above types... --->

      <!--- First we determine whether the link needs the HTTP --->
      <cfif thevirtualtour is not "" and (thevirtualtour contains "http://" or thevirtualtour contains "https://")>
        <cfset thevirtualtour = replacenocase(thevirtualtour, 'http:', 'https:') />
      <cfelseif thevirtualtour is not "" and thevirtualtour does not contain "http://" and thevirtualtour does not contain "https://">
        <cfset thevirtualtour = "https://#virtual_tour#">
      </cfif>

      <cfif thevirtualtour contains 'youtu.be' or thevirtualtour contains 'youtube'>

        <!--- youtube only - Next we determine if the URL needs a ? or & appended to it --->
        <cfif thevirtualtour contains "?">
          <cfset thevirtualtour = "#thevirtualtour#&width=765&height=384">
        <cfelse>
          <cfset thevirtualtour = "#thevirtualtour#?width=765&height=384">
        </cfif>

      </cfif>

      <cfset returnThis = thevirtualtour>

      <cfreturn returnThis />
    </cffunction>
    <!--- END: VIRTUAL TOUR --->

<!--- <cfset encryptedCC = EncryptCC(#form.ID#)> --->

<cffunction name="FormatUnit" hint="Checks for Pound sign in Unit Number" output="true" returntype="string">
  <cfargument name="unitnumber" required="YES" type="string">
    <cfif left(unitnumber,1) eq "##" or unitnumber contains "##">
      <cfset unitnum = "#unitnumber#">
    <cfelse>
      <cfset unitnum = "###unitnumber#">
    </cfif>
  <cfreturn  unitnum>
</cffunction>

<cfscript>
/**
 * An enhanced version of left() that doesn't cut words off in the middle.
 * Minor edits by Rob Brooks-Bilson (rbils@amkor.com) and Raymond Camden (ray@camdenfamily.com)
 *
 * Updates for version 2 include fixes where count was very short, and when count+1 was a space. Done by RCamden.
 *
 * @param str 	 String to be checked.
 * @param count 	 Number of characters from the left to return.
 * @return Returns a string.
 * @author Marc Esher (jonnycattt@aol.com)
 * @version 2, April 16, 2002
 */
function fullLeft(str, count) {
	if (not refind("[[:space:]]", str) or (count gte len(str)))
		return Left(str, count);
	else if(reFind("[[:space:]]",mid(str,count+1,1))) {
	  	return left(str,count);
	} else {
		if(count-refind("[[:space:]]", reverse(mid(str,1,count)))) return Left(str, (count-refind("[[:space:]]", reverse(mid(str,1,count)))));
		else return(left(str,1));
	}
}

/**
 * Flexible PIN generator, supporting alphabetical, numeric, and alphanumeric types, upper, lower, and mixed cases, and validating prescence of letters and numbers in alphanumeric PINs at least 2 characters long.
 *
 * @param chars 	 Number of characters to return. (Required)
 * @param type 	 Type of PIN to create. Types are: n (numeric), a (alphabetical), m (mixed, or alphanumeric). Default is m. (Optional)
 * @param format 	 Case of PIN. Options are: u (uppercase), l (lowercase), m (mixed). Default is m. (Optional)
 * @return Returns a string.
 * @author Sierra Bufe (sierra@brighterfusion.com)
 * @version 1, May 14, 2002
 */
function createPIN(chars){
	var type    = "m";
	var format  = "m";
	var PIN     = "";
	var isValid = false;
	var i       = 0;
	var j       = 0;
	var r	    = 0;

	// Check to see if type was provided.  If not, default to "m" (mixed, or alphanumeric).
	if (ArrayLen(Arguments) GT 1) {
		type = Arguments[2];
		if (type is "alphanumeric")
			type = "m";
		type = left(type,1);
		if ("a,n,m" does not contain type)
			return "Invalid type argument.  Valid types are:  alpha, numeric, alphanumeric, mixed, a, n, m.  This argument is optional, and defaults to alphanumeric";
	}

	// Check to see if format was provided.  If not, default to "m" (mixed upper and lower).
	if (ArrayLen(Arguments) GT 2) {
		format = Arguments[3];
		format = left(format,1);
		if ("u,l,m" does not contain format)
			return "Invalid format argument.  Valid formats are:  upper, lower, mixed, u, l, m.";
	}

	// if type is alphanumeric, set j to 10 to allow for numbers in the RandRange
	if (type is "m")
		j = 10;

	while (not isValid) {

		PIN = "";

		// loop through each character of the PIN
		for (i = 1; i LTE chars; i = i+1) {

			// numeric type
			if (type is "n") {
				r = RandRange(0,9) + 48;

			// lowercase format
			} else if (format is "l") {
				r = RandRange(97,122 + j);
				if (r GTE 123)
					r = r - 123 + 48;

			// uppercase format
			} else if (format is "u") {
				r = RandRange(65,90 + j);
				if (r GTE 91)
					r = r - 91 + 48;

			// upper and lower cases mixed
			} else if (format is "m") {
				r = RandRange(65,116 + j);
				if (r GTE 117)
					r = r - 117 + 48;
				else if (r GTE 91)
					r = r + 6;

			}

			PIN = PIN & Chr(r);
		}

		// verfify that alphanumeric strings contain both letters and numbers
		if (type is "m" AND chars GTE 2) {
			if (REFind("[A-Z,a-z]+",PIN) AND REFind("[0-9]+",PIN))
				isValid = true;
		} else {
			isValid = true;
		}

	}

	return PIN;
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

<!---
 Capitalizes the first letter in each word.
 Made udf use strlen, rkc 3/12/02
 v2 by Sean Corfield.

 @param string 	 String to be modified. (Required)
 @return Returns a string.
 @author Raymond Camden (ray@camdenfamily.com)
 @version 2, March 9, 2007
--->
<cffunction name="CapFirst" returntype="string" output="false">
	<cfargument name="str" type="string" required="true" />

	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />

	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />
		<cfif len(word) gt 1>
			<cfset newstr = newstr & right(word,len(word)-1) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction>

</cfcomponent>