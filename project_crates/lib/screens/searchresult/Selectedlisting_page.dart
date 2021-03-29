import 'package:flutter/material.dart';
import '../listing/Editinglist_page.dart';
import '../common/NavigationBar.dart';


class Selectedlisting_page extends StatelessWidget {

  String _search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            toolbarHeight: 50,
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Column(

                          children: <Widget>[
                            Text(
                                'Food',
                                style: TextStyle(color: Colors.grey,fontSize: 30,fontWeight: FontWeight.bold)
                            ),
                          ]
                      )
                  )

                ]
            ),

        ),
        backgroundColor: Color(0xFFFFC857),

        body: Body(),
        bottomNavigationBar: NavigationBar(0),


    );
    // body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final bool currentuser =true; // this dictate if the user click on his own food or others (true->owner of food), (false->other people food)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(child: Center(
         child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFFFFC857),
              height: 230,
              width: 450,
              child:
              Container(
                padding:EdgeInsets.fromLTRB(100,10,100,30),
                width: 100,
                height: 230,
                child:DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                    image: const DecorationImage(
                      image: AssetImage('assets/coffee.jpg'),
                      fit:  BoxFit.fill,
                    ),
                  ),
                ),
              ),
           ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  Container(
                    padding:EdgeInsets.fromLTRB(10,10,50,0),

                    child:Text(
                        'Posted 1 week ago ',
                        style: TextStyle(color: Colors.grey,fontSize: 22,fontWeight: FontWeight.bold)
                    ),

                  ),

            _Currentuserbutton(currentuser),
              ]
            ),
            Container(
              alignment: Alignment(-0.9,0.9),
                child: RichText(
                    text: TextSpan(
                        text:'by, ',style: TextStyle(color: Colors.grey,fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(text: 'name ', style: TextStyle(color: Color(0xFFFFC857),fontWeight: FontWeight.bold ,fontSize: 25),

                          )
                        ]
                    )
                )
            ),
            SizedBox(height: 20),
            Container(
              child:Text(
                  'Description of the food ',
                  style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.normal)
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment(-0.9,0),
              child:Text(
                  'Location ',
                  style: TextStyle(color: Colors.grey,fontSize: 22,fontWeight: FontWeight.bold)
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.grey[300],
                height: 150,
                width: 350,
                child:DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],

                    ),
                  ),
            )



      ]
         )
        ),
        //bottomNavigationBar: Navigationbar(0),
    )
    );
  }







  _Currentuserbutton(bool currentuser)
  {
    if(currentuser==true){
      return Container(
        padding:EdgeInsets.fromLTRB(20, 0, 20, 20),
        alignment: Alignment(0.7,0),
        child:
        MaterialButton(
          elevation: 1,
          minWidth:100, // width of the button
          height: 50,
          onPressed: () async {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Editinglist_page()));
          }
          ,color: Colors.grey[300],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),


          child: Text('Edit',
              style: TextStyle(color: Colors.grey[600], fontSize: 20)),
        ),

      );


    }
    else if(currentuser==false){
      return Container(
        padding:EdgeInsets.fromLTRB(20, 0, 20, 20),
        alignment: Alignment(0.7,0),
        child:
        MaterialButton(
          elevation: 1,
          minWidth:100, // width of the button
          height: 50,
          onPressed: () async {
            // go to chat page
          }
          ,color: Colors.grey[300],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),


          child: Text('chat',
              style: TextStyle(color: Colors.grey[600], fontSize: 20)),
        ),

      );


    }


  }




}

