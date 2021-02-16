<cfabort> <cfquery datasource="#DSNMLS#" name="Getlistings">
	SELECT *
	FROM mastertable
	where mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'> and wsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#wsid#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsid#'>
</cfquery>

<cfquery datasource="#dsnmls#" name="getareas">
	SELECT *
	FROM masterareas_cleaned
  where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#"> <cfif isdefined('Getlistings.area') and LEN(Getlistings.area)>and areashidden in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#Getlistings.area#">)</cfif>
</cfquery>

<cfquery datasource="#dsnmls#" name="GetDatelisted">
	SELECT *
	FROM property_dates
  where mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'>
</cfquery>



<!---GETS IMAGE PATH--->
<cfquery name="getmlscoinfo" datasource="#DSNMLS#" >
	SELECT *
	FROM mlsfeeds
	where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
</cfquery>

<!--- <cfquery name="GetImages" datasource="#RetsImages#">
  Select path
  from rets20.#ImageTableName#
  where mlnumber = '#mlsnumber#'
  order by `Index`
</cfquery> --->

  <cfset HowManyPhotos = "#listlen(GetListings.photo_link)#">
  <cfif listlen(GetListings.photo_link) gt 1>
    <cfset ThePhoto = "#listgetat(GetListings.photo_link,'1')#">
    <cfset AllPhotos = "#ListDeleteAt(GetListings.photo_link,'1')#">
      <cfelse>
    <cfset ThePhoto = "#GetListings.photo_link#">
    <cfset AllPhotos = "">
  </cfif>


