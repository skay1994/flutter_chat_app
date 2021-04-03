import 'package:flutter/cupertino.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:common/common.dart';

class ChatController {
  Socket socket;
  final String name;
  final String room;
  final listEvents = RxList<SocketEvent>();
  final textController = TextEditingController();

  ChatController(this.name, this.room) {
    _init();
  }

  void _init() {
    socket = io(API_URL, OptionBuilder().setTransports(['websocket']).build());
    socket.connect();
    socket.onConnect(
        (_) => socket.emit('enter_room', {'name': name, 'room': room}));
    socket.on('message', (data) {
      final event = SocketEvent.toJson(data);
      listEvents.add(event);
    });
  }

  void send() {
    final event = SocketEvent(
      name: name,
      room: room,
      text: textController.text,
      type: SocketType.message,
    );
    socket.emit('message', event.toJson());
    textController.clear();
    listEvents.add(event);
  }

  void dispose() {
    socket.clearListeners();
    socket.dispose();
    textController.dispose();
  }
}
