import 'dart:io';

class Listing {
  final String listingID;
  final String userID;
  final String listingTitle;
  final double longitude;
  final double latitude;
  final String category;
  final DateTime postDateTime;
  final bool isRequest;
  final File listingImage;
  final String description;
  Listing({this.listingID,this.userID, this.listingTitle,this.longitude,
    this.latitude,this.category,this.postDateTime,this.isRequest,
    this.listingImage,this.description});
}