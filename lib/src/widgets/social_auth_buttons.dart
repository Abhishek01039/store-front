import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storefront/src/bloc/login/login_bloc.dart';
import 'package:storefront/src/mobile/screens/store/store_screen.dart';
import 'package:storefront/src/repository/authentication/social/social_provider_factory.dart';
import 'package:storefront/src/web/screens/store/store_screen_web.dart';

import 'package:storefront/src/widgets/snackbar_widget.dart';
import 'package:storefront/src/widgets/social_auth_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({Key? key}) : super(key: key);

  SizedBox _buildSizedBox() {
    return const SizedBox(
      height: 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return BlocConsumer<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state is LoginErrorState) {
              showSnackbar(
                context: context,
                text: state.errorMessage.contains(':')
                    ? (state.errorMessage.split(':')[1]).toString().trim()
                    : state.errorMessage,
              );
            }
            if (state is SocialLoginSuccessState) {
              if (state.email != null) {
                if (kIsWeb) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoreScreenWeb(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoreScreen(),
                    ),
                  );
                }
              }
              showSnackbar(
                context: context,
                text: 'Login successful!',
              );
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialAuthButton(
                  svg: 'assets/icons/facebook.svg',
                  voidCallback: () {
                    context.read<LoginBloc>().add(
                          const SocialLoginEvent(
                            socialService: SocialService.fb,
                          ),
                        );
                  },
                ),
                _buildSizedBox(),
                SocialAuthButton(
                  svg: 'assets/icons/google.svg',
                  voidCallback: () {
                    context.read<LoginBloc>().add(
                          const SocialLoginEvent(
                            socialService: SocialService.google,
                          ),
                        );
                  },
                ),
                _buildSizedBox(),
                SocialAuthButton(
                  svg: 'assets/icons/twitter.svg',
                  voidCallback: () {},
                ),
              ],
            );
          },
        );
      },
    );
  }
}
