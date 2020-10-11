import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/models/saved-messages.dart';


class SavedMessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final biggerFont = TextStyle(fontSize: 18);
    return Consumer<SavedMessages>(builder: (ctx, store, child) {
      Widget body;
      String title = 'Saved messages';
      if (store.empty) {
        body = Center(child: Text('No saved items', style: biggerFont));
      } else {
        final tiles = store.messages.map((msg) => ListTile(title: Text(msg.sender, style: biggerFont)));
        final dividedTiles = ListTile.divideTiles(tiles: tiles, context: context).toList();
        body = ListView(children: dividedTiles);
        title += ' (${store.count})';
      }

      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: body
      );
    });
  }
}
