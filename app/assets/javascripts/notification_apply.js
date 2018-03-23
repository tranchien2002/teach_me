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
          $("#notifying-"+ data.owner_request).addClass("notifying");
          $("#notifying-"+ data.owner_request).on("click", function () {
            $("#notifying-"+ data.owner_request).removeClass("notifying")
          })
        }
        if(data.applier_destroy){
            console.log(data.applier_destroy);
          $("#user-apply-" + data.applier_destroy).remove();
        }
      }
    });
  }).call(this);
})
