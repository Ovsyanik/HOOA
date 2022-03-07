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
final cardsTable = 'Cards';

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
        "busyTime TEXT, "
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
        "image TEXT, "
        "instagram TEXT, "
        "rate REAL, "
        "services TEXT, "
        "FOREIGN KEY (services) REFERENCES $serviceTable(id)"
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
        "services INTEGER, "
        "client TEXT, "
        "master INTEGER, "
        "price TEXT, "
        "dateTime TEXT, "
        "FOREIGN KEY (master) REFERENCES $staffTable(id),"
        "FOREIGN KEY (services) REFERENCES $serviceTable(id)"
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

    await database.execute("CREATE TABLE $cardsTable ("
        "id INTEGER PRIMARY KEY, "
        "number TEXT, "
        "date TEXT, "
        "typeCard TEXT, "
        "cvv TEXT, "
        "user INTEGER, "
        "FOREIGN KEY (user) REFERENCES $userTable(id)"
        ");");

    var category = CategoryService(name: 'Окрашивание волос');
    var category2 = CategoryService(name: 'Покраска волос');
    var category3 = CategoryService(name: 'Стрижка женская');
    var category4 = CategoryService(name: 'Стрижка мужская');
    var category5 = CategoryService(name: 'Химическая завивка');
    var category6 = CategoryService(name: 'Окрашивание');
    var category7 = CategoryService(name: 'Укладка и причёска');
    var category8 = CategoryService(name: 'Лечение волос');
    var category9 = CategoryService(name: 'Уходовые процедуры');
    var category10 = CategoryService(name: 'Наращивание волос');

    await database.insert(categoryServiceTable, category.toDatabaseJson());
    await database.insert(categoryServiceTable, category2.toDatabaseJson());
    await database.insert(categoryServiceTable, category3.toDatabaseJson());
    await database.insert(categoryServiceTable, category4.toDatabaseJson());
    await database.insert(categoryServiceTable, category5.toDatabaseJson());
    await database.insert(categoryServiceTable, category6.toDatabaseJson());
    await database.insert(categoryServiceTable, category7.toDatabaseJson());
    await database.insert(categoryServiceTable, category8.toDatabaseJson());
    await database.insert(categoryServiceTable, category9.toDatabaseJson());
    await database.insert(categoryServiceTable, category10.toDatabaseJson());
  }
}
