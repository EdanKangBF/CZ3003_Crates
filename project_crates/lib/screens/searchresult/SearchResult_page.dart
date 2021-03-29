



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import '../common/NavigationBar.dart';
import 'Selectedlisting_page.dart';






class SearchResult_page extends StatelessWidget {





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
            actions: <Widget>[
              Container(
                width: 300,

                child:
                TextField(
                  style: TextStyle(color: Colors.black,height: 0,fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter Search',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      filled: true,
                      fillColor: Colors.grey[50]),
                  onChanged: (value) {
                    _search = value
                        .trim(); // store the password typed in the _password
                  },
                ),
              ),



              IconButton(
                alignment: Alignment.center,
                icon: new Icon(Icons.search,size:35),
                color:Colors.black,
                onPressed: () {
                  // pressed to execute search in the search field the user has entered
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SearchResult_page()));
                },
              ),
            ]


        ),


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
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class _BodyState extends State<Body> {
  List listItem = ['Drink and Beverages', 'Snack', 'Can food','Can food','Can food','Can food',];
  String valueChoose;
  String _distance;

  Future<void> showFliterDialog(BuildContext context) async {
    return await showDialog(context: context,
        builder: (context) {
          final TextEditingController _textEditingController = TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                child: setupFliterDialoadContainer(),

                height: 200,
                width: 300,
              ),

              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child:
                        MaterialButton(
                          elevation: 1,
                          minWidth: 100,
                          // width of the button
                          height: 30,
                          onPressed: () async {
                            // clear the filter
                          }
                          ,
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius
                              .circular(15.0)),

                          child: Text('Clear',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 20)),
                        ),
                      ),
                      Container(
                        child:
                        MaterialButton(
                          elevation: 1,
                          minWidth: 100,
                          // width of the button
                          height: 30,

                          onPressed: () async {
                            // apply
                          }
                          ,
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius
                              .circular(150.0)),

                          child: Text('Apply',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 20)),
                        ),
                      )
                    ]
                ),

              ],
            );
          });
        });
  }

  Future<void> showSortDialog(BuildContext context) async {
    return await showDialog(context: context,
        builder: (context) {
          final TextEditingController _textEditingController = TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                child: setupSortDialoadContainer(),

                height: 110,
                width: 300,
              ),

              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child:
                        MaterialButton(
                          elevation: 1,
                          minWidth: 100,
                          // width of the button
                          height: 30,
                          onPressed: () async {
                            // clear the sort
                          }
                          ,
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius
                              .circular(15.0)),

                          child: Text('Clear',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 20)),
                        ),
                      ),
                      Container(
                        child:
                        MaterialButton(
                          elevation: 1,
                          minWidth: 100,
                          // width of the button
                          height: 30,

                          onPressed: () async {
                            // apply
                          }
                          ,
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius
                              .circular(150.0)),

                          child: Text('Apply',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 20)),
                        ),
                      )
                    ]
                ),

              ],
            );
          });
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Align(
                  alignment: Alignment(-0.7, 0),
                  child:
                  Text('4 result for "coffee powder"',
                      // Text placement will change depend on the search result
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)
                  )
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child:
                      MaterialButton(
                        elevation: 1,
                        minWidth: 100,
                        // width of the button
                        height: 30,
                        onPressed: () async {
                          await showFliterDialog(context);
                        }
                        ,
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius
                            .circular(10.0)),

                        child: Text('Fliters',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 20)),
                      ),
                    ),
                    Container(
                      child:
                      MaterialButton(
                        elevation: 1,
                        minWidth: 100,
                        // width of the button
                        height: 30,

                        onPressed: () async {
                          await showSortDialog(context);// go to sort page
                        }
                        ,
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius
                            .circular(10.0)),

                        child: Text('Sort',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 20)),
                      ),
                    )
                  ]
              ),
              //SizedBox(height: 20),
              NearbyList(context),


            ]
        ),
      ),


    );
  }

  setupFliterDialoadContainer() {
    return
      Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Align(
                    alignment: Alignment(-0.9, 0),
                    child:
                    Text("Filters",
                        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                    )
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: Align(
                    alignment: Alignment(-0.9, 0),
                    child:
                    Text("category",
                        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                child: Container(

                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: DropdownButton(
                      hint: Text('Select category',
                        style: TextStyle(color: Colors.white, fontSize: 20),),
                      value: valueChoose,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue;
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),

                    )

                ),
              ),

              Container(
                child: Align(
                    alignment: Alignment(-0.9, 0),
                    child:
                    Text("distance",
                        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                    )
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //change here don't //worked
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("within",
                          // Text placement will change depend on the search result
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal)
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,5,5,0),
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: TextFormField(
                              //initialValue: userData.name,
                              decoration: InputDecoration(
                                  hintText: '  eg 2',
                                  fillColor: Colors.grey
                              ),

                              style: TextStyle(fontSize: 15.0, color: Colors.black),
                              validator: (val) => val.isEmpty ? 'distance' : null,

                              onChanged: (val) => setState(() => _distance = val),
                            ),
                          ),
                        ),
                      ),
                      Text("kilometers",
                          // Text placement will change depend on the search result
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal)
                      ),


                    ]


                ),
              ),


            ],


          ));
  }

  setupSortDialoadContainer() {
    return
      Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Align(
                    alignment: Alignment(-0.9, 0),
                    child:
                    Text("Sort",
                        // Text placement will change depend on the search result
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                    )
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                child: Container(

                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: DropdownButton(
                      hint: Text('Sort',
                        style: TextStyle(color: Colors.white, fontSize: 20),),
                      value: valueChoose,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue;
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),

                    )

                ),
              ),



            ],


          ));



  }

}

Widget NearbyList(context){
  return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ListingCard1( "Old Town White Coffee",  "leejunwei",  'assets/coffee.jpg',  'assets/icons/default.png',context),
              ListingCard1( "Korean Spicy Noodles Samyang",  "Eggxactly",  'assets/noodles.jpg', 'assets/icons/default.png',context),
            ],
          ),
          Row(
            children: [
              // ListingCard(title: "Old Town White Coffee", owner: "leejunwei", listingImg: 'assets/coffee.jpg', ownerImg: 'assets/icons/default.png'),
              // ListingCard(title: "Korean Spicy Noodles Samyang", owner: "Eggxactly", listingImg: 'assets/noodles.jpg', ownerImg: 'assets/icons/default.png'),
            ],
          ),
        ],
      )
  );
}

Widget ListingCard1(title, owner, listingImg, ownerImg, context){
  return Expanded(
      child: Container(
        child: InkWell(
          //TODO: Edit this function to add listing page logic
          onTap: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  Selectedlisting_page()));},
          child: Card(
              color: Colors.grey[350],
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1/1,
                        child: Image.asset(
                          listingImg,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height:10),
                      Text(title,
                          maxLines: 1, // ensure long titles do not make card taller
                          overflow: TextOverflow.ellipsis, // adds the '...' at the end of long titles
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )
                      ),
                      SizedBox(height:5),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(ownerImg),
                            radius:15,
                          ),
                          SizedBox(width: 6),
                          Text(owner),
                        ],
                      ),
                    ]
                ),
              )
          ),
        ),
      )
  );
}