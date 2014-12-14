jQuery(function ($) {
  ENTER_KEY= 13
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
        $("tbody").append(
          '<tr><td>・' + datas[i].name+ '</td>'
          + '<td><a data-confirm="削除します" data-method="delete" href="/tags/' + datas[i].id + '" rel="nofollow">削除</a></td></tr>');
      }
    }
  }

});
