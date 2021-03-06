import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/models/ChatMessage.dart';
import 'package:flutter_application_1/models/ConversationCard.dart';
import 'package:flutter_application_1/models/Listing.dart';
import 'package:flutter_application_1/models/Notifications.dart';
import 'package:flutter_application_1/models/ReportListing.dart';
import 'package:flutter_application_1/models/Conversation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ActivityPresenter{

  final _databaseRef = FirebaseDatabase.instance.reference();
  final _photoStorageReference = FirebaseStorage.instance.ref().child('chat_photos');

  //Get list
  Future<List<Notifications>> readNotificationList(String userID) async{
    List<Notifications> notiList = new List<Notifications>();
    await _databaseRef.child('Notification').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      if(map != null){
        map.forEach((key, value) {
          Notifications noti = new Notifications(notificationID: key, notificationText: value['notificationText'],
              listingID: value['listingID'], reportID: value['reportID'],
              userID: value['userID'], notiDate: DateTime.parse(value['notiDate']) ?? "");
          if(noti.userID == userID){
            notiList.add(noti);
          }

        });
      }
    });
    return notiList;
  }

  //Get one instance
  Future<Notifications> readNotification(String notificationID) async{
    DataSnapshot snapshot = await _databaseRef.child('Notification').child(notificationID).once();
    Notifications noti = new Notifications(notificationID: notificationID,
        notificationText: snapshot.value['notificationText'],
        listingID: snapshot.value['listingID'], reportID: snapshot.value['reportID'],
        userID: snapshot.value['userID'],
        notiDate: DateTime.parse(snapshot.value['notiDate']));

    return noti;
  }

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

  //Get username of user
  Future<String> readUsername(String userID) async{
    DataSnapshot snapshotName = await _databaseRef.child('users').child(userID).once();
    String name = snapshotName.value['username'];
    return name;
  }

  //Get avatar of user
  Future<String> readAvatar(String userID) async{
    DataSnapshot snapshotName = await _databaseRef.child('users').child(userID).once();
    String imgPath = snapshotName.value['imagePath'];
    return imgPath;
  }


  Future<Map<String, String>> getUsernameMap(String conversation_id) async{
    Map usernameMap = <String, String>{};

    var user1 = getFirstUserIDFromConversation(conversation_id);
    var user2 = getSecondUserIDFromConversation(conversation_id);

    usernameMap[user1] = await readUsername(user1);
    usernameMap[user2] = await readUsername(user2);

    return usernameMap;
  }

  Future<Map<String, String>> getAvatarMap(String conversation_id) async{
    Map avatarMap = <String, String>{};

    var user1 = getFirstUserIDFromConversation(conversation_id);
    var user2 = getSecondUserIDFromConversation(conversation_id);

    avatarMap[user1] = await readAvatar(user1);
    avatarMap[user2] = await readAvatar(user2);

    return avatarMap;
  }



  //Get one report listing
  Future<ReportListing> readReportListing(String reportID) async{
    DataSnapshot snapshot = await _databaseRef.child('ReportListing').child(reportID).once();
    ReportListing reportListing = new ReportListing(reportID: reportID, listingID: snapshot.value['listingID'],
        reportTitle: snapshot.value['reportTitle'], reportOffense: snapshot.value['reportOffense'],
        reportDescription: snapshot.value['reportDescription'], complete: snapshot.value['complete'],
        reportDate: DateTime.parse(snapshot.value['reportDate']), userID: snapshot.value['userID']);

    return reportListing;
  }

  //
  // Chat
  //

  //Retrieve list of convo
  Future<List<Conversation>> readConversationList(String userID) async{
    var conList = <Conversation>[];
    await _databaseRef.child('Conversation').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;

      // if no conversation in entire db, then return empty map
      if (map == null){
        print('No conversation at all in db');
        return conList;
      }

      map.forEach((key, value) {
        var con = Conversation(conversation_id: key, messages: value['messages'].cast<String>());
        if(con.conversation_id.contains(userID)) {
          conList.add(con);
        }
      });
    });
    return conList;
  }


  Future<List<ConversationCard>> readConversationCardList(List<Conversation> convo_list, String userID) async{
    var conversationCardList = <ConversationCard>[];

    for(int i = 0; i < convo_list.length; i++){
      // get listing id from conversation_id (first 20 char)
      var listing_id = convo_list[i].conversation_id.substring(0,20);
      print(listing_id);

      // get the listing
      var listing = await readListing(listing_id);
      print(listing.listingTitle);

      // listing title
      var listing_title = listing.listingTitle;
      var listing_img = listing.listingImage;

      // determine who is the partner
      var partner_uid;
      if (listing.userID == userID){ // current user is owner
        partner_uid = getSecondUserIDFromConversation(convo_list[i].conversation_id);
      }else{
        partner_uid = listing.userID;
      }

      // get username of partner
      var partner_username = await readUsername(partner_uid);

      // construct Conversation Card object
      var cc  = await ConversationCard(conversation_id: convo_list[i].conversation_id, listing_title: listing_title, partner_username:partner_username, listing_img:listing_img);

      // add to list
      await conversationCardList.add(cc);
    }


    // return
    return conversationCardList;
  }


  String getListingIDFromConversation(String conversation_id){
    return conversation_id.substring(0,20);
  }

  String getFirstUserIDFromConversation(String conversation_id){
    return conversation_id.substring(20,48);
  }

  String getSecondUserIDFromConversation(String conversation_id){
    return conversation_id.substring(48,76);
  }


  //Retrieve one convo
  Future<Conversation> readConversation(String conversationID) async{
    DataSnapshot snapshot = await _databaseRef.child('Conversation').child(conversationID).once();
    Conversation convo = new Conversation(conversation_id: conversationID, messages: snapshot.value['messages'].cast<String>());
    return convo;
  }

  //Check if conversation exists
  Future<bool> checkConvoExists(String listingID, String ownerID, String getterID) async{
    DataSnapshot snapshot = await _databaseRef.child('Conversation').child(listingID+ownerID+getterID).once();
    if(snapshot.value == null){
      return false;
    }
    else{
      return true;
    }
  }

  //Add convo
  //For initial. Add message first, then get the ID, then add it to convo
  Future addConversation(String listingID, String ownerID, String getterID, List<String> messageID) async{
    await _databaseRef.child("Conversation").child(listingID+ownerID+getterID).set({
      "messages": messageID,
    });
  }

  //Update convo
  //Add more messages to list
  Future updateConversation(Conversation data) async{
    await _databaseRef.child("Conversation").child(data.conversation_id).update({
      "messages": data.messages,
    });
    await print("updateConversation completed");
  }

  //Retrieve listing info
  Future<Listing> readListingInfo(String listingID) async{
    DataSnapshot snapshot = await _databaseRef.child('Listing').child(listingID).once();
    Listing listing = new Listing(listingID: listingID, listingTitle: snapshot.value['listingTitle'],
        listingImage: snapshot.value['listingImage'], userID: snapshot.value['userID'],
        isRequest: snapshot.value['isRequest'], isComplete: snapshot.value['isComplete'],
        postDateTime: DateTime.parse(snapshot.value['reportDate']), description: snapshot.value['description']);

    return listing;
  }

  //Retrieve chat messages
  Future<List<ChatMessage>> readChatMessage(List<String> id) async{
    var messagesList = <ChatMessage>[];

    for (int i = 0; i < id.length ; i++){
      if(id[i] != "defaultempty"){
        DataSnapshot snapshot = await _databaseRef.child('ChatMessage').child(id[i]).once();
        ChatMessage chatMsg = new ChatMessage(text: snapshot.value['text'], imageUrl: snapshot.value['imageUrl'],
            sender_uid: snapshot.value['sender_uid'] ?? "", date_sent: DateTime.parse(snapshot.value['date_sent']));
        messagesList.add(chatMsg);
      }
    }
    return messagesList.reversed.toList();
  }

  // retrieve a single chat message
  Future<ChatMessage> readOneChatMessage(String id) async{

    var snapshot = await _databaseRef.child('ChatMessage').child(id).once();

    var chatMsg = ChatMessage(text: snapshot.value['text'], imageUrl: snapshot.value['imageUrl'],
        sender_uid: snapshot.value['sender_uid'], date_sent: DateTime.parse(snapshot.value['date_sent']));

    return chatMsg;
  }


  //Add chat message
  Future addChatMessage(String text, String imageUrl, String user_id) async{
    var newpush = await _databaseRef.child('ChatMessage').push();
    await newpush.set({
      'text': text,
      'imageUrl': imageUrl,
      'sender_uid': user_id ?? '',
      'date_sent': DateTime.now().toString(),
    });

    // return ID
    return newpush.key;
  }


  // image submitted
  Future sendImage(ImageSource imageSource, user_id) async {

    // upload picture
    var image = await ImagePicker.pickImage(source: imageSource);
    var fileName = Uuid().v4();
    var photoRef = _photoStorageReference.child(fileName);
    var uploadTask = photoRef.putFile(image);
    await uploadTask.onComplete;
    String downloadUrl = await photoRef.getDownloadURL();
    await print('chat image uploaded: $downloadUrl.ref.getDownloadURL()');

    // add message to db
    return await addChatMessage(null, downloadUrl, user_id);

  }



}
