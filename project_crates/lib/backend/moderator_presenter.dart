import 'package:firebase_database/firebase_database.dart';
import '../models/ReportListing.dart';
import '../models/ReportListingAction.dart';
import '../models/Notification.dart';
import '../models/Listing.dart';

class ModeratorPresentor{

  final String reportListingID;
  final String reportListingActionID;
  final String moderatorID;

  ModeratorPresentor({
   this.reportListingID, this.reportListingActionID, this.moderatorID
  });

  final _databaseRef = FirebaseDatabase.instance.reference();

  //
  // ReportListing
  //

  //Get list
  Future<List<ReportListing>> readReportListingList(String name) async{
    List<ReportListing> reportListingList = new List<ReportListing>();
    await _databaseRef.child('ReportListing').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        ReportListing reportListing = new ReportListing(reportID: key, listingID: value['listingID'],
            reportTitle: value['reportTitle'], reportOffense: value['reportOffense'],
            reportDescription: value['reportDescription'], complete: value['complete'],
            reportDate: DateTime.parse(value['reportDate']), userID: value['userID']);
        if(name != ""){
          if(reportListing.complete == "False" && reportListing.reportTitle.toLowerCase().contains(name.toLowerCase())){
            reportListingList.add(reportListing);
            print("test");
          }
        }
        else{
          if(reportListing.complete == "False"){
            reportListingList.add(reportListing);
            print("test2");
            print(name);
          }
        }
      });
    });

    return reportListingList;
  }

  Future<List<ReportListing>> readReportListingListCompleted(String name) async{
    List<ReportListing> reportListingList = new List<ReportListing>();
    await _databaseRef.child('ReportListing').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        ReportListing reportListing = new ReportListing(reportID: key, listingID: value['listingID'],
            reportTitle: value['reportTitle'], reportOffense: value['reportOffense'],
            reportDescription: value['reportDescription'], complete: value['complete'],
            reportDate: DateTime.parse(value['reportDate']), userID: value['userID']);
        if(name != ""){
          if(reportListing.complete == "True" && reportListing.reportTitle.toLowerCase().contains(name.toLowerCase())){
            reportListingList.add(reportListing);
          }
        }
        else{
          if(reportListing.complete == "True"){
            reportListingList.add(reportListing);
          }
        }
      });
    });
    return reportListingList;
  }

  //Get one instance
  Future<ReportListing> readReportListing(String reportID) async{
    DataSnapshot snapshot = await _databaseRef.child('ReportListing').child(reportID).once();
    ReportListing reportListing = new ReportListing(reportID: reportID, listingID: snapshot.value['listingID'],
        reportTitle: snapshot.value['reportTitle'], reportOffense: snapshot.value['reportOffense'],
        reportDescription: snapshot.value['reportDescription'], complete: snapshot.value['complete'],
        reportDate: DateTime.parse(snapshot.value['reportDate']), userID: snapshot.value['userID']);

    return reportListing;
  }

  //Add
  Future addReportListingData(ReportListing data) async{
    await _databaseRef.child("ReportListing").push().set({
      "listingID": data.listingID,
      "reportTitle": data.reportTitle,
      "reportDescription": data.reportDescription,
      "reportOffense": data.reportOffense,
      "complete": "False",
      "reportDate": data.reportDate.toString(),
      "userID": data.userID
    });
  }

  //Update
  Future updateReportListingData(String reportID) async{
    await _databaseRef.child("ReportListing").child(reportID).update({
      "complete": "True"
    });
  }

  //
  // ReportListingAction
  //

  //Get list
  Future<List<ReportListingAction>> readReportListingActionList() async{
    List<ReportListingAction> reportListingActionList = new List<ReportListingAction>();
    await _databaseRef.child('ReportListingAction').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        ReportListingAction reportListingAction = new ReportListingAction(reportID: key, actionsTaken: value['actionsTaken'],
            updateToReporter: value['updateToReporter'], updateToOffender: value['updateToOffender'],
            moderatorID: value['moderatorID'], actionDate: DateTime.parse(value['actionDate']));
        reportListingActionList.add(reportListingAction);
      });
    });
    return reportListingActionList;
  }

  //Get one instance
  Future<ReportListingAction> readReportListingAction(String reportID) async{
    DataSnapshot snapshot = await _databaseRef.child('ReportListingAction').child(reportID).once();
    ReportListingAction reportListingAction = new ReportListingAction(reportID: reportID,
        actionsTaken: snapshot.value['actionsTaken'].cast<String>(),
        updateToReporter: snapshot.value['updateToReporter'], updateToOffender: snapshot.value['updateToOffender'],
        moderatorID: snapshot.value['moderatorID'],
        actionDate: DateTime.parse(snapshot.value['actionDate']));

    return reportListingAction;
  }

  //Add
  Future addReportListingActionData(ReportListingAction data) async{
    String updateToO = "";
    String updateToR = "";

    if(data.updateToOffender == ""){
      updateToO = "You were reported for inappropriate listing.";
    }
    else{
      updateToO = data.updateToOffender;
    }

    if(data.updateToReporter == ""){
      updateToR = "Actions against the offender has been taken.";
    }
    else{
      updateToR = data.updateToReporter;
    }

    await _databaseRef.child("ReportListingAction").child(data.reportID).set({
      "actionsTaken": data.actionsTaken,
      "updateToReporter": updateToR,
      "updateToOffender": updateToO,
      "moderatorID": data.moderatorID,
      "actionDate": data.actionDate.toString()
    });

    //Get ReportListing
    ReportListing rl = await readReportListing(data.reportID);

    //Get Listing
    Listing l = await readListing(rl.listingID);

    String action = "0";

    //Notification
    String notiText = data.updateToReporter + "\n" + "Actions Taken: " + "\n";

    if(data.actionsTaken.length > 0){
      for(var i = 0; i < data.actionsTaken.length; i++){
        notiText += data.actionsTaken[i] + "\n";
      }

      if(data.actionsTaken[0] == "temporary"){
        action = "1";
      }
      else if(data.actionsTaken[0] == "permanent"){
        action = "2";
      }
    }
    else{
      notiText += "None";
    }

    Notification noti = new Notification(notificationText: notiText, isMatch: "ListingReport", reportID: data.reportID,userID: rl.userID);
    addNotification(noti);

    if(data.actionsTaken.length > 1){
      //Delete listing
      deleteListing(l);
    }

    //Update user
    updateUser(l.userID, action);

  }

  //
  // Add to notification
  //

  Future addNotification(Notification data) async{
    await _databaseRef.child("Notification").push().set({
      "notificationText": data.notificationText,
      "isMatch": data.isMatch,
      "listingID": data.listingID ?? "",
      "reportID": data.reportID ?? "",
      "userID": data.userID
    });
  }

  //
  //Listing
  //

  //Get listing
  Future<Listing> readListing(String listingID) async{
    DataSnapshot snapshot = await _databaseRef.child('Listing').child(listingID).once();
    if(snapshot.value != null){
      Listing listing = new Listing(listingID: listingID, listingTitle: snapshot.value['listingTitle'], listingImage: snapshot.value['listingImage'],
          userID: snapshot.value['userID']);
      return listing;
    }
    else{
      DataSnapshot snapshotDeleted = await _databaseRef.child('ListingDeleted').child(listingID).once();
      Listing listing = new Listing(listingID: listingID, listingTitle: snapshotDeleted.value['listingTitle'], listingImage: snapshotDeleted.value['listingImage'],
          userID: snapshotDeleted.value['userID']);
      return listing;
    }
  }

  //Delete listing
  Future deleteListing(Listing listing) async{
    await _databaseRef.child("ListingDeleted").child(listing.listingID).set({
      "category": listing.category,
      "description": listing.description,
      "isComplete": listing.isComplete,
      "isRequest": listing.isRequest,
      "latitude": listing.latitude,
      "listingImage": listing.listingImage,
      "listingTitle": listing.listingTitle,
      "longitude" : listing.longitude,
      "postDateTime": listing.postDateTime.toString(),
      "userID" : listing.userID
    });

    await _databaseRef.child("Listing").child(listing.listingID).remove();
  }

  //
  // User
  //

  //Get username of user
  Future<String> readUsername(String userID) async{
    DataSnapshot snapshotName = await _databaseRef.child('users').child(userID).once();
    String name = snapshotName.value['username'];
    return name;
  }


  //Update user account for ban
  Future updateUser(String userID, String action) async{
    await _databaseRef.child("users").child(userID).update({
      "isBanned": action,
      "bannedFrom": DateTime.now().toString()
    });
  }


}