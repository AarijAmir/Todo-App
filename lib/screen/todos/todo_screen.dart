import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screen/todos/bloc/todos_bloc.dart';
import 'package:todo_app/services/todo.dart';

class TodosScreen extends StatefulWidget {
  final String username;
  const TodosScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
        ),
      ),
      body: BlocProvider(
        create: (context) => TodosBloc(
          todoService:
              RepositoryProvider.of<TodoService>(context, listen: false),
        )..add(
            LoadTodosEvent(username: widget.username),
          ),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: [
                  ...state.tasks
                      .map(
                        (e) => ListTile(
                          title: Text(e.task),
                          leading: Checkbox(
                            value: e.completed,
                            onChanged: (value) {
                              BlocProvider.of<TodosBloc>(context, listen: false)
                                  .add(
                                ToggleTodoEvent(
                                  todoTask: e.task,
                                ),
                              );
                            },
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                BlocProvider.of<TodosBloc>(context,
                                        listen: false)
                                    .add(
                                  DeleteTodoEvent(
                                    todoTask: e.task,
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                              )),
                        ),
                      )
                      .toList(),
                  ListTile(
                    title: const Text('Create New Task'),
                    trailing: const Icon(
                      Icons.create,
                    ),
                    onTap: () async {
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => const SingleChildScrollView(
                          child: Dialog(
                            child: CreateNewTask(),
                          ),
                        ),
                      );

                      if (result != null) {
                        BlocProvider.of<TodosBloc>(context).add(
                          AddTodoEvent(
                            todoText: result,
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  late final TextEditingController _inputController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      height: size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: Text(
              'What task do you want to create?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: TextField(
              controller: _inputController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(
                _inputController.text,
              );
            },
            child: const Text(
              'Save',
            ),
          ),
        ],
      ),
    );
  }
}
