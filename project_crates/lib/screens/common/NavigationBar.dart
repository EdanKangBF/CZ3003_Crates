import 'package:flutter/material.dart';

import 'theme.dart';
import '../listing/Newlisting_page.dart';
import '../home/home.dart';
import '../nearby/nearby.dart';
import '../profile/profile.dart';

class NavigationBar extends StatefulWidget {
  final int tab;

  NavigationBar(this.tab);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  @override
  Widget build(BuildContext context,) {
   int  _currentIndex;
   _currentIndex=widget.tab; // this tab tell which page the current screen is
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: primaryColor,
        selectedItemColor: Colors.orange[900],
        unselectedItemColor: Colors.white,
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          _currentIndex=value;
          switch(value){
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1: Navigator.push(context, MaterialPageRoute(builder: (context) => Nearby()));
              break;
            case 2: Navigator.push(context, MaterialPageRoute(builder: (context) => Newlisting_page()));
              break;
            case 3: //go to activity page
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            break;

          }
        },

        items: [
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
        ],

      ),
    );
  }
}

