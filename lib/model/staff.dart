import 'package:flutter/cupertino.dart';

import 'Sex.dart';

class Staff {
  int id;
  String fullName;
  String position;
  double rate;
  String sex;
  String numberPhone;
  Image image;

  Staff({
    this.id,
    this.fullName,
    this.position,
    this.rate = 0,
    this.sex,
    this.numberPhone,
    this.image
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'fullName': this.fullName,
    'position': this.position,
    'sex': this.sex,
    'rate': this.rate,
    'numberPhone': this.numberPhone,
    'image': this.image
  };

  factory Staff.fromDatabaseJson(Map<String, dynamic> data) => Staff(
    id: data['id'],
    fullName: data['fullName'],
    position: data['position'],
    sex: data['sex'],
    rate: data['rate'],
    numberPhone: data['numberPhone'],
    image: data['image']
  );
}
