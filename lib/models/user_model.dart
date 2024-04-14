import 'package:collection/collection.dart';

class User {
  String email;
  String password;

  User({required this.email, required this.password});
}

class UserStorage {
  static final List<User> _users = [];

  static void addUser(User user) {
    _users.add(user);
  }

  static User? getUser(String email, String password) {
    // Usando firstWhereOrNull que retorna null automaticamente se nenhum usuário for encontrado
    return _users.firstWhereOrNull(
      (user) => user.email == email && user.password == password
    );
  }
}
