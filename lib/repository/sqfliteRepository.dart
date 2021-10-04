import 'dart:async';

import 'package:hooa/model/Sale.dart';
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

  Future<List<Sale>> getSales() async {
    final db = await dbProvider.database;
    var result = await db.query (salesTable);
    List<Sale> sales = result.isNotEmpty ?
    result.map((item) => Sale.fromDatabaseJson(item)).toList()
        : [];
    return sales;
  }

  Future addSale(Sale sale) async {
    final db = await dbProvider.database;
    await db.insert(salesTable, sale.toDatabaseJson());
  }

  Future updateSale(Sale sale) async {
    final db = await dbProvider.database;
    await db.update(salesTable, sale.toDatabaseJson(),
        where: 'id = ?', whereArgs: [sale.id]);
  }

  Future deleteSale(int id) async {
    final db = await dbProvider.database;
    await db.delete(
        salesTable,
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<Institution> getInstitution(String email, String password) async {
    final db = await dbProvider.database;
    var result = await db.query(institutionTable,
      where: 'email = ? and password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? Institution.fromDatabaseJson(result.first) : null;
  }

  Future<User> getUser(String email, String password) async {
    final db = await dbProvider.database;
    var result = await db.query(userTable,
      where: 'email = ? and password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? User.fromDatabaseJson(result.first) : null;
  }

  Future updateInstitution(Institution institution) async {
    final db = await dbProvider.database;
    await db.update(institutionTable, institution.toDatabaseJson(),
        where: 'id = ?', whereArgs: [institution.id]);
  }

  Future<List<Institution>> getInstitutions() async {
    final db = await dbProvider.database;
    var result = await db.query (institutionTable);
    List<Institution> sales = result.isNotEmpty ?
    result.map((item) => Institution.fromDatabaseJson(item)).toList()
        : [];
    return sales;
  }
}