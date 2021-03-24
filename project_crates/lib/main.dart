//import packages, modules, tools
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authenticate/authenticate.dart';
import 'package:flutter_application_1/screens/common/AdminNavigationBar.dart';
import 'package:flutter_application_1/screens/common/UserNavigationBar.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/nearby/nearby.dart';
import 'package:flutter_application_1/screens/profile/profile.dart';
import 'package:provider/provider.dart';
import 'screens/wrapper.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/backend/auth.dart';

void main() {
  runApp(MyApp());
} //entry point


//StatelessWidget: does not have state. does not change with interaction with the program
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
