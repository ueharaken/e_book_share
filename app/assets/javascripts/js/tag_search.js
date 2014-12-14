jQuery(function ($) {
  ENTER_KEY = 13
  $("form").on("keypress", "input:not(:submit), select", function(ev) {
    return ev.which !== ENTER_KEY && ev.keyCode !== ENTER_KEY
  });

  var  tags = [];
  $.getJSON('/tags/return_json_tags', function(json) {
    if(json.length !== 0) tags = json;
    search_tag(tags);
  });

  $("#_tag_name").keyup(function () {
    $("tbody > tr").remove();
    search_tag(tags);
  });

  function search_tag(datas) {
    if(datas.length == 0) return $("tbody").append("<tr><td>タグがありません</td></tr>");
    for(var i in datas ) {
      if(datas[i].name.indexOf($("#_tag_name").val()) != -1 || $("#_tag_name").val() == "") {
        $("tbody").append($("<tr>")
          .append($('<td>')
            .append('<span id=\'name'+i+'\'>・' + datas[i].name+ '</span>'))
          .append($('<td>')
            .append('<input type=\'button\' value=\'編集\' onClick="javascript:edit('+i+', '+datas[i].id+', \''+datas[i].name+'\');" id=\'button'+i+'\' >'))
          .append($('<td>')
            .append('<a data-confirm=\'削除します\' data-method=\'delete\' href=\'/tags/' + datas[i].id + '\' rel=\'nofollow\'>削除</a>')));
      }
    }
  }
});

function edit(i, id, name) {
  $("#name"+i).replaceWith('<form action=\'/tags/'+id+'/update\' method=\'post\' name=\'frm'+i+'\'><input type=\'text\' name=\'@tag[name]\' value=\''+name+'\'></form>');
  $("#button"+i).replaceWith('<input type=\'button\' value=\'登録\' onClick="javascript:document.frm'+i+'.submit();">');
}
