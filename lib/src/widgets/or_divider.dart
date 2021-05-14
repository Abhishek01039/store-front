import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 2,
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
              'OR',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        const Expanded(
          flex: 2,
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
