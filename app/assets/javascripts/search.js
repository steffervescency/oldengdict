// silly way to decode HTML entities
function html_entity_decode(input) {
  var y = document.createElement('textarea');
  y.innerHTML = input;
  return y.value;
}

// add ash or thorn to the input when buttons are clicked
function append_search(cha) {
    $("#search").val($("#search").val() + html_entity_decode(cha))
    $("#search").focus()
}

// submit search
function submit_search() {
    search_string = $("#search").val()
    sourcelang = $('input[name=sourcelang]:checked').val()
    if(search_string.length > 0) {
        $("#search_form").attr("action", "/" + sourcelang + "/" + search_string);
        return true;
    }
    return false;
}

$(function () {
    $("#ash").click(function() { append_search("&aelig;") });
    $("#thorn").click(function() { Math.random() > 0.5 ? append_search("&eth;") : append_search("&thorn;")});
    $("#go").click(function() {
        $("#search_form").submit();
    });
})