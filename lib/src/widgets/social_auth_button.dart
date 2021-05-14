import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialAuthButton extends StatelessWidget {
  final String svg;
  final Function() voidCallback;

  const SocialAuthButton({
    Key? key,
    required this.svg,
    required this.voidCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => voidCallback(),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svg,
              height: 30,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
