<cfinclude template="/sales/lightboxes/_header.cfm">

<cfif NOT isdefined('cookie.loggedin')>
  <cfparam name="FavoriteMLSID" type="string" default="">
  <cfparam name="FavoriteWSID" type="string" default="">
  <cfparam name="Favoritemlsnumber" type="string" default="">
  <cflocation url="/sales/lightboxes/create-account.cfm?action=#action#&FavoriteWSID=#FavoriteWSID#&FavoriteMLSID=#FavoriteMLSID#&Favoritemlsnumber=#Favoritemlsnumber#" addtoken="No">
</cfif>

<cfinclude template="/sales/lightboxes/_footer.cfm">