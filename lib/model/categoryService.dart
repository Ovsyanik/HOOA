class CategoryService {
  int id;
  String name;

  CategoryService({
    this.id,
    this.name
  });

  Map<String, dynamic> toDatabaseJson() => {
    'id': this.id,
    'name': this.name
  };

  factory CategoryService.fromDatabaseJson(Map<String, dynamic> data) => CategoryService(
      id: data['id'],
      name: data['name'],
  );
}