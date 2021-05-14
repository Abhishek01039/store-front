import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:storefront/src/config/screen_size.dart';
import 'package:storefront/src/mobile/screens/auth_screen.dart';
import 'package:storefront/src/mobile/widgets/forms.dart';
import 'package:storefront/src/widgets/footer.dart';
import 'package:storefront/src/widgets/logo.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';
import 'package:storefront/src/widgets/sign_up_with_text.dart';

import '../../config/color_config.dart';

class AuthScreenWeb extends StatelessWidget {
  SizedBox _buildSizedBox({double height = 20}) {
    return SizedBox(
      height: height,
    );
  }

  RichText _signUpRichText(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        text: 'Learn more ',
        style: theme.headline5,
        children: [
          TextSpan(
            text: 'here.',
            style: theme.headline5?.copyWith(
              decoration: TextDecoration.underline,
              color: Styleguide.colorAccentsOrange_1,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildColumn(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Logo(),
        _buildSizedBox(height: height / 30),
        Text(
          'The Local Energy platform enables',
          style: _textTheme.headline5,
        ),
        _buildSizedBox(height: height / 60),
        Text(
          'food artisans to build a successful',
          style: _textTheme.headline5,
        ),
        _buildSizedBox(height: height / 60),
        Text(
          'online food business, while providing',
          style: _textTheme.headline5,
        ),
        _buildSizedBox(height: height / 60),
        Text(
          'consumers with healthy, local food.',
          style: _textTheme.headline5,
        ),
        _buildSizedBox(height: height / 30),
        _signUpRichText(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // if screen's size is less than 600 then it's shows mobile view
    return isWebsite(context)
        ? AuthScreen()
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: BasicScaffold(
              backgroundColor: Styleguide.pageColor,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: _buildColumn(context),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 500,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSizedBox(height: 100),
                                  const Text(
                                    'Get Started Free!',
                                    style: TextStyle(
                                      letterSpacing: 1.7,
                                      fontSize: 30,
                                      color: Styleguide.colorAccentsOrange_1,
                                    ),
                                  ),
                                  _buildSizedBox(),
                                  // signup divider
                                  const SignUpWithText(),
                                  _buildSizedBox(),
                                  // Login/signup forms and social auth buttons
                                  Forms(),
                                  _buildSizedBox(height: 100),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Footer(
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
