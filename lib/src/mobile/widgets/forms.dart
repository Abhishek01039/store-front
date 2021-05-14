import 'package:flutter/material.dart';
import 'package:storefront/src/widgets/form/login_form.dart';
import 'package:storefront/src/widgets/form/signup_form.dart';
import 'package:storefront/src/widgets/or_divider.dart';
import 'package:storefront/src/widgets/social_auth_buttons.dart';
import 'package:storefront/src/widgets/table_header_opacity.dart';

class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  bool _isSignup = false;
  SizedBox _buildSizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  TableHeaderOpacity _agreeTermsLink() {
    return TableHeaderOpacity(
      child: RichText(
        key: const Key('rich_text'),
        maxLines: 2,
        text: TextSpan(
          text: 'By signing up, you agree to our ',
          style: Theme.of(context).textTheme.subtitle2,
          children: <InlineSpan>[
            TextSpan(
              text: 'Terms of Service',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
            )
          ],
        ),
      ),
    );
  }

  Row _toogleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            _isSignup ? 'Need an account? ' : 'Already an account? ',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isSignup = !_isSignup;
            });
          },
          child: Text(
            _isSignup ? 'Sign Up' : 'Sign In',
            style: const TextStyle(
              color: Colors.orange,
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // social credential buttons
        const Center(
          child: SocialAuthButtons(
            key: Key('social_auth_button'),
          ),
        ),
        _buildSizedBox(),
        const OrDivider(),
        _buildSizedBox(),
        if (_isSignup) LoginForm() else SignupForm(),
        _buildSizedBox(),
        _agreeTermsLink(),
        _buildSizedBox(),
        // signup/signin toggle button
        _toogleButton(),
      ],
    );
  }
}
