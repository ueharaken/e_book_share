jQuery(function ($) {
  var  tags = [];
  $.getJSON('/tags/return_json_tags', function(json) {
    tags = json;
    tag_autocomplete(json);
  })

  $(".add_tag").click(function() {
    $("#input_taglist").append('<li><input class="tags ui-autocomplete-input" name="tags[]" type="text" autocomplete="off"></li>');
    tag_autocomplete(tags);
  });

  $(".remove_tag").click(function() {
    if($("#input_taglist> li").length != 1) {
      $("#input_taglist> li:last-child").remove();
    }
    tag_autocomplete(tags);
  });

  function tag_autocomplete(tag) {
    tags_name = [];
    for (i in tag) {
      tags_name.push(tag[i].name);
    }
    $(".tags").autocomplete({
      source: tags_name
    })
  }

});
