import 'package:dartz/dartz.dart';
import 'package:inside_1/data/network/failure.dart';
import 'package:inside_1/data/network/success.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/repositories/firestore_user_repository.dart';
import 'package:inside_1/domain/use_case/base_use_case.dart';

class CreateUserUseCase
    implements BaseUseCase<CreateUserUseCaseInputs, Success> {
  final FirestoreUserRepository _firestoreUserRepository;

  CreateUserUseCase(this._firestoreUserRepository);

  @override
  Future<Either<Failure, Success>> execute(
      CreateUserUseCaseInputs input) async {
    return await _firestoreUserRepository.createUser(UsersInfo(
      uid: input.uid,
      username: input.username,
      email: input.email,
    ));
  }
}

class CreateUserUseCaseInputs {
  String uid;
  String username;
  String email;

  CreateUserUseCaseInputs(
      {required this.uid, required this.username, required this.email});
}
