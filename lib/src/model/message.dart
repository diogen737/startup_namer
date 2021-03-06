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
    isMine = senderUid == selfUid;
    isDateSeparator = false;
    // TODO: add error check
    sent = DateTime.parse(pojo.sent);
    sentFormatted = DateFormat.Hm().format(sent);
  }

  Message.dateSeparator(String date) {
    content = date;
    isDateSeparator = true;
  }
}