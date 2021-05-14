part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupErrorState extends SignupState {
  const SignupErrorState({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class SignupSuccessState extends SignupState {
  const SignupSuccessState({this.email, this.status = false, this.username});

  final bool status;
  final String? username;
  final String? email;

  SignupSuccessState copyWith({
    bool? status,
    String? username,
    String? email,
  }) {
    return SignupSuccessState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, username, email];
}

class SignupPassShowState extends SignupState {}

class SignupPassHideState extends SignupState {}

class SignupRePassShowState extends SignupState {}

class SignupRePassHideState extends SignupState {}
