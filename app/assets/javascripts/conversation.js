var rating = function(){
  $.ajax({
    url: "/conversations/" + $("#conversation-id").text(),
    type: "put",
    data: {rate_point: $(this).val()}
  })
}
$(document).ready(function() {
  if($("#chat-form")[0]){
    $("#chat-form")[0].scrollIntoView();
  }
  if ($("#rating")){
    var stars = $(".stars");
    for(var i = 0; i < stars.length; i++){
      $("#"+stars[i].id).bind('click',rating)
    }
    $("#rating").modal("show")
  }
});
