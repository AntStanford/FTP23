<cfquery name="GetFulls" datasource="#settings.dsn#">
  Select distinct strpropidold, strpropid from prop_images
  where strpropidold <> strpropid
</cfquery>

<table>

  <tr><th>Translation</th><th>Old Link</th><th>New Link</th></tr>

  <cfoutput query="getFulls">

    <cfquery name="GetOldSeoName" datasource="surfsiderealty">
      select seopropertyname,cleanstrpropid from pp_propertyinfo where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetFulls.strpropidold#">
    </cfquery>

    <cfquery name="GetNewSeoName" datasource="#settings.dsn#">
      select seopropertyname,cleanstrpropid from pp_propertyinfo where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetFulls.strpropid#">
    </cfquery>

    <tr>
      <td>#strpropidold#, #strpropid#</td>
      <td>/rentals/#GetOldSeoName.seopropertyname#/#GetOldSeoName.cleanstrpropid#</td>
        <td>/rentals/#GetNewSeoName.seopropertyname#/#GetNewSeoName.cleanstrpropid#</td></tr>

  </cfoutput>

</table>  


<cfabort>
<!--- <cfquery name="GetEmpties" datasource="#settings.dsn#">
  Select distinct strpropid from prop_images
  where strpropidNew is null
</cfquery>

<cfoutput query="GetEmpties">

  <cfquery name="GetPropids" datasource="#settings.dsn#">
    Select strpropid, strname from pp_propertyinfo
    where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetEmpties.strpropid#">
  </cfquery>

  <cfif GetPropids.strpropid eq GetEmpties.strpropid>
    
    <cfquery name="Update" datasource="#settings.dsn#">
      Update prop_images set strpropidNew = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetPropids.strpropid#"> where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetEmpties.strpropid#">
    </cfquery>

  </cfif>


</cfoutput> --->



<cfif isDefined('session.NoStrpropid')>
<cfelse>
  <cfset session.NoStrpropid = ''>
</cfif>

<cfif isDefined('url.strpropid') and isDefined('url.strpropidNew')>
  <cfif url.strpropidNew eq 'skip'>
    <cfset session.NoStrpropid = listappend(session.NoStrpropid,url.strpropid)>
  <cfelse>
    <cfquery name="Update" datasource="#settings.dsn#">
      Update prop_images set strpropidNew = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.strpropidNew#"> where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.strpropid#">
    </cfquery>
    <cfset session.NoStrpropid = listappend(session.NoStrpropid,url.strpropid)>
    <cfset session.NoStrpropid = listappend(session.NoStrpropid,url.strpropidNew)>
  </cfif>
</cfif>


<cfquery name="GetEmpties" datasource="#settings.dsn#">
  Select distinct strpropid from prop_images
  where strpropidNew is null
</cfquery>

<cfquery name="GetFulls" datasource="#settings.dsn#">
  Select distinct strpropidNew from prop_images
  where strpropidNew is not null
</cfquery>

<cfquery name="GetPropids" datasource="#settings.dsn#">
  Select strpropid, strname from pp_propertyinfo
  where strpropid not in (<cfqueryparam value="#valuelist(GetFulls.strpropidNew)#" cfsqltype="cf_sql_varchar" list="true">)
  and strpropid not in (<cfqueryparam value="#session.NoStrpropid#" cfsqltype="cf_sql_varchar" list="true">)
  and strpropid <> 'WAIT & SEA'
</cfquery>



<cfif GetPropids.recordcount neq 0>
  
  <cfoutput>
    <h3 style="padding:3px 10px">#GetPropids.strname# <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetPropids.strpropid#"> (#GetPropids.recordcount# left)</h3>
    <table>
    <tr><td style="padding:3px 10px"><a href="test.cfm?strpropid=#GetPropids.strpropid#&strpropidNew=skip">Skip</a></td></tr>
      <tr><td style="padding:3px 10px">&nbsp;</td></tr>

  </cfoutput>

  <tr>
  <cfoutput query="GetEmpties">
    <cfif currentrow MOD 9 eq 1>
      </tr><tr>
    </cfif>
    <td style="padding:3px 10px"><a href="test.cfm?strpropid=#GetEmpties.strpropid#&strpropidNew=#GetPropids.strpropid#"><cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetEmpties.strpropid#"></a></td>
  </cfoutput>
  </tr>
  </table>

<cfelse>

  <cfquery name="GetOrphanPropids" datasource="#settings.dsn#">
    Select strpropid, strname from pp_propertyinfo
    where strpropid not in (<cfqueryparam value="#valuelist(GetFulls.strpropidNew)#" cfsqltype="cf_sql_varchar" list="true">)
  </cfquery>

  <table>
    <cfoutput query="GetOrphanPropids">
      <tr><td>#strpropid#</td><td>#strname#</td.></td>
    </cfoutput>
  </table>

</cfif>






<!--- 





<cfquery name="GetEmpties" datasource="#settings.dsn#">
  Select distinct strpropid from prop_images
  where strpropidNew is null
</cfquery>

<cfquery name="GetFulls" datasource="#settings.dsn#">
  Select distinct strpropid from prop_images
  where strpropidNew is not null
</cfquery>

<cfquery name="GetPropids" datasource="#settings.dsn#">
  Select strpropid, strname from pp_propertyinfo
  where strpropid not in (<cfqueryparam value="#valuelist(GetFulls.strpropid)#" cfsqltype="cf_sql_varchar" list="true">)
</cfquery>

<cfoutput>
  <h3 style="padding:3px 10px">#GetPropids.strname# <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetPropids.strpropid#"></h3>
  <table>
  <tr><td style="padding:3px 10px"><a href="test.cfm?strpropid=#GetEmpties.strpropid#&strpropidNew=skip">Skip</a></td></tr>
    <tr><td style="padding:3px 10px">&nbsp;</td></tr>

</cfoutput>

<tr>
<cfoutput query="GetPropids">
  <cfif currentrow MOD 5 eq 0>
    </tr><tr>
  </cfif>
  <td style="padding:3px 10px">#strname#<br><a href="test.cfm?strpropid=#GetEmpties.strpropid#&strpropidNew=#GetPropids.strpropid#"><cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#GetPropids.strpropid#"></a></td>
</cfoutput>
</tr>
</table>

 --->