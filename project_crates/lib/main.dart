//import packages, modules, tools
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Chat/chatuser.dart';
import 'package:flutter_application_1/screens/authenticate/authenticate.dart';
import 'screens/wrapper.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_application_1/Chat/chatscreenv2.dart';

void main() {
  runApp(MyApp());
} //entry point

//StatelessWidget: does not have state. does not change with interaction with the program
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        platform: TargetPlatform.android,
      ),
      home: Authenticate(),
    );
  }
}
