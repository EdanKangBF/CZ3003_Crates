import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/auth.dart';
import 'package:flutter_application_1/backend/moderator_presentor.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/ReportListing.dart';
import 'package:flutter_application_1/models/ReportListingAction.dart';
import 'package:flutter_application_1/screens/common/theme.dart';
import 'package:flutter_application_1/screens/common/widgets.dart';

enum Penalties { temporary, permanent, none }

class ListingActionForm extends StatefulWidget {
  final ReportListing reportListing;
  final Listing listing;

  ListingActionForm({@required this.reportListing, @required this.listing});

  @override
  _ListingActionFormState createState() => _ListingActionFormState();
}

class _ListingActionFormState extends State<ListingActionForm> {
  String _currentReasonToR;
  String _currentReasonToO;

  TextEditingController reasonToR = TextEditingController();
  TextEditingController reasonToO = TextEditingController();

  Penalties _penalty = Penalties.none;

  //Whether or not listing should be deleted
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text("Reported Listing",
            style: TextStyle(fontSize: 30, color: Colors.white)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.0))),
      ),
      body: Container(
        
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose Actions',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Colors.white,

                    ),
                    child: Column(children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.only(left: 20.0),
                        title: const Text('Delete Listing'),
                        value: _isSelected,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isSelected = newValue;
                          });
                        },
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Ban Account for 1 month'),
                            leading: Radio<Penalties>(
                              value: Penalties.temporary,
                              groupValue: _penalty,
                              toggleable: true,
                              onChanged: (Penalties value) {
                                setState(() {
                                  _penalty = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Ban Account permanently'),
                            leading: Radio<Penalties>(
                              value: Penalties.permanent,
                              groupValue: _penalty,
                              toggleable: true,
                              onChanged: (Penalties value) {
                                setState(() {
                                  _penalty = value;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                  SizedBox(height: 20),
                  Text('Update to Reporter',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                        onChanged: (val) =>
                            setState(() => _currentReasonToR = val),
                        controller: reasonToR,
                        minLines: 4,
                        // Allows box to grow vertically
                        maxLines: null,
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
                        )),
                  ),
                  SizedBox(height: 20),
                  Text('Update to Offender',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                        onChanged: (val) =>
                            setState(() => _currentReasonToO = val),
                        controller: reasonToO,
                        minLines: 4,
                        // Allows box to grow vertically
                        maxLines: null,
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
                        )),
                  ),
                  SizedBox(height: 20),
                  // RadioButton(),
                  // MyTextField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 40),
                      Expanded(
                          child: CustomButton(
                        btnText: "Submit",
                        btnPressed: () async {
                          List<String> actionsTaken = new List<String>();

                          actionsTaken.add(_penalty.toString().substring(10));
                          if (_isSelected == true) {
                            actionsTaken.add("Deleted Listing");
                          }

                          String currUser = await currentUser();
                          ReportListingAction data = new ReportListingAction(
                              reportID: widget.reportListing.reportID,
                              actionsTaken: actionsTaken,
                              updateToReporter: _currentReasonToR,
                              updateToOffender: _currentReasonToO,
                              moderatorID: currUser,
                              actionDate: DateTime.now());

                          await ModeratorPresentor()
                              .addReportListingActionData(data);
                          await ModeratorPresentor().updateReportListingData(
                              widget.reportListing.reportID);
                          displayToastMessage('Successfully submitted', context);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                      )),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          btnText: "Cancel",
                          btnPressed: () {
                            Navigator.pop(context);
                          }, //show popup dialog
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
