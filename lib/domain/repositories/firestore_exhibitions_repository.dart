import 'package:inside_1/domain/model/model.dart';

abstract class FirestoreExhibitionsRepository {
  Stream<List<Exhibition>> getExhibitions();
}