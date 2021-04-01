import 'package:common/common.dart';
import 'package:test/test.dart';

void main() {
  test('from json to json', () {
    final json = {
      'name': 'Maria',
      'room': '',
      'text': '',
      'type': 'SocketType.enter_room',
    };

    final event = SocketEvent.toJson(json);

    expect(event.name, 'Maria');
    expect(event.type, SocketType.enter_room);
    expect(event.toJson(), json);
  });
}
