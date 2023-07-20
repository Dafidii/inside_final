import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserServiceClient {
  static final _firestoreUserCollection =
      FirebaseFirestore.instance.collection('users');

  Future<bool> userExist(String uid) =>
      _firestoreUserCollection.doc(uid).get().then(
        (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            return true;
          } else {
            return false;
          }
        },
      );

  Future createUser(String uid, Map<String, dynamic> data) {
    return _firestoreUserCollection.doc(uid).set(data, SetOptions(merge: true));
  }

  Future updateUser(String uid, Map<String, dynamic> data) {
    return _firestoreUserCollection.doc(uid).set(data, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(String uid) =>
      _firestoreUserCollection.doc(uid).snapshots();
}
