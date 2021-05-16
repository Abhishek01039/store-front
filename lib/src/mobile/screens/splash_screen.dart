import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:storefront/src/mobile/screens/auth_screen.dart';
import 'package:storefront/src/mobile/screens/store/store_screen.dart';
import 'package:storefront/src/web/screens/auth_screen_web.dart';
import 'package:storefront/src/web/screens/store/store_screen_web.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MySpalsh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () async {
        // await FirebaseAuth.instance.signOut();
        // if user exist then navigates to home screen otherwise auth screen
        FirebaseAuth.instance.currentUser?.email == null
            ? kIsWeb
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AuthScreenWeb(),
                    ),
                  )
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AuthScreen(),
                    ),
                  )
            : kIsWeb
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoreScreenWeb(),
                    ),
                  )
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoreScreen(),
                    ),
                  );
      },
    );

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
