import 'package:hooa/model/TypeInstitution.dart';

class Institution {
  int id;
  String name;
  TypeInstitution type;
  String address;
  String numberPhone;
  String email;
  String password;

  Institution({
    this.id,
    this.name,
    this.type,
    this.address,
    this.numberPhone,
    this.email,
    this.password
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'name': this.name,
    'type': this.type ,
    'address': this.address,
    'numberPhone': this.numberPhone,
    'email': this.email,
    'password': this.password
  };

  factory Institution.fromDatabaseJson(Map<String, dynamic> data) => Institution(
    id: data['id'],
    name: data['name'],
    type: data['type'],
    address: data['address'],
    numberPhone: data['numberPhone'],
    email: data['email'],
    password: data['password']
  );
}