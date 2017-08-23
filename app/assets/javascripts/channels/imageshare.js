App.devstats = App.cable.subscriptions.create("ImageshareChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
},
  disconnected:  function() {
   // Called when the subscription has been terminated by the server
},
  received: function(data) {
    var test = data['id'].toString();
  	$('.banner' + test).html('<p>' + data['codename'] + ' has submitted a picture! View it <a href="/image_shares/' + data['image'] + '"' + 'target="_blank"> here.</a>')
  	$('.banner' + test).animate({top: "0px"}, 1000);
  	$('.banner' + test).click(function(){
  		$('.banner' + test).delay(400).animate({top: "-75px"}, 1000);
  		$('.banner' + test).html('<p>Already been downloaded!</p>')
  	});
},
});