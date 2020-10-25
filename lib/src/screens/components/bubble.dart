import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/src/model/message.dart';

class MessageBubble extends StatelessWidget {
  final Message msg;
  final _myMessageColor = Color.fromRGBO(225, 255, 199, 1.0);
  final _otherMessageColor = Color.fromRGBO(212, 234, 244, 1.0);
  final _msgTextStyle = TextStyle(fontSize: 18);
  final _msgSentStyle = TextStyle(fontSize: 13, color: Colors.grey.shade500);
  final _dateSeparatorStyle = TextStyle(
    fontSize: 16,
    shadows: [Shadow(blurRadius: 3.0, color: Colors.grey, offset: Offset(3.0, 3.0))]
  );

  MessageBubble({this.msg});

  @override
  Widget build(BuildContext context) {
    return msg.isDateSeparator ? _dateSeparatorContainer() : _messageBubble(context);
  }

  Bubble _messageBubble(BuildContext context) {
    return Bubble(
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .75),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(msg.content, style: _msgTextStyle)
            ),
            SizedBox(width: 16),
            Text(msg.sentFormatted, style: _msgSentStyle),
          ],
        )
      ),
      margin: BubbleEdges.fromLTRB(5, 0, 5, 10),
      alignment: msg.isMine ? Alignment.bottomRight : Alignment.bottomLeft,
      color: msg.isMine ? _myMessageColor : _otherMessageColor,
      nip: msg.isMine ? BubbleNip.rightBottom : BubbleNip.leftTop,
    );
  }

  Container _dateSeparatorContainer() {
    return Container(
      child: Text(msg.content, style: _dateSeparatorStyle),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
