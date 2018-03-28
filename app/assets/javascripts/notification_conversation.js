$(document).ready(function() {
  (function() {
    App.notification_conversation = App.cable.subscriptions.create({
      channel: 'NotificationConversationChannel'
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        if(data.owner_conversation){
          $("#notifications-" + data.owner_conversation).prepend(data.notification)
          $("#notifying-"+ data.owner_conversation).addClass("notifying");
          $("#notifying-"+ data.owner_conversation).on("click", function () {
            $("#notifying-"+ data.owner_conversation).removeClass("notifying")
          })
        }
      }
    });
  }).call(this);
})

