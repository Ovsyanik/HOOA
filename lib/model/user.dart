class User {
  int id;
  String fullName;
  String sex;
  String numberPhone;
  String email;
  String password;

  User({
    this.id,
    this.fullName,
    this.sex,
    this.numberPhone,
    this.email,
    this.password
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'fullName': this.fullName,
    'sex': this.sex ,
    'numberPhone': this.numberPhone,
    'email': this.email,
    'password': this.password
  };

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
    id: data['id'],
    fullName: data['fullName'],
    sex: data['sex'],
    numberPhone: data['numberPhone'],
    email: data['email'],
    password: data['password']
  );
}
