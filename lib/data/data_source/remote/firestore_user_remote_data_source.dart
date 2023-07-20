import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inside_1/data/network/app_api/firestore_user_service.dart';
import 'package:inside_1/domain/model/model.dart';

abstract class FirestoreUserRemoteDataSource {
  Future createUser(UsersInfo usersInfo);
  Future updateUser(UsersInfo usersInfo);
  Future<bool> userExist(String uid);
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(String uid);
}

class FirestoreUserRemoteDataSourceImpl implements FirestoreUserRemoteDataSource{
  final FirestoreUserServiceClient _firestoreUserServiceClient;

  FirestoreUserRemoteDataSourceImpl(this._firestoreUserServiceClient);

  @override
  Future createUser(UsersInfo usersInfo) async {
    return await _firestoreUserServiceClient.createUser(usersInfo.uid, usersInfo.toJson());
  }

  @override
  Future updateUser(UsersInfo usersInfo) async {
    return await _firestoreUserServiceClient.updateUser(usersInfo.uid, usersInfo.toJson());
  }

  @override
  Future<bool> userExist(String uid) async {
    return await _firestoreUserServiceClient.userExist(uid);
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(String uid) => _firestoreUserServiceClient.getUserInfo(uid);

}