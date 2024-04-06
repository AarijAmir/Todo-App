part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadTodosEvent extends TodosEvent {
  final String username;
  const LoadTodosEvent({required this.username});
  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

class AddTodoEvent extends TodosEvent {
  final String todoText;
  const AddTodoEvent({required this.todoText});
  @override
  // TODO: implement props
  List<Object?> get props => [todoText];
}

class ToggleTodoEvent extends TodosEvent {
  final String todoTask;
  const ToggleTodoEvent({required this.todoTask});
  @override
  // TODO: implement props
  List<Object?> get props => [todoTask];
}

class DeleteTodoEvent extends TodosEvent {
  final String todoTask;
  const DeleteTodoEvent({required this.todoTask});
  @override
  // TODO: implement props
  List<Object?> get props => [todoTask];
}
