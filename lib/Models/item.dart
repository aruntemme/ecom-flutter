import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String title;
  String shortInfo;
  Timestamp publishedDate;
  String thumbnailUrl;
  String category;
  String longDescription;
  String status;
  int price;

  ItemModel({
    this.title,
    this.category,
    this.longDescription,
    this.price,
    this.publishedDate,
    this.shortInfo,
    this.status,
    this.thumbnailUrl,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    category = json['category'];
    status = json['status'];
    price = json['price'];
  }
}
