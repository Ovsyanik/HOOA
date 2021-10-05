class Institution {
  int id;
  String name;
  String type;
  String address;
  String numberPhone;
  String email;
  String password;
  String timeStart;
  String timeEnd;
  String instagram;
  String image;


  Institution({
    this.id,
    this.name,
    this.type,
    this.address,
    this.numberPhone,
    this.email,
    this.password,
    this.timeStart,
    this.timeEnd,
    this.instagram,
    this.image
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'name': this.name,
    'type': this.type ,
    'address': this.address,
    'numberPhone': this.numberPhone,
    'email': this.email,
    'password': this.password,
    'timeStart': this.timeStart,
    'timeEnd': this.timeEnd,
    'instagram': this.instagram,
    'image': this.image
  };

  factory Institution.fromDatabaseJson(Map<String, dynamic> data) => Institution(
    id: data['id'],
    name: data['name'],
    type: data['type'],
    address: data['address'],
    numberPhone: data['numberPhone'],
    email: data['email'],
    password: data['password'],
    timeStart: data['timeStart'],
    timeEnd: data['timeEnd'],
    instagram: data['instagram'],
    image: data['image']
  );
}