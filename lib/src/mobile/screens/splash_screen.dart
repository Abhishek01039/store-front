import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:storefront/src/mobile/router/auto_router.gr.dart'
    hide MySplashRoute;
import 'package:storefront/src/web/router/web_router.gr.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:auto_route/auto_route.dart';

class MySpalsh extends StatefulWidget {
  @override
  _MySpalshState createState() => _MySpalshState();
}

class _MySpalshState extends State<MySpalsh> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        // await FirebaseAuth.instance.signOut();
        // if user exist then navigates to home screen otherwise auth screen
        FirebaseAuth.instance.currentUser?.email == null
            ? kIsWeb
                ? context.router.replace(const AuthRouteWeb())
                : context.router.replace(const AuthRoute())
            : kIsWeb
                ? context.router.replace(const StoreRouteWeb())
                : context.router.replace(const StoreRoute());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      backgroundColor: Styleguide.colorAccentsOrange_1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/local-energy-logy.png',
              height: 200,
              width: 200,
              color: Colors.white70,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Local Energy',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
