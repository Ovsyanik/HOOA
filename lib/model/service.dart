class Service {
  int id;
  int categoryService;
  String description;
  String name;
  String price;

  Service({
    this.id,
    this.categoryService,
    this.description,
    this.name,
    this.price
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'categoryService': this.categoryService,
    'description': this.description,
    'name': this.name,
    'price': this.price
  };

  factory Service.fromDatabaseJson(Map<String, dynamic> data) => Service(
      id: data['id'],
      categoryService: data['categoryService'],
      description: data['description'],
      name: data['name'],
      price: data['price']
  );
}