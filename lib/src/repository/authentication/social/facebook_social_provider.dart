import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:storefront/src/utils/message_text.dart';

import 'i_social_provider.dart';

class FacebookSocialProvider extends SocialProvider {
  late String _email;

  @override
  Future<UserCredential?> login() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else if (result.status == LoginStatus.failed) {
      throw Exception(Message.loginFailed);
    } else if (result.status == LoginStatus.cancelled) {
      throw Exception(Message.loginCancel);
    } else if (result.status == LoginStatus.operationInProgress) {
      throw Exception(Message.previousLoginOperation);
    }
    throw Exception(Message.genericLoginErrorMessage);
  }

  @override
  String get email => _email;

  @override
  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }
}
