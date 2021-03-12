import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/registerPage.dart';
import 'landingPage.dart';
import 'auth.dart';
import 'appTheme.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.orange,
            title: Text(
              "Login",
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(70.0)))),
        body: Body());
    // body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseUser user;
//login click
  void googleLoginClick() {
    signInWithGoogle().then((user) => {
          this.user = user,
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LandingPage(user.displayName)))
        });
  }

  void registerUserClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

//TODO user validation
  void loginUserClick() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LandingPage('insert username here')));
  }

  Widget googleLoginButton() {
    return ButtonTheme(
        minWidth: 300.0,
        height: 60.0,
        child: OutlineButton(
            onPressed: this.googleLoginClick,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            splashColor: Colors.grey,
            borderSide: BorderSide(color: Colors.grey),
            child: Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assests/google_logo.png'),
                      height: 25,
                      alignment: Alignment.topLeft,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Sign in with Google',
                            style: TextStyle(color: Colors.grey, fontSize: 20)))
                  ],
                ))));
  }

  Widget registerButton() {
    return ButtonTheme(
        minWidth: 400.0,
        height: 60.0,
        child: OutlineButton(
            onPressed: () {
              registerUserClick();
            },
            splashColor: Colors.grey,
            borderSide: BorderSide(color: Colors.white10),
            child: Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'New User? Create Account',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))));
  }

  Widget loginButton() {
    return ButtonTheme(
        minWidth: 300.0,
        height: 60.0,
        child: FlatButton(
            onPressed: () {
              loginUserClick();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Colors.amber,
            child: Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Center(
              child: Container(
                  width: 400,
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'CratesApp',
                    style: TextStyle(color: Colors.amber, fontSize: 40),
                  )))),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'username')),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Password'),
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
          child: loginButton()),
      Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
          child: googleLoginButton()),
      Container(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(padding: EdgeInsets.zero, child: registerButton())
          ],
        ),
      )
    ])));
  }
}
