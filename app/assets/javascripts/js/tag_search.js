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
    $("#search-hidden").remove();
    $(".tag_list").append("<input type='hidden' value='" + $("#_tag_name").val() + "' id='search-hidden' name='tag_name'>");
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
          $(".tag_list > tbody").append($("<tr>")
            .append($('<td>')
              .append('<input id="tag_id_'+datas[j].id+'" name="tag_id[]" type="checkbox" value="'+datas[j].id+'">')
              .append('<label for="tag_id_'+datas[j].id+'" id=\'name'+j+'\'>' + datas[j].name+ '</span>'))
            .append($('<td>')
              .append('<input type=\'button\' value=\'編集\' onClick="javascript:edit('+j+', '+datas[j].id+', \''+datas[j].name+'\');" id=\'button'+j+'\' >'))
            .append($('<td>')
              .append('<a data-confirm=\'削除します\' data-method=\'delete\' href=\'/tags/' + datas[j].id + '\' rel=\'nofollow\'>削除</a>')));
        }
      }
    }
  }
});

function edit(i, id, name) {
  $("#name"+i).replaceWith('<form class=\'edit-tag\' action=\'/tags/'+id+'/update\' method=\'post\' name=\'frm'+i+'\'><input type=\'text\' name=\'@tag[name]\' value=\''+name+'\'></form>');
  $("#button"+i).replaceWith('<input type=\'button\' value=\'登録\' onClick="javascript:document.frm'+i+'.submit();">');
}
