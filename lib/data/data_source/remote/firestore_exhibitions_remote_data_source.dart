import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inside_1/data/network/app_api/firestore_exhibitions_service.dart';

abstract class FirestoreExhibitionsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getExhibitions();
}

class FirestoreExhibitionsRemoteDataSourceImpl
    implements FirestoreExhibitionsRemoteDataSource {
  final FirestoreExhibitionsServiceClient _firestoreExhibitionsServiceClient;

  FirestoreExhibitionsRemoteDataSourceImpl(
      this._firestoreExhibitionsServiceClient);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getExhibitions() =>
      _firestoreExhibitionsServiceClient.getExhibitions();
}
