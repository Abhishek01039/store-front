import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storefront/src/utils/message_text.dart';

import 'i_social_provider.dart';

class GoogleSocialProvider extends SocialProvider {
  late String _email;
  late GoogleSignIn _googleSignIn;
  late FirebaseAuth _firebaseAuth;

  static final GoogleSocialProvider _singleton =
      GoogleSocialProvider._internal();

  factory GoogleSocialProvider(
      {FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn}) {
    _singleton._googleSignIn = googleSignIn ?? GoogleSignIn();
    _singleton._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    return _singleton;
  }

  GoogleSocialProvider._internal();

  @override
  Future<UserCredential?> login() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(Message.genericLoginErrorMessage);
    }
  }

  @override
  String get email => _email;

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
