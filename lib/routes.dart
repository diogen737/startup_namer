
import 'package:flutter/material.dart';
import 'package:startup_namer/screens/message-list/message-list.dart';
import 'package:startup_namer/screens/saved-messages/saved-messages.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => MessageList(),
  '/saved': (context) => SavedMessageList(),
};
