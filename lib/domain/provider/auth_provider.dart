import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier{
  bool _isLoggedIn = false;
  String _userUid = "";

  bool get isLoggedIn => _isLoggedIn;
  String get userUid => _userUid;

  AuthState(){
    FirebaseAuth.instance.authStateChanges().listen(onAuthStateChanged);
  }

  Future<void> onAuthStateChanged(User? user) async {
    if(user == null){
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
      _userUid = user.uid;
    }
    notifyListeners();
  }
}