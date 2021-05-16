import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storefront/src/widgets/tralling_icon.dart';

class TrallingIconWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? '',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? '',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        const TrallingIcon(
          width: 60,
        ),
      ],
    );
  }
}
