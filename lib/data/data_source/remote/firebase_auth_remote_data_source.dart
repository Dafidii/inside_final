import 'package:firebase_auth/firebase_auth.dart';
import 'package:inside_1/data/network/app_api/firebase_auth_service.dart';
import 'package:inside_1/data/request/request.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserCredential> register(RegisterRequest registerRequest);
  Future<UserCredential> login(LoginRequest loginRequest);
  Future<bool> checkIfEmailAlreadyInUse(String email);
  Future sendPasswordResetEmail(String email);
  Future signOut();
}

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource{
  final FirebaseAuthServiceClient _firebaseAuthServiceClient;

  FirebaseAuthRemoteDataSourceImpl(this._firebaseAuthServiceClient);

  @override
  Future<UserCredential> register(RegisterRequest registerRequest) async {
    return await _firebaseAuthServiceClient.register(registerRequest.email , registerRequest.password);
  }

  @override
  Future<UserCredential> login(LoginRequest loginRequest) async {
    return await _firebaseAuthServiceClient.login(loginRequest.email , loginRequest.password);
  }

  @override
  Future sendPasswordResetEmail(String email) async {
    return await _firebaseAuthServiceClient.sendPasswordResetEmail(email);
  }

  @override
  Future<bool> checkIfEmailAlreadyInUse(String email) async {
    return await _firebaseAuthServiceClient.checkIfEmailAlreadyInUse(email);
  }

  @override
  Future signOut() async {
    return await _firebaseAuthServiceClient.signOut();
  }

}