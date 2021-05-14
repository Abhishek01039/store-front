import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storefront/src/config/theme_config.dart';
import 'package:storefront/src/mobile/screens/splash_screen.dart';
import 'package:storefront/src/repository/authentication/authentication_repository_impl.dart';

import 'src/bloc/login/login_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationRepository: AuthenticationRepositoryImpl(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeConfig.lightTheme,
        home: MySpalsh(),
      ),
    );
  }
}
