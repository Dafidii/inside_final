import 'package:inside_1/data/data_source/remote/firestore_exhibitions_remote_data_source.dart';
import 'package:inside_1/data/mapper/mapper.dart';
import 'package:inside_1/data/network/network_info.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/repositories/firestore_exhibitions_repository.dart';

class FirestoreExhibitionsRepositoryImpl extends FirestoreExhibitionsRepository {


  final FirestoreExhibitionsRemoteDataSource _firestoreExhibitionsRemoteDataSource;
  final NetworkInfo _networkInfo;

  FirestoreExhibitionsRepositoryImpl(
      this._firestoreExhibitionsRemoteDataSource, this._networkInfo);


  @override
  Stream<List<Exhibition>> getExhibitions() {
    final response = _firestoreExhibitionsRemoteDataSource.getExhibitions();
    return (response.exhibitionsToDomain());
  }

}