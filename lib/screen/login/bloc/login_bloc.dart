import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/constants/const.dart';
import 'package:todo_app/services/authentication.dart';
import 'package:todo_app/services/todo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;
  final TodoService todoService;
  LoginBloc({required this.authenticationService, required this.todoService})
      : super(const RegisteringState()) {
    on<LoginCheckEvent>((event, emit) async {
      // TODO: implement event handler
      print('Called Before User');
      final user = await authenticationService.authenticateUser(
        username: event.username.trim(),
        password: event.password.trim(),
      );
      print('Called After User = $user');

      if (user != null) {
        emit(LoginSuccessfulState(username: user));
        emit(const LoginInitialState());
      } else {
        emit(const RegisterFailureState(
          error: 'Invalid username or password',
        ));
        emit(const LoginInitialState());
      }
    });
    on<RegisterAccountEvent>((event, emit) async {
      final result = await authenticationService.createUser(
          username: event.username, password: event.password);
      switch (result) {
        case UserCreationResult.success:
          emit(
            LoginSuccessfulState(username: event.username),
          );
          break;
        case UserCreationResult.failure:
          emit(const RegisterFailureState(error: 'Something went wrong.'));
          break;
        case UserCreationResult.alreadyExists:
          emit(const RegisterFailureState(error: 'User already exists.'));
          break;
      }
      emit(const LoginInitialState());
    });

    on<RegisterServiceEvent>((event, emit) async {
      await authenticationService.init();
      await todoService.init();
      emit(const LoginInitialState());
    });
  }
}
