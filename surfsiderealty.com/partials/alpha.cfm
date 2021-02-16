<cfparam name="url.letter" default="a">

<cfquery name="getRentalsPage" datasource="#settings.dsn#">
SELECT
  distinct
  'US' AS strCountry,
  cityname AS strCity,
  unitcode AS strPropId,
  seopropertyname,
  unitshortname AS strName,
  unitcode AS cleanstrpropid

FROM escapia_properties

WHERE unitcode != ""
ORDER BY unitshortname;
   </cfquery>
  <cfset alist="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">

<br>
      <div id="abc">
        <cfoutput>
           <ul>
            <!--- <li><a hreflang="en" href="#script_name#?letter=numbers">##</a></li> --->
            <cfloop list="#alist#" index="i">
              <li><a class="btn" href="alphabetical-listings###i#">#i#</a></li>
            </cfloop>
            </ul>
        </cfoutput>
      </div>

      <div id="results">
        <ul>
        <cfif getRentalsPage.recordcount is 0>

        <!--- Added this for Google, when there are no results on page : Drew P. --->
        <!--- <cfheader statuscode="404" statustext="Page Not Found" /> commented out because statuscode 404 creates default server error pages now --->

          <li>No Properties Found.</li>
        </cfif>
        <cfset lastFirstLetter = ''>
        <cfoutput query="GetRentalsPage">
        <!--- Dont' show annual rentals in list --->
          <cfset firstLetter = left(strName,1)>
          <cfif firstLetter neq lastFirstLetter and alist contains(firstletter)>
              <a name="#firstLetter#"><h3>#firstLetter#</h3>
          </cfif>
          <cfset lastFirstLetter = firstLetter>


            <cfif cleanstrpropid is "">

              <!---This is a condo, link straight to the condoplex page--->

              <cfset mycountry = #Replace(strCountry,' ','-','all')#>
              <cfset mycity = #Replace(strCity,' ','-','all')#>

              <li><a hreflang="en" href="/rentals/#mycity#/#mycountry#">#strName#</a></li>

            <cfelse>
              <cfset PropId = #Replace(cleanstrpropid,' ','','all')#>
              <cfset seoPropName = #replace(replace(seopropertyname,':','-','all'),'/','-','all')#>
              <!---<li><a hreflang="en" href="/rentals/#seopropertyname#/#PropId#">#strName#</a></li>--->
              <li><a hreflang="en" href="/rentals/#seopropname#">#strName#</a></li>

            </cfif>

        </cfoutput>
        </ul>

      </div>
