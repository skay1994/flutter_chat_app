library common;

const API_URL = 'http://localhost:3000';

class SocketEvent {
  final String name;
  final String room;
  final String text;
  final SocketType type;

  SocketEvent(
      {required this.name,
      required this.room,
      this.text = '',
      required this.type});

  Map toJson() {
    return {'name': name, 'room': room, 'text': text, 'type': type.toString()};
  }

  factory SocketEvent.toJson(Map json) {
    return SocketEvent(
        name: json['name'],
        room: json['room'],
        text: json['text'],
        type: SocketType.values
            .firstWhere((element) => element.toString() == json['type']));
  }
}

enum SocketType { enter_room, leave_room, message }
