import 'package:flutter/material.dart';
import 'package:storefront/src/utils/text_style.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Footer extends StatelessWidget {
  const Footer({Key? key, this.color = Colors.white}) : super(key: key);
  final Color color;

  SizedBox _buildSizeBox() {
    return const SizedBox(
      height: 10,
    );
  }

  SizedBox _buildWidthBox() {
    return const SizedBox(
      width: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  'Terms & Conditions',
                  style: underlineTextWithHeadline.copyWith(
                    color: color,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 70,
                ),
                Text(
                  'Privacy Policy',
                  style: underlineTextWithHeadline.copyWith(
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            _buildSizeBox(),
            Text(
              '© 2021, Local Energy',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    wordSpacing: 2.0,
                    color: color,
                  ),
            ),
          ],
        ),
        if (kIsWeb) _buildWidthBox(),
        Image.asset(
          'assets/logo/local-energy-logy.png',
          height: 36,
          width: 36,
        ),
      ],
    );
  }
}
