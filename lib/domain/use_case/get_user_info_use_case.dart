import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/repositories/firestore_user_repository.dart';

class GetUserInfoUseCase{
  final FirestoreUserRepository _firestoreUserRepository;

  GetUserInfoUseCase(this._firestoreUserRepository);

  Stream<UsersInfo> execute(GetUserInfoUseCaseInputs input) {
    return _firestoreUserRepository.getUserInfo(input.uid);
  }

}

class GetUserInfoUseCaseInputs{
  String uid;

  GetUserInfoUseCaseInputs(this.uid);
}