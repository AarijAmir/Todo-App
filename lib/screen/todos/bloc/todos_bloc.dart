import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/services/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService todoService;
  TodosBloc({required this.todoService}) : super(TodosInitialState()) {
    on<LoadTodosEvent>((event, emit) async {
      // TODO: implement event handler
      final List<Task> todos =
          await todoService.getTasks(username: event.username);
      emit(TodosLoadedState(
        tasks: todos,
        username: event.username,
      ));
    });
    on<AddTodoEvent>((event, emit) {
      final currentState = state as TodosLoadedState;
      print('Blocieee = ${event.todoText}');
      todoService.addTask(
        task: event.todoText,
        username: currentState.username,
      );
      // because we added todo, so it's mean we need to load the todos
      add(LoadTodosEvent(username: currentState.username));
    });
    on<ToggleTodoEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      await todoService.updateTask(
        task: event.todoTask,
        username: currentState.username,
      );
      add(LoadTodosEvent(username: currentState.username));
    });
    on<DeleteTodoEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      todoService.removeTask(
        task: event.todoTask,
        username: currentState.username,
      );
      add(LoadTodosEvent(username: currentState.username));
    });
  }
}
