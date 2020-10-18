import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/src/model/message.dart';

class MessageBubble extends StatelessWidget {
  final Message msg;
  final myMessageColor = Color.fromRGBO(225, 255, 199, 1.0);
  final otherMessageColor = Color.fromRGBO(212, 234, 244, 1.0);

  MessageBubble({this.msg});

  @override
  Widget build(BuildContext context) {
    return Bubble(
      child: Text(msg.content),
      margin: BubbleEdges.fromLTRB(5, 0, 5, 10),
      alignment: msg.isMine ? Alignment.bottomRight : Alignment.bottomLeft,
      color: msg.isMine ? myMessageColor : otherMessageColor,
      nip: msg.isMine ? BubbleNip.rightBottom : BubbleNip.leftTop,
    );
  }
}
