import 'package:flutter/material.dart';

import 'src/chat_page.dart';
import 'src/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/chat': (_) {
          final args = ModalRoute.of(_).settings.arguments as Map;
          return ChatPage(name: args['name'], room: args['room']);
        }
      },
    );
  }
}
