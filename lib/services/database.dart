import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference firestoreUserCollection =
      firestore.collection("Users");
}
