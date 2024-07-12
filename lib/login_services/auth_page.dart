import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<void> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No user found for that email.';
        case 'wrong-password':
          throw 'Wrong password provided.';
        default:
          throw 'Login failed. Please try again.';
      }
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
