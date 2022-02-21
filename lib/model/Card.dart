class Card {
  int id;
  String number;
  String date;
  int cvv;
  String typeCard;
  int user;

  Card({
    this.id,
    this.number,
    this.date,
    this.typeCard,
    this.cvv,
    this.user,
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'number': this.number,
    'date': this.date,
    'typeCard': this.typeCard,
    'cvv': this.cvv,
    'user': this.user,
  };

  factory Card.fromDatabaseJson(Map<String, dynamic> data) => Card(
    id: data['id'],
    number: data['number'],
    date: data['date'],
    typeCard: data['typeCard'],
    cvv: data['cvv'],
    user: data['user'],
  );
}
