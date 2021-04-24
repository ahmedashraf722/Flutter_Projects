import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential authS = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = authS.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    UserCredential authS = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = authS.user;
    return user.uid;
  }

  Future<User> getUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User user = _firebaseAuth.currentUser;

    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = _firebaseAuth.currentUser;
    return user.emailVerified;
  }
}
