import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authenticate/authenticate.dart';
import 'package:flutter_application_1/screens/authenticate/register.dart';
import 'package:flutter_application_1/screens/authenticate/sign_in.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/nearby/nearby.dart';
import 'package:flutter_application_1/screens/nearby/nearby_filter.dart';
import 'package:flutter_application_1/screens/profile/profile.dart';

// SignIn, Register, RegisterNext, RegisterFinal, Home, Nearby

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either Home or Authentication Widget
    return Home();
  }
}
