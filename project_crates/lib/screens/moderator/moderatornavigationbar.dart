import 'package:flutter/material.dart';
import '../moderator/searchlisting.dart';

import '../moderator/reportpage.dart';

class ModeratorNavigationBar extends StatefulWidget {
  final int tab;

  ModeratorNavigationBar(this.tab);
  @override
  _ModeratorNavigationBarState createState() => _ModeratorNavigationBarState();
}

class _ModeratorNavigationBarState extends State<ModeratorNavigationBar> {
  @override
  Widget build(
    BuildContext context,
  ) {
    int _currentIndex;
    _currentIndex =
        widget.tab; // this tab tell which page the current screen is
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.orange, //primary color?
        selectedItemColor: Colors.orange[900],
        unselectedItemColor: Colors.white,
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          _currentIndex = value;
          switch (value) {
            case 0:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReportPage()));
              break;
          }
        },

        items: [
          BottomNavigationBarItem(
            title: Text('All Listings'),
            icon: Icon(Icons.fastfood),
          ),
          BottomNavigationBarItem(
            title: Text('Reports'),
            icon: Icon(Icons.topic),
          ),
        ],
      ),
    );
  }
}
