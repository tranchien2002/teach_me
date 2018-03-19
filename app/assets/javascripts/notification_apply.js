$(document).ready(function() {
  (function() {
    App.notification_apply = App.cable.subscriptions.create({
      channel: 'NotificationApplyChannel'
      },
      {
        connected: function() {},
        disconnected: function() {},
        received: function(data) {
          if(data.applier) {
            $("#list-appliers-" + data.request_id).append(data.applier);
          }
          if(data.owner_request){
            $("#notifications-" + data.owner_request).prepend(data.notification)
            $("#notifying-"+ data.owner_request).css("color", "red")
          }
            $("#notifying-"+ data.owner_request).on("click", function () {
              $(this).css("color","")
            })
        }
      });
  }).call(this);
})
