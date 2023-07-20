import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:inside_1/data/data_source/remote/firebase_auth_remote_data_source.dart';
import 'package:inside_1/data/mapper/mapper.dart';
import 'package:inside_1/data/network/error_handlers/firebase_auth_error_handler.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/network/network_info.dart';
import 'package:inside_1/data/network/success.dart';
import 'package:inside_1/data/request/request.dart';
import 'package:inside_1/domain/repositories/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {
  final FirebaseAuthRemoteDataSource _firebaseAuthRemoteDataSource;
  final NetworkInfo _networkInfo;

  FirebaseAuthRepositoryImpl(
      this._firebaseAuthRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, User>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _firebaseAuthRemoteDataSource.register(registerRequest);

        return Right(response.toDomain());
      } on FirebaseAuthException catch (error) {
        return (left(FirebaseAuthErrorHandler.handle(error).failure));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }

  @override
  Future<Either<Failure, User>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
        await _firebaseAuthRemoteDataSource.login(loginRequest);

        return Right(response.toDomain());
      } on FirebaseAuthException catch (error) {
        debugPrint(error.message);
        debugPrint(error.code);
        return (left(FirebaseAuthErrorHandler.handle(error).failure));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }

  @override
  Future<Either<Failure, Success>> sendPasswordResetEmail(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        await _firebaseAuthRemoteDataSource.sendPasswordResetEmail(email);
        return Right(Success(FirebaseAuthResponseCode.successful,
            FirebaseAuthResponseMessage.successful));
      } on FirebaseAuthException catch (error) {
        return (Left(FirebaseAuthErrorHandler.handle(error).failure));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }

  @override
  Future<Either<Failure, Success>> checkIfEmailAlreadyInUse(String email) async {
    if (await _networkInfo.isConnected) {

      try {
        final bool response = await _firebaseAuthRemoteDataSource.checkIfEmailAlreadyInUse(email);
        return (response.toDomain());
      } on FirebaseAuthException catch (error) {
        debugPrint(error.message);
        debugPrint(error.code);
        return (left(FirebaseAuthErrorHandler.handle(error).failure));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    if(await _networkInfo.isConnected){
      try{
        await _firebaseAuthRemoteDataSource.signOut();
        return Right(Success(FirebaseAuthResponseCode.successful, FirebaseAuthResponseMessage.successful));
      } on FirebaseAuthException catch(error){
        return (Left(FirebaseAuthErrorHandler.handle(error).failure));
      }
    } else {
      return (Left(FirebaseAuthStatus.noInternetConnection.getFailure()));
    }
  }
}
