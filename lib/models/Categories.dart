

class Categories {
  String id;
  String name;

  Categories({
    required this.id,
    required this.name
  });

  factory Categories.formJson(Map<String, dynamic> json)
  {
    return Categories(
        id: json['id'],
        name: json['name']
    );
  }
}