<!doctype html>
<!--[if IE 7 ]><html class="ie ie7" lang="en-US"><![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en-US"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en-US"><![endif]-->
<!--[if gt IE 9]><!--><html lang="en-US"><!--<![endif]-->
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <link href="/stylesheets/screen.css" media="screen, projection" rel="stylesheet" type="text/css">
  <link href="/sales/stylesheets/mls.css" media="screen, projection" rel="stylesheet" type="text/css">

  <title>Printer Friendly</title>

</head>

<body>

<style>
#mls-wrapper{width:710px;margin: 0 auto;}
#print-wrapper img{border:1px #ccc solid;padding:3px;background:#fff}
#print-wrapper{width:710px;margin: 0 auto;}
#contact-info li{list-style-type:none; text-indent: -25px;}
#company-logo{float: right;}
#company-logo img{float:right}
#print-propertyinfo{width: 100%;margin: 15px 0 0 0;float: right;}
#property-mainimage{width:320px;float: left;}
#property-mainimage img{width:320px;}
#property-details{width:260px;margin-left:30px;float:right;}
#agent-info, #additional-info, #property-amenities{padding-top: 25px;}
#amenities-leftcol, #amenities-rightcol{width: 200px;float: left;}
#additional-images img{width: 234px;}
td{border: none;}
#agent-info{clear:both}
#property-details{width:360px}
#property-details th{font-weight:bold;color:black}
</style>

<div id="mls-wrapper">

<cfoutput query="Getlistings">
  <cfinclude template="/sales/includes/image-handler.cfm">
  <div id="print-wrapper">
    <div style="background:##fff;padding:15px;margin:0 0 25px;overflow:hidden">
      <a hreflang="en" href="javascript:window.print();" class="button light" style="float:right;">Click here to print</a>
    </div>
    <div id="print-header">
      <div id="company-logo">
        <img src="/images/layout/#mls.logo#">
      </div>
      <div id="contact">
        <h3>Contact Information</h3>
        <ul id="contact-info">
          <li>#mls.companyname#</li>
          <li>#mls.address#</li>
          <li>#mls.city#, #mls.state# #mls.zip#</li>
          <li><strong>Phone:</strong> #mls.phone#</li>
          <cfif mls.phone1800 is not ""><li><strong>Toll Free:</strong> #mls.phone1800#</li></cfif>
          <cfif mls.fax is not ""><li><strong>Fax:</strong> #mls.fax#</li></cfif>
          <li><strong>Email:</strong> #mls.adminemail#</li>
        </ul>
      </div>
    </div>
    <div id="print-propertyinfo">
      <h3>Property Details</h3>
      <div id="property-mainimage">
        <cfif HowManyPhotos gt 0><IMG src="#thephoto#" width="150" border="1" alt="#mls.companyname# - MLS Number: #mlsnumber#"><cfelse><IMG src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="150" border="1" alt="#mls.companyname#- MLS Number: #mlsnumber#"></cfif>
      </div>
      <div id="property-details">
        <table>
        <tr>
          <th colspan=2>#street_number# #street_name# <cfif LEN(unit_number)>#unit_number#</cfif> - #dollarformat(list_price)#</th>
        </tr>
        <tr>
          <td>MLS ##:</td>
          <td>#mlsnumber#</td>
        </tr>
        <tr>
          <td>Address:</td>
          <td>#street_number# #street_name# <cfif LEN(unit_number)>#unit_number#</cfif></td>
        </tr>
        <tr>
          <td>City/Zip:</td>
          <td>#city#, #state# #zip_code#</td>
        </tr>
        <tr>
          <td>Area:</td>
          <td>#getareas.city#</td>
        </tr>
        <tr>
          <td>Neighborhood:</td>
          <td>#subdivision#</td>
        </tr>
        </table>
        <br/>
        <table>
        <tr>
          <th colspan=2>Property Data</th>
        </tr>
        <tr>
          <td>Kind:</td>
          <td>#kind#</td>
        </tr>
        <tr>
          <td>Acres:</td>
          <td>#ACREAGE#</td>
        </tr>
        <tr>
          <td>Zoning:</td>
          <td>#zoning#</td>
        </tr>
        </table>
      </div>
    </div>
    <div id="agent-info">
      <div id="agent-comments">
        <h3>Agent Comments:</h3>
        #remarks#
      </div>
      <div id="additional-info">
        <h3>Additional Information:</h3>
        <strong>Lot description</strong>: #Lot_Description#<br/>
        <cfif Elementary_school is not ""><strong>Schools</strong>: <em>Elementary</em>: #Elementary_school# / <em>Middle</em>: #Middle_school# / <em>High</em>: #high_school#</cfif>
      </div>
      <div id="property-amenities">
        <h3>Amenities:</h3>
        <div class="amenities-list">
          <table width="750" border="0" cellspacing="2" cellpadding="2" align="center">
          <tr>
            <td>
              <cfif interior_features is not "">
                <h3>Interior Features</h3>
                <ul>
                  <cfloop index="i" list="#interior_features#">
                    <li>#i#</li>
                  </cfloop>
                </ul>
              </cfif>
            </td>
            <td>
              <cfif exterior_features is not "">
                <h3>Exterior Features</h3>
                <ul>
                  <cfloop index="i" list="#exterior_features#">
                    <li>#i#</li>
                  </cfloop>
                </ul>
              </cfif>
            </td>
          </tr>
          <tr>
            <td>
              <cfif rooms is not "">
                <h3>Rooms</h3>
                <ul>
                  <cfloop index="i" list="#rooms#">
                    <li>#i#</li>
                  </cfloop>
                </ul>
              </cfif>
            </td>
            <td>
              <cfif utilities is not "">
                <h3>Utilities to Site</h3>
                <ul>
                  <cfloop index="i" list="#utilities#">
                    <li>#i#</li>
                  </cfloop>
                </ul>
              </cfif>
            </td>
          </tr>
          <tr>
            <td>
              <cfif Flooring is not "">
                <h3>Flooring</h3>
                <ul>
                  <cfloop index="i" list="#Flooring#">
                    <li>#i#</li>
                  </cfloop>
                </ul>
              </cfif>
            </td>
            <td>
              <cfif appliances is not "">
                <h3>Appliances</h3>
                <ul>
                  <cfloop index="i" list="#appliances#">
                    <li>#i#</li>
                  </cfloop>
                </ul>
              </cfif>
            </td>
            </tr>
            <tr>
              <td>
                <cfif cooling is not "">
                  <h3>Cooling / Heating</h3>
                  <ul>
                    <cfloop index="i" list="#cooling#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </cfif>
              </td>
              <td>
                <cfif fireplace is not "">
                  <h3>Fireplace</h3>
                  <ul>
                    <cfloop index="i" list="#fireplace#">
                      <li>#i#</li>
                    </cfloop>
                  </ul>
                </cfif>
              </td>
              </tr>
              <tr>
                <td>
                  <cfif roof is not "">
                    <h3>Roof</h3>
                    <ul>
                      <cfloop index="i" list="#roof#">
                        <li>#i#</li>
                      </cfloop>
                    </ul>
                  </cfif>
                </td>
                <td>
                  <cfif dining_description is not "">
                    <h3>Dining Area</h3>
                    <ul>
                      <cfloop index="i" list="#dining_description#">
                        <li>#i#</li>
                      </cfloop>
                    </ul>
                  </cfif>
                </td>
                </tr>
                <tr>
                  <td>
                    <cfif lotfront is not "">
                      <h3>Lot Size</h3>
                      <ul>
                        <li>#lotfront# front</li>
                        <li>#lotright# right</li>
                        <li>#lotrear# rear</li>
                        <li>#lotleft# left</li>
                      </ul>
                    </cfif>
                  </td>
                  <td>
                    <cfif waterfront_type is not "" or water_view_type is not "">
                      <h3>Waterfront / View</h3>
                      <ul>
                        <cfif waterfront_type is not ""><li>#waterfront_type#</li></cfif>
                        <cfif water_view_type is not "" and #water_view_type# is not #waterfront_type#><li>#water_view_type#</li></cfif>
                      </ul>
                    </cfif>
                  </td>
                </tr>
                </table>
              </div>
            </div>
          </div>
          <div id="additional-images">
            <cfloop index="i" list="#AllPhotos#">
              <img src="#i#">
            </cfloop>
          </div>
        </div>
        <br/>
      </div>
    </div>
  </div>
</cfoutput>

</div>


</body>
</html>
