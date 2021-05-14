part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupRequest extends SignupEvent {
  const SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password, lastName, firstName];
}

class SignupPassShowRequested extends SignupEvent {}

class SignupPassHideRequested extends SignupEvent {}

class SignupRePassShowRequested extends SignupEvent {}

class SignupRePassHideRequested extends SignupEvent {}
