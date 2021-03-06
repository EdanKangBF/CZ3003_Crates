import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/moderator_presentor.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/ReportListing.dart';
import 'package:flutter_application_1/screens/common/theme.dart';
import 'package:flutter_application_1/screens/moderator/oneReportListing.dart';

class ReportListingPage extends StatefulWidget {
  @override
  _ReportListingPageState createState() => _ReportListingPageState();
}

//
// List of reports
//

class _ReportListingPageState extends State<ReportListingPage> {
  bool dataLoading = false;
  List<ReportListing> reportListings;
  ModeratorPresentor _moderatorPresentor = new ModeratorPresentor();
  final TextEditingController _searchController = TextEditingController();
  String _searchName = "";
  bool sort = false;

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

    reportListings =
    await _moderatorPresentor.readReportListingList(_searchName);

    setState(() {
      reportListings = reportListings;
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
          backgroundColor: primaryColor,
          title: Text("Reported Listing",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(40.0))),
        ),
        body: dataLoading == false
            ? SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(20, 3, 20, 3),
                decoration: BoxDecoration(
                    border:
                    Border(bottom: BorderSide(color: primaryColor))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.search),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          key: Key('SearchReport'),
                          controller: _searchController,
                          decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                          onEditingComplete: () {
                            setState(() {
                              loadData();
                            });
                          },
                          onChanged: (val) => setState(() {
                            _searchName = val;
                          }),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            padding: EdgeInsets.only(right: 10.0),
                            child: TextButton.icon(
                              icon: Icon(Icons.sort),
                              label: Text('Sort'),
                              onPressed: () {
                                if (sort == false) {
                                  reportListings.sort((a, b) {
                                    sort = true;
                                    return a.reportTitle
                                        .toString()
                                        .toLowerCase()
                                        .compareTo(b.reportTitle
                                        .toString()
                                        .toLowerCase());
                                  });
                                } else {
                                  reportListings.sort((b, a) {
                                    sort = false;
                                    return a.reportTitle
                                        .toString()
                                        .toLowerCase()
                                        .compareTo(b.reportTitle
                                        .toString()
                                        .toLowerCase());
                                  });
                                }

                                setState(() {});
                              },
                            )))
                  ],
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: reportListings.length,
              itemBuilder: (context, index) {
                return reportCard(context, reportListings[index]);
              },
            ),

          ]),
        )
            : Center(child: CircularProgressIndicator()));
    // body: Body());
  }
}

Widget reportCard(BuildContext context, ReportListing report) {
  return Container(
    child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Card(
            key: Key('ReportListing'),
            margin: EdgeInsets.fromLTRB(5, 2, 2, 5),
            child: GestureDetector(
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  title: Text(report.reportTitle),
                  subtitle: Text(report.reportDescription),
                  isThreeLine: false,
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                onTap: () async {
                  // Load other listing details
                  Listing listing =
                  await ModeratorPresentor().readListing(report.listingID);

                  // Call listing to display
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OneReportListing(
                              reportListing: report, listing: listing)));
                }))),
  );
}
