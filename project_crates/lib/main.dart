//import packages, modules, tools
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authenticate/authenticate.dart';
import 'package:flutter_application_1/screens/common/AdminNavigationBar.dart';
import 'package:flutter_application_1/screens/common/UserNavigationBar.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/nearby/nearby.dart';
import 'package:flutter_application_1/screens/profile/profile.dart';
import 'screens/wrapper.dart';
import 'package:flutter/services.dart';
import 'dart:io';


void main() {
  runApp(MyApp());
} //entry point


//StatelessWidget: does not have state. does not change with interaction with the program
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      UserNavigationBar.tag: (context) => UserNavigationBar(),
      AdminNavigationBar.tag: (context) => AdminNavigationBar(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        platform: TargetPlatform.android,
      ),
      // initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => Wrapper(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/profile': (context) => Profile(),
      //   '/Nearby': (context) => Nearby(),
      // },
      home: Wrapper(),
      routes: routes,
    );
  }
}
