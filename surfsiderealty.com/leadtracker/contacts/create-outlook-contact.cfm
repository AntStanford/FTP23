	<CFQUERY DATASOURCE="#mls.dsn#" NAME="GetInfo">
		SELECT * 
		FROM cl_accounts
		where id = '#id#'
	</CFQUERY>


<cffile action="WRITE" file="#UploadPathOutlook#\#url.id#.vcf" output="BEGIN:VCARD
VERSION:2.1
N:#GetInfo.firstname# #GetInfo.lastname#
FN:#GetInfo.firstname# #GetInfo.lastname#
ORG:
TITLE:
TEL;WORK;VOICE: #GetInfo.phone#
TEL;CELL;VOICE:#GetInfo.cellphone#
TEL;CELL;VOICE:#GetInfo.officephone#
ADR;WORK:;#GetInfo.address#;#GetInfo.address2#;#GetInfo.city#;#GetInfo.state#;#GetInfo.zip#;United States of America
LABEL;WORK;ENCODING=QUOTED-PRINTABLE:#GetInfo.address#, #GetInfo.address2#=0D=0A#GetInfo.city#, #GetInfo.state# #GetInfo.zip#=0D=0AUnited States of America
EMAIL;PREF;INTERNET:#GetInfo.email#
REV:#url.id#
END:VCARD" addnewline="Yes" fixnewline="No">



<cfoutput>
<script language="JavaScript">
		window.location="/admin/contacts/outlook/#url.id#.vcf"
	</script>
</cfoutput>