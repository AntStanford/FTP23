<cfif isdefined('cookie.loggedin')>
  <!---ADD TO FAVORITES--->
  <cfif isdefined('action') and action is "addtofavorites">
    <cfquery name="AlreadyFav" datasource="#mls.dsn#" >
      SELECT *
      FROM cl_favorites
      where clientid = <cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR"> and mlsnumber = '#Favoritemlsnumber#' and wsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Favoritewsid#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Favoritemlsid#'>
    </cfquery>
    <cfif AlreadyFav.recordcount eq 0>
      <cfquery datasource="#mls.dsn#" dbtype="ODBC">
        Insert
        Into cl_favorites
          (clientid,mlsid,wsid,mlsnumber)
        Values
          (<cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">,
           <cfqueryparam value="#Favoritemlsid#" cfsqltype="CF_SQL_VARCHAR">,
           <cfqueryparam value="#Favoritewsid#" cfsqltype="CF_SQL_VARCHAR">,
           <cfqueryparam value="#Favoritemlsnumber#" cfsqltype="CF_SQL_VARCHAR"> )
      </cfquery>
    </cfif>
  </cfif>
  <!---DELETE FROM FAVORITES--->
  <cfif isdefined('action') and action is "removefromfavorites">
    <cfquery datasource="#mls.dsn#" name="GetInfo">
      delete
      FROM cl_favorites
      where clientid = <cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"> and mlsid = <cfqueryparam value="#Favoritemlsid#" cfsqltype="CF_SQL_VARCHAR"> and wsid = <cfqueryparam value="#Favoritewsid#" cfsqltype="CF_SQL_VARCHAR"> and mlsnumber = <cfqueryparam value="#Favoritemlsnumber#" cfsqltype="CF_SQL_VARCHAR">
    </cfquery>
  </cfif>
  <cfquery name="CheckFavorites" datasource="#mls.dsn#" >
    SELECT *
    FROM cl_favorites
    where clientid = <cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR">
  </cfquery>
</cfif>