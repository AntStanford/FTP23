// START: Create an Account Validation

function validateForm()
{
var x=document.forms["thisform"]["firstname"].value;
if (x==null || x=="")
  {
  alert("First Name is a required field.");
  return false;
  }
  
  var x=document.forms["thisform"]["lastname"].value;
if (x==null || x=="")
  {
  alert("Last Name is a required field.");
  return false;
  }

  var x=document.forms["thisform"]["Phone"].value;
if (x==null || x=="")
  {
  alert("Phone is a required field.");
  return false;
  }


  
    var x=document.forms["thisform"]["email"].value;
if (x==null || x=="")
  {
  alert("Email is a required field.");
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
  

  var x=document.forms["thisform"]["thepassword"].value;
if (x==null || x=="")
  {
  alert("Password is a required field.");
  return false;
  }
  

}

// END: Create an Account Validation