import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/Newlisting_page.dart';
import 'package:flutter_application_1/ui/SearchResult_page.dart';


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
            backgroundColor: Color(0xFFFFC857),
            title: Text(
              "Landing Page",
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(70.0))),
            actions: <Widget>[

              IconButton(
                alignment: Alignment.center,
                icon: new Icon(Icons.search,size:35),
                color:Colors.black,
                onPressed: () {
                  // pressed to execute search in the search field the user has entered
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  SearchResult_page()));
                },
              ),
            ]

        ),

        body: Body()


    );
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
    return Scaffold(
        body: SingleChildScrollView(

        child: Column(
        children: <Widget>[

          IconButton(
            alignment: Alignment.center,
            icon: new Icon(Icons.add_circle_outline,size:35),
            color:Colors.black,
            onPressed: () {
              // pressed to execute search in the search field the user has entered
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Newlisting_page()));
            },
          ),



      ]
        )
        )
    );

  }
}
