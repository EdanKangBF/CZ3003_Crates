//import packages, modules, tools
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authenticate/root.dart';



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
      home:RootPage(),
    );
  }
}
