import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/auth.dart';
import 'package:flutter_application_1/chats/chatuser.dart';
import 'package:flutter_application_1/screens/common/user_main.dart';
import '../common/admin_main.dart';
import 'sign_in.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

enum AdminStatus { notAdmin, isAdmin }

class _RootPageState extends State<RootPage> {
  // Set default AuthStatus as not signed in
  AuthStatus authStatus = AuthStatus.notSignedIn;
  // Set default adminStatus as notAdmin
  AdminStatus adminStatus = AdminStatus.notAdmin;

  @override
  // Configure initial state before widget build
  void initState() {
    super.initState();
    currentUser().then((userID) => {
          setState(() {
            // authStatus = userID == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
          })
        });
  }

  // Login & Logout Status
  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  // Set Admin Status
  void _isAdmin() {
    setState(() {
      adminStatus = AdminStatus.isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new SignIn(
          onSignedIn: _signedIn,
          isAdmin: _isAdmin,
        );
      case AuthStatus.signedIn:
        switch (adminStatus) {
          case AdminStatus.notAdmin:
            return new ChatUserScreen();
          case AdminStatus.isAdmin:
            return new AdminMain();
        }
    }
  }
}
