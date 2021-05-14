import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storefront/src/repository/authentication/authentication_repository.dart';
import 'package:storefront/src/repository/authentication/social/i_social_provider_factory.dart';
import 'package:storefront/src/repository/authentication/social/social_provider_factory.dart';
import 'package:storefront/src/utils/message_text.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
    SocialProviderFactory? socialProviderFactory,
  })  : _authenticationRepository = authenticationRepository,
        _socialProviderFactory =
            socialProviderFactory ?? SocialProviderFactoryImpl(),
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  late final SocialProviderFactory _socialProviderFactory;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginRequest) {
      yield LoginLoadingState();
      try {
        final UserCredential? session = await _authenticationRepository.logIn(
            email: event.email, password: event.password);

        if (session == null) {
          // if session is null then thows an error.
          throw Exception(Message.genericLoginErrorMessage);
        }

        yield LoginSuccessState(
          username: session.user?.displayName,
          email: session.user?.email,
          status: true,
        );
      } catch (e) {
        yield LoginErrorState(errorMessage: e.toString());
      }
    } else if (event is SocialLoginEvent) {
      yield SocialLoginLoadingState();
      try {
        final socialProvider =
            _socialProviderFactory.createInstance(event.socialService);

        final UserCredential? session = await socialProvider.login();

        if (session == null) {
          // if session is null then thows an error.
          throw Exception(Message.genericLoginErrorMessage);
        }

        yield SocialLoginSuccessState(
          username: session.user?.displayName,
          email: session.user?.email,
          status: true,
        );
      } catch (e) {
        yield LoginErrorState(errorMessage: e.toString());
      }
    } else if (event is LogoutRequested) {
      yield LogoutLoadingState();
      try {
        await _authenticationRepository.logOut();

        yield LogoutSuccess();
      } catch (e) {
        yield LogoutError(errorMessage: e.toString());
      }
    } else if (event is LoginPassShowRequested) {
      yield LoginPassShowState();
    } else if (event is LoginPassHideRequested) {
      yield LoginPassHideState();
    }
  }
}
