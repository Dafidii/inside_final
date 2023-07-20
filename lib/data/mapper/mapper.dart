import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inside_1/app/constants.dart';
import 'package:inside_1/data/network/error_handlers/firebase_auth_error_handler.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/network/success.dart';
import 'package:inside_1/domain/model/model.dart';

extension UserCredentialMapper on UserCredential {
  User toDomain() {
    return user!;
  }

  UsersInfo toDomainUserInfo() {
    return UsersInfo(
      uid: user?.uid ?? kEmpty,
      username: user?.displayName?.split(' ').first ?? kEmpty,
      email: user?.displayName ?? kEmpty,
    );
  }
}

extension UserExistMapper on bool {
  Either<Failure, Success> toDomainUserExist() {
    if (this) {
      return (Right(Success(FirebaseAuthResponseCode.successful,
          FirebaseAuthResponseMessage.successful)));
    } else {
      return (Left(FirebaseAuthStatus.userAlreadyExist.getFailure()));
    }
  }
}

extension CheckIfEmailAlreadyInUseMapper on bool {
  Either<Failure, Success> toDomain() {
    if (this) {
      return (Left(FirebaseAuthStatus.emailAlreadyInUse.getFailure()));
    } else {
      return (Right(Success(FirebaseAuthResponseCode.successful,
          FirebaseAuthResponseMessage.successful)));
    }
  }
}

extension StreamDocumentSnapshot
on Stream<DocumentSnapshot<Map<String, dynamic>>> {
  Stream<UsersInfo> userInfoToDomain() async* {
    yield* map((doc) => UsersInfo.fromJson(doc.data()!));
  }
}

extension StreamQuerySnapshotMapper
on Stream<QuerySnapshot<Map<String, dynamic>>> {
  Stream<List<Exhibition>> exhibitionsToDomain() async* {
    yield* map((snapshot) =>
        snapshot.docs.map((doc) => Exhibition.fromJson(doc.data())).toList());
  }
}

