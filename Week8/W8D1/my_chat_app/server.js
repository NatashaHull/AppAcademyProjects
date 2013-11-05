var http = require('http');
var fs = require('fs');
var path = require('path');
var mime = require('mime');
var socketio = require('socket.io');
var router = require('./router.js').Router

var guestnumber = 1;
var nicknames = {};
var namesUsed = {};
var currentRooms = {};
var rooms = {};

var mainServer = http.createServer(function (request, response) {
  router(request, response, fs);
}).listen(8080);

var listen = function(server) {
  var io = socketio.listen(server);
  io.sockets.on('connection', function(socket) {
    console.log('A socket is connected!');
     nicknames[socket.id] = "guestUser"+guestnumber;
     guestnumber += 1;

     socket.join('lobby');
     currentRooms[socket.id] = 'lobby';
     rooms["lobby"] = (rooms["lobby"] || []);
     rooms["lobby"].push(nicknames[socket.id]);
     io.sockets.emit("updateRooms", rooms);

    socket.on('message', function(data) {
      if(nicknames[socket.id]) {
        data.message = nicknames[socket.id]+"("+currentRooms[socket.id]+") "+": "+data.message
      }
      console.log("From the server:",data);
      io.sockets.in(currentRooms[socket.id]).emit("message", data);
    });

    socket.on('nicknameChangeRequest', function(data) {
      console.log(data.name);
      if (namesUsed[data.name] === undefined) {
        var room = currentRooms[socket.id];
        var index = rooms[room].indexOf(nicknames[socket.id]);
        rooms[room][index] = data.name;
        namesUsed[data.name] = true;
        nicknames[socket.id] = data.name;
        io.sockets.emit("updateRooms", rooms);
      }
    });

    socket.on('roomChangeRequest', function(data) {
      console.log(data.room);

      //Removes user from the old room
      var room = currentRooms[socket.id];
      var index = rooms[room].indexOf(nicknames[socket.id]);
      rooms[room].splice(index, 1);

      //Adds user to the current room
      rooms[data.room] = (rooms[data.room] || []);
      rooms[data.room].push(nicknames[socket.id]);

      currentRooms[socket.id] = data.room;
      socket.leave(room);
      socket.join(data.room);
      io.sockets.emit("updateRooms", rooms);
    });

    socket.on('disconnect', function(){

      //Removes user from the old room
      var room = currentRooms[socket.id];
      var index = rooms[room].indexOf(nicknames[socket.id]);
      rooms[room].splice(index, 1);

      delete namesUsed[nicknames[socket.id]];
      delete nicknames[socket.id];
      delete currentRooms[socket.id];

      console.log("A socket disconnected.");
    });

  });
}

listen(mainServer);

console.log('Server running at http://127.0.0.1:8080');
