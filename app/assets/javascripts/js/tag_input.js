jQuery(function ($) {
  var  tags = [];
  $.getJSON('/tags/return_json_tags', function(json) {
    tags = json;
  })
    .done(function() {
      tags_name = [];
      for (i in tags) {
        tags_name.push(tags[i].name);
      }
      $(".tags").autocomplete({
        source: tags_name
      })
    });

});
