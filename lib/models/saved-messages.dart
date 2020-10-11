import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:startup_namer/models/message.dart';

class SavedMessages extends ChangeNotifier {
  final _messages = Set<Message>();

  UnmodifiableListView<Message> get messages => UnmodifiableListView(_messages);
  int get length => _messages.length;

  bool contains(Message msg) {
    return _messages.contains(msg);
  }

  void add(Message msg) {
    _messages.add(msg);
    notifyListeners();
  }

  void remove(Message msg) {
    _messages.remove(msg);
    notifyListeners();
  }
}
