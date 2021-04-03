import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/auth.dart';
import 'package:flutter_application_1/backend/moderator_presenter.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/ReportListing.dart';
import 'package:flutter_application_1/models/ReportListingAction.dart';
import 'package:flutter_application_1/screens/common/theme.dart';
import 'package:flutter_application_1/screens/common/widgets.dart';

import 'oneListingAction.dart';

class OneReportListing extends StatefulWidget {
  final ReportListing reportListing;
  final Listing listing;

  OneReportListing({@required this.reportListing, @required this.listing});

  @override
  _OneReportListingState createState() => _OneReportListingState();
}

class _OneReportListingState extends State<OneReportListing> {
  bool dataLoading = false;
  String usernameListing = "";
  String usernameReport = "";
  ModeratorPresentor _moderatorPresentor = new ModeratorPresentor();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    setState(() {
      // Data is still loading
      dataLoading = true;
    });

    usernameListing =
        await _moderatorPresentor.readUsername(widget.listing.userID);
    usernameReport =
        await _moderatorPresentor.readUsername(widget.reportListing.userID);

    setState(() {
      usernameListing = usernameListing;
      usernameReport = usernameReport;
      // Data is done loading
      dataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          shadowColor: offWhite,
          backgroundColor: primaryColor,
          title: Text("Reported Listing",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.0))),
        ),
        body: dataLoading == false
            ? Container(
                child: ListView(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment(-1, -1),
                              child: TextButton.icon(
                                  icon: Icon(Icons.keyboard_backspace),
                                  label: Text('Back'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            //backbutton
                            InkWell(
                              onTap: () {
                                //TODO Link to listing
                              },
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          widget.listing.listingImage),
                                      radius: 60,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200.0,
                                        alignment: Alignment.centerLeft,
                                        child: Text.rich(TextSpan(
                                            text: 'Listing ID:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      widget.listing.listingID,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ])),
                                      ),
                                      Container(
                                        width: 200.0,
                                        alignment: Alignment.centerLeft,
                                        child: Text.rich(TextSpan(
                                            text: 'Listing Title:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: widget
                                                      .listing.listingTitle,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ])),
                                      ),
                                      Container(
                                        width: 200.0,
                                        alignment: Alignment.centerLeft,
                                        child: Text.rich(TextSpan(
                                            text: 'Listed by: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: usernameListing,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ])),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //picture + listing id:listing name + listed by
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 23.0, top: 15.0),
                                alignment: Alignment.centerLeft,
                                child: Text.rich(TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              widget.reportListing.reportTitle,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]))),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 23.0, top: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text.rich(TextSpan(
                                    text: 'Reported by: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: usernameReport,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]))),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 23.0, top: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text.rich(TextSpan(
                                    text: 'Report Type: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget
                                              .reportListing.reportOffense,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]))),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 23.0, top: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text.rich(TextSpan(
                                    text: 'Reported on: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.reportListing.reportDate
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]))),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 23.0, top: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Report Description: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            // text of just report description
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 23.0, top: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.reportListing.reportDescription,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )),
                            SizedBox(height: 30),

                            Row(
                              children: [
                                SizedBox(width: 40),
                                Expanded(
                                  child: CustomButton(
                                    btnText: "Choose Actions",
                                    btnPressed: () {
                                      print(widget.reportListing.listingID);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListingActionForm(
                                                      reportListing:
                                                          widget.reportListing,
                                                      listing:
                                                          widget.listing)));
                                    }, //show popup dialog
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: dismissReport(context,
                                      widget.reportListing, widget.listing),
                                ),
                                SizedBox(width: 40),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}

Widget dismissReport(
    BuildContext context, ReportListing reportListing, Listing listing) {
  return CustomButton(
    btnText: "Dismiss Report",
    btnPressed: () async {
      String currUser = await currentUser();
      List<String> actions;
      ReportListingAction action = new ReportListingAction(
          reportID: reportListing.reportID,
          actionsTaken: actions,
          actionDate: DateTime.now(),
          updateToReporter: "Actions were not taken",
          updateToOffender: "Actions were not taken",
          moderatorID: currUser);
      await ModeratorPresentor().addReportListingActionData(action);
      await ModeratorPresentor()
          .updateReportListingData(reportListing.reportID);
      displayToastMessage('Successfully submitted', context);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }, //show popup dialog
  );
}
