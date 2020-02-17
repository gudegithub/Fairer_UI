import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fairer_ui/models/classData.dart';
import 'package:fairer_ui/models/memo.dart';
import 'package:fairer_ui/models/user.dart';


class DatabaseService {
  
  final String uid;
  DatabaseService({ this.uid,this.university, this.week, this.time, this.classId});

  // ユーザープロフィール取得

  final CollectionReference userProfileCollection = Firestore.instance.collection('userProfile');

  UserProfile _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserProfile(
      uid: uid,
      name: snapshot.data["name"],
      university: snapshot.data["university"],
      department: snapshot.data["department"],
    );
  }

  Future<void> updateUserProfile(String name, String university, String department) async {
    return await userProfileCollection.document(uid).setData({
      'name': name,
      'university' : university,
      'department' : department,
    });
  }

  Stream<UserProfile> get userData  {
    return userProfileCollection.document(uid).snapshots()
      .map(_userDatafromSnapshot);
  }


  // 時間割情報取得

  final String university;
  final int week;
  final int time;

  final CollectionReference classDataCollection = Firestore.instance.collection('classData');

  List<FirebaseClassData> _classDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FirebaseClassData(
        id: doc.documentID,
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
      'university': university,
      'className': className,
      'week': week,
      'time': time,
      'teacherName': teacherName,
      'room': room,
      'classCode': classCode,
    });
  }

  Stream<List<FirebaseClassData>> get getClassData {
    final  classCollection = classDataCollection
      .where("university", isEqualTo: university)
      .where("week", isEqualTo: week)
      .where("time", isEqualTo: time)
      .snapshots()
      .map(_classDataListFromSnapshot);
    
    return classCollection;

  }

  // 検索用のリストを取得



  // Memo機能

  final String classId;

  final CollectionReference memoCollection = Firestore.instance.collection('memo');

  Future<void> createMemo(String title, String content) async {
    return await memoCollection.document().setData({
      'title' : title,
      'content' : content,
      'timestamp': Timestamp.now(),
      'classId' : uid,
    });
  }

  List<Memo> _memoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Memo(
        id: doc.documentID,
        title: doc.data["title"],
        content: doc.data["content"],
        classId: doc.data["classId"]
      );
    }).toList();
  }

  Stream<List<Memo>> get getMemo {
    return memoCollection
      .where("classId", isEqualTo: classId)
      .snapshots()
      .map(_memoListFromSnapshot);
  }
}