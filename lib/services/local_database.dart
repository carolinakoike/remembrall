class LocalDatabase {
  static final Map<String, String> _users = {};

  static bool register(String email, String password) {
    if (!_users.containsKey(email)) {
      _users[email] = password;
      return true; // Usuário registrado com sucesso
    }
    return false; // Usuário já existe
  }

  static bool login(String email, String password) {
    return _users[email] == password; // Retorna true se as credenciais estiverem corretas
  }
}
