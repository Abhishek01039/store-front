import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storefront/src/bloc/signup/signup_bloc.dart';
import 'package:storefront/src/mobile/screens/store/store_creation_screen.dart';
import 'package:storefront/src/repository/authentication/authentication_repository_impl.dart';
import 'package:storefront/src/utils/validators/email_validator.dart';
import 'package:storefront/src/web/screens/store/store_screen_web.dart';
import 'package:storefront/src/widgets/form/custom_auth_text_form_field.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../button.dart';
import '../circular_indicator.dart';
import '../snackbar_widget.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController reEnterPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isAutovalidate = false;

  SizedBox _buildSizedBox() {
    return const SizedBox(
      height: 8,
    );
  }

  /// clear all [TextFormField]
  void _disposeController() {
    firstName.clear();
    lastName.clear();
    email.clear();
    password.clear();
    reEnterPassword.clear();
  }

  /// reset the state of [SignupForm]
  void _resetState() {
    _disposeController();
    isAutovalidate = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignupBloc(authenticationRepository: AuthenticationRepositoryImpl()),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupErrorState) {
            showSnackbar(
              context: context,
              text: state.errorMessage.contains(':')
                  ? (state.errorMessage.split(':')[1]).toString().trim()
                  : state.errorMessage,
            );
          }
          if (state is SignupSuccessState) {
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
                text: 'Sign up successful!',
              );
            }
          }
        },
        builder: (BuildContext context, SignupState state) {
          return Form(
            key: _formKey,
            autovalidateMode: isAutovalidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CustomAuthTextFormField(
                          key: const Key('first_name'),
                          textEditingController: firstName,
                          textCapitalization: TextCapitalization.words,
                          labelText: 'First Name',
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please enter first name';
                            }
                          },
                        ),
                      ),
                      Flexible(
                        child: CustomAuthTextFormField(
                          key: const Key('last_name'),
                          textEditingController: lastName,
                          textCapitalization: TextCapitalization.words,
                          labelText: 'Last Name',
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please enter last name';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildSizedBox(),
                  CustomAuthTextFormField(
                    key: const Key('email'),
                    textEditingController: email,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validate: emailValidator,
                  ),
                  _buildSizedBox(),
                  if (state is SignupPassShowState)
                    CustomAuthTextFormField(
                      key: const Key('password'),
                      textEditingController: password,
                      labelText: 'Password',
                      suffixIcon: const Icon(Icons.visibility_off),
                      suffixIconPressed: () {
                        context
                            .read<SignupBloc>()
                            .add(SignupPassHideRequested());
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
                      key: const Key('password'),
                      textEditingController: password,
                      labelText: 'Password',
                      suffixIcon: const Icon(Icons.visibility),
                      suffixIconPressed: () {
                        context
                            .read<SignupBloc>()
                            .add(SignupPassShowRequested());
                      },
                      isObsecure: true,
                      validate: (String? val) {
                        if (val!.isEmpty) {
                          return 'Please enter password';
                        } else if (val.length < 6) {
                          return 'Password must be 6 character';
                        }
                      },
                    ),
                  _buildSizedBox(),
                  if (state is SignupRePassShowState)
                    CustomAuthTextFormField(
                      key: const Key('re_enter_password'),
                      textEditingController: reEnterPassword,
                      labelText: 'Re-enter password',
                      suffixIcon: const Icon(Icons.visibility_off),
                      suffixIconPressed: () {
                        context
                            .read<SignupBloc>()
                            .add(SignupRePassHideRequested());
                      },
                      validate: (String? val) {
                        if (val!.isEmpty) {
                          return 'Please enter re-enter password';
                        } else if (val != password.text) {
                          return 'Password is not match';
                        }
                      },
                    )
                  else
                    CustomAuthTextFormField(
                      key: const Key('re_enter_password'),
                      textEditingController: reEnterPassword,
                      labelText: 'Re-enter password',
                      isObsecure: true,
                      suffixIcon: const Icon(Icons.visibility),
                      suffixIconPressed: () {
                        context
                            .read<SignupBloc>()
                            .add(SignupRePassShowRequested());
                      },
                      validate: (String? val) {
                        if (val!.isEmpty) {
                          return 'Please enter re-enter password';
                        } else if (val != password.text) {
                          return 'Password is not match';
                        }
                      },
                    ),
                  Stack(
                    children: [
                      Button(
                        elevatedButtonKey: const Key('sign_up'),
                        child: 'SIGN UP',
                        function: (state is SignupLoadingState)
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ==
                                    false) {
                                  setState(() {
                                    isAutovalidate = true;
                                  });
                                } else {
                                  context.read<SignupBloc>().add(
                                        SignupRequest(
                                          firstName: firstName.text,
                                          lastName: lastName.text,
                                          email: email.text,
                                          password: password.text,
                                        ),
                                      );
                                }
                              },
                      ),
                      if (state is SignupLoadingState)
                        customCircularIndicator(),
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
