import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storefront/src/extension/user_extension.dart';
import 'package:storefront/src/repository/authentication/authentication_repository.dart';
import 'package:storefront/src/utils/message_text.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(SignupInitial());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupRequest) {
      yield SignupLoadingState();
      try {
        final UserCredential? session = await _authenticationRepository.signIn(
            email: event.email, password: event.password);

        if (session == null) {
          // if session is null then thows an error.
          throw Exception(Message.genericLoginErrorMessage);
        }

        // update the display name with first name and last name
        await session.user?.updateProfile(
            displayName:
                UserExtension('').fullName(event.firstName, event.lastName));
        await session.user?.reload();

        yield SignupSuccessState(
          username: session.user?.displayName,
          email: session.user?.email,
          status: true,
        );
      } catch (e) {
        yield SignupErrorState(errorMessage: e.toString());
      }
    } else if (event is SignupPassShowRequested) {
      yield SignupPassShowState();
    } else if (event is SignupPassHideRequested) {
      yield SignupPassHideState();
    } else if (event is SignupRePassShowRequested) {
      yield SignupRePassShowState();
    } else if (event is SignupRePassHideRequested) {
      yield SignupRePassHideState();
    }
  }
}
