import 'package:chatapp/models/message.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  //instance of firestore and auth
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

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
  Future<void> sendMessage(String recieverId, message) async {
    //get current user info
    final String currentUserId = _auth.currentUser()!.uid;
    final String currentUserEmail = _auth.currentUser()!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderID: currentUserId,
      senderEmail: currentUserEmail,
      recieverID: recieverId,
      message: message,
      timeStamp: timestamp,
    );

    //constrcut chatroom id for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
  }

  //get messages
}
