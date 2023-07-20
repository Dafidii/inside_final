import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/repositories/firestore_exhibitions_repository.dart';

class GetExhibitionsUseCase{
  final FirestoreExhibitionsRepository _firestoreExhibitionsRepository;

  GetExhibitionsUseCase(this._firestoreExhibitionsRepository);

  Stream<List<Exhibition>> execute() {
    return _firestoreExhibitionsRepository.getExhibitions();
  }
}