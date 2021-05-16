import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storefront/src/bloc/login/login_bloc.dart';
import 'package:storefront/src/mobile/screens/store/store_screen.dart';
import 'package:storefront/src/utils/validators/email_validator.dart';
import 'package:storefront/src/web/screens/store/store_screen_web.dart';
import 'package:storefront/src/widgets/form/custom_auth_text_form_field.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../button.dart';
import '../circular_indicator.dart';
import '../snackbar_widget.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isRememberMe = false;
  bool isAutovalidate = false;

  /// clear all [TextFormField]
  void _disposeController() {
    password.clear();
    email.clear();
  }

  /// reset the state of [LoginForm]
  void _resetState() {
    _disposeController();
    isAutovalidate = false;
    isRememberMe = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (LoginState prev, LoginState curr) => prev != curr,
        listener: (context, state) {
          if (state is LoginErrorState) {
            showSnackbar(
              context: context,
              text: state.errorMessage.contains(':')
                  ? (state.errorMessage.split(':')[1]).toString().trim()
                  : state.errorMessage,
            );
          }
          if (state is LoginSuccessState) {
            if (state.email != null) {
              _resetState();
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
              showSnackbar(
                context: context,
                text: 'Login successful!',
              );
            }
          }
        },
        buildWhen: (LoginState prev, LoginState curr) => prev != curr,
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: isAutovalidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomAuthTextFormField(
                    key: const Key('email_input'),
                    textEditingController: email,
                    textInputType: TextInputType.emailAddress,
                    labelText: 'Email',
                    validate: emailValidator,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (state is LoginPassShowState)
                    CustomAuthTextFormField(
                      key: const Key('password_input'),
                      textEditingController: password,
                      labelText: 'Password',
                      suffixIcon: const Icon(Icons.visibility_off),
                      suffixIconPressed: () {
                        context.read<LoginBloc>().add(LoginPassHideRequested());
                      },
                      validate: (String? val) {
                        if (val!.isEmpty) {
                          return 'Please enter password';
                        } else if (val.length < 6) {
                          return 'Password must be 6 character';
                        }
                      },
                    )
                  else
                    CustomAuthTextFormField(
                      key: const Key('password_input'),
                      textEditingController: password,
                      labelText: 'Password',
                      isObsecure: true,
                      suffixIcon: const Icon(Icons.visibility),
                      suffixIconPressed: () {
                        context.read<LoginBloc>().add(LoginPassShowRequested());
                      },
                      validate: (String? val) {
                        if (val!.isEmpty) {
                          return 'Please enter password';
                        } else if (val.length < 6) {
                          return 'Password must be 6 character';
                        }
                      },
                    ),
                  Stack(
                    children: [
                      Button(
                        elevatedButtonKey: const Key('sign_in'),
                        child: 'SIGN IN',
                        function: (state is LoginLoadingState)
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ==
                                    false) {
                                  setState(() {
                                    isAutovalidate = true;
                                  });
                                } else {
                                  context.read<LoginBloc>().add(
                                        LoginRequest(
                                          email: email.text,
                                          password: password.text,
                                        ),
                                      );
                                }
                              },
                      ),
                      if (state is LoginLoadingState) customCircularIndicator(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
