part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();
}

class TodosInitialState extends TodosState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TodosLoadedState extends TodosState {
  final List<Task> tasks;
  final String username;
  const TodosLoadedState({
    required this.tasks,
    required this.username,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [tasks, username];
}
