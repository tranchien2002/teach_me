$(document).ready(function() {
  (function() {
    App.close_conversation = App.cable.subscriptions.create({
        channel: 'CloseConversationChannel'
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        if(data.notification_close){
          $("#notifications-" + data.close_notify_user).prepend(data.notification_close)
          $("#notifying-"+ data.close_notify_user).addClass("notifying");
          $("#notifying-"+ data.close_notify_user).on("click", function () {
            $("#notifying-"+ data.close_notify_user).removeClass("notifying")
          })
        }
      }
    });
    }).call(this);
})
