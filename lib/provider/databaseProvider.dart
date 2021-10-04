import 'dart:io';

import 'package:hooa/model/categoryService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final staffTable = 'Staff';
final userTable = 'User';
final institutionTable = 'Institution';
final recordsTable = 'Records';
final categoryServiceTable = 'CategoryService';
final serviceTable = 'Service';
final salesTable = 'Sales';

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
        "image TEXT, "
        "services TEXT, "
        "FOREIGN KEY (services) REFERENCES $serviceTable(id)"
        ");");

    await database.execute("CREATE TABLE $institutionTable ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "type TEXT, "
        "address TEXT, "
        "numberPhone TEXT, "
        "email TEXT, "
        "password TEXT, "
        "timeStart TEXT, "
        "timeEnd TEXT, "
        "instagram TEXT "
        ");");

    await database.execute("CREATE TABLE $categoryServiceTable ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT"
        ");");

    await database.execute("CREATE TABLE $serviceTable ("
        "id INTEGER PRIMARY KEY, "
        "categoryService INTEGER, "
        "description TEXT, "
        "name TEXT, "
        "price TEXT, "
        "time TEXT, "
        "FOREIGN KEY (categoryService) REFERENCES $categoryServiceTable(id)"
        ");");

    await database.execute("CREATE TABLE $recordsTable ("
        "id INTEGER PRIMARY KEY, "
        "service INTEGER, "
        "client TEXT, "
        "master TEXT, "
        "price TEXT, "
        "dateTime TEXT "
        ");");

    await database.execute("CREATE TABLE $salesTable ("
        "id INTEGER PRIMARY KEY, "
        "institution INTEGER, "
        "service INTEGER, "
        "count INTEGER, "
        "dateStart TEXT, "
        "dateEnd TEXT, "
        "FOREIGN KEY (institution) REFERENCES $institutionTable(id), "
        "FOREIGN KEY (service) REFERENCES $serviceTable(id)"
        ");");

    var category = CategoryService(name: 'Окрашивание волос');
    var category2 = CategoryService(name: 'покраска волос');

    await database.insert(categoryServiceTable, category.toDatabaseJson());
    await database.insert(categoryServiceTable, category2.toDatabaseJson());
  }
}