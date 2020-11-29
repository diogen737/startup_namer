import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup_namer/src/blocs/message-bloc.dart';
import 'package:startup_namer/src/model/message.dart';
import 'package:startup_namer/src/screens/components/bubble.dart';
import 'package:startup_namer/src/screens/components/loading.dart';

class MessageListScreen extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageListScreen> {
  MessageBloc _bloc;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = MessageBloc();
    _scrollController = ScrollController(keepScrollOffset: true);
    _scrollController.addListener(() {
      log(_scrollController.position.toString());
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        _bloc.loadMoreMessages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [IconButton(
          icon: Icon(Icons.list),
          onPressed: () => Navigator.pushNamed(context, '/saved')
        )],
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.loadInitialMessages(),
        child: StreamBuilder<List<Message>>(
          stream: _bloc.messageStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();
            return ListView.builder(
              reverse: true,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return MessageBubble(msg: snapshot.data[index]);
              }
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _scrollController.dispose();
  }
}
