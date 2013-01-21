$(function() {
  $('ol.nested_set li').click(function ( e ) {
    
    if($(this).children().hasClass('visible')) {
      $(this)
       .children('ol')
       .hide( 0 )
       .removeClass('visible');
    }
    else {
      $(this)
       .children('ol')
       .show( 0 )
       .addClass('visible');
    }

    return false;
  });
$('ol.nested_set li a').dblclick(function ( e ) {

  window.location = $(this).attr('href');
});
  $('ol.nested_set li')
  .children('ol')
  .hide(0);
  
  $('a.active').parents('ol')
    .show()
    .addClass('visible');

});
