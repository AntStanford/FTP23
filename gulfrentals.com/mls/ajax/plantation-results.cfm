<cfquery name="GetCommunities" datasource="#settings.dsn#">
  Select id from cms_communities where townpage = 0
</cfquery>
<cfset communityList = valuelist(GetCommunities.id)>

<cfquery name="GetCommunityAmenities" datasource="#settings.dsn#">
  Select concat('Amenity_',id) as amenityid from cms_community_amenities order by sort
</cfquery>

<cfset doCommunitySearch = false>
<cfset fieldnameList = valuelist(GetCommunityAmenities.amenityid)>
<cfloop list="#fieldnameList#" index="fieldname">
  <cftry>
    <cfif evaluate(fieldname) neq ''>
      <cfset doCommunitySearch = true>
    </cfif>
    <cfcatch></cfcatch>
  </cftry>
</cfloop>

<!--- <cfoutput>#communityList#<Br></cfoutput> --->

<cfif doCommunitySearch>
  <cfloop list="#fieldnameList#" index="fieldname">
    <cftry>
      <cfif fieldname contains('Amenity_') and evaluate(fieldname) neq ''>
        <cfset amenityID = replace(fieldname,'Amenity_','')>
        <cfquery name="GetCommunities" datasource="#settings.dsn#">
          Select distinct communityid from cms_amenities_communities
          where amenityid = #amenityID#

          <cfif evaluate(fieldname) contains('|')>
            and theText between <cfqueryparam value="#listgetat(evaluate(fieldname),1,'|')#" cfsqltype="cf_sql_integer">
                          and <cfqueryparam value="#listgetat(evaluate(fieldname),2,'|')#" cfsqltype="cf_sql_integer">
          <cfelse>
            and theText = <cfqueryparam value="#evaluate(fieldname)#" cfsqltype="cf_sql_varchar">
          </cfif>

          and communityid in (<cfqueryparam value="#communityList#" list="true" cfsqltype="cf_sql_varchar">)
        </cfquery>
        <!--- <Cfdump var="#GetCommunities#"> --->
        <cfset communityList = valuelist(GetCommunities.communityid)>
      </cfif>
      <cfcatch><!--- <cfoutput>#cfcatch.message#<Br></cfoutput> ---></cfcatch>
    </cftry>
  </cfloop>
</cfif>

<cfif isDefined('searchPrice') and searchPrice neq ''>
  <cfquery name="GetPrices" dbtype="query">
    Select subdivision from session.qSearch
    where list_price between <cfqueryparam value="#listgetat(searchprice,1)#" cfsqltype="cf_sql_integer">
      and <cfqueryparam value="#listgetat(searchprice,2)#" cfsqltype="cf_sql_integer">
  </cfquery>
</cfif>

<cfif isDefined('proptype') and proptype neq ''>

  <cfif proptype eq 'Land'>
    <cfquery name="GetLands" dbtype="query">
      Select subdivision from session.qSearch
      where wsid = 2
    </cfquery>
  </cfif>

  <cfif proptype eq 'Condo/Townhouse'>
    <cfquery name="GetCondoTownhoue" dbtype="query">
      Select subdivision from session.qSearch
      where subcategory = 'Townhouse' or subcategory = 'Condominium'
    </cfquery>
  </cfif>

  <cfif proptype eq 'Single Family Residence'>
    <cfquery name="GetSingleFamilyResidence" dbtype="query">
      Select subdivision from session.qSearch
      where subcategory = 'Single Family Residence'
    </cfquery>
  </cfif>

</cfif>

