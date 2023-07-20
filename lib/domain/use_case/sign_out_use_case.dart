import 'package:dartz/dartz.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/network/success.dart';
import 'package:inside_1/domain/repositories/firebase_auth_repository.dart';
import 'package:inside_1/domain/use_case/base_use_case.dart';

class SignOutUseCase implements BaseUseCase {
  final FirebaseAuthRepository _firebaseAuthRepository;

  SignOutUseCase(this._firebaseAuthRepository);

  @override
  Future<Either<Failure, Success>> execute(_) async {
    return await _firebaseAuthRepository.signOut();
  }
}