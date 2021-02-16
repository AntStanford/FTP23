
function validateForm()
{
var x=document.forms["thisform"]["firstname"].value;
if (x==null || x=="")
  {
  alert("First name is required.");
  return false;
  }
  
  var x=document.forms["thisform"]["lastname"].value;
if (x==null || x=="")
  {
  alert("Last name is required.");
  return false;
  }
  
    var x=document.forms["thisform"]["email"].value;
if (x==null || x=="")
  {
  alert("Email is required.");
  return false;
  }
  
var x=document.forms["thisform"]["email"].value;
var atpos=x.indexOf("@");
var dotpos=x.lastIndexOf(".");
if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
  {
  alert("Not a valid e-mail address");
  return false;
  }
  

}
