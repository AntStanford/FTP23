<cfoutput>
<table class="table table-striped">
<tr class="info">
	<td><b>Description</b></td>
	<td><b>Price</b></td>
</tr>

<!--- Loop through all the taxes and fees and tally up the total amount --->
<cfif isdefined('feesArray')>
	<cfloop from="1" to="#arraylen(feesArray)#" index="i">
	   
	   <cfset ratesid = feesArray[i].ratesid.xmltext>
      <cfset description = feesArray[i].ratesname.xmltext>
      
      <!--- Add this in case the user enters a valid promo code --->
	   <cfif ratesid eq 0>
	     <cfset description = 'Promo discount'>   	   
	   </cfif>
	   
	   <cfif description contains 'insurance'>
	   	<cfset travelinsuranceAmt = feesArray[i].ratesvalue.xmltext>
	   </cfif>
	   
		<tr>
		   <td>#description#</td>
		   <td>#DollarFormat(feesArray[i].ratesvalue.xmltext)#</td>
		</tr>
		<cfset totalamount = totalamount + #feesArray[i].ratesvalue.xmltext#>
	</cfloop>
</cfif>

<tr class="success"><td>Total Amount</td><td>#DollarFormat(totalamount)#</td></tr>

<cfif isdefined('depositsArray')>									

	<cfloop from="1" to="#arraylen(depositsArray)#" index="i">
		
		<!---
		Uncomment this if the first deposit should be due today instead of the total amount
		<cfif i eq 1>
			<cfset totalAmount = depositsArray[i].amount.xmltext>
		</cfif> --->
		
		<tr class="warning">
			<td><strong>Due on #depositsArray[i].duedate.xmltext#</strong></td>
			<td><strong>#DollarFormat(depositsArray[i].amount.xmltext)#</strong></td>
		</tr>										
	</cfloop>									

</cfif>

</table>

<h3>Protect Your Trip</h3>
<b>Travel Insurance</b> - Protect your payments should you have to cancel.
<p><input type="radio" name="travel_insurance" value="add_insurance" id="addinsurance"       data-serviceid="#settings.booking.barefootInsuranceServiceID#" <cfif arguments.useraction is 'add_insurance'>CHECKED</cfif>> <label for="addinsurance">Add travel insurance for #Dollarformat(travelinsuranceAmt)#</label></p>
<p><input type="radio" name="travel_insurance" value="remove_insurance" id="removeinsurance" data-serviceid="#settings.booking.barefootInsuranceServiceID#" <cfif arguments.useraction is 'remove_insurance' or arguments.useraction eq ''>CHECKED</cfif> > <label class="nothanks" for="removeinsurance">No thanks, I am not interested in travel insurance</label></p>

<!--- This script loads the data from the API call to the hidden input fields in the checkout form --->
<script type="text/javascript">         
   $('input##totalAmountforAPI').val("#totalamount#");
   $('input##Total').val("#totalamount#"); 				                           
</script>

<cfif arguments.useraction is 'add_insurance'>
	<script type="text/javascript">         
   	$('input##tripinsuranceamount').val("#travelinsuranceAmt#");
   	$('input##addInsurance').val("true");				                           
	</script>
<cfelseif arguments.useraction is 'remove_insurance'>
	<script type="text/javascript">         
   	$('input##tripinsuranceamount').val(0);
   	$('input##addInsurance').val("false");				                           
	</script>
</cfif>
				      		
</cfoutput>