import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/listing/Newlisting_page.dart';
import 'package:flutter_application_1/screens/nearby/nearby.dart';
import 'package:flutter_application_1/screens/profile/profile.dart';
import 'common/theme.dart';

class UserWrapper extends StatefulWidget {
  @override
  _UserWrapperState createState() => _UserWrapperState();
}

class _UserWrapperState extends State<UserWrapper> {

  final List<Widget> screens = [
    Home(),
    Nearby(),
    Newlisting_page(),
    //todo: replace with activity page
    Newlisting_page(),
    Profile(),
  ];

  // for bottom navigation bar
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: primaryColor,
          selectedItemColor: Colors.orange[900],
          unselectedItemColor: Colors.white,
          selectedLabelStyle: Theme.of(context).textTheme.caption,
          unselectedLabelStyle: Theme.of(context).textTheme.caption,
          onTap: (val) => setState(() {
              _currentIndex = val;
            }),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Nearby'),
              icon: Icon(Icons.gps_fixed),
            ),
            BottomNavigationBarItem(
              title: Text('New listing'),
              icon: Icon(Icons.add_circle_outline),
            ),
            BottomNavigationBarItem(
              title: Text('Activity'),
              icon: Icon(Icons.notifications_none),
            ),
            BottomNavigationBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.account_circle),
            ),
          ]),
    );
  }
}
