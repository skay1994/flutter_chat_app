import 'package:socket_io_client/socket_io_client.dart';
import 'package:common/common.dart';

class ChatController {
  Socket socket;
  final String name;
  final String room;

  ChatController(this.name, this.room) {
    _init();
  }

  void _init() {
    socket = io(
        'http://localhost:3000',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket.connect();
    socket.onConnect(
        (_) => socket.emit('enter_room', {'name': name, 'room': room}));
    socket.on('message', (data) {
      final event = SocketEvent.toJson(data);
    });
  }
}
