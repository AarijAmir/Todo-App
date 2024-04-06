part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginSuccessfulState extends LoginState {
  final String username;
  const LoginSuccessfulState({required this.username});
  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

class RegisteringState extends LoginState {
  const RegisteringState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterFailureState extends LoginState {
  final String error;
  const RegisterFailureState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
