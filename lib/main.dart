import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/screen/login/login_screen.dart';
import 'package:todo_app/services/authentication.dart';
import 'package:todo_app/services/todo.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationService(),
        ),
        RepositoryProvider(
          create: (context) => TodoService(),
        ),
      ],
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
