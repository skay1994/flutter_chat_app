import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String room;

  ChatPage({Key key, @required this.name, @required this.room})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = ChatController(widget.name, widget.room);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room: ${widget.room}'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              RxBuilder(builder: (_) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.listEvents.length,
                    itemBuilder: (_, id) {
                      final event = controller.listEvents[id];

                      if (event.type == SocketType.enter_room) {
                        return ListTile(
                            title: Text('${event.name} entrou na sala'));
                      } else if (event.type == SocketType.leave_room) {
                        return ListTile(
                            title: Text('${event.name} saiu da sala'));
                      }

                      return ListTile(
                        title: Text(event.name),
                        subtitle: Text(event.text),
                      );
                    },
                  ),
                );
              }),
              TextField(
                controller: controller.textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type your Text',
                ),
              )
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
