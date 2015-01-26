jQuery(function ($) {
  var  tags = [];
  $.getJSON('/bookshelves/return_json_unfav_tags', function(json) {
    if(json.length == 0) return $(".tag_list").append("<p>タグがありません</p>");
    tags = json;
    search_tag(tags);
  });

  $("#_tag_name").keyup(function () {
    if(tags.length == 0) return;
    $(".tag_list > *").remove();
    search_tag(tags);
  });

  function search_tag(datas) {
    var split_input = $("#_tag_name").val().split(' ');
    var displayed = [];
    for(var i in split_input) {
      if(split_input[i] == '' && i > 0) continue;
      for(var j in datas ) {
        if(displayed.length == 30) return;
        if(datas[j].name.indexOf(split_input[i]) != -1 && $.inArray(datas[j].name, displayed) == -1 || $("#_tag_name").val() == "" ) {
          displayed.push(datas[j].name);
          $(".tag_list").append($("<p>")
            .append('<input id="tag_id_'+datas[j].id+'" name="tag_id[]" type="checkbox" value="'+datas[j].id+'">' )
            .append('<label for="tag_id_'+datas[j].id+'" id=\'name'+j+'\'>' + datas[j].name+ '</span>'));
        }
      }
    }
  }
});
