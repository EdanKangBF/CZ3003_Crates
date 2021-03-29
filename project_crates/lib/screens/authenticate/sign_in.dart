import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/auth.dart';
import '../authenticate/register.dart';
import '../common/widgets.dart';
import '../common/theme.dart';
import '../home/home.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerUserClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  void loginUserClick() {
    FirebaseUser user;
    signInWithEmailAndPassword(emailController.text, passwordController.text).then((user) =>
    {
      //If successful login, navigate to home page
      if (user != null){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home()))
      } else {
        //TODO: Show appropriate error messages (eg wrong password) on front-end
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            "Sign in to\nyour account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              letterSpacing: 1,
                              color: offWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: offWhite,
                                hintText: 'Email')),
                        SizedBox(height: 5),
                        TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: offWhite,
                                hintText: 'Password')),
                        SizedBox(height: 20),
                        CustomButton(
                            btnText: 'Log In',
                            btnPressed: (){
                              loginUserClick();
                            }
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,10,20,10),
                          child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Divider(color:offWhite, thickness:2)
                                ),
                                SizedBox(width: 10,),
                                Text("OR",
                                    style: TextStyle(
                                      color:offWhite,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(width: 10,),
                                Expanded(
                                    child: Divider(color:offWhite, thickness:2)
                                ),
                              ]
                          ),
                        ),
                        CustomButton(
                            btnText: 'Register',
                            btnPressed: (){
                              registerUserClick();
                            }
                        ),
                        SizedBox(height: 100),
                        Text('CRATES',
                          style: TextStyle(
                            letterSpacing: 3,
                            color: offWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),),
                        Text('By Team Gestalt',
                          style: TextStyle(
                            color: offWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),),
                      ]),
                ))));
  }
}