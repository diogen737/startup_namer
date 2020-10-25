import 'package:startup_namer/src/model/message-pojo.dart';

class MessageRepository {
  final List<MessagePojo> _predefined = [
    MessagePojo(
      'Newer message long long, very long message i suppose',
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
    MessagePojo(
      'Yesterday message',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
    ),
    MessagePojo(
      'Month ago',
      'Oleg M.',
      '123',
      DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
    ),
    MessagePojo(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(days: 30, hours: 1)).toIso8601String(),
    ),
    MessagePojo(
      'Even older message',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(days: 365)).toIso8601String(),
    ),
  ];

  Future<List<MessagePojo>> fetchMessages() async {
    return Future.delayed(
      Duration(seconds: 1),
      () => _predefined
    );
  }
}