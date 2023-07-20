import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/request/request.dart';
import 'package:inside_1/domain/repositories/firebase_auth_repository.dart';
import 'package:inside_1/domain/use_case/base_use_case.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInputs, User>{
  final FirebaseAuthRepository _firebaseAuthRepository;

  RegisterUseCase(this._firebaseAuthRepository);

  @override
  Future<Either<Failure, User>> execute(RegisterUseCaseInputs input) async {
    return await _firebaseAuthRepository.register(RegisterRequest(input.email, input.password));
  }

}


class RegisterUseCaseInputs {
  String email;
  String password;

  RegisterUseCaseInputs(this.email, this.password);
}