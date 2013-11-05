(function() {
  var ChatApp = window.ChatApp = (window.ChatApp || {})

  var Chat = ChatApp.Chat = function (socket) {
    this.socket = socket;
  };

  Chat.prototype.sendMessage = function (message) {
    this.socket.emit('message', { message: message });
  }

  Chat.prototype.changeNickname = function(newName) {
    this.socket.emit('nicknameChangeRequest', { name: newName });
  }

  Chat.prototype.changeRoom = function(newRoom) {
    this.socket.emit('roomChangeRequest', {room: newRoom });
  }

  Chat.prototype.processCommand = function(data) {
    var splitMessage = data.split(" ");
    if(splitMessage[0] === "/nick") {
      this.changeNickname(splitMessage[1]);
    }else if(splitMessage[0] === "/join"){
      this.changeRoom(splitMessage[1]);
    }
  }
})();