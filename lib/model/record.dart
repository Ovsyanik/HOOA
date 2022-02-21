import 'dart:convert';

class Record {
  int id;
  String client;
  int master;
  String price;
  DateTime dateTime;
  List<int> services;

  Record({
    this.id,
    this.services,
    this.client,
    this.master,
    this.dateTime,
    this.price,
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'services': jsonEncode(this.services),
    'client': this.client,
    'master': this.master,
    'dateTime': this.dateTime,
    'price': this.price,
  };

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
      id: data['id'],
      services: jsonDecode(data['services']).cast<int>(),
      client: data['client'],
      master: data['master'],
      price: data['price'],
      dateTime: data['dateTime'],
  );
}