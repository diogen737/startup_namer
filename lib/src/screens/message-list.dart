import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _bloc = MessageBloc();
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
        onRefresh: () => _bloc.getMessages(),
        child: StreamBuilder<List<Message>>(
          stream: _bloc.messageStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();
            return ListView.builder(
              reverse: true,
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
  }
}
