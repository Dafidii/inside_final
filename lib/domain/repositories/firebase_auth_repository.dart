import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/network/success.dart';
import 'package:inside_1/data/request/request.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, User>> register(RegisterRequest registerRequest);
  Future<Either<Failure, User>> login(LoginRequest loginRequest);
  Future<Either<Failure, Success>> checkIfEmailAlreadyInUse(String email);
  Future <Either<Failure, Success>> sendPasswordResetEmail(String email);
  Future<Either<Failure, Success>> signOut();
}