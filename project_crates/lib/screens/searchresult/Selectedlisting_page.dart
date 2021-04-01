import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/profile_presenter.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/common/theme.dart';
import 'package:flutter_application_1/screens/common/widgets.dart';
import 'package:flutter_application_1/backend/databaseAccess.dart';
import '../listing/Editinglist_page.dart';

class Selectedlisting_page extends StatefulWidget {
  final String listingID;

  Selectedlisting_page({this.listingID});

  @override
  _Selectedlisting_pageState createState() => _Selectedlisting_pageState();
}

//TODO previous page to pass in listing ID, example given below
//////////////////////////////////////////////////////////////////
// return TextButton(
//   child: Text('test'),
//   onPressed: () {
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => Selectedlisting_page(
//               listingID: '-MX7zj0KP3sQgEkJ2J38', //listingID goes here
//             )));
//   },
// );
/////////////////////////////////////////////////////////////////

class _Selectedlisting_pageState extends State<Selectedlisting_page> {
  @override
  initState() {
    super.initState();
    loadAsyncData(widget.listingID).then((response) {
      setState(() {
        listingTitle = response['listing'].listingTitle;
        description = response['listing'].description;
        listingImg = response['listing'].listingImage;
        username = response['poster'].username;
        currentuser = response['currentUID'] == response['listing'].userID;
        posted = DateTime.now()
                .difference(response['listing'].postDateTime)
                .inDays
                .toString() +
            ' days ago';
      });
    });
  }

  // TODO: This variable determines what buttons are built (true -> edit button, false-> report and chat buttons)
  bool currentuser;
  String listingTitle;
  String listingImg;
  String username;
  String description;
  String posted;

  DatabaseAccess dao = DatabaseAccess();
  ProfilePresenter profilePresenter = ProfilePresenter();

  @override
  Widget build(BuildContext context) {
    if (listingTitle == null) //check if data has loaded
      return CircularProgressIndicator(); //TODO make this look better
    else
      return Scaffold(
          backgroundColor: offWhite,
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              listingDetailsTopCard(
                  listingTitle, listingImg, currentuser, widget.listingID),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("posted $posted",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          RichText(
                            text: TextSpan(
                                text: 'by ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: username,
                                    style: TextStyle(
                                        color: Color(0xFFFFC857),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  )
                                ]),
                          )
                        ])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [
                  Text(description,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 15),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text('Location ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
              Container(
                color: Colors.grey[300],
                height: 150,
                width: 350,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                ),
              )
            ]),
            //bottomNavigationBar: Navigationbar(0),
          ));
  }

  Future<String> getUID() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Future loadAsyncData(String listingID) async {
    Listing listing = await dao.getListing(listingID);
    User poster = await profilePresenter.retrieveUserProfile(listing.userID);
    String currentUID = await getUID();
    return {'listing': listing, 'poster': poster, 'currentUID': currentUID};
  }
}

Widget listingDetailsTopCard(title, listingImg, currentUser, listingID) {
  return Stack(clipBehavior: Clip.none, children: <Widget>[
    Container(
      width: double.infinity,
      height: 300,
      child: Card(
          margin: EdgeInsets.zero,
          color: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.network(
                    listingImg,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          )),
    ),
    //TODO: Set the functions when the buttons are clicked (for backend ppl)
    reportCompleteButtons(currentUser, () {}, () {
      FirebaseDatabase.instance
          .reference()
          .child('Listing')
          .child(listingID)
          .child('isComplete')
          .set(true);
      print(
          'Listing completed'); //TODO show completion message to user and remove complete button
    }),
    chatEditButtons(currentUser, () {}, () {}),
  ]);
}

// return a report button only if this is true
Widget reportCompleteButtons(
    currentuser, ReportBtnPressed, CompleteBtnPressed) {
  print(currentuser);
  if (currentuser == false) {
    return Positioned(
      right: 110,
      left: 200,
      bottom: -20,
      child: Container(
          height: 40,
          child: CustomCurvedButton(
            btnText: 'Report',
            btnPressed: ReportBtnPressed,
          )),
    );
  } else {
    return Positioned(
      right: 110,
      left: 200,
      bottom: -20,
      child: Container(
          height: 40,
          child: CustomCurvedButton(
            btnText: 'Complete',
            btnPressed: CompleteBtnPressed,
          )),
    );
  }

  return Row();
}

Widget chatEditButtons(bool currentuser, EditBtnPressed, ChatBtnPressed) {
  if (currentuser == true) {
    return Positioned(
      right: 20,
      left: 290,
      bottom: -20,
      child: Container(
          height: 40,
          child: CustomCurvedButton(
            btnText: 'Edit',
            btnPressed: EditBtnPressed,
          )),
    );
  } else {
    return Positioned(
      right: 20,
      left: 290,
      bottom: -20,
      child: Container(
          height: 40,
          child: CustomCurvedButton(
            btnText: 'Chat',
            btnPressed: ChatBtnPressed,
          )),
    );
  }
}
