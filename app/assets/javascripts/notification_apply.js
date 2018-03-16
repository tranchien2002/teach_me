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
            $("#list-appliers-" + data.request_id).prepend(data.applier);
          }
        }
      });
  }).call(this);
})
