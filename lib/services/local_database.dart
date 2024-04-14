import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper db = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/SignUpDatabase.db';
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, dob TEXT, email TEXT, password TEXT, gender TEXT, phone TEXT)');
    });
  }

  // Inserir dados na tabela Users
  Future<int> insertUser(String name, String dob, String email, String password, String gender, String phone) async {
    final db = await database;
    var res = await db.rawInsert(
      'INSERT INTO Users (name, dob, email, password, gender, phone) VALUES (?, ?, ?, ?, ?, ?)',
      [name, dob, email, password, gender, phone]);
    return res;
  }

  // Método para recuperar todos os usuários
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    var res = await db.query('Users');
    return res.isNotEmpty ? res : [];
  }
}
