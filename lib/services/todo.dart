import 'package:hive/hive.dart';
import 'package:todo_app/constants/const.dart';
import 'package:todo_app/model/task.dart';

class TodoService {
  late Box<Task> _tasks;
  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox(tasksBox);
    await _tasks.clear();
    await _tasks.add(
      Task(
        completed: true,
        task: 'Subscribe to Flutter from scratch',
        user: 'aarijamir9@gmail.com',
      ),
    );
    await _tasks.add(
      Task(
        completed: false,
        task:
            'During the generation of the three address code in a single pass is that we may not know the address where the program should go. A number of jumping statements is generated with the target label or address is temporarily left unspecified. Back patching is the process of filling up un-specified information of label using an appropriate semantic actions during the code generation.',
        user: 'areebamir9@gmail.com',
      ),
    );
  }

  Future<List<Task>> getTasks({required String username}) async {
    return _tasks.values.where((element) => element.user == username).toList();
  }

  void addTask({required String task, required String username}) {
    _tasks.add(Task(completed: false, task: task, user: username));
  }

  void removeTask({required String task, required String username}) async {
    final removeTask = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await removeTask.delete();
  }

  Future<void> updateTask({
    required String task,
    required String username,
  }) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    final int index = taskToEdit.key as int;
    await _tasks.put(index,
        Task(completed: !taskToEdit.completed, task: task, user: username));
  }
}
