import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screen/login/bloc/login_bloc.dart';
import 'package:todo_app/screen/todos/todo_screen.dart';
import 'package:todo_app/services/authentication.dart';
import 'package:todo_app/services/todo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;

  late final TextEditingController _passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authenticationService: RepositoryProvider.of<AuthenticationService>(
            context,
            listen: false,
          ),
          todoService: RepositoryProvider.of<TodoService>(
            context,
            listen: false,
          ))
        ..add(
          RegisterServiceEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login To Todo App',
          ),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  print('Calledie = $state');
                  // TODO: implement listener
                  if (state is LoginSuccessfulState) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TodosScreen(
                          username: state.username,
                        ),
                      ),
                    );
                  } else if (state is RegisterFailureState) {
                    print('Came in');
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Error',
                        ),
                        content: Text(state.error.toString()),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginInitialState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<LoginBloc>(context,
                                          listen: false)
                                      .add(
                                    LoginCheckEvent(
                                      password: _passwordController.text,
                                      username: _usernameController.text,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<LoginBloc>(context,
                                          listen: false)
                                      .add(
                                    RegisterAccountEvent(
                                      password: _passwordController.text.trim(),
                                      username: _usernameController.text.trim(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Register',
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
