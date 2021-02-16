<cfset table = 'cms_users'>

<!--- Location of key used to encrypt the salt; stored outside of webroot --->
<cfset authKeyLocation = expandpath('../../../auth/key.txt')>
<cffile action="read" file="#authKeyLocation#" variable="authkey">

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
	<cfquery dataSource="#settings.dsn#">
    	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  	</cfquery>
  	
  	<cflocation addToken="no" url="index.cfm?success">
  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <!--- Only do this if user provides a new password --->
  <cfif len(form.password)>
  
    <!--- Generate a salt --->
    <cfset theSalt = createUUID() />
    
    
    <!--- Hash the password with the salt in it's plain form--->
    <cfset passwordHash = Hash(form.password & theSalt, 'SHA-512') /> 
    
    
    <!--- The encrypted salt to store in the database, using the authKey--->
    <cfset encryptedSalt = encrypt(theSalt, authKey, 'AES','Base64')>
  
  </cfif>
  
  
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,    
    email = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">
    <cfif len(form.password)>,password = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#passwordHash#"></cfif>
    <cfif len(form.password)>,encryptedSalt = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#encryptedSalt#"></cfif>    
    where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">
  
<cfelse>  <!---insert statement--->
  
  
  <!--- Generate a salt --->
  <cfset theSalt = createUUID() />
  
  
  <!--- Hash the password with the salt in it's plain form--->
  <cfset passwordHash = Hash(form.password & theSalt, 'SHA-512') /> 
  
  
  <!--- The encrypted salt to store in the database, using the authKey--->
  <cfset encryptedSalt = encrypt(theSalt, authKey, 'AES','Base64')>
  
  
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(name,email,password,role,encryptedSalt)    
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,      
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#passwordHash#">,
      'client',
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#encryptedSalt#">    
    )
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?success">
  
</cfif>