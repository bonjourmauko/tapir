// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function ShowLoading()
{
  $('#loading_box').slideDown()
}

function HideLoading()
{
  $('#loading_box').slideUp()
}

$(document).ready(function() {
  
  //$('.force_full_width').each(function(){width($(this).parent().width())})
  $('.force_full_width').each(function(){$(this).width($(this).parent().width())})

  
})