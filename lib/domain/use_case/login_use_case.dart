import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/request/request.dart';
import 'package:inside_1/domain/repositories/firebase_auth_repository.dart';
import 'package:inside_1/domain/use_case/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInputs, User> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  LoginUseCase(this._firebaseAuthRepository);

  @override
  Future<Either<Failure, User>> execute(LoginUseCaseInputs input) async {
    return await _firebaseAuthRepository
        .login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInputs {
  String email;
  String password;

  LoginUseCaseInputs(this.email, this.password);
}