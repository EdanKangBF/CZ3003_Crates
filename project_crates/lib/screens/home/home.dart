import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/NavigationBar.dart';
import '../common/widgets.dart';
import '../common/theme.dart';

class Home extends StatefulWidget {
  static String tag = 'users-page';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: NavigationBar(0),
        backgroundColor: offWhite,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                topCard(),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.fromLTRB(25,0,0,10),
                  child: Text('Categories',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                  ),
                ),
                CategoryList(),
                SizedBox(height:15),
                Padding(
                  padding: EdgeInsets.fromLTRB(25,0,0,10),
                  child: Text('Nearby',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                  ),
                ),
                NearbyList(),
                SizedBox(height:30),
              ]),
        ));
  }
}


Widget topCard(){
  return Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      Container(
      width: double.infinity,
        height: 200,
        child: Card(
            margin: EdgeInsets.zero,
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:60),
                Center(
                  child: Text(
                    "CRATES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 2,
                      color: offWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(height:30),
                Padding(
                  padding: EdgeInsets.only(left:25),
                  child: Text('search',
                  style: TextStyle(
                    color: offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
      Positioned(
        right: 45,
        left: 45,
        bottom:-20,
        child: Container(
          height: 50,
          child: TextField(
              decoration: InputDecoration(
                  focusedBorder :OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                  prefixIcon: Icon(Icons.search),
                  prefixStyle: TextStyle(
                    decorationColor: Colors.red,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'search')),
        ),
      ),

    ]
  );

}

Widget CategoryList(){
  return SizedBox(
    height:140,
    child: ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          height:140.0,
          width: 140.0,
          child: Card(
            color: Colors.grey[350],
            margin: EdgeInsets.all(5),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: Text('All',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                  child: Image(
                    image: AssetImage('assets/icons/groceries.png')
                  ),
                )
              ]
            )
          )
        ),
        Container(
            height:140.0,
            width: 140.0,
            child: Card(
                color: Colors.grey[350],
                margin: EdgeInsets.all(5),
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text('Vegetables',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                        child: Image(
                            image: AssetImage('assets/icons/broccoli.png')
                        ),
                      )
                    ]
                )
            )
        ),
        Container(
            height:140.0,
            width: 140.0,
            child: Card(
                color: Colors.grey[350],
                margin: EdgeInsets.all(5),
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text('Canned Foods',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                        child: Image(
                            image: AssetImage('assets/icons/cream.png')
                        ),
                      )
                    ]
                )
            )
        ),
        Container(
            height:140.0,
            width: 140.0,
            child: Card(
                color: Colors.grey[350],
                margin: EdgeInsets.all(5),
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text('Canned Foods',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
                        child: Image(
                            image: AssetImage('assets/icons/cream.png')
                        ),
                      )
                    ]
                )
            )
        ),
      ],
    )
  );
}

Widget NearbyList(){
  return Container(
    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ListingCard(title: "Old Town White Coffee", owner: "leejunwei", listingImg: 'assets/coffee.jpg', ownerImg: 'assets/icons/default.png'),
            ListingCard(title: "Korean Spicy Noodles Samyang", owner: "Eggxactly", listingImg: 'assets/noodles.jpg', ownerImg: 'assets/icons/default.png'),
          ],
        ),
        Row(
          children: [
            ListingCard(title: "Old Town White Coffee", owner: "leejunwei", listingImg: 'assets/coffee.jpg', ownerImg: 'assets/icons/default.png'),
            ListingCard(title: "Korean Spicy Noodles Samyang", owner: "Eggxactly", listingImg: 'assets/noodles.jpg', ownerImg: 'assets/icons/default.png'),
          ],
        ),
      ],
    )
  );
}

// Widget ListingCard(title, owner, listingImg, ownerImg){
//   return Expanded(
//       child: Container(
//         child: InkWell(
//           //TODO: Edit this function to add listing page logic
//           onTap: (){print(title + " tapped!");},
//           child: Card(
//               color: Colors.grey[350],
//               margin: EdgeInsets.all(5),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       AspectRatio(
//                         aspectRatio: 1/1,
//                         child: Image.asset(
//                           listingImg,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       SizedBox(height:10),
//                       Text(title,
//                         maxLines: 1, // ensure long titles do not make card taller
//                         overflow: TextOverflow.ellipsis, // adds the '...' at the end of long titles
//                         style: TextStyle(
//                           color: Colors.grey[800],
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         )
//                       ),
//                       SizedBox(height:5),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: AssetImage(ownerImg),
//                             radius:15,
//                           ),
//                           SizedBox(width: 6),
//                           Text(owner),
//                         ],
//                       ),
//                     ]
//                 ),
//               )
//           ),
//         ),
//       )
//   );
// }