<cfquery name="GetComunitiesDetails" datasource="#settings.dsn#">
  Select * from cms_communities
  where 1=1
  <cfif doCommunitySearch>
    and id in (<cfqueryparam value="#communityList#" list="true" cfsqltype="cf_sql_varchar">)
  </cfif>
  <cfif isDefined('GetPrices')>
    and displayname in (<cfqueryparam value="#valuelist(GetPrices.subdivision)#" list="true" cfsqltype="cf_sql_varchar">)
  </cfif>
  <cfif isDefined('GetLands')>
    and displayname in (<cfqueryparam value="#valuelist(GetLands.subdivision)#" list="true" cfsqltype="cf_sql_varchar">)
  </cfif>
  <cfif isDefined('GetCondoTownhoue')>
    and displayname in (<cfqueryparam value="#valuelist(GetCondoTownhoue.subdivision)#" list="true" cfsqltype="cf_sql_varchar">)
  </cfif>
  <cfif isDefined('GetSingleFamilyResidence')>
    and displayname in (<cfqueryparam value="#valuelist(GetSingleFamilyResidence.subdivision)#" list="true" cfsqltype="cf_sql_varchar">)
  </cfif>
  and townpage = 0
</cfquery>

<cfset session.plantationSearchResults = valuelist(GetComunitiesDetails.id)>

<cfif GetComunitiesDetails.recordcount eq ''>

  <h3>No Plantations Match Your Search Criteria</h3>

<cfelse>

  <h3>Results</h3>
  <div class="row communities-listings-wrap">
    <cfoutput query="GetComunitiesDetails">
      <div class="col-xs-12 col-sm-6 col-md-4">
        <div class="panel panel-default">
          <div class="panel-heading">#displayname#</div>
          <div class="panel-body">
            <cfquery name="GetImage" datasource="#settings.dsn#" maxrows="1">
              Select thefile from cms_galleries where communityid = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer"> order by sort asc
            </cfquery>

            <div class="community-img-wrap">
              <div style="background:url('/images/gallery/#GetImage.thefile#') no-repeat;"></div>
            </div>

            <strong class="community-location">#location#</strong>

            <a class="btn site-color-1-bg site-color-1-lighten-bg-hover text-white" href="/plantation/#slug#">Full Details</a>

            <cfquery name="getinfo" datasource="#settings.dsn#">
              select *
              from cms_communities
              where id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfset mlsid = '1,5'>
            <cfif LEN(getinfo.subdivision)>
              <a class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" href="/mls/search-results.cfm?mlsid=#mlsid#&wsid=1&subdivision=#getinfo.subdivision#&sortby=List_Price Asc">#getSubDListings(mlsid,1,getinfo.subdivision)# Residential Listings</a>
              <a class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" href="/mls/search-results.cfm?mlsid=#mlsid#&wsid=2&subdivision=#getinfo.subdivision#&minprice=0&maxprice=999999999&citymailingaddress=&sortby=List_Price Asc">#getSubDListings(mlsid,2,getinfo.subdivision)# Land Listings</a>
            <cfelseif LEN(getinfo.area)>
              <a class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" href="/mls/search-results.cfm?mlsid=#mlsid#&wsid=1&area=#getinfo.area#&sortby=List_Price Asc">#getAreaListings(mlsid,1,getinfo.area)# Residential Listings</a>
              <a class="btn site-color-2-bg site-color-2-lighten-bg-hover text-white" href="/mls/search-results.cfm?mlsid=#mlsid#&wsid=2&area=#getinfo.area#&minprice=0&maxprice=999999999&citymailingaddress=&sortby=List_Price Asc">#getAreaListings(mlsid,2,getinfo.area)# Land Listings</a>
            </cfif>

      <!---
            <cfquery name="GetAmenities" datasource="#settings.dsn#">
              Select * from cms_amenities_communities, cms_community_amenities
              where cms_amenities_communities.communityid = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
              and cms_amenities_communities.amenityid = cms_community_amenities.id
              and cms_amenities_communities.thetext <> '' and cms_amenities_communities.thetext <> 'No'
              order by cms_community_amenities.sort
            </cfquery>

            <cfif GetAmenities.recordcount gt 0>
            <ul>
              <cfloop query="GetAmenities">
                <li>#GetAmenities.title#<cfif GetAmenities.thetext neq 'Yes'>: #GetAmenities.thetext#</cfif></li>
              </cfloop>
            </ul>
            </cfif>
       --->

          </div>
        </div>
      </div>
    </cfoutput>
  </div>
</cfif>