<cfset table = 'cms_contacts'>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->

	<cfquery dataSource="#application.dsn#">
    	delete from cms_contacts where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  	</cfquery>

  	<cflocation addToken="no" url="index.cfm?success">

<cfelseif isdefined('form.id')> <!--- update statement --->

  <cfif len(form.email)>
    <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
  <cfelse>
    <cfset variables.encEmail = ''>
  </cfif>
  <cfif len(form.phone)>
    <cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
  <cfelse>
    <cfset variables.encPhone = ''>
  </cfif>

  <cfquery dataSource="#application.dsn#">
    update cms_contacts set
    firstname = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
    lastname = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
    email = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,
    phone = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encPhone#">,
    comments = <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.comments#">
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>

  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->

  <cfif len(form.email)>
    <cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
  <cfelse>
    <cfset variables.encEmail = ''>
  </cfif>
  <cfif len(form.phone)>
    <cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
  <cfelse>
    <cfset variables.encPhone = ''>
  </cfif>

  <cfquery dataSource="#application.dsn#">
    insert into cms_contacts(firstname,lastname,email,phone,comments)
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encPhone#">,
      <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.comments#">
    )
  </cfquery>

  <cflocation addToken="no" url="form.cfm?success">

</cfif>