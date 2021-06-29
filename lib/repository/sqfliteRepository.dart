import 'dart:ffi';

import 'package:hooa/model/institution.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/model/user.dart';
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

  Future<List<Staff>> getStaff() async {
    final db = await dbProvider.database;
    var result = await db.query (staffTable);
    List<Staff> staff = result.isNotEmpty ?
      result.map((item) => Staff.fromDatabaseJson(item)).toList()
      : [];
    return staff;
  }
}