import 'package:hooa/model/categoryService.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/record.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/model/user.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/provider/databaseProvider.dart';

class SqfliteRepository {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> insertUser(User user) async {
    final db = await dbProvider.database;
    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> insertInstitution(Institution institution) async {
    final db = await dbProvider.database;
    var result = db.insert(institutionTable, institution.toDatabaseJson());
    return result;
  }

  Future addStaff(Staff staff) async {
    final db = await dbProvider.database;
    await db.insert(staffTable, staff.toDatabaseJson());
  }

  Future deleteStaff(int id) async {
    final db = await dbProvider.database;
    await db.delete(
        staffTable,
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<List<Staff>> getStaff() async {
    final db = await dbProvider.database;
    var result = await db.query (staffTable);
    List<Staff> staff = result.isNotEmpty ?
      result.map((item) => Staff.fromDatabaseJson(item)).toList()
      : [];
    return staff;
  }

  Future addRecord(Record record) async {
    final db = await dbProvider.database;
    await db.insert(recordsTable, record.toDatabaseJson());
  }

  Future<List<Record>> getRecords() async {
    final db = await dbProvider.database;
    var result = await db.query (recordsTable);
    List<Record> records = result.isNotEmpty ?
      result.map((item) => Record.fromDatabaseJson(item)).toList()
      : [];
    return records;
  }

  Future<List<Service>> getServices() async {
    final db = await dbProvider.database;
    var result = await db.query (serviceTable);
    List<Service> services = result.isNotEmpty ?
        result.map((item) => Service.fromDatabaseJson(item)).toList()
        : [];
    return services;
  }

  Future addService(Service service) async {
    final db = await dbProvider.database;
    await db.insert(serviceTable, service.toDatabaseJson());
  }

  Future<List<CategoryService>> getCategoryServices() async {
    final db = await dbProvider.database;
    var result = await db.query (categoryServiceTable);
    List<CategoryService> categories = result.isNotEmpty ?
    result.map((item) => CategoryService.fromDatabaseJson(item)).toList()
        : [];
    return categories;
  }

  Future deleteService(int id) async {
    final db = await dbProvider.database;
    await db.delete(
        serviceTable,
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future updateService(Service service) async {
    final db = await dbProvider.database;
    await db.update(serviceTable, service.toDatabaseJson(),
      where: 'id = ?', whereArgs: [service.id]);
  }

  Future<List<Service>> getServicesById(List<int> ids) async {
    final db = await dbProvider.database;
    List<Service> services = [];
    for(int i = 0; i < ids.length; i++) {
      var result = await db.query (serviceTable, where: 'id = ?', whereArgs: [ids.elementAt(i)]);
      if(result.isNotEmpty) {
        services.add(result.map((e) => Service.fromDatabaseJson(e)).first);
      }
    }

    return services;
  }

  Future updateStaff(Staff staff) async {
    final db = await dbProvider.database;
    await db.update(staffTable, staff.toDatabaseJson(),
        where: 'id = ?', whereArgs: [staff.id]);
  }
}