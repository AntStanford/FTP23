
<cfoutput>
 <cfset NewURL="/featured-listings">           
            <cfheader statuscode="301" statustext="Moved permanently">
            <cfheader name="Location" value="#NewURL#">
           <!--- Redirect #OldURL# to #NewURL# --->
            </cfoutput>