// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer/model/message.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <Message>[];
  final _saved = Set<Message>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16),
        reverse: true,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final suggestionIndex = i ~/ 2;
          if (suggestionIndex >= _suggestions.length) {
            final newPairs = generateWordPairs()
              .take(10)
              .toList()
              .asMap()
              .map((i, entry) => MapEntry(i, Message(entry, i.toString(), i.toString())))
              .values
              .toList();
            _suggestions.addAll(newPairs);
          }

          return _buildRow(_suggestions[suggestionIndex]);
        });
  }

  Widget _buildRow(Message msg) {
    final alreadySaved = _saved.contains((msg));
    return ListTile(
      title: Text(msg.content.asPascalCase, style: _biggerFont),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() => alreadySaved ? _saved.remove(msg) : _saved.add(msg));
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        final tiles = _saved.map((msg) => ListTile(title: Text(msg.sender, style: _biggerFont)));
        final dividedTiles = ListTile.divideTiles(tiles: tiles, context: context).toList();
        final savedTilesBody = dividedTiles.length > 0
          ? ListView(children: dividedTiles)
          : Center(child: Text('No saved items', style: _biggerFont));

        return Scaffold(
          appBar: AppBar(title: Text('Saved Suggestions')),
          body: savedTilesBody,
        );
      })
    );
  }
}
