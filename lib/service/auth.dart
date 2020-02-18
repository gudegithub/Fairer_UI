import 'dart:async';
import 'package:fairer_ui/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
	Future<String> signIn(String email, String password);

	Future<String> signUp(String email, String password);

	Future<User> currentUser();

	Future<void> emailVerification();

	Future<void> signOut();

	Future<bool> isEmailVerified();
  
  Future<String> signInWithGoogle();

  Future<void> signOutGoogle();
}

class Auth implements BaseAuth {

	final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

	Future<String> signIn(String email, String password) async {
		AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
				email: email, password: password);
		FirebaseUser user = result.user;
		return user.uid;
	}

	Future<String> signUp(String email, String password) async {
		AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
				email: email, password: password);
		FirebaseUser user = result.user;
		return user.uid;
	}

	Future<User> currentUser() async {
		FirebaseUser user = await _firebaseAuth.currentUser();
		return user != null ? User(uid: user.uid) : null;
	}

	Future<void> signOut() async {
    try {
      return _firebaseAuth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
		
	}

	Future<void> emailVerification() async {
		FirebaseUser user = await _firebaseAuth.currentUser();
		user.sendEmailVerification();
	}

	Future<bool> isEmailVerified() async {
		FirebaseUser user = await _firebaseAuth.currentUser();
		return user.isEmailVerified;
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    return user.uid;
  }

  Future<void> signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

}

