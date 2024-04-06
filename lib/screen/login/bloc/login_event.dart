part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginCheckEvent extends LoginEvent {
  final String username;
  final String password;
  const LoginCheckEvent({required this.password, required this.username});
  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}

class RegisterServiceEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterAccountEvent extends LoginEvent {
  final String username;
  final String password;
  const RegisterAccountEvent({required this.password, required this.username});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
