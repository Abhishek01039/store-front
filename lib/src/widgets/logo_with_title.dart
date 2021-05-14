import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';

class LogoWithTitle extends StatelessWidget {
  const LogoWithTitle({Key? key, required this.isDrawer}) : super(key: key);

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: isDrawer ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Image.asset(
          'assets/logo/local-energy-logy.png',
          height: 36,
          width: 36,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Local Energy',
          style: TextStyle(
            fontSize: !isDrawer ? 16 : 20,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w300,
            color: Styleguide.colorAccentsOrange_1,
          ),
        ),
      ],
    );
  }
}
