import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class GlobalService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.fromApp(FirebaseApp.instance);
  Firestore _firestore = Firestore(app: FirebaseApp.instance);

  Future<FirebaseUser> signup(
      String email, String password, String name) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());

    return user;
  }

  Future<FirebaseUser> login(String email, String passord) async {
    var fireBaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: passord.trim());
    return fireBaseUser;
  }
  
  Future<FirebaseUser> signedInUser() async {
    return _firebaseAuth.currentUser();
  }

  Future resetPassword({String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  
  Future logOut() async {
    await _firebaseAuth.signOut();
  }

}
