import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fairer_ui/models/user.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userProfile = Firestore.instance.collection('userProfile');

  UserProfile _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserProfile(
      uid: uid,
      name: snapshot.data["name"],
      university: snapshot.data["university"],
      department: snapshot.data["department"],
      graduationYear: snapshot.data["guraduationYear"]
    );
  }

}