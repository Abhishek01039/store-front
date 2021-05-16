import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:storefront/app.dart';

void main() {
  // initialiaze the facebook javascript SDK
  FacebookAuth.instance.webInitialize(
    appId: '206682137884266',
    cookie: true,
    xfbml: true,
    version: 'v9.0',
  );

  runApp(MyApp());
}
