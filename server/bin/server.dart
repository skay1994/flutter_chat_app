import 'dart:io';

import 'package:common/common.dart';
import 'package:socket_io/socket_io.dart';

void main(List<String> arguments) {
  final server = Server();
  server.on('connection', (client) {
    onConnection(client);
  });

  server.listen(Platform.environment['PORT'] ?? 3000);
}

void onConnection(Socket socket) {
  socket.on('enter_room', (data) {
    final name = data['name'];
    final room = data['room'];

    socket.join(room);
    socket.to(room).broadcast.emit(
        'message',
        SocketEvent(name: name, room: room, type: SocketType.enter_room)
            .toJson());

    socket.on('disconnect', (_) {
      socket.to(room).broadcast.emit(
          'message',
          SocketEvent(name: name, room: room, type: SocketType.leave_room)
              .toJson());
    });

    socket.on('message', (data) {
      socket.to(room).broadcast.emit('message', SocketEvent.toJson(data));
    });
  });
}
