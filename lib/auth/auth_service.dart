import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in

  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredentials;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up

  //sign out
}
