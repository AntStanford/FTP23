<cfset c = 0>
<!--- This path should start from the web root and work forward from
			there, if you don't have it in the web root --->
<cfset cffpPath = "/cfformprotect">

<!--- load the file that grabs all values from the ini file --->
<cfinclude template="#cffpPath#/cffpConfig.cfm">

<!--- Bas van der Graaf (bvdgraaf@e-dynamics.nl): Make sure JS is only included once when securing multiple forms with cfformprotect. --->
<cfif not structkeyExists(request,"cffpJS")>
	<script type="text/javascript" defer="defer"> <!--- /cfformprotect/js/cffp.js - minified here for all sites --->
  function getMousePos(e){if(!e)var e=window.event;e.pageX||e.pageY?(xPos=e.pageX,yPos=e.pageY):(e.clientX||e.clientY)&&(xPos=e.clientX+document.body.scrollLeft+document.documentElement.scrollLeft,yPos=e.clientY+document.body.scrollTop+document.documentElement.scrollTop)}function timedMousePos(){if(document.onmousemove=getMousePos,xPos>=0&&yPos>=0){var e=xPos,t=yPos;intervals++}1==intervals?(firstX=xPos,firstY=yPos):2==intervals&&(clearInterval(myInterval),calcDistance(firstX,firstY,e,t))}function calcDistance(e,t,s,o){var n=Math.round(Math.sqrt(Math.pow(e-s,2)+Math.pow(t-o,2)));try{for(var a=getInputElementsByClassName("cffp_mm"),l=0;l<a.length;l++)a[l].value=n}catch(r){}}function logKeys(){keysPressed++;for(var e=getInputElementsByClassName("cffp_kp"),t=0;t<e.length;t++)e[t].value=keysPressed}function dummy(){}var getInputElementsByClassName=function(e){var t=new Array,s=0,o=document.getElementsByTagName("input");for(i=0;i<o.length;i++)o[i].className==e&&(t[s]=o[i],s++);return t},myInterval=window.setInterval(timedMousePos,250),xPos=-1,yPos=-1,firstX=-1,firstY=-1,intervals=0,keysPressed=0;document.onkeypress=logKeys;
  </script>
	<cfset request.cffpJS = true>
</cfif>

<!--- check the config (from the ini file)to see if each test is turned on --->
<cfif cffpConfig.mouseMovement>
	<!--- If the user moves their mouse, put the distance in this field (JavaScript function handles this).
				cffpVerify.cfm will make sure the user at least used their keyboard. A spam
				bot won't trigger this --->
	<cfset c= c + 1>
	<input id="fp<cfoutput>#c#</cfoutput>" type="hidden" name="formfield1234567891" class="cffp_mm" value="" />
</cfif>

<cfif cffpConfig.usedKeyboard>
	<!--- If the types on their keyboard, put the amount of keys pressed in this field.
				cffpVerify.cfm will make sure the user at least used their keyboard. A spam
				bot won't trigger this --->
				<cfset c= c + 1>
	<input id="fp<cfoutput>#c#</cfoutput>" type="hidden" name="formfield1234567892" class="cffp_kp" value="" />
</cfif>

<cfif cffpConfig.timedFormSubmission>
	<!--- in cffpVerify.cfm I will verify that the amount of time it took to
				fill out this form is 'normal' (the time limits are set in the ini file)--->
	<!--- get the current time, obfuscate it and load it to this hidden field --->
	<cfset currentDate = dateFormat(now(),'yyyymmdd')>
	<cfset currentTime = timeFormat(now(),'HHmmss')>
	<!--- Add an arbitrary number to the date/time values to mask them from prying eyes --->
	<cfset blurredDate = currentDate+19740206>
	<cfset blurredTime = currentTime+19740206>
	<cfset c= c + 1>
	<input id="fp<cfoutput>#c#</cfoutput>" type="hidden" name="formfield1234567893" value="<cfoutput>#blurredDate#,#blurredTime#</cfoutput>" />
</cfif>

<cfif cffpConfig.hiddenFormField>
	<!--- A lot of spam bots automatically fill in all form fields.  cffpVerify.cfm will
				test to see if this field is blank. The "leave this empty" text is there for blind people,
				who might see this hidden field --->
				<cfset c= c + 1>
	<span style="display:none">Leave this field empty <input id="fp<cfoutput>#c#</cfoutput>" type="text" name="formfield1234567894" value="" /></span>
</cfif>