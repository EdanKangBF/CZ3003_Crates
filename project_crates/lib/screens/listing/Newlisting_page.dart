import 'package:flutter/material.dart';
import '../home/home.dart';

class Newlisting_page extends StatelessWidget {

  String _search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFFFC857),

            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(70.0))),

            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment(-0.7,0),
                      child: Column(

                          children: <Widget>[
                            Text(
                                'New Listing',
                                style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)
                            ),
                          ]
                      )
                  )])



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
  //String isSelected;
  List<bool> isselected = [true,false];
  List listItem=['Drink and Beverages','Snack','Can food',];
  String valueChoose;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          //body: Center(
          child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Align(
                    alignment: Alignment(-0.7,0),
                    child:
                    Text('I am...',        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey,fontSize: 35,fontWeight: FontWeight.bold)
                    )
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Container(
                        padding:EdgeInsets.fromLTRB(20, 20, 20, 10),
                        //color: Colors.grey,


                        child:
                        Container(
                          color: Colors.grey[300],


                          child: ToggleButtons(
                            borderRadius: BorderRadius.circular(10.0),
                            isSelected: isselected,
                            color: Colors.white,
                            selectedColor: Color(0xFFFFC857),

                            fillColor: Colors.grey,
                            renderBorder: true,

                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Giving away',
                                    style: TextStyle( fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Requesting for ',
                                    style: TextStyle( fontSize: 20)),
                              ),

                            ],
                            onPressed:(int newIndex){
                              setState(() {
                                for (int buttonIndex = 0; buttonIndex < isselected.length; buttonIndex++) {
                                  if (buttonIndex == newIndex) {
                                    isselected[buttonIndex] = true;
                                  } else {
                                    isselected[buttonIndex] = false;
                                  }
                                }
                              });
                            },

                          ),
                        ),

                      ),
                    ]
                ),
                Align(
                    alignment: Alignment(-0.8,0),
                    child:
                    Text('a',        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey,fontSize: 35,fontWeight: FontWeight.bold)
                    )
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(

                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)
                      ),
                      child:DropdownButton(
                        hint: Text('Option', style: TextStyle(color: Colors.white,fontSize: 20),),
                        value: valueChoose,
                        isExpanded: true,
                        onChanged: (newValue){
                          setState(() {
                            valueChoose = newValue;
                          });
                        },
                        items: listItem.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );


                        }).toList(),

                      )

                  ),
                ),
                Align(
                    alignment: Alignment(-0.7,0),
                    child:
                    Text("it's called ...",        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey,fontSize: 35,fontWeight: FontWeight.bold)
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Container(

                    child:
                    TextField(style: TextStyle(fontSize: 10),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                          hintText: 'Name of the product',
                        )
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment(-0.5,0),
                    child:
                    Text("Additional details",        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey,fontSize: 35,fontWeight: FontWeight.bold)
                    )
                ),
                Container(

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(


                      child:
                      TextField(
                          style: TextStyle(fontSize: 10),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(10,40,10,40),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                              hintText: 'Description of the product')),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment(-0.8,0),
                    child:
                    Text("Address",        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey,fontSize: 30,fontWeight: FontWeight.bold)
                    )
                ),
                Container(

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(


                      child:
                      TextField(
                          style: TextStyle(fontSize: 10),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(10,30,10,30),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                              hintText: 'Address')),
                    ),
                  ),
                ),


                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    color: Colors.grey[300],
                    child: Icon(Icons.photo_camera, color: Colors.white, size: 50.0),
                  ),
                ),

                Container(
                  padding:EdgeInsets.fromLTRB(20, 20, 20, 20),
                  //alignment: Alignment(0.7,0),
                  child:
                  MaterialButton(
                    elevation: 1,
                    minWidth:100, // width of the button
                    height: 50,
                    onPressed: () async {
                      //execute upadate
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                    }
                    ,color: Color(0xFFFFC857),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),


                    child: Text('Post',
                        style: TextStyle(color: Colors.grey[600], fontSize: 35)),
                  ),

                ),











                //////////////////////////////////////////////////////////////////////////////////////
              ]),
        ),
    );
  }
}

