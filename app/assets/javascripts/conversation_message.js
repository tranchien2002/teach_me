$(document).ready(function() {
  var height = $(window).height();
  $('.left-chat').css('height', (height - 92) + 'px');
  $('.right-header-contentChat').css('height', (height - 163) + 'px');

  $('#form-message').on('keydown', function(event) {
    if (event.keyCode === 13) {
      message_content = event.target.value
      conversation_id = $("#conversation-id").text()
      $.ajax({
        url: "/messages",
        method: "post",
        data: {message:{content: message_content, conversation_id: conversation_id}},
        success: function(result){
          event.target.value = "";
        }
      })
      return event.preventDefault();
    }
  })
})
