import 'package:firebase_auth/firebase_auth.dart';

abstract class SocialProvider {
  String get email;

  // social signin
  Future<UserCredential?> login();

  // social signout
  Future<void> signOut();
}
