import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServiceClient {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  get user => _firebaseAuth.currentUser;

  Future<bool> checkIfEmailAlreadyInUse(String email) => _firebaseAuth
      .fetchSignInMethodsForEmail(email)
      .then((list) => list.isNotEmpty ? true : false);

  Future<UserCredential> register(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> login(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future sendPasswordResetEmail(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

}
