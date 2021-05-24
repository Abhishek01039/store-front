import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:storefront/app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  // initialiaze the facebook javascript SDK
  FacebookAuth.instance.webInitialize(
    appId: '206682137884266',
    cookie: true,
    xfbml: true,
    version: 'v9.0',
  );

  runApp(MyApp());
}
