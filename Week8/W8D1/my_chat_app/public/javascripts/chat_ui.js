$(document).ready( function () {
  var chat = new ChatApp.Chat(io.connect());

  $("#message-form").on('submit', function (event) {
    event.preventDefault();
    var message = $("#message_content").val();
    if (message[0] === '/') {
      chat.processCommand(message);
    } else {
      chat.sendMessage(message);
    }
    $("#message_content").val("");
  });

  var appendMessage = function(data) {
    var message = data.message;
    var html = $("<p>");
    html.text(message);
    $("#messages").append(html);
  }

  var updateRooms = function(rooms) {
    var outerUl = $("<ul>");
    console.log("rooms", rooms);
    for(key in rooms) {
     var outerLi = $("<li>");
     outerLi.html(key);
     var innerUl = $("<ul>");
      rooms[key].forEach( function (nickname) {
        var innerLi = $('<li>');
        innerLi.html(nickname);
        innerUl.append(innerLi)
      });
      outerLi.append(innerUl);
      outerUl.append(outerLi);
    }
    $("#rooms").html(outerUl)
  }

  chat.socket.on("message", appendMessage);
  chat.socket.on("updateRooms", updateRooms);
});