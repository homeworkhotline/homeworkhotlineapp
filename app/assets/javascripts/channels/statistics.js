App.devstats = App.cable.subscriptions.create("ImageshareChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
},
  disconnected:  function() {
   // Called when the subscription has been terminated by the server
},
  received: function(data) {
    $('.sessionsh1').text(data['sessions'])
},
});