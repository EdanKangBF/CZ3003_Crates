import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/auth.dart';
import 'package:flutter_application_1/backend/moderator_presenter.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/ReportListing.dart';
import 'package:flutter_application_1/models/ReportListingAction.dart';
import 'package:flutter_application_1/screens/common/theme.dart';


class oneReportCompleted extends StatefulWidget {
  final ReportListing reportListing;
  final Listing listing;

  oneReportCompleted({@required this.reportListing, @required this.listing});

  @override
  _oneReportCompletedState createState() => _oneReportCompletedState();
}

class _oneReportCompletedState extends State<oneReportCompleted> {
  ModeratorPresentor _moderatorPresentor = new ModeratorPresentor();
  ReportListingAction reportListingAction;
  bool dataLoading = false;
  String usernameListing = "";
  String usernameReport = "";
  String usernameMod = "";

  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    setState(() {
      // Data is still loading
      dataLoading = true;
    });

    reportListingAction = await _moderatorPresentor.readReportListingAction(widget.reportListing.reportID);
    usernameListing = await _moderatorPresentor.readUsername(widget.listing.userID);
    usernameReport = await _moderatorPresentor.readUsername(widget.reportListing.userID);
    usernameMod = await _moderatorPresentor.readUsername(reportListingAction.moderatorID);

    setState(() {
      reportListingAction = reportListingAction;
      usernameListing = usernameListing;
      usernameReport = usernameReport;
      usernameMod = usernameMod;
      dataLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text("Reported Listing",
            style: TextStyle(fontSize: 30, color: Colors.white)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.0))),
      ),
      body: dataLoading == false?
      SingleChildScrollView(
        child: Container(
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
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      child: CircleAvatar(
                        backgroundImage:
                        NetworkImage(widget.listing.listingImage),
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.listing.listingID,
                                    )
                              ])),
                        ),
                        Container(
                          width: 200.0,
                          alignment: Alignment.centerLeft,
                          child: Text.rich(TextSpan(
                              text: 'Listing Title:',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.listing.listingTitle)
                              ])),
                        ),
                        Container(
                          width: 200.0,
                          alignment: Alignment.centerLeft,
                          child: Text.rich(TextSpan(
                              text: 'Listed by: ',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                    text: usernameListing,
                                    )
                              ])),
                        )
                      ],
                    ),
                  ],
                ),
                //picture + listing id:listing name + listed by
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Text.rich(TextSpan(
                        text: 'Title of report: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                        children: <TextSpan>[
                          TextSpan(
                              text: widget.reportListing.reportTitle)
                        ]))),

                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                        TextSpan(text: 'Reported by: ',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              text: usernameReport,
                              )
                        ]))),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                        TextSpan(text: 'Report Type: ',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.reportListing.reportOffense,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]))),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                        TextSpan(text: 'Reported on: ',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              text: widget.reportListing.reportDate.toString(),)
                        ]))),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Report Description: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                ),
                // text of just report description
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.reportListing.reportDescription,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 23.0, top: 10.0, right: 23),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: primaryColor)
                      )
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0, right: 23),
                    alignment: Alignment.centerLeft,
                    child: Text('Action Taken On: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                ),
                // text of just report description
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(reportListingAction.actionDate.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                )
              ),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Action Taken: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                ),
                // text of just report description
                Container(
                  margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(reportListingAction.actionsTaken.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Update To Reporter: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                ),
                // text of just report description
                Container(
                  margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(reportListingAction.updateToReporter,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Update To Offender: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                ),
                // text of just report description
                Container(
                  margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(reportListingAction.updateToOffender,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Action Taken By: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                ),
                // text of just report description
                Container(
                  margin: const EdgeInsets.only(left: 23.0, top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(usernameMod,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
      ): Center(child: CircularProgressIndicator()),
    );
  }
}

