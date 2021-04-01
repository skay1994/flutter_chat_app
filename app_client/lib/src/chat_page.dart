import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String room;

  ChatPage({Key key, @required this.name, @required this.room})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, id) {
                    return ListTile(title: Text('${id}'));
                  },
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type your Text',
                ),
              )
            ],
          )),
    );
  }
}
