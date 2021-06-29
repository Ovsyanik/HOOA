import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final staffTable = 'Staff';
final userTable = 'User';
final institutionTable = 'Institution';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/hooa.db";
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $userTable ("
        "id INTEGER PRIMARY KEY, "
        "fullName TEXT, "
        "sex TEXT, "
        "numberPhone TEXT, "
        "email TEXT, "
        "password TEXT "
        ");");

    await database.execute("CREATE TABLE $staffTable ("
        "id INTEGER PRIMARY KEY, "
        "fullName TEXT, "
        "position TEXT, "
        "sex TEXT, "
        "rate REAL, "
        "numberPhone TEXT, "
        "image TEXT "
        ");");

    await database.execute("CREATE TABLE $institutionTable ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "type TEXT, "
        "address TEXT, "
        "numberPhone TEXT, "
        "email TEXT, "
        "password TEXT "
        ");");
  }
}
