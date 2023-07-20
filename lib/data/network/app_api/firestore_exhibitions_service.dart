import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExhibitionsServiceClient {
  static final _firestoreExhibitionsCollection =
  FirebaseFirestore.instance.collection('exhibitions');

  Stream<QuerySnapshot<Map<String, dynamic>>> getExhibitions() =>
      _firestoreExhibitionsCollection.snapshots();
}