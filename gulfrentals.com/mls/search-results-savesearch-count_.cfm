<cfif COUNTINFO.thecount gt 0>
<li class="results">


     <cfoutput>
       Results
       <cfif isdefined('url.page') is "No" or url.page is "1">
         1
       <cfelse>
         <cfif page is "2">
           11
         <cfelse>
           #(start_record + 1)#
         </cfif>
       </cfif>
       -
       <cfif isdefined('url.page') is "No" or url.page is "1">
         <cfif #COUNTINFO.thecount# lt records_per_page>
           #COUNTINFO.thecount#
         <cfelse>
           10
         </cfif>
         <cfelse>
           <!--- <cfif page gt 10>
             #evaluate((page + 2) * 10)#
           <cfelse> --->
         <cfif page is "2" and #COUNTINFO.thecount# gt 20>
           20
         <cfelseif page is "2" and #COUNTINFO.thecount# lt 20>
           #COUNTINFO.thecount#
         <cfelse>
           <cfif (start_record + 10) gt COUNTINFO.thecount>#COUNTINFO.thecount#<cfelse>#(start_record + 10)#</cfif>
         </cfif>
         <!--- </cfif> --->
       </cfif>
       of #COUNTINFO.thecount#
     </cfoutput>

</li>
<cfelse>
	<h3>Your search did not produce any results.<br><br>  Please <a href="javascript:history.back()">go back</a> and adjust your search fields.</h3>

</cfif>