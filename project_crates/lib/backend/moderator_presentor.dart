import 'package:firebase_database/firebase_database.dart';
import '../models/ReportChat.dart';
import '../models/ReportChatAction.dart';
import '../models/ReportListing.dart';
import '../models/ReportListingAction.dart';
import '../models/Notification.dart';

class DatabaseService{

  final String reportChatID;
  final String reportListingID;
  final String reportChatActionID;
  final String reportListingActionID;
  final String moderatorID;

  DatabaseService({
    this.reportChatID, this.reportListingID, this.reportChatActionID, this.reportListingActionID, this.moderatorID
  });

  final _databaseRef = FirebaseDatabase.instance.reference();

  //
  // ReportChat
  //

  //Get list
  List<ReportChat> readReportChatList(){
    List<ReportChat> reportChatList = new List<ReportChat>();
    _databaseRef.child('ReportChat').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        ReportChat reportChat = new ReportChat(reportID: key, chatID: value['chatID'],
        reportTitle: value['reportTitle'], reportOffense: value['reportOffense'],
        reportDescription: value['reportDescription'], complete: value['complete'],
            reportDate: DateTime.parse(value['reportDate']), userID: value['userID']);
        reportChatList.add(reportChat);
      });
    });

    return reportChatList;
  }

  //Get one instance
  Future<ReportChat> readReportChat(String reportID) async{
    DataSnapshot snapshot = await _databaseRef.child('ReportChat').child(reportID).once();
    ReportChat reportChat = new ReportChat(reportID: reportID, chatID: snapshot.value['chatID'],
        reportTitle: snapshot.value['reportTitle'], reportOffense: snapshot.value['reportOffense'],
        reportDescription: snapshot.value['reportDescription'], complete: snapshot.value['complete'],
        reportDate: DateTime.parse(snapshot.value['reportDate']), userID: snapshot.value['userID']);
    return reportChat;
  }

  //Search list


  //Add
  Future addReportChatData(ReportChat data) async{
    _databaseRef.child("ReportChat").push().set({
      "chatID": data.chatID,
      "reportTitle": data.reportTitle,
      "reportDescription": data.reportDescription,
      "reportOffense": data.reportOffense,
      "complete": "False",
      "reportDate": data.reportDate.toString(),
      "userID": data.userID
    });
  }

  //Update
  Future updateReportChatData(String reportID) async{
    _databaseRef.child("ReportChat").child(reportID).update({
      "complete": 'True'
    });
  }

  //
  // ReportChatAction
  //

  //Get list
  List<ReportChatAction> readReportChatActionList(){
    List<ReportChatAction> reportChatActionList = new List<ReportChatAction>();
    _databaseRef.child('ReportChatAction').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        ReportChatAction reportChatAction = new ReportChatAction(reportID: key, actionsTaken: value['actionsTaken'],
            actionReason: value['actionReason'], updateToReporter: value['updateToReporter'],
            moderatorID: value['moderatorID'], actionDate: DateTime.parse(value['actionDate']));
        reportChatActionList.add(reportChatAction);
      });
    });
    return reportChatActionList;
  }

  //Get one instance
  Future<ReportChatAction> readReportChatAction(String reportID) async{
    DataSnapshot snapshot = await _databaseRef.child('ReportChatAction').child(reportID).once();
    ReportChatAction reportChatAction = new ReportChatAction(reportID: reportID, actionsTaken: snapshot.value['actionsTaken'],
        actionReason: snapshot.value['actionReason'], updateToReporter: snapshot.value['updateToReporter'],
        moderatorID: snapshot.value['moderatorID'], actionDate: DateTime.parse(snapshot.value['actionDate']));

    return reportChatAction;
  }

  //Add
  Future addReportChatActionData(ReportChatAction data) async{
    _databaseRef.child("ReportChatAction").child(data.reportID).set({
      "actionsTaken": data.actionsTaken,
      "actionReason": data.actionReason,
      "updateToReporter": data.updateToReporter,
      "moderatorID": data.moderatorID,
      "actionDate": data.actionDate.toString()
    });

    ReportChat rc = await readReportChat(data.reportID);

    String notiText = data.updateToReporter + "\n Actions Taken: " + "\n";
    for(var i = 0; i < data.actionsTaken.length; i++){
      notiText += data.actionsTaken[i] + "\n";
    }

    Notification noti = new Notification(notificationText: notiText, isMatch: "ChatReport", reportID: data.reportID,userID: rc.userID);
    addNotification(noti);
  }

  //
  // ReportListing
  //

  //Get list
  List<ReportListing> readReportListingList(){
    List<ReportListing> reportListingList = new List<ReportListing>();
    _databaseRef.child('ReportListing').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        ReportListing reportListing = new ReportListing(reportID: key, listingID: value['listingID'],
            reportTitle: value['reportTitle'], reportOffense: value['reportOffense'],
            reportDescription: value['reportDescription'], complete: value['complete'],
            reportDate: DateTime.parse(value['reportDate']), userID: value['userID']);
        reportListingList.add(reportListing);
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
    _databaseRef.child("ReportListing").push().set({
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
    _databaseRef.child("ReportListing").child(reportID).update({
      "complete": "True"
    });
  }

  //
  // ReportListingAction
  //

  //Get list
  List<ReportListingAction> readReportListingActionList(){
    List<ReportListingAction> reportListingActionList = new List<ReportListingAction>();
    _databaseRef.child('ReportListingAction').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      map.forEach((key, value) {
        ReportListingAction reportListingAction = new ReportListingAction(reportID: key, actionsTaken: value['actionsTaken'],
            actionReason: value['actionReason'], updateToReporter: value['updateToReporter'],
            moderatorID: value['moderatorID'], actionDate: DateTime.parse(value['actionDate']));
        reportListingActionList.add(reportListingAction);
      });
    });
    return reportListingActionList;
  }

  //Get one instance
  Future<ReportListingAction> readReportListingAction(String reportID) async{
    DataSnapshot snapshot = await _databaseRef.child('ReportListingAction').child(reportID).once();
    ReportListingAction reportListingAction = new ReportListingAction(reportID: reportID, actionsTaken: snapshot.value['actionsTaken'],
        actionReason: snapshot.value['actionReason'], updateToReporter: snapshot.value['updateToReporter'],
        moderatorID: snapshot.value['moderatorID'], actionDate: DateTime.parse(snapshot.value['actionDate']));

    return reportListingAction;
  }

  //Add
  Future addReportListingActionData(ReportListingAction data) async{
    _databaseRef.child("ReportListingAction").child(data.reportID).set({
      "actionsTaken": data.actionsTaken,
      "actionReason": data.actionReason,
      "updateToReporter": data.updateToReporter,
      "moderatorID": data.moderatorID,
      "actionDate": data.actionDate.toString()
    });

    ReportListing rl = await readReportListing(data.reportID);

    String notiText = data.updateToReporter + "\n Actions Taken: " + "\n";
    for(var i = 0; i < data.actionsTaken.length; i++){
      notiText += data.actionsTaken[i] + "\n";
    }

    Notification noti = new Notification(notificationText: notiText, isMatch: "ListingReport", reportID: data.reportID,userID: rl.userID);
    addNotification(noti);
  }

  //
  // Add to notification
  //

  Future addNotification(Notification data) async{
    _databaseRef.child("Notification").push().set({
      "notificationText": data.notificationText,
      "isMatch": data.isMatch,
      "listingID": data.listingID ?? "",
      "reportID": data.reportID ?? "",
      "userID": data.userID
    });
  }


}