import 'package:dartz/dartz.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/network/success.dart';
import 'package:inside_1/domain/model/model.dart';

abstract class FirestoreUserRepository {
  Future<Either<Failure,Success>> createUser(UsersInfo usersInfo);
  Future<Either<Failure,Success>> updateUser(UsersInfo usersInfo);
  Future<Either<Failure,Success>> userExist(String uid);
  Stream<UsersInfo> getUserInfo(String uid);
}