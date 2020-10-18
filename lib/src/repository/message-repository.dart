import 'package:startup_namer/src/model/message-pojo.dart';

class MessageRepository {
  final List<MessagePojo> _predefined = [
    MessagePojo(
      'Newer message',
      'Oleg M.',
      '123',
      DateTime.now().toIso8601String(),
    ),
    MessagePojo(
      'Older message',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(hours: 1)).toIso8601String(),
    ),
  ];

  Future<List<MessagePojo>> fetchMessages() async {
    return Future.delayed(
      Duration(seconds: 2),
      () => _predefined
    );
  }
}