class Sale {
  int id;
  int institution;
  int service;
  int count;
  String dateStart;
  String dateEnd;

  Sale({
    this.id,
    this.institution,
    this.service,
    this.count,
    this.dateStart,
    this.dateEnd,
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'institution': this.institution,
    'service': this.service,
    'count': this.count,
    'dateStart': this.dateStart,
    'dateEnd': this.dateEnd,
  };

  factory Sale.fromDatabaseJson(Map<String, dynamic> data) => Sale(
    id: data['id'],
    institution: data['institution'],
    service: data['service'],
    count: data['count'],
    dateStart: data['dateStart'],
    dateEnd: data['dateEnd']
  );
}