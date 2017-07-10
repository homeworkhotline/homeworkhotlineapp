App.devstats = App.cable.subscriptions.create("DevstatsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
},
  disconnected:  function() {
   // Called when the subscription has been terminated by the server
},
  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    var allCount = data['calllogs'] + data['reports'] + data['principals'] + data['schools'] + data['searches'] + data['students'] + data['timesheets'] + data['user']
    if(isNaN(allCount)){}else{
    $('.total').text(allCount);
}
	if(isNaN(data['calllogs'] || data['reports'] || data['principals'] || data['schools'] || data['searches'] || data['students'] || data['timesheets'] || data['user'])){}else{
	new Chartkick.PieChart("piedb", [["Users",data['user']],["Timesheets",data['timesheets']],["Students",data['students']],["Schools",data['schools']],["Searches",data['searches']],["Principals",data['principals']],["Reports",data['reports']],["Call Logs",data['calllogs']]], {"animateScale" : true, "legend":false,"colors":["#b9e3f8","#8bd1f4","#5dbeef", "#2eacea", "#1592d1", "#1072a2", "#0b5174", "#073045"]});
    }
    $('.activelogs').text(data['activelogs']);
    $('.online').text(data['users']);
},
});