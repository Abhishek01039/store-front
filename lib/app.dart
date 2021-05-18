import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storefront/src/config/theme_config.dart';
import 'package:storefront/src/repository/authentication/authentication_repository_impl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'src/bloc/login/login_bloc.dart';
import 'src/mobile/router/auto_router.gr.dart';
import 'src/web/router/web_router.gr.dart';

class MyApp extends StatelessWidget {
  final _appRouter = kIsWeb ? WebRouter() : AppRouter();

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
      child: MaterialApp.router(
        theme: ThemeConfig.lightTheme,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
