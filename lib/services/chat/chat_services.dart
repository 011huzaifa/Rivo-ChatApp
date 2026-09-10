import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  //instance of firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //user streams
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firebaseFirestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go thtough each user
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send messages

  //get messages
}
