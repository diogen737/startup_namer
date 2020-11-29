import 'package:intl/intl.dart';
import 'package:startup_namer/src/model/message-pojo.dart';

class Message {
  String content;
  String sender;
  String senderUid;
  DateTime sent;
  String sentFormatted;
  bool isMine;
  bool isDateSeparator;

  Message.fromPojo(MessagePojo pojo, String selfUid) {
    content = pojo.content;
    sender = pojo.sender;
    senderUid = pojo.senderUid;
    sent = pojo.sent;
    isMine = senderUid == selfUid;
    isDateSeparator = false;
    sentFormatted = DateFormat.Hm().format(sent);
  }

  Message.dateSeparator(Message msg, String date) {
    content = date;
    sent = msg.sent;
    isMine = false;
    isDateSeparator = true;
  }
}