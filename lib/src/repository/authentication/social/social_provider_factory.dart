import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'facebook_social_provider.dart';
import 'google_social_provider.dart';
import 'i_social_provider.dart';
import 'i_social_provider_factory.dart';

enum SocialService { google, fb }

class SocialProviderFactoryImpl extends SocialProviderFactory {
  late GoogleSignIn _googleSignIn;
  late FirebaseAuth _firebaseAuth;

  static final SocialProviderFactoryImpl _singleton =
      SocialProviderFactoryImpl._internal();

  factory SocialProviderFactoryImpl(
      {FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn}) {
    _singleton._googleSignIn = googleSignIn ?? GoogleSignIn();
    _singleton._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    return _singleton;
  }

  SocialProviderFactoryImpl._internal();

  @override
  SocialProvider createInstance(SocialService socialService) {
    late SocialProvider provider;

    switch (socialService) {
      case SocialService.fb:
        provider = FacebookSocialProvider();
        break;
      case SocialService.google:
        provider = GoogleSocialProvider(
          googleSignIn: _googleSignIn,
          firebaseAuth: _firebaseAuth,
        );
        break;
    }

    return provider;
  }
}
