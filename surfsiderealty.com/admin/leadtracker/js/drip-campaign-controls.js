// USED TO PULL TEMPLATES INTO DRIP CAMPAIGN EDITOR

// STEP ONE - TEMPLATE SELECT BOX
var oXmlHttpTemplate1

function getStepOneTemplate(str)
	{
	var url="/admin/leadtracker/components/drip-get-templates.cfm?&TemplateID=" + str
	oXmlHttpTemplate1=GetHttpObject(StepOneTemplateChanged)
	oXmlHttpTemplate1.open("GET", url , true)
	oXmlHttpTemplate1.send(null)
	}

	function StepOneTemplateChanged()
	{
	if (oXmlHttpTemplate1.readyState==4 || oXmlHttpTemplate1.readyState=="complete")
	{
	document.getElementById("StepOneTemplateChanged").innerHTML=oXmlHttpTemplate1.responseText
	}
	}

	function GetHttpObject(handler)
	{
	try
	{
	var oRequester = new XMLHttpRequest();
		oRequester.onload=handler
		oRequester.onerror=handler
		return oRequester
	}
	catch (error)
	{
	try
	{
	var oRequester = new ActiveXObject("Microsoft.XMLHTTP");
	oRequester.onreadystatechange=handler
	return oRequester
	}
	catch (error)
	{
	return false;
	}
	}
}


// STEP TWO - TEMPLATE SELECT BOX
var oXmlHttpTemplate2

function getStepTwoTemplate(str)
	{
	var url="/admin/leadtracker/components/drip-get-templates.cfm?&TemplateID=" + str
	oXmlHttpTemplate2=GetHttpObject(StepTwoTemplateChanged)
	oXmlHttpTemplate2.open("GET", url , true)
	oXmlHttpTemplate2.send(null)
	}

	function StepTwoTemplateChanged()
	{
	if (oXmlHttpTemplate2.readyState==4 || oXmlHttpTemplate2.readyState=="complete")
	{
	document.getElementById("StepTwoTemplateChanged").innerHTML=oXmlHttpTemplate2.responseText
	}
	}

	function GetHttpObject(handler)
	{
	try
	{
	var oRequester = new XMLHttpRequest();
		oRequester.onload=handler
		oRequester.onerror=handler
		return oRequester
	}
	catch (error)
	{
	try
	{
	var oRequester = new ActiveXObject("Microsoft.XMLHTTP");
	oRequester.onreadystatechange=handler
	return oRequester
	}
	catch (error)
	{
	return false;
	}
	}
}

// STEP Three - TEMPLATE SELECT BOX
var oXmlHttpTemplate3

function getStepThreeTemplate(str)
	{
	var url="/admin/leadtracker/components/drip-get-templates.cfm?&TemplateID=" + str
	oXmlHttpTemplate3=GetHttpObject(StepThreeTemplateChanged)
	oXmlHttpTemplate3.open("GET", url , true)
	oXmlHttpTemplate3.send(null)
	}

	function StepThreeTemplateChanged()
	{
	if (oXmlHttpTemplate3.readyState==4 || oXmlHttpTemplate3.readyState=="complete")
	{
	document.getElementById("StepThreeTemplateChanged").innerHTML=oXmlHttpTemplate3.responseText
	}
	}

	function GetHttpObject(handler)
	{
	try
	{
	var oRequester = new XMLHttpRequest();
		oRequester.onload=handler
		oRequester.onerror=handler
		return oRequester
	}
	catch (error)
	{
	try
	{
	var oRequester = new ActiveXObject("Microsoft.XMLHTTP");
	oRequester.onreadystatechange=handler
	return oRequester
	}
	catch (error)
	{
	return false;
	}
	}
}


// STEP Four - TEMPLATE SELECT BOX
var oXmlHttpTemplate4

function getStepFourTemplate(str)
	{
	var url="/admin/leadtracker/components/drip-get-templates.cfm?&TemplateID=" + str
	oXmlHttpTemplate4=GetHttpObject(StepFourTemplateChanged)
	oXmlHttpTemplate4.open("GET", url , true)
	oXmlHttpTemplate4.send(null)
	}

	function StepFourTemplateChanged()
	{
	if (oXmlHttpTemplate4.readyState==4 || oXmlHttpTemplate4.readyState=="complete")
	{
	document.getElementById("StepFourTemplateChanged").innerHTML=oXmlHttpTemplate4.responseText
	}
	}

	function GetHttpObject(handler)
	{
	try
	{
	var oRequester = new XMLHttpRequest();
		oRequester.onload=handler
		oRequester.onerror=handler
		return oRequester
	}
	catch (error)
	{
	try
	{
	var oRequester = new ActiveXObject("Microsoft.XMLHTTP");
	oRequester.onreadystatechange=handler
	return oRequester
	}
	catch (error)
	{
	return false;
	}
	}
}

// STEP Five - TEMPLATE SELECT BOX
var oXmlHttpTemplate5

function getStepFiveTemplate(str)
	{
	var url="/admin/leadtracker/components/drip-get-templates.cfm?&TemplateID=" + str
	oXmlHttpTemplate5=GetHttpObject(StepFiveTemplateChanged)
	oXmlHttpTemplate5.open("GET", url , true)
	oXmlHttpTemplate5.send(null)
	}

	function StepFiveTemplateChanged()
	{
	if (oXmlHttpTemplate5.readyState==4 || oXmlHttpTemplate5.readyState=="complete")
	{
	document.getElementById("StepFiveTemplateChanged").innerHTML=oXmlHttpTemplate5.responseText
	}
	}

	function GetHttpObject(handler)
	{
	try
	{
	var oRequester = new XMLHttpRequest();
		oRequester.onload=handler
		oRequester.onerror=handler
		return oRequester
	}
	catch (error)
	{
	try
	{
	var oRequester = new ActiveXObject("Microsoft.XMLHTTP");
	oRequester.onreadystatechange=handler
	return oRequester
	}
	catch (error)
	{
	return false;
	}
	}
}


// Updates Subject Line for each Template

function UpdateSubjectOne(){
	document.getElementById('StepOneSubject').value = document.getElementById('StepOneTemplateID').options[document.getElementById('StepOneTemplateID').selectedIndex].text;
}

function UpdateSubjectTwo(){
	document.getElementById('StepTwoSubject').value = document.getElementById('StepTwoTemplateID').options[document.getElementById('StepTwoTemplateID').selectedIndex].text;
}

function UpdateSubjectThree(){
	document.getElementById('StepThreeSubject').value = document.getElementById('StepThreeTemplateID').options[document.getElementById('StepThreeTemplateID').selectedIndex].text;
}

function UpdateSubjectFour(){
	document.getElementById('StepFourSubject').value = document.getElementById('StepFourTemplateID').options[document.getElementById('StepFourTemplateID').selectedIndex].text;
}

function UpdateSubjectFive(){
	document.getElementById('StepFiveSubject').value = document.getElementById('StepFiveTemplateID').options[document.getElementById('StepFiveTemplateID').selectedIndex].text;
}