

function validatePlanForm()
{



var a=document.forms["thisform"]["Lib_2_TemplateID"].value;
var a= parseInt(a);
var b=document.forms["thisform"]["Lib_3_TemplateID"].value;
var b= parseInt(b);
var c=document.forms["thisform"]["Lib_4_TemplateID"].value;
var c= parseInt(c);
var d=document.forms["thisform"]["Lib_5_TemplateID"].value;
var d= parseInt(d);
var Wone=document.forms["thisform"]["Lib_1_WaitDays"].value;
var Wone= parseInt(Wone);
var Wtwo=document.forms["thisform"]["Lib_2_WaitDays"].value;
var Wtwo= parseInt(Wtwo);
var Wthree=document.forms["thisform"]["Lib_3_WaitDays"].value;
var Wthree= parseInt(Wthree);
var Wfour=document.forms["thisform"]["Lib_4_WaitDays"].value;
var Wfour= parseInt(Wfour);
var Wfive=document.forms["thisform"]["Lib_5_WaitDays"].value;
var Wfive= parseInt(Wfive);

if (a != "0" && Wone >= Wtwo)
  {
  alert("Step Two needs to be scheduled after Step One");
  return false;
  }

if (b != "0" && Wtwo >= Wthree)
  {
  alert("Step Three needs to be scheduled after Step Two");
  return false;
  }

if (c != "0" && Wthree >= Wfour)
  {
  alert("Step Four needs to be scheduled after Step Three");
  return false;
  }

if (d != "0" && Wfour >= Wfive)
  {
  alert("Step Five needs to be scheduled after Step Four");
  return false;
  }


 var x=document.forms["thisform"]["Lib_PlanName"].value;
if (x==null || x=="")
  {
  alert("Plan Name is required.");
  return false;
  }
 
  var x=document.forms["thisform"]["Lib_1_TemplateID"].value;
if (x==null || x=="" || x=="0")
  {
  alert("Step One - Template is required.");
  return false;
  }
  
    var x=document.forms["thisform"]["Lib_1_Subject"].value;
if (x==null || x=="")
  {
  alert("Step One - Subject is required.");
  return false;
  }
  
    var x=document.forms["thisform"]["Lib_1_ModifiedTemplate"].value;
if (x==null || x=="")
  {
  alert("Step One - Message is required.");
  return false;
  }


 var x=document.forms["thisform"]["Lib_1_ModifiedTemplate"].value;
if (x==null || x=="")
  {
  alert("Step One - Message is required.");
  return false;
  } 

}

 // && Wone >= Wtwo

 // var x=document.forms["thisform"]["PlanName"].value;
// if (x==null || x=="")
//   {
//   alert("Plan Name is required.");
//   return false;
//   }
 
//   var x=document.forms["thisform"]["StepOneTemplateID"].value;
// if (x==null || x=="" || x=="0")
//   {
//   alert("Step One - Template is required.");
//   return false;
//   }
  
//     var x=document.forms["thisform"]["StepOneSubject"].value;
// if (x==null || x=="")
//   {
//   alert("Step One - Subject is required.");
//   return false;
//   }
  
//     var x=document.forms["thisform"]["StepOneMessageBody"].value;
// if (x==null || x=="")
//   {
//   alert("Step One - Message is required.");
//   return false;
//   }


//  var x=document.forms["thisform"]["StepOneMessageBody"].value;
// if (x==null || x=="")
//   {
//   alert("Step One - Message is required.");
//   return false;
//   }