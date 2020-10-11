// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/models/saved-messages.dart';
import 'package:startup_namer/routes.dart';
import 'package:startup_namer/theme/style.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => SavedMessages(),
    child: MyApp()
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: appTheme(),
      routes: routes,
      initialRoute: '/',
    );
  }
}
