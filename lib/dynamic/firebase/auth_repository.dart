import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/dynamic/models/user.dart';

class AuthRepositry {
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Future signInWithEmailPass(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User user = userCredential.user;
      userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailPass(String email, String pass) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      User user = userCredential.user;
      userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

// STATE MANAGEMENT THROUGH STREAM-PROVIDER\
  Stream<UserModel> get getUserForState {
    return _auth.authStateChanges().map(userFromFirebaseUser);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
