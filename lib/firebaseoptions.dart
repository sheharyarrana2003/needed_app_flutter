import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebaseoptions {
  static final workerCollections =
      FirebaseFirestore.instance.collection('Workers');
  static final currentUser = FirebaseAuth.instance.currentUser!;
}
