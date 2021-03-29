import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../activity/items.dart';
import '../common/theme.dart';

// Custom button for login/register pages
// takes in button text and a function that is performed when button is pressed
class CustomButton extends StatelessWidget {
  final String btnText;
  final Function btnPressed;

  // constructor
  CustomButton({this.btnText, this.btnPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: btnPressed,
        child: SizedBox(
            width: double.infinity,
            child: Center(
                child: Text(btnText,
                    style: TextStyle(
                      color: offWhite,
                    )))),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFED8146)),
        ));
  }
}

// Curved grey button
class CustomCurvedButton extends StatelessWidget {
  final String btnText;
  final Function btnPressed;

  // constructor
  CustomCurvedButton({this.btnText, this.btnPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: btnPressed,
        child: SizedBox(
            width: double.infinity,
            child: Center(
                child: Text(btnText,
                    style: TextStyle(
                      color: offWhite,
                    )))),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
        ));
  }
}

// Listing Card widget (Uses local asset image, therefore will not work for dynamically loaded data)
// TODO: Replace all instances of this ListingCard() class with CustomListingCard()
class ListingCard extends StatelessWidget {
  final String title, owner, listingImg, ownerImg;

  // constructor
  ListingCard({this.title, this.owner, this.listingImg, this.ownerImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.grey[350],
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      listingImg,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(title,
                    maxLines: 1, // ensure long titles do not make card taller
                    overflow: TextOverflow
                        .ellipsis, // adds the '...' at the end of long titles
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
                SizedBox(height: 5),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(ownerImg),
                      radius: 15,
                    ),
                    SizedBox(width: 6),
                    Text(owner),
                    reportbuttonforlisting(context)
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

// TODO: Remove this widget when all pages have removed this as it is not longer in use
class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.home),
                  SizedBox(width: 8),
                  Text('Home'),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Profile'),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Text('Nearby'),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.notifications),
                  SizedBox(width: 8),
                  Text('Activity'),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.library_add),
                  SizedBox(width: 8),
                  Text('New Listing'),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.logout),
                  SizedBox(width: 8),
                  Text('Sign Out'),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ] // Populate the Drawer in the next step.
          ),
    );
  }
}

// Updated Listing Card that supports GridView and uses NetworkImage
// TODO: Try to make image fit to card!!!! omg
class CustomListingCard extends StatelessWidget {
  final String title, owner, listingImg, ownerImg;

  // constructor
  CustomListingCard({this.title, this.owner, this.listingImg, this.ownerImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.grey[350],
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.network(
                      listingImg,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(title,
                    maxLines: 1, // ensure long titles do not make card taller
                    overflow: TextOverflow
                        .ellipsis, // adds the '...' at the end of long titles
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
                SizedBox(height: 5),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(ownerImg),
                      radius: 15,
                    ),
                    SizedBox(width: 6),
                    Text(owner),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
