jQuery(function ($) {
  var form_default_height = $('#book_search').height();
  if($(window).width() < 667) {
    $('#book_search').height(0);
  }

  $('#on-off-label').click(function() {
    if($('#book_search').height() == 0) {
      var form_height = form_default_height + $('.tag_list').height();
      $('#book_search').animate({
        height: form_height
      }, 500, 'linear', function() {
        $('#book_search').addClass('adjust_height');
      });
    } else {
      if($(window).width() > 667) {
        return;
      }
      $('#book_search').removeClass('adjust_height');
      $('#book_search').animate({
        height: 0
      }, 500);
    }
  });
});
