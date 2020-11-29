import 'package:startup_namer/src/model/message-pojo.dart';

class MessageRepository {
  final List<MessagePojo> _predefined = [
    MessagePojo(
      'Newer message long long, very long message i suppose',
      'Oleg M.',
      '123',
      DateTime.now(),
    ),
    MessagePojo(
      'Older message',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(hours: 1)),
    ),
    MessagePojo(
      'Yesterday message',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(days: 1)),
    ),
    MessagePojo(
      'Month ago',
      'Oleg M.',
      '123',
      DateTime.now().subtract(Duration(days: 30)),
    ),
    MessagePojo(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(days: 30, hours: 1)),
    ),
    MessagePojo(
      'Even older message',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(days: 365)),
    ),
    MessagePojo(
      'Even older lazy-loaded message 1',
      'Oleg M.',
      '123',
      DateTime.now().subtract(Duration(days: 368)),
    ),
    MessagePojo(
      'Even older lazy-loaded message 2',
      'Ruslan M.',
      '456',
      DateTime.now().subtract(Duration(days: 370)),
    ),
  ];

  int initLoadAmount;
  int nextLoadAmount;
  bool firstLoad = true;

  MessageRepository({this.initLoadAmount = 5, this.nextLoadAmount = 2});

  Future<List<MessagePojo>> fetchMessages(DateTime from) async {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final messagesToTake = firstLoad ? initLoadAmount : nextLoadAmount;
        firstLoad = false;
        return _predefined.where((element) => element.sent.isBefore(from))
          .take(messagesToTake)
          .toList();
      }
    );
  }
}