import 'package:flutter/material.dart';

class SignUpWithText extends StatelessWidget {
  const SignUpWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              thickness: 2.0,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'SIGN UP WITH',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              thickness: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}
