import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/auth.dart';
import 'package:flutter_application_1/backend/moderator_presentor.dart';
import 'package:flutter_application_1/models/ReportListing.dart';
import 'package:flutter_application_1/screens/common/theme.dart';
import 'package:flutter_application_1/screens/common/widgets.dart';

class SendListingReport extends StatefulWidget {
  final String listingID;

  SendListingReport({@required this.listingID});

  @override
  _SendListingReportState createState() => _SendListingReportState();
}

class _SendListingReportState extends State<SendListingReport> {
  // hardcoded list of offenses
  List<String> _reportOffenseList = <String>[
    'Item wrongly categorized',
    'Offensive behaviour/content',
    'Listing contains Prohibited item',
    'Suspicious account'
  ];
  String _currentCat;
  String _reportDescription;
  String _reportTitle;

  TextEditingController reportDescCtrl = TextEditingController();
  TextEditingController reportTitleCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentCat = _reportOffenseList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: offWhite,
      child: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                      margin: EdgeInsets.zero,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 52),
                          Center(
                            child: Text(
                              "Report Listing",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 2,
                                color: offWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: Text('Title',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ))),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      onChanged: (val) => setState(() => _reportTitle = val),
                      controller: reportTitleCtrl,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 1,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'enter a title')),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text('Offense',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          focusColor: Colors.red,
                          value: _currentCat,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _currentCat = newValue;
                            });
                          },
                          items: _reportOffenseList.map((_categories) {
                            return DropdownMenuItem(
                              value: _categories,
                              child: Text(_categories),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text('Description',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      onChanged: (val) =>
                          setState(() => _reportDescription = val),
                      controller: reportDescCtrl,
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 5,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'enter a description')),
                ),
                Row(
                  children: [
                    SizedBox(width: 40),
                    Expanded(
                      child: CustomButton(
                          btnText: 'Send Report',
                          btnPressed: () async {
                            String currUser = await currentUser();
                            ReportListing report = new ReportListing(
                                reportTitle: _reportTitle,
                                listingID: widget.listingID,
                                reportDescription: _reportDescription,
                                complete: "False",
                                reportDate: DateTime.now(),
                                reportOffense: _currentCat,
                                userID: currUser);
                            await ModeratorPresentor()
                                .addReportListingData(report);
                            displayToastMessage('Successfully submitted', context);
                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: CustomButton(
                            btnText: 'Cancel',
                            btnPressed: () {
                              Navigator.pop(context);
                            })),
                    SizedBox(width: 40),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
