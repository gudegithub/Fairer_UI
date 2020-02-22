class User {

  final String uid;


  User({this.uid});

}

class UserProfile {

  final String uid;
  final String name;
  final String university;
  final String department;
  final int graduationYear;

  UserProfile({this.uid,this.name, this.university, this.department, this.graduationYear});

}