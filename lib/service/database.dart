import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fairer_ui/models/classData.dart';
import 'package:fairer_ui/models/user.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});

  // ユーザープロフィール取得

  final CollectionReference userProfileCollection = Firestore.instance.collection('userProfile');

  UserProfile _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserProfile(
      uid: uid,
      name: snapshot.data["name"],
      university: snapshot.data["university"],
      department: snapshot.data["department"],
      graduationYear: snapshot.data["graduationYear"]
    );
  }

  Future<void> updateUserProfile(String name, String university, String department, String graduationYear) async {
    return await userProfileCollection.document(uid).setData({
      'name': name,
      'university' : university,
      'department' : department,
      'graduationYear' : graduationYear
    });
  }

  Stream<UserProfile> get userData  {
    return userProfileCollection.document(uid).snapshots()
      .map(_userDatafromSnapshot);
  }


  // 時間割情報取得

  final CollectionReference classDataCollection = Firestore.instance.collection('classData');

  List<FirebaseClassData> _classDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FirebaseClassData(
        university: doc.data["university"],
        week: doc.data["week"],
        time: doc.data["time"],
        className: doc.data["className"],
        teacherName: doc.data["teacherName"],
        room: doc.data["room"],
        classCode: doc.data["classCode"],
      );
    }).toList();
  }

  Future<String> createClassData(String university, String className, int week, int time, String teacherName, String room, String classCode) async {

    final classData = classDataCollection.document();

    classData.setData({
      'university': university,
      'className': className,
      'week': week,
      'time': time,
      'teacherName': teacherName,
      'room': room,
      'classCode': classCode,
    });
    return classData.documentID;
  }

  Future<void> updateClassData(String id,String className, int week, int time, String teacherName, String room, String classCode) async {
    return await classDataCollection.document(id).setData({
      'className': className,
      'week': week,
      'time': time,
      'teacherName': teacherName,
      'room': room,
      'classCode': classCode,
    });
  }

  Stream<List<FirebaseClassData>> get classData {
    return classDataCollection.snapshots()
      .map(_classDataListFromSnapshot);
  }

  searchClassData(int week, int time, String university) {
    int week;
    int time;
    String university;

    return classDataCollection
        .where("university", isEqualTo: university)
        .where("week", isEqualTo: week)
        .where("time", isEqualTo: time)
        .snapshots()
      ?? "no result"; 
  }


  Future getUserProfile (String documentId) async {
    DocumentSnapshot docSnapshot =
        await userProfileCollection.document(documentId).get();
    return UserProfile(
      uid: docSnapshot.data["uid"],
      name: docSnapshot.data["name"],
      university: docSnapshot.data["university"],
      department: docSnapshot.data["department"],
    );
  }
}