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
    final Timestamp timeStamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderID: currentUserId,
      senderEmail: currentUserEmail,
      recieverID: recieverId,
      message: message,
      timeStamp: timeStamp,
    );

    //constrcut chatroom id for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); // sort the IDs (ensure the chatroom ID is the same for any 2 people)

    String chatRoomID = ids.join('_');

    // add new message to databse
    await _firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    //construct a chatroom id for 2 users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }
}
