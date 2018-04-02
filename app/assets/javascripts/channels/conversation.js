$(document).ready(function() {
  (function() {
    App.conversation = App.cable.subscriptions.create({
      channel: 'ConversationChannel'
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        if (data.content.blank == null) {
          $('#list-message').append('<li>' + '<div class="rightside-left-chat">' +
           '<span>' + ' <i class="fa fa-circle" aria-hidden="true"></i>' + data.username + ":" +
           '<small>' + data.created_at + '</small>' +
           '</span>' + '<br><br>' +
           '<p>' + data.content + '</p>' +
           '</div>' + '</li>'
          );

        }
        if (data.notify_to){
          $("#conversation-" + data.notify_to).addClass("notifying");
          $("#conversation-" + data.notify_to).on("click", function () {
              $("#conversation-"+ data.notify_to).removeClass("notifying")
          })
        }
      },
    });
  }).call(this);
})
