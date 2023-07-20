import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:inside_1/data/data_source/remote/firestore_user_remote_data_source.dart';
import 'package:inside_1/data/mapper/mapper.dart';
import 'package:inside_1/data/network/error_handlers/firebase_auth_error_handler.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/network/network_info.dart';
import 'package:inside_1/data/network/success.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/repositories/firestore_user_repository.dart';

class FirestoreUserRepositoryImpl extends FirestoreUserRepository {
  final FirestoreUserRemoteDataSource _firestoreUserRemoteDataSource;
  final NetworkInfo _networkInfo;

  FirestoreUserRepositoryImpl(
      this._firestoreUserRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Success>> createUser(UsersInfo usersInfo) async {
    if (await _networkInfo.isConnected) {
      try {
        await _firestoreUserRemoteDataSource.createUser(usersInfo);

        return (Right(Success(FirebaseAuthResponseCode.successful,
            FirebaseAuthResponseMessage.successful)));
      } on FirebaseException catch (error) {
        return (Left(Failure(error.code, error.message.toString())));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }

  @override
  Future<Either<Failure, Success>> updateUser(UsersInfo usersInfo) async {
    if (await _networkInfo.isConnected) {
      try {
        await _firestoreUserRemoteDataSource.updateUser(usersInfo);

        return (Right(Success(FirebaseAuthResponseCode.successful,
            FirebaseAuthResponseMessage.successful)));
      } on FirebaseException catch (error) {
        return (Left(Failure(error.code, error.message.toString())));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }

  @override
  Future<Either<Failure, Success>> userExist(String uid) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _firestoreUserRemoteDataSource.userExist(uid);

        return (response.toDomainUserExist());
      } on FirebaseException catch (error) {
        return (Left(Failure(error.code, error.message.toString())));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }

  @override
  Stream<UsersInfo> getUserInfo(String uid) {
    final response = _firestoreUserRemoteDataSource.getUserInfo(uid);
    return(response.userInfoToDomain());
  }
}
