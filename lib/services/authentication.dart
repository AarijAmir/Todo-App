import 'package:hive/hive.dart';
import 'package:todo_app/constants/const.dart';
import 'package:todo_app/model/user.dart';

class AuthenticationService {
  late Box<User> _users;
  Future<String?> authenticateUser(
      {required String username, required String password}) async {
    final bool isSuccessful = _users.values.any((element) =>
        element.username == username && element.password == password);
    return (isSuccessful) ? username : null;
  }

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox(userBox);
    await _users.clear();
    await _users.add(
      User(
        password: 'xyz',
        username: 'aarijamir9@gmail.com',
      ),
    );
    await _users.add(
      User(
        password: 'abc',
        username: 'areebamir9@gmail.com',
      ),
    );
  }

  Future<UserCreationResult> createUser(
      {required String username, required String password}) async {
    final alreadyExists = _users.values.any(
      (element) => element.username.toLowerCase() == username.toLowerCase(),
    );
    if (alreadyExists) {
      return UserCreationResult.alreadyExists;
    }
    try {
      _users.add(User(password: password, username: username));
      return UserCreationResult.success;
    } catch (e) {
      return UserCreationResult.failure;
    }
  }
}
