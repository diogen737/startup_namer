import 'dart:async';

import 'package:startup_namer/src/model/message.dart';
import 'package:startup_namer/src/repository/message-repository.dart';

class MessageBloc {
  final _selfUid = '123';
  final _repository = MessageRepository();
  final _messageController = StreamController<List<Message>>();


  StreamSink<List<Message>> get messageSink => _messageController.sink;
  Stream<List<Message>> get messageStream => _messageController.stream;

  MessageBloc() {
    getMessages();
  }

  getMessages() async {
    final pojos = await _repository.fetchMessages();
    final messages = pojos
      .map((pojo) => new Message.fromPojo(pojo, _selfUid))
      .toList();
    messageSink.add(messages);
  }

  dispose() {
    _messageController?.close();
  }
}
