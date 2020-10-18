import 'dart:async';

import 'package:startup_namer/src/model/message.dart';
import 'package:startup_namer/src/repository/message-repository.dart';

class MessageBloc {
  final _repository = MessageRepository();
  final _messageController = StreamController<List<Message>>();

  StreamSink<List<Message>> get messageSink => _messageController.sink;
  Stream<List<Message>> get messageStream => _messageController.stream;

  MessageBloc() {
    getMessages();
  }

  getMessages() async {
    final res = await _repository.fetchMessages();
    messageSink.add(res);
  }

  dispose() {
    _messageController?.close();
  }
}
