jQuery(function ($) {
  ENTER_KEY = 13
  $("form").on("keypress", "input:not(:submit), select", function(ev) {
    return ev.which !== ENTER_KEY && ev.keyCode !== ENTER_KEY
  });

  var  tags = [];
  $.getJSON('/tags/return_json_tags', function(json) {
    if(json.length == 0) return $(".tag_list > tbody").append("<tr><td>タグがありません</td></tr>");
    tags = json;
    search_tag(tags);
  });

  $("#_tag_name").keyup(function () {
    if(tags.length == 0) return;
    $(".tag_list > tbody > tr").remove();
    search_tag(tags);
  });

  function search_tag(datas) {
    var split_input = $("#_tag_name").val().split(' ');
    var displayed = [];
    for(var i in split_input) {
      if(split_input[i] == '' && i > 0) continue;
      for(var j in datas ) {
        if(datas[j].name.indexOf(split_input[i]) != -1 && $.inArray(datas[j].name, displayed) == -1 || $("#_tag_name").val() == "" ) {
          displayed.push(datas[j].name);
          var checked = is_checked(datas[j].id);
          $(".tag_list > tbody").append($("<tr>")
            .append($('<td>')
              .append('<input id="tag_id_'+datas[j].id+'" name="tag_id[]" type="checkbox" '+checked+' value="'+datas[j].id+'">' )
              .append('<label for="tag_id_'+datas[j].id+'" id=\'name'+j+'\'>' + datas[j].name+ '</span>')));
        }
      }
    }
  }

  function is_checked(tag_id) { 
    var vars = [], hash; 
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&'); 
    for(var i = 0; i < hashes.length; i++) { 
        hash = hashes[i].split('=');
        if (hash[0] == 'tag_id%5B%5D') {
          if(hash[1] == tag_id) return 'checked'
        }
    }
    return ''; 
  }
});
