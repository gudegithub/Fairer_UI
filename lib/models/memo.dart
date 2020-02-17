import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {

  final String id;
  final String title;
  final String content;
  final Timestamp timestamp;
  final String classId;

  Memo({this.id, this.title, this.content, this.timestamp, this.classId});

}