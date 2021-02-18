<cfset qResults = application.oMLS.all_properties(settings.mls.mlsid)>

<cfinclude template="/components/header.cfm">
<main class="int">
	<div class="container int">
      <div class="row">
        <div class="col-xs-12 mainContent">
          <h1>All Properties</h1>
          <table class="table">
          <tr>
            <th>Address</th>
            <th>City/Zip</th>
            <th>List Price</th>
            <th>MLS Number</th>
            <th>Bedrooms</th>
            <th>Bathrooms</th>
          </tr>
          <cfloop query="qResults.query">
            
            <cfset detailPage = application.oHelpers.optimizeMyURL(qResults.query.street_number,
                                        qResults.query.street_name,
                                        qResults.query.city,
                                        qResults.query.zip_code,
                                        qResults.query.mlsnumber,
                                        qResults.query.mlsid,
                                        qResults.query.wsid)>
                                        
            <cfoutput>
               <tr>
                  <td><a href="#detailPage#">#street_number# #street_name#</a></td>
                  <td>#city#, #state# #zip_code#</td>
                  <td>$#NumberFormat(list_price)#</td>
                  <td>#mlsnumber#</td>
                  <td>#bedrooms#</td>
                  <td>#baths_full#</td>
               </tr>
            </cfoutput>
          </cfloop>
          </table>
        </div>
      </div>
	</div>
</main>
<cfinclude template="/components/footer.cfm">