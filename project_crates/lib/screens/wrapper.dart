import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/authenticate/authenticate.dart';
import 'package:flutter_application_1/screens/authenticate/authenticate.dart';
import 'package:flutter_application_1/screens/authenticate/register.dart';
import 'package:flutter_application_1/screens/authenticate/sign_in.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/nearby/nearby.dart';
import 'package:flutter_application_1/screens/nearby/nearby_filter.dart';
import 'package:flutter_application_1/screens/profile/profile.dart';
import 'package:flutter_application_1/screens/userWrapper.dart';
import 'package:provider/provider.dart';

// SignIn, Register, RegisterNext, RegisterFinal, Home, Nearby

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
    print("Wrapper building... " + user.toString());

    // return either Home or Authentication Widget
    // depending on whether a user is logged in or not
    if (user==null){
      return Authenticate();
    }else{
      return UserWrapper();
    }

  }
}
