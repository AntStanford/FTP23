<cfoutput>#expandPath('/wp-nav-test.txt')#</cfoutput>
<cfif fileExists(expandPath('/wp-nav-test.txt'))>file exists<cfelse>nope</cfif>
<cffile action="read" file="#expandPath('/wp-nav-test.txt')#" variable="getWpData" />
<cfset variables.rawHTML = getWpData />

<cfoutput>
<br>

<cfset variables.navStart = findNoCase("<nav class='main_menu'", variables.rawHTML) />
variables.navStart:#variables.navStart#<br>
<cfset variables.navEnd = findNoCase('</nav>', variables.rawHTML, variables.navStart) />
variables.navEnd:#variables.navEnd#<br>
<cfset variables.navLen = variables.navEnd - variables.navStart + 6 />
variables.navLen:#variables.navLen#<br>
<cfset variables.wpNav = mid(variables.rawHTML, variables.navStart, variables.navLen) />

<textarea rows="50" cols="200">#variables.wpNav#</textarea>
</cfoutput>