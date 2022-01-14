// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;
  Future<UserCredential> signup(String email, String password) async {
    final authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<UserCredential> signin(String email, String password) async {
    final authResult = await auth.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password.trim().toLowerCase());
    return authResult;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
