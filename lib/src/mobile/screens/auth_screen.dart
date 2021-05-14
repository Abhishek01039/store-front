import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:storefront/src/mobile/widgets/forms.dart';
import 'package:storefront/src/utils/text_style.dart';
import 'package:storefront/src/widgets/logo.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';
import 'package:storefront/src/widgets/sign_up_with_text.dart';

class AuthScreen extends StatelessWidget {
  SizedBox _buildSizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  Row _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Terms & Conditions',
          style: underlineTextWithHeadline,
        ),
        Text(
          'Privacy Policy',
          style: underlineTextWithHeadline,
        )
      ],
    );
  }

  Container _buildFooter(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildSizedBox(),
          Image.asset(
            'assets/logo/local-energy-logy.png',
            height: 100,
            width: 100,
          ),
          _buildSizedBox(),
          _footer(),
          _buildSizedBox(),
          Text(
            '© 2021, Local Energy',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  wordSpacing: 2.0,
                ),
          ),
          _buildSizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      backgroundColor: Styleguide.pageColor,
      child: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Logo(),
              _buildSizedBox(),
              const Text(
                'Get Started Free!',
                style: TextStyle(
                  letterSpacing: 1.7,
                  fontSize: 30,
                ),
              ),
              _buildSizedBox(),
              // signup divider
              const SignUpWithText(),
              _buildSizedBox(),
              // Login/signup forms and social auth buttons
              Forms(),
              _buildSizedBox(),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }
}
