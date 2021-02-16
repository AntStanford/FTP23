// Select Action Changer

var oXmlHttpActionSelector

function ActionSelector(str)
{
var url="/admin/leadtracker/components/action-selector.cfm?&clientaction=" + str
oXmlHttpActionSelector=GetHttpObject(stateChangedAction)
oXmlHttpActionSelector.open("GET", url , true)
oXmlHttpActionSelector.send(null)
}

function stateChangedAction()
{
if (oXmlHttpActionSelector.readyState==4 || oXmlHttpActionSelector.readyState=="complete")
{
document.getElementById("searchresultsActionChange").innerHTML=oXmlHttpActionSelector.responseText
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


function hideshow(which){
	if (!document.getElementById)
	return
	if (which.style.display=="table-cell")
	which.style.display="table-cell"
	else
	which.style.display="table-cell"
}


function hidemessage(which){
	which.style.display="none"
}