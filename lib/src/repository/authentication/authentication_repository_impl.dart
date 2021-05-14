import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storefront/src/utils/message_text.dart';

import 'authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  late FirebaseAuth _firebaseAuth;
  late GoogleSignIn _googleSignIn;

  static final AuthenticationRepositoryImpl _singleton =
      AuthenticationRepositoryImpl._internal();

  factory AuthenticationRepositoryImpl(
      {FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn}) {
    _singleton._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    _singleton._googleSignIn = googleSignIn ?? GoogleSignIn();
    return _singleton;
  }

  AuthenticationRepositoryImpl._internal();

  @override
  Future<UserCredential?> logIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception(Message.noUserFound);
      } else if (e.code == 'wrong-password') {
        throw Exception(Message.wrongPassword);
      } else if (e.code == 'too-many-requests') {
        throw Exception(Message.tryManyAttemps);
      }
    } catch (e) {
      throw Exception(Message.genericErrorMessage);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();

      /// [GoogleSignIn().signOut()] if user login via google
      if ((await _googleSignIn.isSignedIn()) == true) {
        await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }
    } catch (error) {
      throw Exception(Message.genericErrorMessage);
    }
  }

  @override
  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception(Message.weekPassword);
      } else if (e.code == 'email-already-in-use') {
        throw Exception(Message.alreadyExist);
      }
    } catch (e) {
      throw Exception(Message.genericErrorMessage);
    }
  }
}
