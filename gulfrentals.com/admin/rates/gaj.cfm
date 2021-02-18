<cfif isdefined('url.id') AND isDefined('url.name')>


<cfquery name="getRates" dataSource="#dsn#">
        select *
        from cms_rates_gaj
        where propertyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="62776">
        order by startdate asc
</cfquery>

 <cfif ListFind("216.99.119.254,98.121.170.115", cgi.remote_host)><p>ICND EYES ONLY</p>
    <cfdump var="#getRates#">
</cfif>

<cfelse>

    <cflocation url="index.cfm" addtoken="no">

</cfif>

<cfset variables.maxRows = 13>
<cfset variables.rowsToProcess = (variables.maxRows GT getRates.recordcount ? variables.maxRows : getRates.recordcount)>

<cfset page.title ="Editing: #url.name#"><!---#url.name#---->
<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.success') and isdefined('url.id')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>Update successful!</strong> Continue editing this property or <a href="index.cfm">go back.</a>
  </div>
</cfif>

<div class="widget-box">
    <div class="widget-title">
    <span class="icon">
        <i class="icon-th"></i>
        </span>
        <h5>Add / Edit Form</h5>
    </div>

    <div class="widget-content nopadding">

        <form id="cmsRates" method="post" action="gaj-submit.cfm?id=<cfoutput>#url.id#&name=#url.name#</cfoutput>" class="form-horizontal" enctype="multipart/form-data">

            <table class="table table-bordered table-striped">
                <tr>
                <th>No.</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Rent</th>
                </tr>

                <cfloop from="1" to="#variables.rowsToProcess#" index="i">
                <cfoutput>
                    <tr>
                        <td width="45">#i#.</td>
                        <cfif i EQ variables.rowsToProcess>
                            <td>Monthly</td>
                            <td></td>
                            <td>
                                <cfif parameterexists(id) and isdefined('getrates.rent[i]') and getrates.rent[i] neq ''>
                                    <input type="text" class="input-small nomargin" placeholder="Rent" name="rent_#i#" value="#getrates.rent[i]#">
                                <cfelse>
                                    <input type="text" class="input-small nomargin" placeholder="Rent" name="rent_#i#">
                                </cfif>
                            </td>
                        <cfelseif i EQ (variables.rowsToProcess -1)>
                            <td>Holiday</td>
                            <td></td>
                            <td>
                                <cfif parameterexists(id) and isdefined('getrates.rent[i]') and getrates.rent[i] neq ''>
                                    <input type="text" class="input-small nomargin" placeholder="Rent" name="rent_#i#" value="#getrates.rent[i]#">
                                <cfelse>
                                    <input type="text" class="input-small nomargin" placeholder="Rent" name="rent_#i#">
                                </cfif>
                            </td>
                        <cfelse>
                        <td>
                            <cfif parameterexists(id) and isdefined('getrates.startdate[i]') and getrates.startdate[i] neq ''>
                                <input type="text" class="input-small datepicker nomargin" placeholder="Start Date" name="startdate_#i#" value="#DateFormat(getrates.startdate[i],"mm-dd-yyyy")#">
                            <cfelse>
                                <input type="text" class="input-small datepicker nomargin" placeholder="Start Date" name="startdate_#i#">
                            </cfif>
                            <span class="add-on"><i class="icon-calendar"></i></span>
                        </td>
                        <td>
                                <cfif parameterexists(id) and isdefined('getrates.enddate[i]') and getrates.enddate[i] neq ''>
                                <input type="text" class="input-small datepicker nomargin" placeholder="End Date" name="enddate_#i#" value="#DateFormat(getrates.enddate[i],"mm-dd-yyyy")#">
                            <cfelse>
                                <input type="text" class="input-small datepicker nomargin" placeholder="End Date" name="enddate_#i#">
                            </cfif>
                            <span class="add-on"><i class="icon-calendar"></i></span>
                        </td>
                        <td>
                                <cfif parameterexists(id) and isdefined('getrates.rent[i]') and getrates.rent[i] neq ''>
                                <input type="text" class="input-small nomargin" placeholder="Rent" name="rent_#i#" value="#getrates.rent[i]#">
                            <cfelse>
                                <input type="text" class="input-small nomargin" placeholder="Rent" name="rent_#i#">
                            </cfif>
                        </td>
                        </cfif>
                        <input type="hidden" name="rowID" value="#i#">
                    </tr>
                </cfoutput>
                </cfloop>
            </table>

            <div class="form-actions">
            <input type="submit" value="Submit" class="btn btn-primary">
            </div>

        </form>

    </div>
</div>

<cfinclude template="/admin/components/footer.cfm">

<style type="text/css">label.error{color:red !important;}</style>

<script>
  $(document).ready(function(){
    $("#cmsRates").validate({
        rules: {
            rent: {
                required: true
            },
            messages: {
                name: {
                    required: "Rent is required"
                }
            }
        }
    });
  });
</script>
