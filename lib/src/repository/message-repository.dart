import 'package:startup_namer/src/model/message.dart';

class MessageRepository {
  final List<Message> _predefined = [
    Message('Newer message', 'Oleg M.', DateTime.now()),
    Message('Older message', 'Oleg M.', DateTime.parse('2020-10-08')),
  ];

  Future<List<Message>> fetchMessages() async {
    return Future.delayed(
      Duration(seconds: 2),
      () => _predefined
    );
  }
}