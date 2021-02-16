  function hideshow(which){
  if (!document.getElementById)
  return
  if (which.style.display=="table-cell")
  which.style.display="none"
  else
  which.style.display="table-cell"
  }

//Your JQuery Code Here
$(document).ready(function(){   
    
//Navigation hover
$('.contacttabs li:has(ul)').hover(
  function(){
    $(this).find('ul:first').show();
  },
  function(){
    $(this).find('ul:first').hide();
  }
);
    
});