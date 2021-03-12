import 'package:flutter/material.dart';
import 'appTheme.dart';

class LandingPage extends StatefulWidget {
  final String name;

  LandingPage(this.name);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppTheme.background,
            toolbarHeight: 200,
            title: Text(
              "CRATES",
              style: AppTheme.display1,
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
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
            textInputAction: TextInputAction.search,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                onPressed: null,
              ),
              hintText: 'Search',
              contentPadding: EdgeInsets.only(left: 15, top: 15),
            )));
    ;
  }
}
