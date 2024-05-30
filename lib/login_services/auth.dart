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
      throw e.message ?? 'Login Failed';
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
