<!--- Create Email Dates For Each Step if Campaign already has a start date --->
<cfif LEN(getCampaign.DRIPSTARTDATE)>

	<!--- Step One --->
	<cfif isdefined('form.StepOneWait') and form.StepOneTemplateID neq 0 and LEN(form.StepOneSubject) and LEN(form.StepOneMessageBody)>
		<cfset StepOneDate = DateAdd('d',form.StepOneWait,getCampaign.DRIPSTARTDATE)>
	</cfif>

	<!--- Step Two --->
	<cfif isdefined('form.StepTwoWait') and  form.StepTwoTemplateID neq 0 and LEN(form.StepTwoSubject) and LEN(form.StepTwoMessageBody)>
		<cfset StepTwoDate = DateAdd('d',form.StepTwoWait,getCampaign.DRIPSTARTDATE)>
	</cfif>

	<!--- Step Three --->
	<cfif isdefined('form.StepThreeWait') and  form.StepThreeTemplateID neq 0 and LEN(form.StepThreeSubject) and LEN(form.StepThreeMessageBody)>
		<cfset StepThreeDate = DateAdd('d',form.StepThreeWait,getCampaign.DRIPSTARTDATE)>
	</cfif>

	<!--- Step Four --->
	<cfif isdefined('form.StepFourWait') and  form.StepFourTemplateID neq 0 and LEN(form.StepFourSubject) and LEN(form.StepFourMessageBody)>
		<cfset StepFourDate = DateAdd('d',form.StepFourWait,getCampaign.DRIPSTARTDATE)>
	</cfif>

	<!--- Step One --->
	<cfif isdefined('form.StepFiveWait') and  form.StepFiveTemplateID neq 0 and LEN(form.StepFiveSubject) and LEN(form.StepFiveMessageBody)>
		<cfset StepFiveDate = DateAdd('d',form.StepFiveWait,getCampaign.DRIPSTARTDATE)>
	</cfif>

<cfelseif isDefined('form.startnow') and form.startnow eq 1 and LEN(getCampaign.DRIPSTARTDATE) eq 0><!--- Create Email Dates For Each Step if Campaign was created but never started --->


	<!--- Step One --->
	<cfif isdefined('form.StepOneWait') and form.StepOneTemplateID neq 0 and LEN(form.StepOneSubject) and LEN(form.StepOneMessageBody)>
		<cfset StepOneDate = DateAdd('d',form.StepOneWait,CreateODBCDate(now()))>
	</cfif>

	<!--- Step Two --->
	<cfif isdefined('form.StepTwoWait') and  form.StepTwoTemplateID neq 0 and LEN(form.StepTwoSubject) and LEN(form.StepTwoMessageBody)>
		<cfset StepTwoDate = DateAdd('d',form.StepTwoWait,CreateODBCDate(now()))>
	</cfif>

	<!--- Step Three --->
	<cfif isdefined('form.StepThreeWait') and  form.StepThreeTemplateID neq 0 and LEN(form.StepThreeSubject) and LEN(form.StepThreeMessageBody)>
		<cfset StepThreeDate = DateAdd('d',form.StepThreeWait,CreateODBCDate(now()))>
	</cfif>

	<!--- Step Four --->
	<cfif isdefined('form.StepFourWait') and  form.StepFourTemplateID neq 0 and LEN(form.StepFourSubject) and LEN(form.StepFourMessageBody)>
		<cfset StepFourDate = DateAdd('d',form.StepFourWait,CreateODBCDate(now()))>
	</cfif>

	<!--- Step One --->
	<cfif isdefined('form.StepFiveWait') and  form.StepFiveTemplateID neq 0 and LEN(form.StepFiveSubject) and LEN(form.StepFiveMessageBody)>
		<cfset StepFiveDate = DateAdd('d',form.StepFiveWait,CreateODBCDate(now()))>
	</cfif>

</cfif>