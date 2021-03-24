import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/common/theme.dart';

class AdminNavigationBar extends StatefulWidget{
  static String tag = 'admin-page';
  @override
  _AdminNavigationBarState createState() => new _AdminNavigationBarState();
}
class _AdminNavigationBarState extends State<AdminNavigationBar>{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int _currentIndex = 0;
  final List<Widget> _children =[
    Container(), //put page widget
    Container(),
  ];
  @override
  Widget build(BuildContext context){
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: primaryColor,
          selectedItemColor: Colors.orange[900],
          unselectedItemColor: Colors.white,
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: onTab,
          items:<BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text('All Listings'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Reports'),
              icon: Icon(Icons.folder),
            ),
          ]

      ),
    );
  }
  void onTab(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}