import 'package:flutter/material.dart';

import 'auth.dart';
import 'package:projectcrates/Chat/root.dart';

const title = 'chat';
void main() {
  runApp(MyApp());
} //entry point

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        platform: TargetPlatform.android,
      ),
      home: RootPage(title: title, auth: Auth()),
    );
  }
}
