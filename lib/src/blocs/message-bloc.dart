import 'dart:async';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:startup_namer/src/model/message-pojo.dart';
import 'package:startup_namer/src/model/message.dart';
import 'package:startup_namer/src/repository/message-repository.dart';

class MessageBloc {
  final _selfUid = '123';
  final _repository = MessageRepository();
  final _messageController = StreamController<List<Message>>();

  final List<Message> _messageList = [];
  DateTime lastLoaded;


  StreamSink<List<Message>> get messageSink => _messageController.sink;
  Stream<List<Message>> get messageStream => _messageController.stream.asBroadcastStream();

  MessageBloc() {
    loadInitialMessages();
  }

  loadInitialMessages() async {
    final pojos = await _repository.fetchMessages(DateTime.now());
    final messages = _tranformMessages(pojos);
    _messageList.addAll(messages);
    messageSink.add(_messageList);
    lastLoaded = _messageList.last.sent;
  }
  
  loadMoreMessages() async {
    final pojos = await _repository.fetchMessages(lastLoaded);
    final messages = _tranformMessages(pojos);
    _messageList.addAll(messages);
    messageSink.add(_messageList);
    lastLoaded = _messageList.last.sent;
  }

  List<Message> _tranformMessages(List<MessagePojo> pojos) {
    final messages = pojos.map((pojo) => new Message.fromPojo(pojo, _selfUid)).toList();
    messages.sort((a, b) => b.sent.isAfter(a.sent) ? 1 : -1);

    final List<Message> messagesWithDates = [];
    String currentDate;
    // Process message dates in reversed order
    messages.reversed.forEach((msg) {
      final msgDate = _formatDate(msg.sent);
      if (msgDate != currentDate) {
        currentDate = msgDate;
        messagesWithDates.add(new Message.dateSeparator(msg, currentDate));
      }
      messagesWithDates.add(msg);
    });
    return messagesWithDates.reversed.toList();
  }

  String _formatDate(DateTime date) {
    DateFormat format;
    final today = DateTime.now();
    final yesterday = today.subtract(Duration(days: 1));
    final todayStart = new DateTime(today.year, today.month, today.day);
    final yesterdayStart = new DateTime(yesterday.year, yesterday.month, yesterday.day);
    if (date.isAfter(todayStart)) {
      return 'Today';
    } else if (date.isAfter(yesterdayStart)) {
      return 'Yesterday';
    } else if (date.year != today.year) {
      format = DateFormat.yMMMMd();
    } else {
      format = DateFormat.MMMMd();
    }
    return format.format(date);
  }

  dispose() {
    _messageController?.close();
  }
}
