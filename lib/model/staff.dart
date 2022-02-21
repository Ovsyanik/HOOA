import 'dart:convert';
class Staff {
  int id;
  String fullName;
  String position;
  double rate;
  String sex;
  String numberPhone;
  String image;
  List<int> services;
  List<String> busyTime;

  Staff({
    this.id,
    this.fullName,
    this.position,
    this.rate = 0,
    this.sex,
    this.numberPhone,
    this.image,
    this.services,
    this.busyTime,
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'fullName': this.fullName,
    'position': this.position,
    'sex': this.sex,
    'rate': this.rate,
    'numberPhone': this.numberPhone,
    'image': this.image,
    'services': jsonEncode(this.services),
    'busyTime': jsonEncode(this.busyTime)
  };

  factory Staff.fromDatabaseJson(Map<String, dynamic> data) => Staff(
    id: data['id'],
    fullName: data['fullName'],
    position: data['position'],
    sex: data['sex'],
    rate: data['rate'],
    numberPhone: data['numberPhone'],
    //переделать
    image: data['image'],
    services: jsonDecode(data['services']).cast<int>(),
    busyTime: jsonDecode(data['busyTime']).cast<String>(),
  );
}
