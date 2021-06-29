class Record {
  int id;
  int service;
  String client;
  double master;
  String price;
  DateTime dateTime;

  Record({
    this.id,
    this.service,
    this.client,
    this.master,
    this.dateTime,
    this.price
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'service': this.service,
    'client': this.client,
    'master': this.master,
    'dateTime': this.dateTime,
    'price': this.price
  };

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
      id: data['id'],
      service: data['service'],
      client: data['client'],
      master: data['master'],
      price: data['price'],
      dateTime: data['dateTime']
  );
}